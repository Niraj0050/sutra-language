# सूत्र प्रदर्शन-मार्ग (Performance Roadmap)

लक्ष्य: सूत्र को modern systems-language tier (Go / Rust) पर लाना — एक ही
भाषा में apps + web + AI/ML — Devanagari-native, न्यूनतम बाहरी निर्भरता।
सिद्धांत: **build in Sutra, translate मत करो** — हर हिस्सा सूत्र के लिए
design हो, C का line-by-line port नहीं।

## अभी की हालत (2026-08-30)

Self-hosting compiler + Sutra allocator/GC + ~1900 लाइन live C runtime।
Codegen सीधा AST→text walk है — कोई IR नहीं, कोई optimizer नहीं।

**नापा हुआ (per-module compile समय):**

| module | asm output | समय |
|---|---|---|
| लेखक.सूत्र | 9K lines | 20s |
| सार्थक_विश्लेषक.सूत्र | 14K lines | 28s |
| विश्लेषक.सूत्र | 40K lines | 184s |

14K→40K (2.8×) पर समय 28s→184s (6.5×) — साफ़ **O(n²)**।

**असली मूल कारण (per-phase timestamp से मिला):**
`लेखक.सूत्र` = 476 लाइन → **lexer (`पद_विच्छेदन`) अकेले 22.7s**, बाकी
सब phases (parse + analyze + codegen + assemble) मिलाकर <1s।

1. **Lexer O(n²)** — `स्रोत[i]` (string index) हर character पर
   `sutra_arr_get → sutra_substr` call करता है। जब `sutra_substr` सूत्र
   में पोर्ट हुआ (`पाठ_उपखंड`, commit 5990e4c), वो **बिना cache के O(n)
   per call** है और **unoptimised सूत्र** के रूप में चलता है →
   self-compile ~40× धीमा। C version वही algorithm था पर native speed पर।
   **सीख: hot path को C→सूत्र move करना optimiser के बिना regression है।**
   → अभी `sutra_substr` C में वापस (revert)। `पाठ_उपखंड` सूत्र में defined
   रहता है, codegen उसे तब route करेगा जब सस्ता हो।
2. Allocator free-list — singly-linked first-fit, कोई size-class नहीं।
   time में योगदान कम, पर **memory 300MB→35MB** (यह अलग fix, रखा गया)।
3. Codegen pure stack-machine — 13,670 push/pop pairs। compiled सूत्र
   ~10× slow। यही #1 को इतना बुरा बनाता है।

**बड़ा निष्कर्ष:** runtime port और optimiser **coupled** हैं। optimiser
के बिना bulk runtime port हर hot path पर regression है। इसलिए phase
ordering बदली (नीचे देखो) — cold paths अभी, hot paths optimiser के बाद।
"Build not translate" = algorithm भी बदलो: proper सूत्र lexer
substr-per-char नहीं, byte-cursor walk करेगा।

## "दूसरी भाषाओं से तेज़" — सच्चाई

- Python / JS / Ruby से तेज़ → अभी भी (AOT native vs interpreter)
- Go / Java / C# tier → IR + basic optimizer + generational GC से
  **matchable** (~1 साल)
- C++ / Rust tier → mature optimizer से **अधिकांश code के लिए**
  matchable। "हर state में C++ से तेज़" real target नहीं (LLVM =
  hundreds of person-years)।
- **खास domains में C++ से तेज़** → real: whole-program opt, PGO,
  AI/ML kernels की JIT specialization, GPU offload।

बिकने वाली pitch: *"सूत्र — एक भाषा, apps + web + AI/ML, Go/Rust-tier
performance, Devanagari-native, zero external dependency।"*

## Keystone: सूत्र IR + optimizer

```
सूत्र source
 → Lexer / Parser / Analyzer        (सूत्र — हो चुका)
 → LOWER to सूत्र IR                [typed SSA, ~30 opcodes]     ← नया
 → Optimization passes (सूत्र):                                  ← नया
     const-fold · dead-code-elim · copy-prop · inlining
     · mem2reg (locals → registers) · loop-invariant motion
 → Register allocator (linear-scan)                             ← नया
 → Machine code:
     default : .s text → as / ld  (अभी के जैसा — नहीं बदल रहे)
     release : IR → LLVM  (optional, "beat C++" mode)
```

IR सब unblock करता है: compile speed (text सिर्फ़ अंत में एक बार),
runtime speed (passes IR पर), multi-arch (IR → अलग backends), और
compounding (compiler खुद IR से compile होगा)।

## Runtime — build, translate नहीं

| हिस्सा | अभी | build in सूत्र |
|---|---|---|
| Allocator | first-fit linked list, O(n) | size-classed segregated free lists, O(1) + young-gen bump |
| GC | manual-trigger mark-sweep | generational: young = copy-collect, old = mark-compact, auto-trigger |
| Dict | linear-scan array | open-addressing hash (Robin Hood / Swiss) |
| String | immutable + concat | + small-string-opt + `पाठ_निर्माता` (StringBuilder) O(n) building |
| Values | सब heap पर | NaN-boxing / tagged — int/float/bool बिना allocate |

## Phased plan

### Phase 0 — अभी। आग बुझाओ। ~1 हफ़्ता
- (a) ✅ Allocator → size-class segregated free lists, O(1) alloc/free
  (memory 300MB→35MB)
- (b) ✅ `sutra_substr` → C में वापस (lexer regression revert)
- (c) Lexer: `स्रोत[i]` की जगह byte-cursor — कोई per-char substr नहीं
  (proper fix, "build not translate")
- (d) बाकी hot-path सूत्र ports जाँचो (`पाठ_जोड़`, `अक्षर_बना`); जो
  regress करें, C में वापस जब तक optimiser न आए
- **Milestone: self-compile <30s, dev loop usable**

### Phase 1 — सूत्र IR + optimiser। ~3-6 महीने। **पहले यह** (order बदला)।
optimiser के बिना runtime port regression है — इसलिए यह पहले।

**1a. IR define** — ✅ done (`स्वसंकलक/मध्यम.सूत्र`, commit 6e10f85)
   - typed SSA, ~35 opcodes; 9 type tags (पूर्ण/दशमलव/पाठ/सूची/शब्दकोश/
     वस्तु/बूल/शून्य/मान)। एकक → कार्य → खंड → निर्देश। fresh SSA
     value/label counters, deduped string-const table, pretty-printer।
   - `मध्यम_परीक्षण.सूत्र` — hand-built IR (branch+phi+call), 15 checks green।
   - मूल_संकलन.सूत्र अछूता — fixed point safe।

**1b. AST → IR lowering** — ✅ core done (`स्वसंकलक/मूल_निम्नक.सूत्र`, commit a898821)
   हर local = स्लॉट (alloca); SSA-निर्माण mem2reg (1c) पर टाला।
   functions/params/चर_घोषणा/असाइनमेंट/यदि/यावत्/पुनरावृत्ति/विराम-जारी/
   परत्/लिखतु/फेको + सारे expressions (&&/|| short-circuit शाखा+फाई से)।
   `मूल_निम्नक_परीक्षण.सूत्र` — असली parser से 5 snippets, 21 checks green।
   बाकी (1b follow-up): कठन_प्रयत्न, method/class resolution, real
   function return types। यहीं `स = स + piece` का O(n²) खत्म होगा (जब
   1e emitter बनेगा और यह path wire होगा)।

**1c. passes** — ✅ core done (`स्वसंकलक/अनुकूलक.सूत्र`, commit 2a4b7ca)
   - CFG helpers (successors, pred-map, RPO via DFS)
   - **mem2reg** (स्लॉट_उन्नयन) — स्लॉट + पढ़/लिख_स्लॉट → SSA + phi;
     back-edge phi operands deferred (loops); trivial-phi removal।
     असली यावत् loop पर verified।
   - **const-fold** — const∘const → single स्थिर (fixpoint)
   - **बीज_सरल** — x+0/0+x/x-0/x*1/1*x → x
   - **DCE** — अगम्य खंड + zero-use side-effect-free निर्देश (fixpoint)
   - driver: mem2reg once, फिर {fold, DCE} × 5
   - `verify_ir.ps1` — 46 checks (मध्यम 15 + निम्नक 21 + अनुकूलक 10)
   - v0 अब आरक्षित ("invalid/none") — dict 0="absent" टकराव हटा
   - बाद में: copy-prop, inlining, LICM, phi type-refinement

**1d. register allocator** — ✅ done (`स्वसंकलक/रजि_नियतक.सूत्र`, commit 19be732)
   RPO क्रमांकन → backward liveness (fixpoint) → live intervals →
   linear-scan (expire/assign/spill-furthest)। रजिस्टर pool = 7
   callee-saved (rbx rsi rdi r12-r15) ताकि calls clobber न करें।
   spill → 16-byte ढेर slots। परिणाम फलन पर: रजि_नियतन, ढेर_आकार,
   प्रयुक्त_सुरक्षित। `रजि_नियतक_परीक्षण.सूत्र` — loop (0 spill, phi
   coalesced) + 9-live-value fn (4 spill)। 8 checks.

**1e. IR → x86-64** — ✅ core done (`स्वसंकलक/मूल_उत्सर्जक.सूत्र`, commit 4ef8871)
   Chunk-list builder (no `स = स + piece`)। values registers में
   (रजि_नियतन), हर binop r10 से — कोई push/pop-per-op नहीं।
   स्थिर/अंकगणित/भाग-शेष/तुलना/और-या-नकार/पढ़-लिख_वैश्विक/बुलाओ/अंतर्;
   terminators + edge पर cycle-safe parallel-move phi resolution;
   prologue/epilogue + main wrapper (__शीर्ष + sutra_main)।
   follow-ups done: strings/lists/dicts/indexing, type-aware +/==,
   classes/objects/methods/fields, floats + `प्रकार()`।
   **driver split** (commit इसके बाद): पुराना `उत्सर्जक_चालक` (6 modules)
   O(n²)-स्मृति संकलक में OOM होता था → अब `अग्र_चालक` (parse→lower→opt,
   IR-पाठ dumps) + `पश्च_चालक` (IR-पाठ→regalloc→.s)। बीच में
   `मध्यम_क्रम.सूत्र` — compact line IR serialize/deserialize।
   `उत्_कॉल` में `मुख्य`→`sutra_main` rename भी fix।
   **tests/compiler through the IR path: 44 / 51** (`verify_emit.sh` 16/16,
   `verify_emit_full.sh` full-suite harness)।

**1f. GC roots — ✅ DONE** (commit के बाद) — emitter-only shadow slots:
   `मध्यम_सुरक्षा_बिंदु_है` (कौन-सा call allocate/collect कर सकता है) +
   `मध्यम_जीसी_टैप्ड` (पूर्ण/दशमलव/बूल/शून्य छोड़ बाकी सब — वर्ग-नाम
   समेत)। `रजि_जीसी_जड़ें` (regalloc के बाद): हर GC-टैप्ड मान जिसका
   जीवन-अंतराल एक सुरक्षा-बिंदु घेरता है → spill-क्षेत्र में समर्पित
   स्लॉट, `ढेर_आकार` बढ़ता है। emitter: prologue में zero-init + inline
   `gc_roots[]` पंजीकरण (कोई call नहीं — `movl gc_roots_count`/`leaq`/
   `movq`/`incl`), def के बाद store, मृत्यु पर `movq $0` clear, phi
   block-आरंभ पर, epilogue `subl $N, gc_roots_count` (rax अछूता)।
   **tests/compiler: 46 / 51** — 45, 47 अब pass (था freed-memory read)।
   बाकी 5 (सब पूर्व-मौजूद, कोई regression नहीं):
   - **37** null-in-list ops (native path errors, interpreter allows)
   - **38** dynamic `"str" + सत्य/शून्यम्` → `1`/`0` (tagged dynamic word चाहिए)
   - **40** float-typed builtin returns (`वर्गमूल` etc. "मान" typed) +
     `प्रयत्न`/`पकड़ो` exceptions अभी emit नहीं होते
   - **41, 44** GC गणना — प्रोग्राम सही चलते हैं, बस `स्मृति_स्थिति()` गिनती
     भिन्न: interpreter हर in-scope local रूट करता (conservative), यह
     liveness-आधारित (precise); 44 में DCE मृत alloc हटा देता जो
     interpreter execute करता। यह unwinnable है बिना optimiser/GC-model
     बदले — accounting अंतर, correctness नहीं।

**1g. IR backend SELF-HOSTS — ✅ FIXED POINT** (commit `59fdcb8`, 2026-08-31)।
   `स्वसंकलक/मूल_संकलन_ir.सूत्र` = IR-path compiler driver। Gen1 = split
   (`अग्र_चालक`→`पश्च_चालक`)। Gen1 → Gen2 → Gen3, **Gen2 .s == Gen3 .s
   byte-identical (128289 lines)**। तीनों 46/51 tests/compiler।
   रास्ते के bug fixes: अनुकूलक O(N²)→O(N) (`ac8d6ea`); `उत्_कॉल`
   odd-stack-args pad placement (`f503725`+`0eca2d2` — pad पुश से पहले,
   वरना callee के `16+i*8(%rbp)` offset 8 खिसकते); `निम्नक_लघुपथ`
   dedicated `लघु_खंड` (malformed IR fix); `मुख्य`→`sutra_main` call।

**1h. auto-GC during compile — ✅ DONE** (2026-08-31)।
   `सूत्र_आवंटन` में byte-threshold (128 MB, GC कम reclaim करे तो दुगनी)।
   **opt-in**: सिर्फ़ IR-backend programs `सूत्र_स्वजीसी_आरंभ` (emitter के
   `main:` से) call करके चालू करते हैं — पुराने codegen में roots नहीं।
   library-mode globals initializer नहीं चलते तो threshold भी उसी fn में
   सेट होता (वरना `जीसी_सीमा == 0` → हर alloc पर GC)।
   **इस दौरान 3 असली GC bug मिले+fix हुए:**
   - `जड़_नक्शा[id] == 0` (पहला gcslot offset 0) को `उत्_जड़_संचय`
     "कोई स्लॉट नहीं" समझता (शब्दकोश-get 0 बनाम अनुपस्थित) → offset ≥ 8
     floor (`रजि_जीसी_जड़ें`)। यह Phase-1f roots को भी पूरा करता।
   - `चिह्नित` शब्दकोश-entries buffer को प्रकार-2 array मान के recurse
     करता (raw `[key,val]*` है) → out-of-bounds mark → `चिह्नित_कच्चा`
     (सिर्फ़ mark-bit)।
   - **मुख्य bug:** `sutra_dict_create` = dict + entries दो alloc; दूसरा
     auto-GC कर के अभी-un-rooted dict को sweep कर देता (dict का header
     बाद में overwrite होता → arena walk desync → random block corrupt)।
     `sutra_split`/`sutra_args_get` में भी। हल: `सूत्र_जीसी_दबाओ()/छोड़ो()`
     (suppression counter) से multi-alloc window लपेटो।
   - नव_सूची/शब्दकोश/वस्तु परिणाम अब **सदा रूट** + fill-steps से पहले
     store (dict grow / constructor खुद allocate कर सकता)।
   Gen1→Gen2→Gen3 (auto-GC ON): **Gen2 .s == Gen3 .s — फिक्स्ड पॉइंट**,
   46/51 tests। self-compile अब **39 सेकंड** (OOM-मुक्त)।

**1i. Gen1 ≠ Gen2 determinism — ✅ FOUND + FIXED** (commit `a9bdb5b`)।
   पुराना `मूल_सर्जक` codegen string `==`/`!=` को **pointer-compare**
   करता है जब कोई भी operand static रूप से `पाठ` न हो (दोनों `सूची`
   elements)। `उत्_चालें` का identity-move filter दो register-नाम
   strings (`"%rbx"` दो बार `"%"+नाम` से बना) की तुलना करता — same
   content, अलग object → filter fail → phantom parallel-move
   cycle-break। अकेला identity pair → हानिरहित no-op; असली move के साथ
   → `movq %rbx,%r11; movq real,%rbx; movq %r11,%rbx` जहाँ आखिरी move
   सही मान **overwrite** कर देता (असली miscompile)। हल: `उत्_सम_पाठ`
   (`लंबाई`+`खोजें`, सिर्फ़ integer ops) — `उत्_चालें`/`उत्_एक_चाल`/
   `उत्_स्रोत_में`/cycle-break में। **अब Gen1(split) == Gen2(IR-compiled)
   byte-identical (129483 lines) — पूर्ण determinism।** `verify_ir_selfhost.sh`
   Gen1==Gen2 भी assert करता है।

**1j. IR path = DEFAULT — ✅ DONE** (commit `333ea9c`)। `मूल_संकलन.सूत्र`
   (= `sutrac.exe` का source) अब IR pipeline चलाता है, पुराना
   `मूल_सर्जक` नहीं। `मूल_संकलन_ir.सूत्र` delete। seed
   `स्वसंकलक/निर्माण/मूल_संकलन.s` IR-path source से regenerate
   (129483 lines, पहले ~256K)। `bootstrap.ps1` end-to-end verified:
   seed → seed_sutrac.exe → 5500-line source compile → fresh
   `sutrac.exe` → **[OK] Fixed point, byte-identical, C++ host अछूता**।
   verify_ir 4/4 (अब IR sutrac.exe से — मज़बूत जाँच)। tests/compiler
   46/51. `मूल_सर्जक`/`निर्माता` रखे पर off critical path।

**1k. कठन_प्रयत्न (try/catch) lowering — ✅ DONE** (2026-08-31)।
   `निम्नक_प्रयत्न` (`मूल_निम्नक.सूत्र`) — रनटाइम setjmp/longjmp ABI पर,
   कोई नया IR opcode नहीं:
   `jbuf = बुलाओ sutra_exception_get_jmp_buf []` →
   `sjr = बुलाओ _setjmp [jbuf, (स्थिर 0)]` → `यदि_जाओ sjr≠0 → पकड़ो : प्रयत्न`।
   प्रयत्न-खंड सामान्य निकास पर `बुलाओ sutra_exception_pop` फिर `जाओ अंत`;
   पकड़ो-खंड `बुलाओ sutra_get_exception_value` → त्रुटि-चर स्लॉट → देह।
   पकड़ो-खंड का एकमात्र CFG पूर्ववर्ती setjmp-खंड है → mem2reg पकड़ो में
   पढ़े बाहरी चरों को try-से-पहले वाला मान देता (longjmp callee-saved
   रजिस्टर/spill वैसे भी उसी मान पर restore करता — semantically sound)।
   **साथ में एक असली bug fix:** `कठन_फेको` lowering `नोड["मानः"]` पढ़ता था
   (parser field `नोड["अभिव्यक्ति"]` है) → हर फेंका मान `$0` बनता था।
   इससे `विश्लेषक` का `त्रुटि_फेको` कभी असली संदेश नहीं फेंकता था →
   syntax error पर native संकलक "Uncaught exception" छापता था; अब पूरा
   `त्रुटिः [पङ्क्तिः N, स्तम्भः M]: …` संदेश छपता है।
   Gen2 .s == Gen3 .s (132158 lines), `bootstrap.ps1` [OK] fixed point।
   split (अग्र→पश्च) == unified byte-identical। verify_ir 4/4,
   verify_emit 16/16, **tests/compiler 47/51** (37 null-in-list अब pass;
   40 का exception-भाग अब pass, बचा float-builtin-return type)।
   नया regression test: `tests/compiler/49_exceptions.सूत्र`।
   सीमा (पुराने codegen जैसी): try-देह के अंदर सीधा `परत्` exception frame
   pop नहीं करता। Driver को `प्रयत्न`/`पकड़ो` में लपेटना अभी बाकी है
   (throw-fix से errors पहले ही साफ़ छपते हैं — कम प्राथमिकता)।

**1l. dynamic str-concat + float-builtin return type — ✅ DONE** (2026-08-31)।
   दो असली edge bug (37/40 के बाद बचे थे):
   - **str + बूल/शून्य/दशमलव** — `sutra_add_dynamic` को f64-bits / bool-int /
     null-int सादा पूर्णांक दिखता ("1"/"0"/कचरा)। `निम्नक_पाठ_में_बदलो`
     (`मूल_निम्नक.सूत्र`): `+` में एक operand पाठ हो तो दूसरे का
     static टैग देखकर `बूल_से_पाठ` / `शून्य_से_पाठ` / `sutra_float_to_str`
     inject करो, फिर `sutra_str_concat`। "मान" (सच में dynamic) अब भी
     `add_dynamic` — दुर्लभ, ज्ञात gap।
   - **float builtins की परत्-type** — `वर्गमूल`/`घात`/`निरपेक्ष`/`न्यूनतम`/
     `अधिकतम` `_f` symbols पर हैं, परिणाम f64-bits, पर टैग "मान" था →
     `लिखतु` कच्चा पूर्णांक छापता। `निम्नक_अंतर्निहित_परत्` → "दशमलव"।
     `गोल` असल में `llround` से **पूर्णांक** लौटाता → टैग "पूर्ण"।
   - रास्ते में मिला third bug: **float unary `-`** — emitter `ऋणात्मक`
     हमेशा `negq` (integer two's-complement) करता था → `-5.5` = bits of
     `-0.8125`। Fix: `प्रकार=="दशमलव"` पर `btcq $63` (चिह्न-बिट पलटो)।
   `bootstrap.ps1` [OK] fixed point, split==unified, **tests/compiler
   50/52** — बचे सिर्फ़ 41, 44 (GC-accounting: program output सही, बस
   `स्मृति_स्थिति()` गिनती interpreter-conservative बनाम IR-precise;
   optimiser/GC-model बदले बिना unwinnable)।

- **Milestone: compiled सूत्र ~1.5-2× of C (scalar)। self-compile seconds।
  push/pop 13,670 → ~कुछ सौ। अब hot code C→सूत्र move करना safe है।**

### Phase 2 — Runtime port complete, BUILT properly। ~1 महीना
list / dict (open-addressing hash) / print / float / exceptions /
fileIO — हर एक designed, अब बिना regression।
- **Milestone: `sutra_runtime.c` DELETED. हर binary = सूत्र + तल.s
  (76 लाइन)। शून्य C, शून्य libc। → Level 1 independence**

**2a. शब्दकोश → open-addressing हैश (सूत्र) — ✅ DONE** (commit `d047b15`, 2026-09-01)।
   `sutra_dict_*` C में linear-scan सरणी था (हर lookup O(n))। अब
   `मूल_रनटाइम.सूत्र` में — packed insertion-order प्रविष्टि-सरणी के ऊपर
   एक हैश सूचकांक (open addressing, linear probe, load ≤ 0.75)। C प्रतीक
   अब पतले shim; `sutra_dict_keys` अभी भी packed सरणी सीधे पढ़ता →
   `कुंजियाँ()` क्रम अपरिवर्तित। block 24→40 बाइट (+24 सूचकांक*, +32
   हैश_क्षमता); GC का `चिह्नित` एक line जोड़ता (सूचकांक बफर → चिह्नित_कच्चा)।
   **self-compile ~48s → ~24s** (compiler के बड़े context शब्दकोश hot path थे)।
   fixed point कायम, tests 50/52 (वही 41/44 accounting)।
   रास्ते के fixes (runtime modules अब तक सिर्फ़ पुराने `मूल_सर्जक` से बने थे —
   IR backend ने इन्हें कभी compile नहीं किया था):
   - **पाठ_तुल्य अनंत recursion** — params `मान`-typed थे → IR backend ने
     `अ == ब` identity-fast-path को `sutra_str_equal(अ,ब)` = `पाठ_तुल्य` में
     बदला → खुद को call। हल: तुलना-भारी runtime fns के params `संख्या`
     (वे pointer रखते हैं, `मूल_आवंटक.सूत्र` की शैली)।
   - **library-mode** — IR उत्सर्जक हमेशा `main` wrapper देता → `मूल_रनटाइम`/
     `मूल_आवंटक` (सिर्फ़ कार्य + globals, कोई मुख्य) `multiple definition of
     main`। `निम्नक_एकक` अब __शीर्ष छोड़ता जब हर top-level node घोषणा हो और
     कोई मुख्य न हो; उत्सर्जक main-block को `मुख्य_है || शीर्ष_है` पर gate करता।
   - **अनुपलब्ध intrinsic maps** — `उत्_अंतर्_प्रतीक` में `अंतर्_जड़_संख्या`/
     `अंतर्_जड़_मान`/`अंतर्_सक्रिय_अपवाद` जोड़े; सार्थक whitelist में
     `सूत्र_जीसी_दबाओ`/`सूत्र_जीसी_छोड़ो`।

**2c. सूची (list) ops → सूत्र** (commit `5b23b64`, 2026-09-01)।
   `sutra_list_append`/`pop`/`insert`/`remove`/`concat`/`find` + `sutra_arr_create`
   → `मूल_रनटाइम.सूत्र` (`सूची_जोड़`/`निकाल`/`डाल`/`हटा`/`जोड़ो_दो`/`खोज`/`रचना`)।
   वही `[क्षमता:8][गणना:8][तत्व:8×क्षमता]` विन्यास, arena via
   `सूत्र_पुनः_आवंटन` — हर grow/shrink पर GC दबाकर। C प्रतीक अब पतले shim
   (~150 line C हटी)। `sutra_arr_get`/`set`/`length` का string/dict dispatch
   C में ही (sutra_str_get का C-side sequential cache)। कोई compiler बदलाव
   नहीं — fixed point कायम (Gen2==Gen3, seed अछूता), 51/52, **self-compile
   ~24s → ~16s**।

**2d. string search/transform → सूत्र** (commit `34e5557`, 2026-09-01)।
   `sutra_find`/`replace`/`split`/`join`/`trim`/`starts_with`/`ends_with` →
   `मूल_रनटाइम.सूत्र` (`पाठ_कोडबिंदु_खोज`/`पाठ_बदल`/`पाठ_विभाजन`/`पाठ_संयोग`/
   `पाठ_छाँट`/`पाठ_आरंभ_में`/`पाठ_अंत_में`)। बाइट-स्तर मिलान (UTF-8
   self-synchronising)। `sutra_substr` C में ही (lexer hot path)। कोई
   compiler बदलाव नहीं, fixed point कायम।

**2e. print → सूत्र (तल.s WriteFile)** (commit `e55ab00`, 2026-09-01)।
   `sutra_print_dynamic`/`str_print`/`print_null`/`print_bool` अब पतले C shim
   → `गतिशील_छापो`/`पाठ_छापो`/`शून्य_छापो`/`बूल_छापो` (`मूल_रनटाइम.सूत्र`)।
   कोई `printf`/`fwrite`/`fflush` नहीं — सीधे `तल.s` `सूत्र_तल_मुद्रण`
   (GetStdHandle+WriteFile)। नया IR-intrinsic `अंतर्_मुद्रण(आधार, ऑफसेट,
   लंबाई)` उत्सर्जक में। `sutra_print_float` अभी C (float पथ, स्थगित)।
   रास्ते में एक **पूर्व-मौजूद latent GC bug मिला+fix**: `रजि_जीसी_जड़ें`
   allocator/collector के *अपने* कार्यों के लिए GC-जड़ें पंजी करता था
   (`सूत्र_संग्रह` अकेले 26)। उनके स्थानीय चर कच्ची स्मृति रखते हैं
   (block-आधार/टैग/आकार/अंतर-सूचक) — तो step-2 "जड़ों से चिह्नित" खुद
   `सूत्र_संग्रह` के temps scan करता, `जड़_गण` फुलता, कच्चे मान वस्तु समझे
   जाते। भाग्य से अब तक निर्दोष; print-पथ ने एक अंतर-सूचक (`नल+16`, क्षमता-बाइट
   dict-टैग जैसा) सही stale slot में छोड़ा → `चिह्नित` भाग निकला, segfault।
   `रजि_जीसी_तल_कार्य` अब पूरे GC-तल (`मूल_आवंटक.सूत्र`) की root-पंजी छोड़ता
   (26→0)। `46_gc_repeated` regression fix। ज्ञात cosmetic: split-driver
   Gen1 एक अतिरिक्त अप्रयुक्त `""` `.rdata` const देता (`पश्च_चालक` dedup)।

**2f. float — libm हटाओ (Stage 1)** (2026-09-01)।
   `sutra_math_sqrt_f`/`abs_f`/`min_f`/`max_f`/`round_f` + पूर्णांक `sutra_math_sqrt`
   अब SSE asm blob में (`sqrtsd` / `btrq $63` / `minsd` / `maxsd` / `cvtsd2si`)।
   `sutra_math_pow_f` pure-C: पूर्णांक घातांक = सटीक repeated-multiply (कोडबेस
   में यही इस्तेमाल), भिन्नात्मक = `exp(e·ln b)` series (कोई libm)। float अंकगणित
   (`+−×÷`, तुलना, `int↔float`) पहले से asm blob (शून्य libm)। `#include <math.h>`
   हटाया; हर build script + compiler linker command से **`-lm` हटाया**
   (`bootstrap.ps1`, `verify_*`, `मूल_संकलन.सूत्र` char-array)। fixed point कायम
   (135213 lines), 40_native_floats interp==native।

   **§2f Stage 2 — `sutra_float_to_str` / `sutra_print_float` से libc हटा** (2026-09-01)।
   `snprintf("%f")` + `strchr` + `strlen` की जगह `sr_fmt_float()` — SSE अंकगणित
   (`d*1e6+0.5` → `cvttsd2si`) + पूर्णांक अंक-लूप: `total/1e6` = पूर्ण भाग,
   `total%1e6` = 6-अंक अंश (trailing zeros छँटे, कैरी अपने-आप संभला)। NaN/Inf/
   `≥2^53` guard। `sutra_print_float` अब सिर्फ़ `पाठ_छापो(sutra_float_to_str(v))`
   — कोई `printf`/`fflush`। float पथ अब पूर्णतः libc-मुक्त। `40_native_floats` +
   `प्रारूप`/`जेसन`/`गणित` परीक्षण + edge cases (`0.9999999`→"1", `1.0/3.0`,
   `-0.25`) सब interp==native। C-only बदलाव, seed अछूता।

**§2g — file I/O + args + command_run → Win32 सीधे** (2026-09-01)।
   `_wfopen`/`fread`/`fwrite`/`fseek`/`ftell`/`fclose`/`_wsystem`/`malloc`/`free`
   हटे। अब kernel32/shell32:
   - `sutra_file_read` → `CreateFileW` + `GetFileSizeEx` + `ReadFile` **सीधे
     Sutra-string में** (`sutra_str_alloc(NULL,n)` फिर `block+16` में पढ़ो — कोई
     malloc, कोई copy) + `CloseHandle`।
   - `sutra_file_write` → `CreateFileW`(CREATE_ALWAYS) + `WriteFile` loop।
   - `sutra_file_exists` → `GetFileAttributesW` (डायरेक्टरी छोड़)।
   - `sutra_command_run` (`कमांड_चलाओ` — यह `as`/`gcc` चलाता, self-host critical
     path) → `cmd.exe /c …` via `CreateProcessW` + `WaitForSingleObject` +
     `GetExitCodeProcess` (handles inherit → child output दिखे)।
   - `sutra_init_args` → `CommandLineToArgvW` + `WideCharToMultiByte`, argv pool
     एक `VirtualAlloc` (कभी मुक्त नहीं), libc heap नहीं। `sutra_args_get` का
     `strlen` → inline लूप।
   path UTF-8→UTF-16 stack बफ़र में (`MultiByteToWideChar`)। bootstrap.ps1 [OK]
   fixed point (seed compiler अपना स्रोत `CreateFileW` से पढ़ता, `as`/`gcc`
   `CreateProcessW` से चलाता); `तर्क_परीक्षण` + `cli_शब्द_गणना` (argv+file) +
   file round-trip सब काम।

**§2h — stdio हटाओ + मृत GC-registry हटाओ** (2026-09-01)।
   - `fprintf(stderr,…)` (exception uncaught / max-depth) → `sr_err()` =
     `WriteFile(GetStdHandle(STD_ERROR_HANDLE),…)`। `exit(1)` → `ExitProcess(1)`
     (asm blob के 2 `call exit` → `call सूत्र_तल_निकास`)।
   - `printf` in `sutra_gc_status` (`स्मृति_स्थिति`) → `sr_out` + `sr_out_i64`
     (हाथ का पूर्णांक-प्रारूप)।
   - मृत कोड हटाया (~190 line): `gc_allocs` सरणी + सूचक→अनुक्रमणिका hash +
     `gc_register_alloc`/`unregister`/`update`/`mark_allocation` — Route-C में
     कभी नहीं बुलाया (`find_gc_allocation` सीधे `सूत्र_ब्लॉक_प्रकार`, `चिह्नित`
     `मूल_आवंटक.सूत्र` में)। साथ में `malloc`/`free`/`calloc`/`realloc` गए।
   - `#include` अब सिर्फ़: `<string.h>` (`memcpy`/`memset`/`strlen`/`memcmp`),
     `<stdint.h>`/`<stddef.h>` (types), `<windows.h>`/`<shellapi.h>` (OS-तल),
     `<setjmp.h>` (exception ABI)। **`<stdio.h>` / `<stdlib.h>` / `<inttypes.h>`
     हटे।** `sutra_runtime.c` 1685→1505 line। `44_gc_status`/`46` output अब
     WriteFile से; exception message stderr पर।

**§2i — mem/str primitives → तल.s ; str-compare → Sutra** (2026-09-01)।
   - `memcpy` / `memmove` / `memset` / `memcmp` / `strlen` अब **तल.s में हाथ-asm**
     (`rep movsb`/`stosb`/`repe cmpsb`/scan; Win64 rcx,rdx,r8; rdi/rsi push/pop)।
     gcc का loop-idiom-recognition asm को नहीं छूता; `.c` के `memcpy(&d,&bits,8)`
     bit-reinterpret gcc `movq` में fold करता, बाक़ी link पर तल.s को resolve।
   - `sutra_str_equal` → `पाठ_तुल्य`, `sutra_str_compare` → `पाठ_कोडबिंदु_तुलना`
     (Sutra; codepoint-order = UTF-8 byte-order)। `memcmp` call site गया।
   - `sutra_obj_alloc` का redundant `memset` हटाया (`सूत्र_आवंटन` शून्य-भरा देता)।
   - **runtime के चारों `.o` में शून्य libc symbol** — सब kernel32/shell32 +
     आपस में resolve। fixed point 135213, `पाठ_परीक्षण`/`सूची_परीक्षण` interp==native।

**§2j — setjmp/longjmp → तल.s asm shim** (commit `TBD`, 2026-09-01)।
   `<setjmp.h>` का `jmp_buf`/`_setjmp`/`longjmp` की जगह अपना 256-बाइट बफ़र +
   हाथ-asm `_setjmp` / `sr_longjmp` (तल.s)। बचाता: ret-addr, rsp, rbx/rbp/rsi/
   rdi/r12-15, xmm6-15। **कोई SEH unwind** — हमारे compiled code में handlers/
   destructors नहीं (GC explicit, यही डिज़ाइन: catch-खंड का एकमात्र CFG पूर्ववर्ती
   setjmp-खंड → mem2reg pre-try मान देता, longjmp के reg-restore से मेल)।
   compiler `call _setjmp` वैसे ही emit करता; `sutra_floor.o` का `_setjmp`
   linker पहले satisfy करता → CRT का कभी pull नहीं होता (कोई conflict नहीं)।
   `sutra_throw` अब `sr_longjmp` बुलाता।
   - **`sutra_runtime.c` में अब कोई libc header नहीं** — सिर्फ़ `<stdint.h>`/
     `<stddef.h>` (types) + `<windows.h>`/`<shellapi.h>` (OS-तल)। libc undefined
     = सिर्फ़ `memcpy`/`strlen` → तल.s। 49_exceptions + nested/loop try-catch +
     rethrow + uncaught→stderr सब interp==native, fixed point कायम।

**§2k — float SSE `__asm__` blob → तल.s** (commit `TBD`, 2026-09-01)।
   `sutra_runtime.c` के 242-line inline `__asm__(R"(…)")` (`sutra_float_*` अंकगणित/
   तुलना, `int↔float`, `math_*_f` SSE, `sutra_gc_push/pop_root`, `sutra_exception_pop`,
   `sutra_get_exception_value`) → `तल.s` में। बाहरी सूचक (`sutra_throw_div_by_zero` C,
   `gc_roots`/`gc_roots_count`/`sutra_try_depth`/`sutra_active_exception` C globals)
   link पर cross-resolve। साथ में 5 मृत `#if 0` C-दुहराव हटाए। `.c` **1496→1122
   line**। कोई build-plumbing नहीं (`तल.s` पहले से everywhere)। fixed point 135213,
   40_native_floats/49_exceptions/गणित/प्रारूप interp==native।

**§2l — dynamic_type + str-case → Sutra ; ~180 line मृत C हटाओ** (commit `TBD`, 2026-09-01)।
   `sutra_dynamic_type` → `गतिशील_प्रकार` (`सूत्र_ब्लॉक_प्रकार` + नाम-साहित्य);
   `sutra_str_map_case`/`upper`/`lower` → `पाठ_अक्षर_रूप(स, बड़ा)` (ASCII case,
   byte-loop) — दोनों `मूल_रनटाइम.सूत्र` में, C पतले shim। **हटाया (~180 line,
   native path में मृत — compiler Sutra equivalents emit करता, C copies सिर्फ़
   अब-अनुपलब्ध C++ host के लिए थे):** `sutra_str_equal`/`compare` भी नहीं — रखे
   (छोटे); हटाए: `sutra_utf8_cmp_codepoints`+`str_less`/`greater`/`less_equal`/
   `greater_equal` (compiler `पाठ_न्यून` आदि emit करता), `sutra_str_length`/
   `arr_length`/`dynamic_length` (`दैशिक_लंबाई`), `sutra_char_ord` (`अक्षर_कोडबिंदु`),
   पूर्णांक `sutra_math_pow`/`abs`/`min`/`max`/`round` (`_f` संस्करण emit होते)।
   link साफ़ (कोई undefined ref)। `.c` **1122→894 line**। fixed point 135213,
   `प्रकार()`/`उच्च`/`निम्न` interp==native।

**§2m — exception state-machine → Sutra** (commit `e0727e4`, 2026-09-01)।
   अपवाद-अवस्था (`प्रयत्न_गहराई` / `प्रयत्न_ढेर` [VirtualAlloc 256×256] /
   `प्रयत्न_जड़_गण` / `सक्रिय_अपवाद`) + `अपवाद_बफ_लो` / `अपवाद_पॉप` /
   `सक्रिय_अपवाद_लो` / `फेंको` अब `मूल_रनटाइम.सूत्र` में। `तल.s`: `sr_longjmp` →
   `सूत्र_दीर्घकूद(env, roots_snap)` — यह `gc_roots_count` भी बहाल करता (longjmp
   नहीं करता); `sutra_exception_pop`/`get_exception_value` हटाए। `सार्थक`:
   whitelist `सूत्र_दीर्घकूद`(2) + `सूत्र_अपवाद_निकास`(1) → seed refresh (135213→
   135298)। C: `sutra_throw`/`get_jmp_buf`/`exception_pop`/`get_exception_value`/
   `gc_active_exc` → 1-line shim; सिर्फ़ `सूत्र_अपवाद_निकास` (uncaught → stderr +
   ExitProcess, ~12 line) असली C। `.c` **894→870 line**। fixed point 135298,
   49_exceptions + nested/loop/rethrow + GC-inside-try सब interp==native।

**§2n — GC रूट-सरणी + एक्सेसर → तल.s** (commit `8792aac`, 2026-09-03)।
   `gc_roots[]` (8MB) + `gc_roots_count` — `sutra_runtime.c` से `तल.s` की
   स्पष्ट `.bss` में (`.comm` नहीं — 8MB COMMON ब्लॉक इमेज-लेआउट बिगाड़ता →
   लिंक पर `REL32` overflow; C पक्ष को `.bss` सिर्फ़ gcc के `-fno-common`
   default से मिलता था)। रूट-वॉक कॉलबैक `sutra_gc_root_count` /
   `sutra_gc_root_deref` → `तल.s` leaf हाथ-asm। `sutra_gc_active_exc` C
   shim हटा — उत्सर्जक अब `अंतर्_सक्रिय_अपवाद` → सीधे `सक्रिय_अपवाद_लो`
   (`मूल_रनटाइम.सूत्र`, §2m); `मूल_आवंटक.s` नए call-लक्ष्य के लिए पुनर्जनित।
   `sutra_gc_status` जानबूझकर C में रखा: Sutra port आवंटन करता (लेबल +
   `संख्या_से_पाठ` + `पाठ_जोड़`) → उन्हीं गणकों को बिगाड़ता जो छापता है
   (`44_gc_status` 3→33) — diagnostic को वह नहीं बदलना चाहिए जो वह मापता;
   print/format चंक के साथ non-allocating रूप में जाएगा। `.c` **870→865 line**।
   fixed point 135298; 46_gc_repeated + 49_exceptions interp==native;
   41/44/18_stdlib ज्ञात-mismatch अपरिवर्तित।

**§2o — Win32 file I/O + तर्क + समादेश → Sutra + तल.s** (commit `407adfa`, 2026-09-03)।
   पूरा file/args/process भाग `sutra_runtime.c` से निकला। `तल.s`: 13 पतले
   kernel32/shell32 wrappers, सब ≤3 तर्क → Sutra सीधे call करता, struct-
   मार्शलिंग asm से बाहर नहीं (`सूत्र_तल_यूटीएफ_चौड़ा`/`_चौड़ा_यूटीएफ`/`_सञ्चिका_*`/
   `_पढ़ो`/`_लिखो`/`_हैंडल_बंद`/`_समादेश_रेखा`/`_समादेश_विभाजन`/`_स्थानीय_मुक्त`/
   `_समादेश`)। `सूत्र_तल_समादेश` = पूरा CreateProcessW + Wait + GetExitCode +
   CloseHandle×2 (STARTUPINFOW/PROCESS_INFO अपने frame पर, हाथ-asm)।
   `मूल_रनटाइम.सूत्र`: `सञ्चिका_पढ़ो_रन`/`_लिखो_रन`/`_है_रन`/`समादेश_चलाओ_रन`/
   `तर्क_सूची_रन` (loop, lazy VirtualAlloc बफ़र, UTF-8↔UTF-16)। **तर्क अब
   आलसी** → `main:` से `sutra_init_args` कॉल हटी। `निम्नक` builtins retarget;
   `सार्थक` whitelist `सूत्र_तल_*` → seed **135298→135832**। `.c` **865→737**;
   `<shellapi.h>` गया (सिर्फ़ `<windows.h>` — stderr + gc_status)। संकलक खुद
   इसके पार self-compile करता (source पढ़ता, `.s` लिखता, as/gcc चलाता)।
   fixed point + Gen1(split)==Gen2 + Gen2==Gen3 (135832); 51/2 + 10/1;
   file round-trip + command exit-code + args प्रोग्राम interp==native।

**§2p — दशमलव प्रारूपण → Sutra** (commit `25476b3`, 2026-09-03)।
   `sr_fmt_float` / `sutra_float_to_str` / `sutra_print_float` → `मूल_रनटाइम.सूत्र`
   (`दशमलव_प्रारूप` / `दशमलव_से_पाठ` / `दशमलव_छापो`)। "%f"-जैसा: 6 अंश-अंक,
   `गोल()`-गोल, trailing 0 छँटे — व्याख्याता के `std::to_string(double)`+trim
   से मेल। शुद्ध SSE (`सूत्र_float_*` तल.s) + पूर्णांक-लूप। e-नोटेशन स्थिरांक
   (DBL_MAX, 2^53) सूत्र-साहित्य में नहीं लिख सकते → inf = `(धन-धन) != 0`
   (inf-inf = NaN), >2^63 = `गोल()` का INT64_MIN sentinel; `गोल(धन*1e6)` ≡
   `trunc(धन*1e6 + 0.5)` (धन ≥ 0) — पुराने C सूत्र से bit-identical। `निम्नक`
   "दशमलव" print/concat टैग retarget (कोई whitelist बदलाव — कोई नया symbol
   नहीं)। seed 135832 अपरिवर्तित। `sr_ln`/`sr_exp`/`sutra_math_pow_f` C में ही
   (pow का भिन्नात्मक पथ bit-reinterpret चाहिए जो सूत्र नहीं कर सकता; केवल
   18_stdlib छूता)। `.c` **737→689**। 40_native_floats + 48_type_inquiry +
   12-केस प्रारूप probe interp==native।

**§2q — RISKY str hot-path cluster → Sutra** (commit `c7a75d1`, 2026-09-04)।
   लेक्सर के millions-बार-call वाले आवंटन/पहुँच पथ को `मूल_रनटाइम.सूत्र` में:
   - `पाठ_सूचकांक` ← `sutra_str_get` — अनुक्रमिक-पहुँच cache अब मॉड्यूल-global
     + **GC-चक्र-स्टैम्प**: auto-GC `सूत्र_गण_चक्र` बढ़ाता → cache अपने-आप
     अमान्य (पुराना C सिर्फ़ explicit `संग्रह_करो` पर साफ़ करता — latent
     dangle bug)।
   - `पाठ_रचना` ← `sutra_str_alloc` (string-literal emit + `sutra_throw_str`)।
     `सूची_सूचकांक(_सेट)` ← `arr_get/set` (पाठ/शब्दकोश dispatch सहित)।
     `वस्तु_रचना` ← `obj_alloc`। `पाठ_योग_गतिक` ← `add_dynamic`।
     `पाठ_खोज_गतिक` ← `find`। `शब्दकोश_कुंजियाँ_रन` ← `dict_keys`।
     `रन_क्या_पाठ/सूची/शब्दकोश` ← `find_gc_allocation`+`native_is_*`।
     `संग्रह_रन` ← `gc_collect`। `पाठ_बड़ा/छोटा` ← `str_upper/lower`।
     (`उपखंड` पहले से `पाठ_उपखंड`; `str_concat` → `पाठ_जोड़`।)
   ~15 उत्सर्जक/निम्नक emit-sites सीधे सूत्र-नामों पर; `सार्थक` whitelist
   `सूत्र_गण_चक्र` → seed **135832→135894**। `sutra_str_alloc`/`sutra_throw`
   shims हटे (`फेंको` opcode retargeted; `sutra_throw_str` अब `पाठ_रचना`)।
   **`sutra_runtime.c` 689→209 line** — बचा: stderr-पथ (uncaught अपवाद),
   gc_status diagnostic, ~25 पतले shims, pow/ln/exp (double↔int64 bit-cast)।
   **self-compile ~16s→~24s (1.5×, पुरानी टिप्पणी का 40× नहीं!)** — IR-अनुकूलक
   + चक्र-स्टैम्प cache। fixed point 135894; Gen1(split)==Gen2 + Gen2==Gen3;
   51/2 + 10/1; 14_strings / 30_string_indexing / 31 / 32_string_api /
   33_array_ops / 29 / 50_dict_literal / 34_class_param / 40_floats /
   49_exceptions सब interp==native।

**§2r — `sutra_runtime.c` DELETED — Level 1 पूर्ण** (commit `463c7ab`, 2026-09-04)।
   अंतिम C-भाग हटा:
   - **stderr-तल** → `तल.s` `सूत्र_तल_त्रुटि` (STD_ERROR_HANDLE WriteFile)।
     `sutra_float_div` का `call sutra_throw_div_by_zero` → `call भाजन_शून्य_फेंको`।
   - `सूत्र_अपवाद_निकास` / `भाजन_शून्य_फेंको` / `जीसी_स्थिति_रन` → `मूल_रनटाइम.सूत्र`
     (uncaught = `पाठ_जोड़` + `सूत्र_तल_त्रुटि` + `अंतर्_निकास(1)`; div0 = `प्रक्षेपः`;
     gc_status आवंटन-रूप — 44_gc_status वैसे भी GC-accounting mismatch से fail)।
   - `sr_ln`/`sr_exp`/`sutra_math_pow_f` → `लघुगणक_रन`/`घातांकी_रन`/`रन_घात`
     (`मूल_रनटाइम.सूत्र`)। double↔int64 bit-cast = **"मान"-param passthrough**
     कार्य (`दशमलव_बिट`/`बिट_दशमलव` — मशीन-स्तर सिर्फ़ mov, type-tag बदलता); 2^52
     स्थिरांक रनटाइम-गुणन से (int-lit ≥ 2³¹ सीमा से बचने को)। कोई asm नहीं।
   - **~25 पतले shims**: उत्सर्जक/निम्नक अब सीधे सूत्र-नाम emit करते —
     `गतिशील_छापो`/`गतिशील_प्रकार`/`सूची_{जोड़,डाल,निकाल,हटा,जोड़ो_दो}`/
     `पाठ_{बदल,विभाजन,संयोग,छाँट,आरंभ_में,अंत_में}`/`बूल_छापो`/`शून्य_छापो`/
     `अक्षर_बना`/`शब्दकोश_{सेट,कुंजी_है}`/`अपवाद_बफ_लो`/`अपवाद_पॉप`/`सक्रिय_अपवाद_लो`।
   - `सार्थक` whitelist `सूत्र_गण_सक्रिय`/`_संग्रहित`/`सूत्र_तल_त्रुटि` → seed
     **135894→135884**।
   - `मूल_संकलन.सूत्र` का linker-कमांड से `sutra_runtime_prebuilt.o` हटा।
     `bootstrap.ps1` 5→4 चरण (कोई `gcc -c`; लिंक सिर्फ़ `.s`-जनित `.o`)।
     `verify_ir_selfhost.sh`/`verify_emit*.sh`/`README.md` अद्यतन।
   **`sutra_runtime.c` DELETED।** हर सूत्र binary = `तल.s` + `मूल_रनटाइम.s` +
   `मूल_आवंटक.s` + संकलक — **शून्य C, शून्य libc**; gcc केवल as/ld के रूप में।
   fixed point 135884; Gen1(split)==Gen2 + Gen2==Gen3; 51/2 + 10/1;
   pow/exception/div0/gc_status/string/list/dict सब interp==native।

**§2s — Level 2: अपना PE प्रवेश-बिंदु, `-nostdlib` — freestanding** (commit `76ec419`, 2026-09-04)।
   binary अब gcc की `crt2.o` (`__tmainCRTStartup`) नहीं लिंक करता। `तल.s` में
   अपना `mainCRTStartup` (16-संरेखो → `main` बुलाओ → उसका `eax` लेकर
   `ExitProcess`)। CRT init कुछ नहीं चाहिए — stdio हैंडल हर बार
   `GetStdHandle`, heap = `VirtualAlloc`, कोई global ctor / SEH / `.cfi` /
   `.eh_frame` हमारे codegen में (सत्यापित: seed में 0)। नाम `mainCRTStartup`
   = ld का console-default entry → कोई `-e` झंडा नहीं। सब 4 link-कमांड
   (`bootstrap.ps1` · `verify_ir_selfhost.sh` · `verify_emit*.sh` · संकलक का
   अपना emitted linker-कमांड) → `-nostdlib -lkernel32 -lshell32`। seed
   **135884→136031**।
   **परिणाम: हर सूत्र binary सिर्फ़ `KERNEL32.dll` + `SHELL32.dll` import करता**
   — 7 `api-ms-win-crt-*.dll` गए। `sutrac.exe` खुद freestanding। fixed point
   136031; verify_ir 51/2 + suites 10/1।
   **Runtime self-independence पूर्ण — binary का हर बाइट या हमारा code या
   हाथ से बुलाया genuine Win32 API।** gcc अब विशुद्ध `as` + `ld`।

## 3. भाषा-अंतराल (Level 1/2 ने खोले)

**§3a — बिटवार बिल्टिन** (commit `bc26e19`, 2026-09-04)।
   6 पूर्णांक-बिट बिल्टिन — **builtin-रूप में, कोई lexer/parser बदलाव नहीं**
   (self-hosting parser पर जोखिम शून्य): `बिट_और`(&) · `बिट_या`(|) ·
   `बिट_भेद`(^, "differ") · `बिट_उलट`(~, 1-arg) · `बाम_सरक`(<<) ·
   `दक्षिण_सरक`(>> **तार्किक/unsigned `shrq`** — hashing/PRNG को यही चाहिए;
   गणना 6-बिट auto-mask, x86 जैसा)। `निम्नक_कॉल` इन्हें `अंतर्_बिट_*` node
   बनाता; `उत्_अंतर्` inline emit (`andq`/`orq`/`xorq`/`notq`/`shlq`/`shrq`;
   r10/r11 scratch, shift-गणना `%cl` में — `rcx` regalloc-pool में नहीं)।
   `सार्थक` whitelist (उलट 1-arg, बाकी 2) → seed **136031→137585**।
   पहले native-only था (C++ oracle टूटा); §3b ने ठीक किया — अब interp में भी
   (`52_bitwise.सूत्र` interp==native, 11 केस)। **अब xorshift PRNG / FNV
   hashing सूत्र में लिखे जा सकते।**

**§3b — C++ व्याख्याता (`sutra.exe`) build ठीक; bitwise अब interp में भी** (commit `3784030`, 2026-09-04)।
   `sutra.exe` (Aug 26 से frozen था, unbuildable) फिर से बनता है। 2 pre-
   existing rot ठीक किए (दोनों gitignored `संकलक/src/` में — repo "pure Sutra"
   है, C++ host dev-machine scaffold है, इसलिए ये fixes **commit नहीं होते**):
   - `environment.cpp`: `assign()` का `const SutraValue&` signature header के
     by-value से मेल नहीं खाता → header-match।
   - `interpreter.cpp`: 4 orphaned tracing call-sites (`StmtTrace` /
     `WatchpointScope` — classes पहले हटीं, call-sites रह गईं) + 3 write-only
     dead globals (`g_in_pada_vichhedan` / `_env` / `g_last_known_value` —
     definitions हटीं) → सब delete।
   सब 29 `.cpp` compile होते; `build.ps1` `[SUCCESS]`। **rebuilt `sutra.exe`
   64/64 मौजूदा tests पर Aug-26 binary से byte-identical** (oracle shift नहीं)।
   फिर bitwise 6 बिल्टिन `interpreter.cpp` + `semantic.cpp` में जोड़े →
   `tests/compiler/52_bitwise.सूत्र` (नया, interp==native)। `verify_bitwise.sh`
   हटा (52_bitwise ने replace किया)। **tests/compiler अब 52/53।**
   ⚠ fresh clone में `संकलक/src` नहीं (gitignored) → वहाँ C++ host + `verify_*`
   oracle नहीं; `bootstrap.ps1` (शून्य C++) फिर भी चलता।

**§3c — `-nostdlib` लिंक सख़्त: `--no-undefined` + exit-कोड जाँच** (commit `239da7d`, 2026-09-04)।
   कंपाइलर का अपना build-driver (`मूल_संकलन.सूत्र`) लिंक के बाद सिर्फ़
   `सञ्चिका_अस्ति(.exe)` जाँचता था → पिछली रन की **बासी `.exe` = झूठी
   "सफलता"** भले ही `as`/linker अभी-अभी विफल हुआ हो। यही अंधा-धब्बा
   `bootstrap.ps1` में भी।
   - `मूल_संकलन.सूत्र`: हर `as` step + final link से पहले `del /q` से बासी
     `.o`/`.exe` हटाओ, फिर `कमांड_चलाओ(...) != 0` (child exit-कोड, §2o में
     wired) जाँचो — विफलता पर `प्रक्षेपः`।
   - चारों लिंक-कमांड (`मूल_संकलन.सूत्र`, `bootstrap.ps1`,
     `verify_ir_selfhost.sh`, `verify_emit{,_full}.sh`) अब
     `-Wl,--no-undefined` पास करते। PE executable लिंक default में ही
     अनसुलझे प्रतीक पर त्रुटि देता; explicit flag इसे future flag-drift से
     बचाता + मंशा साफ़ दिखाता।
   - `bootstrap.ps1`: पहले `Remove-Item seed_sutrac.exe`, फिर लिंक-परिणाम
     पर `Test-Path` guard।
   seed **137585→138433**। fixed point कायम; verify_ir 52/2,
   run_suites 52/2 + stdlib 10/1, `52_bitwise` interp==native।

## 4. अनुकूलक-सुधार (optimizer / perf)

**§4a — बड़ा-immediate उत्सर्जक fix + बिटवार/एकल const-fold** (commit `988b649`, 2026-09-04)।
   दो हिस्से:
   - **उत्सर्जक (latent bug fix):** `movq $imm, mem` का immediate x86-64 पर
     केवल sign-extended **32-बिट** है। कोई भी folded स्थिरांक ±2³¹ के बाहर
     memory-स्लॉट में → `as` hard error ("operand type mismatch")। पहले से
     मौजूद bug — `1000000 * 1000000` अभी भी 10¹² में fold होता और build
     तोड़ता; किसी test ने छुआ नहीं था। `उत्_पूर्ण_भरो`: बाहर-रेंज मान +
     memory-गंतव्य → `movabsq $imm64, %r10` फिर `movq %r10, mem`
     (register-गंतव्य पर `as` खुद `movabs` चुनता)।
   - **अनुकूलक (const-fold विस्तार):** `स्थिर_तह` अब fold करता है —
     `अंतर्_बिट_{और,या,भेद,उलट,बाम_सरक,दक्षिण_सरक}` स्थिर operands पर
     (संकलन-काल मूल्यांकन §3a/§3b के `बिट_*` बिल्टिन से) + एकल `ऋणात्मक` /
     `नकार` स्थिर पर। साझा `स्थिर_में_बदलो` helper।
   `अनुकूलक_परीक्षण` +3 केस (bitwise fold · unary fold · >2³¹ fold);
   नया `tests/compiler/53_const_fold.सूत्र` (execute होता; interp==native;
   folded मान 2⁵² तक — movabsq पथ exercise करता)।
   seed **138433→140090**। fixed point + Gen1(split)==Gen2==Gen3;
   tests/compiler **53/2**, stdlib 10/1 (41/44/18_stdlib known, शून्य regression)।

**§4b — prologue GC-root पंजीकरण लूप** (commit `597d3e4`, 2026-09-04)।
   `उत्_कार्य` का prologue हर GC-जड़ के लिए **4 सीधी निर्देश** देता था —
   `movq $0, slot` (शून्य) + `leaq slot,%r11 ; movq %r11,(gc_roots[rax]) ;
   incl %eax` (पंजीकरण)। बहुत pointer-locals सुरक्षा-बिंदु पार जीवित →
   सैकड़ों prologue निर्देश। `पद_विच्छेदन` (lexer) में **123 जड़ें** →
   ~492 निर्देश सिर्फ़ जड़-सेटअप में।
   जड़-स्लॉट सन्निहित हैं (`रजि_जीसी_जड़ें` क्रमशः `ढेर, ढेर+8, …` देता;
   उच्च ऑफ = नीचा पता)। **>4 जड़ों पर एक ही fused लूप** — प्रति स्लॉट
   शून्य + पंजीकरण, `subq $8` walk, `decl %ecx ; jnz` — जड़-गिनती चाहे
   जो हो, **~10 निर्देश**। ≤4 जड़ें सीधी रहती (कोई शाखा नहीं)।
   रजिस्टर: `%eax`/`%r10`/`%r11`/`%ecx` — regalloc pool
   (rbx,rsi,rdi,r12-r15) से बाहर + prologue-बिंदु पर मुक्त (params घर आ
   चुके)। लेबल `.Lजड़_<fn>` प्रति-फलन unique।
   **असर:** compiler का अपना `.s` **140090 → 112481 पंक्ति (−20%)**;
   `sutrac.exe` **793552 → 629200 बाइट (−21%)**; `विश्लेषक.सूत्र` `.s`
   39301 → 30774 (−22%)। pointer/string/object-heavy कोड सब तेज़ +
   छोटा; शुद्ध-numeric कोड अछूता (उसमें GC-जड़ नहीं)।
   seed **140090→112481**। fixed point + Gen1(split)==Gen2==Gen3;
   tests/compiler 53/2, stdlib 10/1; GC tests (circular/repeated/realloc)
   पास (जड़-scan सही)।
   **⚠ स्थानीय-CSE आज़माया + छोड़ा:** local scalar-CSE सही था पर compiler
   में शून्य hit (redundancy `पढ़_क्षेत्र`/कॉल में, शुद्ध-अंकगणित में नहीं)
   + हल्का समय-खर्च। GVN + memory-effect ट्रैकिंग चाहिए — बाद के लिए।

**§4c — पाठ-साहित्य साझा तालिका (startup पर एक बार)** (commit `961084d`, 2026-09-04)।
   `उत्_स्थिर` हर `पाठ`-स्थिरांक के लिए **7 निर्देश + `पाठ_रचना` कॉल
   (heap alloc)** देता था — *हर बार जब निर्देश चलता*। compiler `कोड ==
   "स्थिर"` जैसे तुलन **प्रति-संकलन लाखों बार** करता → लाखों साहित्य-alloc
   + लगातार GC।
   **fix:** main-program में हर distinct पाठ-साहित्य startup पर **एक बार**
   `.bss` तालिका `.LC_strtab` में बनता (`सूत्र_पाठ_तालिका_आरंभ`, `main`
   में सबसे पहले — auto-GC arm होने से पूर्व, तो निर्माण के दौरान कोई GC
   नहीं); सारे slots **स्थायी GC-जड़** (कभी pop नहीं — साहित्य पूरे रन
   जीवित)। `उत्_स्थिर` फिर `movq .LC_strtab+8N(%rip), %reg` — **1 निर्देश,
   कोई कॉल, कोई alloc**। पुस्तकालय-मॉड्यूल inline पथ पर (उनमें init
   चलाने को `main` नहीं)। साहित्य immutable + कोई identity/`is` संकारक
   नहीं → object साझा सुरक्षित।
   **असर:** compiler `.s` **112481 → 102628 (−8.8%)**; `sutrac.exe`
   **629200 → 584838 बाइट**; `.s` में `पाठ_रचना` कॉल **3599 → 870** (हर
   साहित्य एक बार); **self-compile ~22s → ~8.5s (2.5×)** — compiler अपना
   अधिकांश समय अपने ही `==` तुलनों के साहित्य alloc + GC में खर्च करता था।
   seed **112481→102628**। fixed point + Gen1(split)==Gen2==Gen3;
   tests/compiler 53/2, stdlib 10/1; GC + string tests पास; bootstrap
   `[OK]`। 41/44 के diagnostic अंक थोड़ा shifted (स्थायी string-जड़ें GC
   accounting बदलती) — फिर भी known-श्रेणी, program output सही (लाइन 1-45
   मैच, सिर्फ़ `स्मृति_स्थिति()` लाइनें भिन्न)।
   **§4 संचयी: compiler `.s` 140090 → 102628 (−27%), binary 793552 →
   584838 (−26%), self-compile ~24s → ~8.5s (~3×)।**

**§4d — const-fold correctness: गतिशील/पाठ `+ 0` गलत तरीके से हटता था**
(commit `2576976`, 2026-09-04; script fixes `71fe7fe`)।
   `बीज_सरल` (x+0→x — Phase 1c से मौजूद, §4 का नहीं) हर `"योग"` निर्देश पर
   चलता जिसमें एक operand स्थिर 0/1 हो — पर यह पहचान केवल **शुद्ध
   पूर्णांक-अंकगणित** पर सच है। `निम्नक_द्विआधारी` हर binary `+` (string
   concat, dynamic add, float add, int add — सब) को **एक ही** `"योग"`
   opcode में lower करता, बस `अंश["विधि"]` (पूर्ण/पाठ/दशमलव/मान) से भेद
   करता — जिसे `बीज_सरल` कभी नहीं देखता था।
   नतीजा: `"x" + 0` → योग(x, 0) विधि="मान" (गतिशील, एक ओर पाठ) → `बीज_सरल`
   का b==0 नियम माचता, पूरा instruction सिर्फ़ `x` में बदल देता — string-concat
   कॉल **पूरी तरह गायब**! (`"" + 0` empty-string print करता, "0" नहीं)।
   **मिला कैसे:** `tests/intrinsics/04_string_ops.सूत्र` इसे पकड़ता — पर वह
   suite हफ़्तों से नहीं चली थी क्योंकि `verify_intrinsics.ps1` एक बासी
   compiler-binary-नाम (`मूल_संकलन_native.exe`, कभी नहीं बना) खोजता था।
   उसी दौरान 2 और बासी scripts मिले+ठीक किए — `verify_compiler.ps1`
   (retired `sutra.exe build` C++ पथ इस्तेमाल करता था, अब `sutrac.exe`
   सीधे; + एक filename bug — `BaseName` बनाम `sutrac.exe`'s असली
   `<name>.सूत्र_native.exe` पैटर्न, हर test "not found" दिखाता था) और
   `verify_compiler_self.ps1` (पुराना नाम `sutra_self.exe` खोजता)।
   **fix:** `बीज_सरल` अब `विधि != "पूर्ण"` पर तुरंत `परत् 0-1` (कोई
   सरलीकरण नहीं)। दोनों-operand-स्थिर fold-पथ (`स्थिर_गणना`) प्रभावित नहीं
   — पाठ/दशमलव literals कभी `स्थिरांक` नक्शे में नहीं आते, तो वह सिर्फ़
   तभी चलता जब दोनों ओर सचमुच पूर्ण हों (जो पहले से विधि="पूर्ण" implies करता)।
   seed **102628→102682**। fixed point + Gen1(split)==Gen2==Gen3;
   tests/compiler 53/2, stdlib 10/1 (अपरिवर्तित); `verify_intrinsics.ps1`
   अब **4/4**; `verify_compiler.ps1`/`verify_compiler_self.ps1` अब **55/57**
   (सिर्फ़ known 41/44)।

**§4e — 41/44 को genuinely हल किया (Niraj का निर्णय: GC-counters compare
करना कभी सही जाँच नहीं थी)** (commit `e02fa68`, 2026-09-04)। `स्मृति_स्थिति()`
के सक्रिय/संग्रहित अंक collector-कार्यान्वयन-विशिष्ट हैं (interp conservative
scope-rooting, native precise SSA-liveness — §4b ने इसे और तेज़ किया) —
दोनों कभी बराबर नहीं होने वाले, तो diff करना correctness-जाँच नहीं था।
   - `41_dynamic_list_stress.सूत्र`: सिर्फ़ खंड M का इकलौता incidental
     `स्मृति_स्थिति()` call हटाया (`संग्रह_करो()` रखा — असली जाँच खंड N है:
     GC के बाद सूची-क्रियाएँ सही चलें)। बाकी 129 लाइन/13 खंड अछूते।
   - `44_gc_status.सूत्र` → `tests/diagnostics/` (नया) — इसका पूरा उद्देश्य
     ही GC-अकाउंटिंग दिखाना है, parity-जाँच असंभव बिना native की precise
     rooting को interp जैसा conservative बनाए (असली regression) या
     interpreter में precise liveness (गिटइग्नोर्ड test-oracle पर बड़ा
     खर्च, बिना असली फ़ायदे के)। `tests/intrinsics/` को पहले से यही
     treatment मिला हुआ (वही कारण — interpreter इसे model नहीं करता)।
     अब भी compile+run होता, बस automated parity-count से बाहर।
   **tests/compiler: genuinely 54/54, ZERO known-failures बचे।** fixed
   point 102682 अपरिवर्तित; stdlib अब सिर्फ़ `18_stdlib` (tagged-value/
   `मान`-सीमा भाषा-सीमा, अलग मुद्दा — §देखें भाषा-अंतराल)।

**§4f — jump-chain threading + branch-edge हॉप हटाया** (commit `156b56b`, 2026-09-04)।
   विश्लेषक.सूत्र के generated `.s` में control-flow waste खोजा (वही empirical
   तरीका जिसने §4b/§4c पकड़े) — दो अलग waste-source मिले:
   - **`जाओ_सरल` (IR-स्तर, नया pass):** if/elif lowering कभी-कभी एक खंड छोड़
     देता जिसका पूरा शरीर सिर्फ़ एक बिना-शर्त `जाओ` अगले खंड तक — pure chain
     hop, कोई काम नहीं। जो खंड किसी फाई का स्रोत नहीं (value-merge ambiguity
     का सवाल ही नहीं), उसे हर `जाओ`/`यदि_जाओ` transitively बायपास कर देता
     (चक्र-सुरक्षा सहित); DCE फिर अगम्य chain-खंड हटा देता। फाई-referenced
     खंड कभी नहीं छूता। नया isolated unit test (हाथ से `मध्यम_*` builders से
     trivial-खंड IR बनाकर — असली parser की lowering सरल if-chains पर पहले
     से ही trivial-आकार से बचती, तो जटिल control-flow पर ही असल में trigger
     होता)।
   - **`उत्_टर्मिनेटर` (emitter-स्तर, बड़ा वाला):** `यदि_जाओ` हमेशा एक
     अतिरिक्त `.L_किनारा_N` लेबल आवंटित करता था — `cmpq`/`je-to-किनारा`/
     `jmp-सत्य`/`किनारा:`/`jmp-असत्य` — 2-तरफ़ा branch एन्कोड करने को **5
     निर्देश**। यह edge-लेबल सिर्फ़ असत्य-किनारे के phi-resolution moves
     (`उत्_फाई_चालें`) को रहने की जगह देने को था; जब असत्य-गंतव्य पर कोई
     फाई ही नहीं, moves resolve करना गारंटीड कुछ नहीं देता — पूरा detour
     व्यर्थ। अब पहले से जाँच: असत्य-गंतव्य पर फाई नहीं → सीधे
     `je <असत्य-लक्ष्य>`, कोई किनारा नहीं, **3 निर्देश**। फाई मौजूद होने पर
     पुराना किनारा-पथ बरकरार (वहाँ अब भी सही चाहिए)।
   **असर:** विश्लेषक.सूत्र `.s` 30774 → 30086; compiler का अपना self-compiled
   `.s` 102682 → 101110। seed **102682→101110**। fixed point +
   Gen1(split)==Gen2==Gen3; tests/compiler 54/54, stdlib 10/1 (अपरिवर्तित);
   `verify_ir.ps1` 4/4 (अनुकूलक_परीक्षण अब 15 checks)।

**§4g — LICM आज़माया + पूरी तरह छोड़ा (कोई commit नहीं — साफ़ revert)।**
   `यावत् (इक < लंबाई(...))` पैटर्न कोडबेस में 130+ जगह; `लंबाई` हमेशा एक
   runtime कॉल है। सुरक्षित LICM लिखा: लूप में कोई भी बुलाओ/अंतर्/
   विधि_बुलाओ/लिख_अनुक्रम/नव्_* हो तो पूरे लूप से hoist मत करो (list
   grow/shrink/alias हो सकता)। hand-built IR पर pass खुद सही साबित हुआ,
   पर **असली compiler पर `call दैशिक_लंबाई` गिनती बिल्कुल नहीं बदली
   (264==264) — कहीं भी hoist नहीं हुआ**, और नए pass के अपने कोड (~200
   line) से self-compiled `.s` **101110 → 103062 (+1952, regression)**।
   **कारण:** एक recursive-descent parser के लगभग हर लूप में कोई-न-कोई
   कॉल होता ही (parse helper बुलाना) — रूढ़िवादी "लूप में कॉल = मत छुओ"
   नियम हर असली लूप को disqualify कर देता। स्थानीय-CSE (§4b, पहले भी
   छोड़ा) की वही जड़-वजह। साफ़ `git checkout` से revert — seed 101110
   अपरिवर्तित।

## 5. Points-to विश्लेषण — बहु-सत्र योजना (Niraj का निर्णय, 2026-09-05)

§4b (local-CSE) और §4g (LICM) दोनों एक ही दीवार से टकराए: किसी भी कॉल को
"शायद कुछ भी बदल दे" मानना पड़ता — और compiler के अपने कोड में लगभग हर
लूप में कोई कॉल होता ही। एक साधारण "यह फलन शुद्ध है क्या" (boolean) से भी
काम नहीं चलेगा — parse helpers जैसे फलन कुछ-न-कुछ लिखते ज़रूर हैं (जैसे
परिणाम-सूची में जोड़ना), भले ही वे उस specific चर को न छुएँ जिसकी परवाह
है। "यह कॉल *उस* वस्तु को नहीं छू सकता" बनाम "छू सकता है" में फ़र्क करने
को असली alias/points-to जानकारी चाहिए।

**Niraj का निर्णय:** पूरा points-to analysis बनाओ, चाहे कितने सत्र लगें
(§4a/§4g से नया factor — मूल_रनटाइम.सूत्र जैसे library-मॉड्यूल का कॉल
opaque रहेगा जब तक उन्हें भी हाथ से classify न करें — self-compile पर
फ़ायदा शायद छोटा हो, पर यह एक genuine, general भाषा-क्षमता है जो आगे
GVN/LICM/cross-call CSE — सब के लिए नींव बनेगी)।

**योजना — 4 milestone, हर एक अपने-आप में सुरक्षित रूप से रुकने लायक:**
- **✅ Milestone 1 — intraprocedural (commit `735d09e`, 2026-09-05)।**
  `बिंदु_विश्लेषण.सूत्र`: हर फलन के भीतर, हर SSA मान किन allocation-sites
  (नव_सूची/नव_शब्दकोश/नव_वस्तु/नव_पाठ/पाठ-स्थिरांक) की ओर इशारा कर सकता
  है — field-insensitive (साझा "भंडार" प्रति वस्तु) + flow-insensitive
  (पूरे फलन पर एक fixpoint, प्रोग्राम-बिंदु के अनुसार नहीं) — दोनों सुरक्षित
  over-approximation (miss कर सकते, गलत नहीं)। पैरामीटर + कॉल-नतीजे अभी
  ⊤ ("पता नहीं")। `बिं_उपनाम_हो_सकता(अ, ब)` — मुख्य क्वेरी।
  **`बिंदु_विश्लेषण_परीक्षण.सूत्र`** — हाथ से `मध्यम_*` builders से IR
  बनाकर 5 परिदृश्य पक्के किए (स्वतंत्र आवंटन अलग रहते, phi दोनों स्रोतों
  से alias पर वे आपस में नहीं, store→load सही ट्रैक होता, पैरामीटर/
  कॉल-नतीजे ⊤)। **टेस्ट लिखते ही एक असली bug मिला** — `बिं_उपनाम_हो_सकता`
  ⊤ को खास केस नहीं मानता था (सिर्फ़ concrete-site-overlap जाँचता), तो एक
  पैरामीटर (⊤) किसी fresh local allocation से alias **नहीं** दिखाता —
  ठीक उल्टा जो एक conservative analysis को चाहिए। पहले असली test-run से
  पहले ही पकड़ा + ठीक किया। `verify_ir.ps1` में जोड़ा (5/5, 10 नए checks)।
  **कहीं wire नहीं — `मूल_संकलन.सूत्र` इसे import नहीं करता, seed
  byte-identical (101110) रहा।**
- **✅ Milestone 2 — interprocedural, एक ही एकक के भीतर** (commit `0317848`,
  2026-09-05)। `विधि_बुलाओ` को अलग handle करने की ज़रूरत ही नहीं पड़ी —
  निम्नक हर method-कॉल को स्थिर रूप से mangled नाम ("वर्ग_<वर्ग>_<विधि>")
  वाले सादे `बुलाओ` में resolve कर देता (मूल_निम्नक.सूत्र); `विधि_बुलाओ`
  opcode मध्यम.सूत्र में सिर्फ़ दस्तावेज़ है, lowering कभी emit नहीं करता
  (मूल_उत्सर्जक की अपनी टिप्पणी: "स्थगित")। कोई first-class fn नहीं तो
  पूरा call-graph स्थिर रूप से जाना जाता — कोई indirect/virtual dispatch
  ही नहीं।
  **तरीका:** context-insensitive (एक फलन के सारे call-site मिलकर एक
  पैरामीटर-सेट बनाते) + पूरे मॉड्यूल पर एक बाहरी fixpoint — हर दौर हर
  फलन का intraprocedural विश्लेषण ताज़ा सीड से दोहराता, जब तक कुछ न बदले।
  पुनरावर्तन (recursion/mutual) को अलग SCC-क्रम की ज़रूरत नहीं — fixpoint
  खुद संभाल लेता। मॉड्यूल के बाहर के कॉल (library — Milestone 3) अब भी ⊤।
  `बिं_फलन_विश्लेषण(फलन)` (Milestone 1 का entry-point) अब सिर्फ़ नए
  `बिं_फलन_विश्लेषण_सन्दर्भ(फलन, शून्यम्)` का wrapper — पुराना व्यवहार +
  सारे 10 Milestone-1 checks बिल्कुल अपरिवर्तित।
  **टेस्ट लिखते ही एक असली convergence bug मिला:** बाहरी fixpoint पिछले
  दौर के संग्रहीत मान में *संघ (union)* जोड़ रहा था, replace नहीं। दौर 1
  में किसी फलन के कॉल-स्थल न मिलें तो पैरामीटर ⊤ मान लिया जाता; दौर 2 में
  असली (छोटा, सटीक) सेट मिलता — पर संघ सिर्फ़ बढ़ा सकता, घटा नहीं, तो
  दौर-1 का ⊤ हमेशा के लिए चिपक जाता और **Milestone 2 का पूरा मकसद ही
  silently बेकार हो जाता** — कभी परिशुद्ध न होता। **fix:** हर बाहरी दौर
  अब Jacobi-शैली — इसी दौर के ताज़ा विश्लेषणों से पैरा/वापसी-बिंदु पूरी
  तरह फिर बनते, पिछले दौर से नक्शा-बराबरी जाँचकर बदलाव तय होता, फिर swap।
  नया test (एक फलन जो सिर्फ़ अपना तर्क लौटाता, एक pointer से बुलाकर एक
  असंबंधित से तुलना) असली फ़ायदा दिखाता: Milestone 1 सिर्फ़ "शायद" कह
  सकता (⊤ सब कुछ से alias); Milestone 2 सही ढंग से "नहीं" साबित करता।
  स्व-पुनरावर्ती फलन (fixpoint बिना अनंत-लूप रुकता) + बहु-कॉलर merge
  (context-insensitive होने की सीमा जान-बूझकर दस्तावेज़ की — sound, पर
  maximally सटीक नहीं) के टेस्ट भी जोड़े।
  `verify_ir.ps1` अब भी 5/5, `बिंदु_विश्लेषण_परीक्षण` 16 checks (था 10)।
  **कहीं wire नहीं — seed byte-identical (101110) रहा।**
- **✅ Milestone 3 — runtime-library hand-classification** (commit `4c578df`,
  2026-09-05)। मूल_रनटाइम.सूत्र की functions का IR analysis को कभी नहीं
  दिखता (अलग compilation unit) — Milestone 2 का हर ऐसा कॉल ⊤ पर गिर
  जाता, चाहे कुछ भी पता क्यों न हो। **हर entry असली स्रोत पढ़कर बनाई
  (अनुमान से नहीं)** — यहाँ ग़लत classification = silent miscompilation।
  compiler के अपने `मूल_संकलन.सूत्र` के compiled `.s` से `call X` लक्ष्य
  निकालकर उसके अपने functions से अलग किए — यही असली-इस्तेमाल-होने-वाली
  सूची थी।
  **4 प्रभाव-आकार, compiler जितने भी library-कॉल करता उन सबको ढाँपते:**
  - **शुद्ध** — नतीजा हमेशा ताज़ा। सारे `पाठ_*` (पाठ अपरिवर्तनीय — कभी
    तर्क में लिखते नहीं, हमेशा नया बनाकर byte-copy: पाठ_जोड़/पाठ_रचना/
    पाठ_उपखंड/पाठ_योग_गतिक/पाठ_संयोग/अक्षर_बना/पाठ_सूचकांक), सूची_रचना/
    शब्दकोश_रचना (ताज़ा-आवंटन ही), + हर non-pointer नतीजे वाला फलन
    (दैशिक_लंबाई, पाठ_तुल्य, सामान्य_*, गतिशील_छापो, …) — बिं_सूचक_है वैसे
    भी इन्हें पहले गेट कर देता, तो "शुद्ध" यहाँ भी सुरक्षित catch-all है।
  - **उपनाम** — नतीजा ठीक एक तर्क के बराबर। सूची_जोड़/सूची_निकाल —
    सूची_जोड़ क्षमता कम पड़ने पर सूत्र_पुनः_आवंटन से पता बदल सकता, फिर
    भी तार्किक रूप से वही सूची, तो तर्क0 का उपनाम मानना सुरक्षित।
  - **भंडार** — नतीजा जो तर्क में पहले से रखा था। सूची_सूचकांक — बिल्कुल
    वही जो local `पढ़_अनुक्रम` करता।
  - **कंटेनर_प्रतिलिपि** — नतीजा नई वस्तु, पर उसके तत्व तर्क के भंडार से।
    शब्दकोश_कुंजियाँ_रन — नई सूची बनती, पर तत्व dict की entries से आते।
  सूची_जोड़ + सूची_सूचकांक_सेट **लेखन भी दर्ज करते** — store हुए मान का
  बिंदु लक्ष्य-तर्क के भंडार में जुड़ता, ठीक वैसे ही जैसे local `लिख_अनुक्रम`
  करता — यह नतीजे के pointer होने से independent लागू होना ज़रूरी था
  (सूची_सूचकांक_सेट पूर्ण लौटाता, फिर भी लेखन-प्रभाव लगना चाहिए)।
  तालिका interprocedural context (Milestone 2) से स्वतंत्र — Milestone 1
  के plain `बिं_फलन_विश्लेषण(फलन)` को भी उतना ही फ़ायदा देती।
  **13 नए checks — सब पहली बार में पास (M1/M2 जैसा कोई bug नहीं मिला इस
  बार)।** `verify_ir.ps1` 5/5, कहीं wire नहीं — seed byte-identical (101110)।
- **✅ Milestone 4 भाग A — written-sites सारांश** (commit `1168ec0`,
  2026-09-05)। हर फलन के लिए `प्रत्यक्ष_लेखन` — वो abstract sites जो यह
  फलन *transitively* (अपने calls के ज़रिए भी) लिख सकता है — ताकि भविष्य
  का LICM "लूप में कोई भी कॉल = मत छुओ" की जगह "लूप में कोई कॉल जो *इस
  specific* आधार को लिख सकता है = मत छुओ" पूछ सके (§4g की असफलता की सीधी
  जड़ यही अंधी रूढ़िवादिता थी)।
  `लिख_अनुक्रम`/`लिख_क्षेत्र` का आधार सीधे जुड़ता; library कॉल के लिए M3 की
  effect-table का `लेखन` field इस्तेमाल होता; module-भीतरी callee के लिए
  पिछले दौर का (Jacobi) `लिखे_स्थल[नाम]` जुड़ता; genuinely unknown कॉल
  रूढ़िवादी रूप से ⊤ जोड़ देता। `लिखे_स्थल` को module fixpoint में
  वापसी_बिंदु/पैरा_बिंदु जैसे ही **replace-not-union Jacobi pattern** से
  थ्रेड किया (M2 की गलती दोहराने से बचने के लिए सोच-समझकर, बिना किसी नए
  bug के)। नया query API: `कग_लेखन_छू_सकता(विश्लेषण, आईडी)`।
  **8 नए checks (12-15)** — सीधा लेखन, library-कॉल लेखन, transitive
  module-भीतरी लेखन, अपरिचित-कॉल रूढ़िवादिता — सब पहली बार में पास (कुल
  30/30)। `verify_ir.ps1` 5/5, कहीं wire नहीं — seed byte-identical
  (101110), पूरा self-host fixed point + bootstrap.ps1 हरा।
- **🟡 Milestone 4 भाग B — LICM logic बनी + सत्यापित, पर wiring blocked
  (commit `aed402e`, 2026-09-05)।** §4g की LICM फिर से बनाई — नया
  `स्वसंकलक/लूप_अनुकूलन.सूत्र`: Cooper-Harvey-Kennedy dominators →
  प्राकृतिक-लूप पहचान (back-edge + backward reachability) → **प्रति-लूप**
  (प्रति-फलन नहीं) written-sites — सिर्फ़ उस लूप के अपने ब्लॉक स्कैन करके
  — जिससे `लंबाई` कॉल्स को hoist किया जाता जब आधार लूप के बाहर परिभाषित
  हो और लूप में कहीं भी उसे छूने वाला कोई लेखन न हो। नेस्टेड लूप सही ढंग
  से संभलते (भीतरी को अपना preheader मिलता, बाहरी को अपना, एक ही pass
  में)। असली parser से 5 structural tests (हाथ-से-बनी IR नहीं — फ्रैजाइल
  phi/back-edge से बचने को), 8/8 checks पास।
  **लिखते समय एक असली bug मिला**: साझा `बिं_स्थल_अतिच्छादन` की "कोई भी
  पक्ष ⊤ हो तो टकराव मान लो" rule हर उस hoist को ग़लत तरीके से रोक देती
  जिसका आधार एक अनसुलझा (⊤) पैरामीटर हो — भले ही लूप वाकई कुछ भी न लिखे।
  खाली written-set किसी से नहीं टकरा सकता, चाहे आधार की पहचान कितनी भी
  अनिश्चित हो। Fix: एक अलग, स्थानीय `लूइनी_लेखन_टकराव` चेक (साझा M1-4
  फलन को बदले बिना)।
  **असली compiler पर empirically मापा** (`मूल_संकलन.सूत्र`+`अग्र_चालक.सूत्र`
  में अस्थायी रूप से wire करके, फिर revert — कमिट नहीं हुआ): विश्लेषक.सूत्र
  पर अकेले 8 असली hoist चले (§4g के शून्य के उलट — पहली बार LICM सच में
  कुछ hoist कर रहा है)। पर पूरे compiler का self-compile ~11s → ~15s हो
  गया — सिर्फ़ hoist-step हटाकर isolate किया तो पूरा regression
  `कग_मॉड्यूल_विश्लेषण` की अपनी लागत से है (20-दौर बाहरी fixpoint, हर
  दौर में हर फलन का 50-दौर तक भीतरी fixpoint — हर एक compile पर, चाहे
  उस फलन में hoist-योग्य लूप हो या न हो) — LICM का अपना कोड नगण्य समय
  जोड़ता। **Unwired छोड़ा** (M1-4A जैसा ही अनुशासन) — wire करने से पहले
  points-to विश्लेषण की अपनी गति सुधारनी होगी (शायद: सिर्फ़ लूप-वाले
  फलनों पर चलाओ, या fixpoint दौर घटाओ, या incremental/worklist-आधारित
  बनाओ — अभी अन्वेषित नहीं)। seed अपरिवर्तित (101110), पूरा self-host
  fixed-point + bootstrap.ps1 दोनों हरे।

**2b. मानक पुस्तकालय (`पुस्तकालय/`) — सूत्र में** (commits `07205ac` + `c07ba45`, 2026-09-01)।
   Phase 2 रोककर पहले लाइब्रेरी (Niraj का निर्णय)। **12 मॉड्यूल**, कोई C
   नहीं, interp/native समान (`tests/stdlib/` 8 फ़ाइलें):
   - बैच 1: `सूची` (30 ops + merge-sort + binary-search) · `शब्दकोश` ·
     `पाठ` · `समुच्चय` (Set) · `ढेर` (Stack) · `कतार` (Queue)
   - बैच 2: `गणित` (number-theory + stats + seedable MINSTD PRNG — सूत्र में
     बिटवार नहीं तो xorshift असंभव) · `प्रारूप` (templates + संख्या-प्रारूप +
     आधार-रूपांतरण) · `जेसन` (बनाओ/सुंदर/पार्स, कुंजियाँ क्रमबद्ध) ·
     `क्रमचय` (itertools) · `ढेर_प्राथमिकता` (min-heap PQ) · `परीक्षण` (mini
     test framework: जाँच/जाँच_निकट/परीक्षण_सारांश)
   - `मानक.सूत्र` सब import; `README.md` में **9 भाषा-सीमाएँ** documented
     (कोई first-class fn / static method-call resolution / class-typed local
     / bool-return display / `हटाएं` on dict / कुंजियाँ order / **कोई tagged
     मान → native में बूल/दशमलव `मान`-सीमा पार करते ही संख्या बन जाते** /
     `स्व.field[i]=v` / int literal ≥ 2³¹)। बैच 2 में **कोई compiler बदलाव
     नहीं** चाहिए (tests/compiler 51/52 बरकरार)।
   **बैच 1 में रास्ते के 2 पूर्व-मौजूद IR bugs मिले+fix** (commit `b99a12a`):
   (1) बहु-प्रविष्टि शब्दकोश-साहित्य `{"अ":1,"ब":2}` — निम्नक `युगल[0/1]`
   पढ़ता था पर parser `{कुंजी, मानः}` देता → हर key+value `$0` बनता था
   (कोई test literal से value नहीं पढ़ता था तो पकड़ा नहीं गया)।
   (2) `सूची[i] < सूची[j]` — `मान`-operands पर raw `cmpq` → पाठ-सूचकों की
   पूर्णांक-तुलना। `सामान्य_*` helpers (पाठ→कोडबिंदु, वरना पूर्णांक)।
   नया regression test `tests/compiler/50_dict_literal.सूत्र` (51/52)।

### Phase 3 — अपना assembler + linker। **स्थगित** (deferred)
अभी `as` / `ld` (GNU) इस्तेमाल होते रहेंगे। बाद में: x86-64 encoder +
COFF/ELF writer + minimal linker → Level 2 independence।

### Phase 4 — ARM64 backend। ~1-2 महीने
IR की वजह से "नया backend" बस। `as` ARM cross-assemble करता है।
- **Milestone: सूत्र on Apple Silicon / Linux ARM / phones**

### Phase 5 — LLVM release backend (निर्णय B)। ~1 महीना
`sutra build --release` → सूत्र IR → LLVM IR text (`.ll`) → `llc`/`clang`।
pure-सूत्र backend `sutra build` का default रहता है। LLVM external tool
है (`as` जैसा), dependency नहीं।
- **Milestone: `--release` builds clang-tier — यहीं "C++ से टक्कर"**

### Phase 6 — domain performance। ongoing
SIMD + autovec, tensor types, GPU (SPIR-V / PTX IR से emit),
WASM backend (web), async runtime।

## निर्णय (Niraj, 2026-08-30): **B**

**अपना optimizer + LLVM release backend।**
- **default** (`sutra build`) → अपना सूत्र backend: IR → अपना optimizer →
  linear-scan regalloc → `.s` text → `as`/`ld`। यही पहचान, dev loop,
  पूरा control, "pure सूत्र" कहानी।
- **`sutra build --release`** → IR → LLVM IR → `llc`/`clang` (external
  tool, बिलकुल `as` जैसा)। यहीं "C++ tier" performance आती है — clang का
  वही backend।

दोनों एक ही सूत्र IR से निकलते हैं। LLVM सिर्फ़ एक वैकल्पिक backend है,
कोई dependency नहीं जो पूरे project को बाँधे। Zig / early-Rust model।
