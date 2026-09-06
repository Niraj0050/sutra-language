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

- **🟡 फलन-इनलाइनिंग v1 — logic बनी + सत्यापित, पर wiring blocked**
  (commit `3aabb16`, 2026-09-05)। सूत्र बनाम `g++ -O2` benchmark में सबसे
  बड़ा नापा गया अंतर यही निकला — `fib(35)` में ~30 करोड़ recursive calls,
  हर एक पूरा call-overhead (stack frame, argument marshalling) भरता, कोई
  inlining नहीं। नया `स्वसंकलक/अंतर्वेशन.सूत्र`: same-module,
  non-recursive, single-basic-block callee (≤20 निर्देश) को call-site पर
  सीधे splice करता — कोई नया ब्लॉक/CFG/phi नहीं चाहिए, बस निर्देश-क्लोन +
  fresh ids + पैरामीटर→argument rename + `अनु_हर_उपयोग_बदलो` से
  परिणाम-rewrite। Splice के बाद बदले हुए काॅलर पर `अनुकूलक_कार्य` फिर
  चलती ताकि constant argument सीधे inlined body से होकर fold हो जाए
  (structural tests में confirmed — const argument वाला call पूरा एक
  `स्थिर` में fold हो गया)। 6 tests (असली parser, लूप_अनुकूलन_परीक्षण जैसी
  शैली): मूल splice, दो स्वतंत्र call-site, self-recursion negative,
  multi-block negative (v1-सीमा), oversized-callee negative — सब पास।
  `verify_ir.ps1` 7/7, कहीं wire नहीं — seed byte-identical (101110)।
  **अस्थायी रूप से `मूल_संकलन.सूत्र`+`अग्र_चालक.सूत्र` में wire करके मापा**
  (M4-B जैसा ही तरीका): self-compile time **~9.3s → ~17.9s (लगभग दोगुना,
  +92%)** — साफ़ regression, तुरंत `git checkout` से revert किया (कमिट
  नहीं हुआ)।
  **fix 1 — mem2reg हटाओ (commit `935f2a4`)**: पूरा `अनुकूलक_कार्य`
  (जो स्लॉट_उन्नयन/mem2reg दोबारा चलाता, पहले से SSA कोड पर बेकार) की
  जगह हल्का `अवे_हल्की_सफाई` (सिर्फ़ const-fold+jump-thread+DCE, 5 दौर)।
  **नतीजा: ~17.9s → ~16.2s (+92%→+74%) — छोटा सुधार, असली समस्या हल
  नहीं हुई।** standalone module में रखा (हानिरहित, भले ही निर्णायक न
  हो), पर wiring फिर unwired ही रही।
  **M4-B जैसा ही step-by-step ablation किया** (हर हिस्सा एक-एक करके
  अस्थायी रूप से बंद करके मापा, हर बार `git checkout` से साफ़ revert):
  (क) पूरा post-splice cleanup ही हटा दिया (सिर्फ़ splice, कोई भी
  दोबारा-optimize नहीं) → **~16.2s — बिल्कुल कोई फ़र्क नहीं** — मतलब
  cleanup राउंड्स कभी भी दोषी नहीं थे, न mem2reg-सहित न उसके बिना।
  (ख) `अनु_हर_उपयोग_बदलो` (per-splice result-rename का पूरा
  function-wide scan) भी हटाकर देखा → **~15.8s — फिर लगभग कोई फ़र्क
  नहीं**। (ग) असली clone/splice ही हटाकर सिर्फ़ detection (हर `बुलाओ` पर
  `अवे_योग्य_फलन` जाँच, बिना कुछ बदले) रखा → **~11s** — यानी detection
  का अपना overhead सिर्फ़ ~1.7s (~18%) है। **निष्कर्ष: असली लागत
  detection में नहीं, rename में नहीं, cleanup में नहीं — बल्कि खुद
  clone-and-splice के काम में है (`अवे_क्लोन_करो`: हर eligible call-site
  पर नया rename-नक्शा शब्दकोश + हर callee-निर्देश के लिए नया शब्दकोश
  object बनाना) — यह ~11s से ~16.2s तक की पूरी बढ़त अकेले खाता है।** यह
  "बेकार दोहराया काम" नहीं है (जैसा mem2reg या LICM का कग_मॉड्यूल_विश्लेषण
  था) — यह असली, ज़रूरी काम है, बस compiler के अपने स्रोत में इतने ज़्यादा
  eligible call-sites हैं (compiler खुद छोटे helper functions से भरा है
  — ठीक वही property जो इसे inlining के लिए आदर्श बनाती, वही इसकी अपनी
  लागत भी बढ़ाती) कि हर एक की अपनी शब्दकोश-allocation लागत (mark-sweep
  GC, generational नहीं) जुड़कर सेकंडों में बदल जाती।
  **महत्वपूर्ण संदर्भ**: यह लागत सिर्फ़ *compiler खुद को compile करने*
  में लगती — compiler से बने साधारण उपयोगकर्ता प्रोग्राम की runtime speed
  पर इसका सीधा असर नहीं।

- **✅ फलन-इनलाइनिंग — असल में WIRE हुई** (commit `3a09dd1`, 2026-09-05)।
  ऊपर की cost सिर्फ़ compile-time थी — असली सवाल था: क्या यह किसी असली
  compiled प्रोग्राम को तेज़ बनाती? **मापा गया** — छोटा helper-function
  benchmark (`कार्य वर्गफल(अ){परत् अ*अ;}`+`कार्य जोड़दो(...)` एक 5×10⁸-दौर
  लूप के अंदर, दोनों compiler-वैरिएंट से native compile करके time किया):
  **बिना inlining ~3.2s → inlining के साथ ~0.71s — ~4.5x runtime speedup**।
  `g++ -O2` उसी प्रोग्राम पर ~0.24s — inlining अकेले C++ का gap **~13x से
  ~3x** तक ले आया। दोनों binaries का output बिल्कुल मैच (overflow-wrapped
  value तक)।
  **निर्णय: इस बार wiring commit की** — पिछले सभी मामलों (M4-B का LICM,
  खुद इसी pass का पहला प्रयास) में "unwired छोड़ो" इसलिए चुना गया था
  क्योंकि फ़ायदा या तो साबित नहीं था या लागत के मुक़ाबले साफ़ नहीं दिखा।
  यहाँ फ़ायदा सीधे मापा गया और लागत से कहीं बड़ा है — यही standard
  compile-time-बनाम-runtime-speed trade-off है जो हर mainstream
  optimizing compiler (GCC/Clang/Rust) मानता है: compiler खुद को बनाने
  में ज़्यादा वक़्त, पर हर बना हुआ प्रोग्राम हमेशा के लिए तेज़।
  **पूर्ण सत्यापन**: `verify_ir.ps1` 7/7; पूरा self-host fixed point
  **134245 lines** पर पहुँचा (101110 से — inlining हर call-site पर कोड
  duplicate करता, यह वृद्धि अपेक्षित); `tests/compiler` 54/54 (कोई
  regression नहीं — correctness बरक़रार); `tests/stdlib` 10/11
  (पूर्व-मौजूद `18_stdlib` सीमा, असंबंधित); bitwise interp==native कायम।
  **seed ताज़ा किया** (`स्वसंकलक/निर्माण/मूल_संकलन.s`, 101110→**134245**)
  और दोबारा `bootstrap.ps1` से पुष्टि — नई जमी हुई seed से भी fixed point
  `[OK]`। **§4/§5 का यह पहला बदलाव है जो असल में डिफ़ॉल्ट pipeline में
  स्थायी रूप से जुड़ा** (M1-4A + M4-B + LICM सब standalone/unwired रहे)।

- **⏸️ LICM/points-to wiring — DEPRIORITIZED** (2026-09-05, कोई नया commit
  नहीं — निर्णय-रिकॉर्ड)। इनलाइनिंग के wire होने के बाद LICM को भी उसी
  तरह wire करने की कोशिश की — पहले सुझाया "points-to को सिर्फ़
  loop-वाले फलनों तक scope करो" तरीका आज़माने से पहले असली data लिया:
  **दोनों "सस्ते fix" candidates measure करके ग़लत साबित हुए:**
  1. **Loop-scoping**: विश्लेषक.सूत्र (90 फलन) पर जाँचा — सीधे loop-वाले
     सिर्फ़ 21 (~23%), पर उनके transitively-called फलन जोड़ते ही **पूरे 90
     (100%) तक पहुँच गया** — compiler का call-graph इतना आपस में जुड़ा है
     (parser/lexer में loops ही control-flow की रीढ़ हैं) कि यह scoping
     कोई भी कटौती नहीं देती।
  2. **Round-cap घटाना**: पूरे compiler (300 फलन) पर असली round-गिनती
     मापी — बाहरी fixpoint **14 दौर** लेता (cap 20 में से — कभी टकराता
     नहीं), भीतरी fixpoint औसत **2.17 दौर**, अधिकतम 12 (cap 50 में से)।
     caps पहले से ही ज़रूरत से बड़े हैं, घटाने का कोई फ़ायदा नहीं — असली
     लागत 300×14=4200 पूर्ण function-विश्लेषण है, जो इस Jacobi-fixpoint
     डिज़ाइन में ही अंतर्निहित है (हर बाहरी दौर में हर फलन दोबारा,
     चाहे कुछ बदला हो या नहीं) — caps की बर्बादी नहीं।
  **निष्कर्ष**: कोई सस्ता fix नहीं बचा। असली उपाय एक **incremental/
  worklist-आधारित fixpoint** होगा (सिर्फ़ वही फलन दोबारा-विश्लेषित करो
  जिसकी dependency असल में बदली) — एक genuine algorithmic redesign,
  छोटा tweak नहीं। **निर्णय: फ़िलहाल टाला गया।** M1-4A + M4-B standalone,
  तैयार, committed रहते हैं (`स्वसंकलक/बिंदु_विश्लेषण.सूत्र` +
  `लूप_अनुकूलन.सूत्र`) — worklist redesign या कोई और सस्ता रास्ता मिलने
  पर फिर से आज़माया जा सकता है।

- **✅ Self-tail-call optimization (TCO) — बनी और असल में WIRE हुई**
  (commit `daf0b63` module, `bccf9e6` wiring, 2026-09-05)। fib(35)
  (non-tail) benchmark ने ~21x gap दिखाया था, पर inlining v1 जानबूझकर
  self-recursion नहीं छूता — यह उसका पूरक: जब पुनरावर्ती कॉल पुच्छ-स्थिति
  में हो (`परत् फलन(...);`, कॉल के बाद कुछ नहीं), उसे argument-rebind +
  loop-header पर जाओ में बदल देता — call-overhead खत्म, stack-गहराई
  O(1)। नया `स्वसंकलक/पुच्छ_अनुकूलन.सूत्र`: सिर्फ़ self-recursion (mutual
  नहीं), सच्ची पुच्छ-स्थिति (कॉल खंड की आख़िरी निर्देश + नतीजे का उपयोग
  ठीक 1), entry-खंड कभी candidate नहीं (कोई base-case वाला विकृत मामला
  अलग रखा)। कई tail-call स्थल सही ढंग से एक ही loop-header पर मिलते।
  **मापा** (inlining जैसा ही तरीका, wire करने से पहले):
  - **Runtime payoff**: accumulator-शैली benchmark (50,000 बाहरी दौर ×
    1000-गहरी पुच्छ-पुनरावृत्ति हर बार) — बिना TCO **~0.40s** → साथ
    **~0.11s**, **~3.6x speedup**। दोनों का output बिल्कुल मैच।
  - **गुणात्मक सुरक्षा-जीत भी**: 20 लाख-गहरी सीधी recursion बिना TCO के
    **crash (stack overflow)** होती, TCO के साथ तुरंत सही चलती — यह
    सिर्फ़ गति नहीं, पहले-crash-होने-वाला प्रोग्राम अब काम करने लगा।
  - **Self-compile लागत**: पहले/बाद एक ही समय पर लगातार मापा (ambient
    machine-load अलग करने को) — **~+5%** — inlining के ~+74-92% से
    कहीं कम, matches समझ में आता है क्योंकि TCO सिर्फ़ उन थोड़े-से फलनों
    को छूता जिनमें असल में self-tail-call हो, हर छोटे helper-call वाले
    फलन को नहीं (inlining जितना)।
  **निर्णय: wire किया** (inlining जैसा ही standard — फ़ायदा सीधे मापा,
  लागत से कहीं बड़ा)। पूर्ण सत्यापन: `verify_ir.ps1` 8/8; self-host
  fixed point **140113 lines** (134245 से — TCO के phi/loop-header
  overhead वाले फलनों से अपेक्षित वृद्धि); `tests/compiler` 54/54 (कोई
  regression नहीं); `tests/stdlib` 10/11 (असंबंधित पूर्व-सीमा); bitwise
  interp==native कायम। **seed ताज़ा किया** (134245→**140113**), दोबारा
  `bootstrap.ps1` से पुष्टि — `[OK]`।

- **✅ फलन वापसी-प्रकार अनुमान — बनी और WIRE हुई** (module commit `d7fe283`,
  wiring `1c3bee2`, 2026-09-05)। fib(35) की असली assembly देखी — pure
  int-only फलन होते हुए भी हर पुनरावर्ती कॉल ~15 निर्देश का GC-root
  registration/deregistration भरता, क्योंकि सूत्र में उपयोगकर्ता-फलनों
  का वापसी-प्रकार कहीं भी अनुमानित नहीं होता (`सार्थक_विश्लेषक` +
  `मूल_निम्नक` दोनों हार्डकोड "अजनक"/"मान")। नया
  `स्वसंकलक/परत्_प्रकार_अनुमान.सूत्र` — IR-स्तर pass, हर फलन के `वापस`
  कथनों का प्रकार पढ़ता (`मान`-रीडिंग को "अभी जानकारी नहीं" मानकर
  नज़रअंदाज़ करते हुए), सहमति मिलने पर हर कॉल-स्थल का प्रकार-टैग सीधे
  अपडेट करता — बंधित module-व्यापी fixpoint (M2 जैसा ही) multi-hop
  forwarding chains सुलझाता।
  **सबसे बड़ी सुरक्षा-जाँच इसी सत्र में** — testing के दौरान एक असली
  दिखने वाला "inlining data-corruption bug" मिला, गहराई से जाँचा तो पता
  चला यह मेरे अपने टेस्ट की ग़लती थी: `सूची_जोड़` सूची बढ़ने पर पता बदल
  सकता (`सूत्र_पुनः_आवंटन`), तो हमेशा `स = जोड़ें(स, x);` से इस्तेमाल
  होना ज़रूरी (bare `जोड़ें(स, x);` कभी नहीं) — ठीक जैसे `tests/compiler`
  और `पुस्तकालय` में हर जगह पहले से होता है। सही किया तो कोई compiler
  bug निकला ही नहीं। इसके बाद असली GC-stress test (self-recursive फलन
  जो integer भी लौटाता और हर कॉल पर GC-managed सूची भी बनाता, पूरी
  pipeline से compile करके native चलाया, interpreter से तुलना) पास हुआ,
  और generated assembly में सीधे पुष्टि दिखी — फलन का अपना GC-root-slot
  count 3 से 2 हो गया (पुनरावर्ती कॉल का नतीजा अब सही से "पूर्ण" टैग)।
  **मापा**: fib(35) पर ~0.41s→~0.39s (~6% speedup — inlining/TCO से
  छोटा क्योंकि यह सिर्फ़ prologue का हिस्सा हटाता, पूरा call-overhead
  नहीं, पर लगभग मुफ़्त — self-compile time पर कोई नापने-लायक फ़र्क नहीं,
  ~13.77s→~13.68s, noise के अंदर, क्योंकि pass सिर्फ़ पहले से बने IR
  टैग पढ़ता, कोई महंगा allocation/re-analysis नहीं)। **निर्णय: wire
  किया।** पूर्ण सत्यापन: `verify_ir.ps1` 9/9; fixed point **140721
  lines** (140113 से); `tests/compiler` 54/54; `tests/stdlib` 10/11;
  bitwise कायम; seed ताज़ा (140113→**140721**), दोबारा bootstrap `[OK]`।

- **⏸️ Bounded self-recursive inlining (गहन_अंतर्वेशन) — बनी, मापी, wire
  नहीं की** (commit `972b062`, 2026-09-05)। fib(35)-शैली non-tail
  self-recursion अभी भी अछूता गैप था — inlining v1 self-recursion
  जानबूझकर छोड़ता, TCO सिर्फ़ पुच्छ-स्थिति छूता। नया
  `स्वसंकलक/गहन_अंतर्वेशन.सूत्र`: self-recursive फलन की अपनी multi-block
  देह (fib खुद यदि/अन्यथा है, single-block v1-अंतर्वेशन के दायरे से बाहर)
  को उसके अपने ≤2 self-recursive कॉल-स्थल में splice करता, ठीक एक स्तर
  गहराई तक — असली CFG-सर्जरी: कॉलर-खंड को कॉल पर तोड़ो, callee के मूल
  (pre-splice) ब्लॉक-सेट का पूरा snapshot क्लोन करो, हर क्लोन किए `वापस`
  को नए "जारी" continuation-ब्लॉक पर phi से मिलाओ। कोई fixpoint नहीं —
  हमेशा *मूल* (pre-splice) block-snapshot से क्लोन, गहराई-1 हार्ड-बाउंड।
  **टेस्टिंग में एक असली bug मिला+ठीक किया**: `गअ_स्थल_बदलो` असली खंड को
  जगह पर mutate करता (split करके), पर पहला snapshot सिर्फ़ block-level
  था — व्यक्तिगत निर्देश-dict (जैसे merge वाला "योग") अब भी साझा थे, तो
  एक candidate के `अनु_हर_उपयोग_बदलो` का जगह-पर operand-rewrite अगले
  candidate की क्लोनिंग को बिगाड़ देता (SSA dominance तोड़कर — एक block
  का value दूसरे में इस्तेमाल होता जो उसे dominate ही नहीं करता)। ठीक
  किया: सारे candidate पहले split+clone हों, रीनेम सबसे आख़िर में एक
  साथ लागू हो।
  **मापा** (temporarily wire करके — fib(35) native, 5-दौर औसत, + एक
  3-तरफ़ा-branch self-recursive आकार पर `sutra.exe run` से तुलना करके
  सुधार सत्यापित):
  - **Runtime payoff**: fib(35) — बिना **~0.384s** → साथ **~0.378s**
    — **~1.5%, measurement-noise के अंदर**, असल में नगण्य।
  - **Self-compile लागत**: **~13.55s → ~14.01s, +3.4%** — TCO/
    return-type-inference से कहीं ज़्यादा (यह pass CFG क्लोन करता, सिर्फ़
    टैग नहीं पढ़ता)।
  **क्यों इतना कम फ़ायदा** — योजना का अपना पहले से लिखा अनुमान सही
  निकला: यह pass कॉल-गिनती को tree में एक स्तर पीछे धकेलता (हर invocation
  अब 2 स्तर का काम करती, आधे invocation में), पर टोटल leaf-तक-पहुँचने
  वाले calls नहीं घटते। इस compiler का calling-convention पहले से ही
  इतना सस्ता है (register-based args, न्यूनतम frame overhead) कि आधे
  call-overhead को स्किप करने से भी wall-clock पर लगभग कोई फ़र्क नहीं
  पड़ता — ठीक वैसे ही जैसे GCC/Clang का `-O2` भी fib पर deep recursive
  expansion नहीं करता, उनकी गति भी register allocation से आती, unrolling
  से नहीं।
  **निर्णय: wire नहीं किया** — cost (+3.4%) फ़ायदे (~1.5%, noise के
  अंदर) से साफ़ बड़ी है, ठीक LICM/points-to जैसा case। Standalone module
  committed, तैयार, अगर calling-convention कभी और महंगा हुआ (जैसे कोई
  बड़ा safepoint/GC-root overhead जुड़े) तो दोबारा मापा जा सकता है।
  पूर्ण सत्यापन (wire करके, फिर revert से पहले): `verify_ir.ps1` 10/10;
  self-host fixed point (Gen1==Gen2==Gen3, 144581 lines); `tests/compiler`
  54/54; `tests/stdlib` 10/11 (असंबंधित पूर्व-सीमा)। Revert के बाद seed
  byte-अपरिवर्तित (कभी छुआ ही नहीं गया)।

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

**✅ Increment 1 — standalone LLVM code-generator DONE, अभी wire नहीं**
(commit `51fb2c3`, 2026-09-05)। `sutra build --release` की तरफ़ पहला
असली कदम — एक correctness-सत्यापित IR→LLVM-IR-पाठ जनरेटर, standalone
(मूल_संकलन.सूत्र की pipeline में wire नहीं), उसी regression corpus पर
जाँचा जिस पर x86 backend।
- **नई फ़ाइलें**: `स्वसंकलक/एलएलवीएम_उत्सर्जक.सूत्र` (मध्यम IR एकक →
  `.ll` पाठ; `उत्सर्जक_एकक` जैसा ही input-contract), `स्वसंकलक/
  एलएलवीएम_चालक.सूत्र` (पश्च_चालक जैसा driver — अग्र_चालक की IR-पाठ पढ़ता),
  `verify_ir_llvm.sh` (verify_ir_selfhost.sh का tests/compiler-loop —
  अग्र_चालक → एलएलवीएम_चालक → `llc -filetype=obj` → वही `gcc -nostdlib`
  link जो मूल_संकलन.सूत्र करता → चला → `sutra.exe run` से diff)।
- **GC**: `रजि_नियतक_कार्य` black-box reuse — सिर्फ़ उसका GC-root-चयन
  (जीसी_जड़ें/जीसी_जड़_नक्शा/जीसी_मृत्यु_पद) लिया, रजिस्टर-नियतन अनदेखा
  (LLVM अपना करता)। shadow-stack scheme x86 जैसा ही — वही `gc_roots[]`
  ABI, per-def slot-store, death null-store, per-return pop। संग्राहक +
  तीनों runtime `.o` (तल/मूल_रनटाइम/मूल_आवंटक) बिलकुल अछूते, LLVM object
  उन्हीं से link होता।
- **डिज़ाइन**: एकसमान i64 value-model (हर सूत्र मान = LLVM i64 raw word,
  केवल शून्य→void; inttoptr पुल सिर्फ़ GEP/load/store पर) — LLVM की phi/
  call type-consistency ज़रूरत को पूरी तरह टालता ("मान" phi जो एक edge
  पर पाठ merge करे वो भी all-i64)। फाई सीधे LLVM `phi` बनता — x86 की
  parallel-move/cycle-break/edge-splitting मशीनरी यहाँ अनावश्यक।
  दशमलव अंकगणित अभी भी `sutra_float_*` runtime कॉल (x86 से byte-parity)।
  mingw target हर `main`-नाम फलन में `call @__main` घुसाता → सूत्र में
  C++ static ctor नहीं, तो emitter एक no-op `@__main` stub देता।
- **Toolchain**: `pacman -S mingw-w64-ucrt-x86_64-clang` + `-llvm`
  (llc/clang, MSYS2 ucrt64 — वही provider जो as/gcc)। Triple
  `x86_64-w64-windows-gnu`।
- **सत्यापन**: `tests/compiler` **54/54** LLVM path से (interpreter-
  byte-match, GC-stress/exception/bitwise समेत); `tests/stdlib` 10/11
  (सिर्फ़ `18_stdlib` — वही पूर्व-मौजूद tagged-value सीमा जो x86 भी fail
  करता, backend bug नहीं)। कोई मौजूदा फ़ाइल नहीं छुई — मूल_संकलन.सूत्र/
  अग्र_चालक.सूत्र/frozen seed byte-identical, तो x86 self-host fixed
  point अप्रभावित; `verify_ir.ps1` 10/10 कायम।
- **⚡ PERF मापा** (commit `deb0922`, native `.exe`, 5-run min):

  | benchmark | सूत्र x86 backend | सूत्र LLVM backend | `gcc -O2` |
  |---|---|---|---|
  | `fib(35)` (recursion) | 0.635s | **0.054s** | 0.031s |
  | tight loop 2×10⁸ (`योग += इ%7`) | 0.589s | **0.218s** | 0.279s |

  LLVM backend = **~12x** faster than सूत्र's own x86 backend on `fib`
  (gap to `gcc -O2` ~20x → **~1.7x**), and **~2.7x** faster on the loop
  — *beating* `gcc -O2` there. यही roadmap का "`--release` builds
  clang-tier — यहीं C++ से टक्कर" milestone, इन patterns पर असल में
  पहुँचा।
  **Unlock**: पहली माप में `फिब(अ-1)+फिब(अ-2)` का `+` `पाठ_योग_गतिक`
  (dynamic-add runtime कॉल) बन रहा था — return-type-inference call-tag
  update करता पर downstream अंकगणित की विधि नहीं (x86 backend में भी वही,
  पर वहाँ कोई downstream optimizer नहीं जो block हो)। छोटा emitter
  refinement (commit `deb0922`): दोनों operand सिद्ध रूप से पूर्ण/बूल हों
  तो "मान"-विधि पर भी native `add`/`icmp` — इससे fib **0.575s→0.054s**
  (clang -O2 अब pure recursion के आर-पार देख पाता)। tests/compiler 54/54
  कायम।

- **✅ `--release` WIRED** (commit `da301d8`, 2026-09-05, Niraj का निर्णय)।
  `sutrac.exe --release prog.सूत्र` अब सीधे LLVM path चलाता — IR →
  `एलएलवीएम_उत्सर्जक_एकक` → `.ll` → `clang -O2 -c` → वही `gcc -nostdlib`
  link। ध्वज-स्कैन minimal (argparse lib नहीं)।
  **पुष्टि पहले**: `clang -O2` (सिर्फ़ `llc` नहीं) GC सुरक्षित रखता —
  पूरी tests/compiler **54/54** `clang -O2 -c` से (GC-stress/circular/
  realloc समेत); `gc_roots[]`+count `external global` + root-स्लॉट
  alloca address-taken तो clang shadow-stack bookkeeping DCE नहीं कर
  पाता। Self-host fixed point wired driver से कायम (Gen2==Gen3
  **174447 lines**, 140721 से — ~1300-पंक्ति `एलएलवीएम_उत्सर्जक.सूत्र` अब
  sutrac.exe के अपने build-graph में), Gen1(split)==Gen2, verify_ir.ps1
  10/10। Seed ताज़ा (140721→**174447**), दोबारा `bootstrap.ps1` `[OK]`।
  **लागत** (back-to-back, वही wired sutrac.exe, सिर्फ़ source अलग):
  self-compile **~14s→~20s (+42%)** — एक-बार-प्रति-compiler-rebuild कर;
  सामान्य `sutrac.exe foo.सूत्र` अप्रभावित (LLVM कोड binary में बस बैठा
  रहता)। inlining wire करने जैसा ही निर्णय (+74-92% self-compile, 4.5x
  payoff के लिए) — यहाँ payoff बड़ा (fib 12x, loop gcc -O2 से तेज़)।

- **✅ Front #1 — native double codegen** (commit `1cee490`, 2026-09-06)।
  दशमलव अंकगणित/तुलना अब `sutra_float_*` runtime helpers से नहीं जाती —
  दशमलव value-model में i64 ही रहता, emitter सिर्फ़ हर float-ऑप के इर्द-गिर्द
  `bitcast i64↔double` करता (`fadd`/`fsub`/`fmul` + ordered `fcmp`
  oeq/une/olt/…, तल.s के ucomisd+sete/setnp से byte-मिलाया)। int→float
  `बुलाओ sutra_int_to_float` → `sitofp`; उल्टा → `fptosi`। float भाग अभी
  भी `sutra_float_div` (उसमें explicit div-by-zero throw है)। LLVM
  bitcast-जोड़े coalesce कर देता (i64→double→i64 identity), तो असली
  `double` SSA देखता — optimize/schedule/(reduction-निर्भरता न हो तो)
  vectorize।
  **मापा** (native `.exe`, 5-run min):
  - pure-double loop (`अ*=k; ब+=अ*0.5`, 5e7): x86 0.284s → **LLVM
    0.064s (~4.4x)** vs `gcc -O2` 0.060s — **parity**।
  - mixed int/float (`योग += इ*0.5 - 1.5`, 5e7): x86 0.468s → **LLVM
    0.137s (~3.4x)** vs `gcc -O2` 0.072s — ~1.9x, बाकी gcc का बेहतर
    per-iteration `sitofp` strength-reduction (clang -O3/-march=native/
    -ffast-math से नहीं बंद होता)।
  Verification: tests/compiler 54/54 LLVM path; stdlib + float-heavy
  12/13 (सिर्फ़ 18_stdlib); self-host fixed point Gen2==Gen3
  **176128 lines** (174447 से), Gen1(split)==Gen2, verify_ir.ps1 10/10;
  seed ताज़ा, re-bootstrap `[OK]`।

- **✅ Front #2 — runtime as bitcode + purity attributes** (commit
  `7d20171`, 2026-09-06)। `--release` अब runtime मॉड्यूल
  (`मूल_रनटाइम.सूत्र`/`मूल_आवंटक.सूत्र`) को भी in-process LLVM IR में
  compile करता, `llvm-link` से user मॉड्यूल के साथ merge करता, फिर
  whole-module `clang -O2` — runtime अब clang के optimizer को एक इकाई
  के रूप में मिलता, frozen opaque `.o` नहीं। `तल.s` (hand asm) अब भी
  `sutra_floor.o`; `sutra_srt.o`/`sutra_alloc.o` --release में नहीं बनते
  (कोड merged `.bc` में)। शुद्ध helper declares पर `memory(read)`/
  `memory(none)` + `nounwind willreturn` attributes।
  **असली correctness fix साथ में**: "पूर्णतः-undef phi" elimination —
  सूत्र का mem2reg कभी ऐसा phi छोड़ देता जिसके सारे source undef हों;
  x86 का edge-move सहन कर लेता पर LLVM verifier "does not dominate all
  uses" से reject करता। emitter अब fixpoint से all-undef set निकालता,
  वो phi emit नहीं करता, उनका हर संदर्भ `undef` कर देता — यही
  `मूल_आवंटक.सूत्र` को LLVM backend से compile होने देता।
  **ईमानदार माप**: #2b runtime को *optimizable* बनाता पर स्वतः inlining
  का लाभ सीमित — `सूची_सूचकांक` 64-निर्देश फलन (type dispatch + bounds
  check + throw path), clang की inline-threshold से ऊपर, तो hot loop
  का `स[इ]` अब भी उसे कॉल करता। benchmark में दिखने वाला barrier-हटाव
  emitter-side container-access specialization चाहता (ज्ञात सूची/पाठ
  base के लिए header-read/element-load inline) — अगला कदम **#2c**।
  regression नहीं: `fib(35)` --release अब भी 0.054s। tests/compiler
  **54/54 via `sutrac.exe --release`** (नया `verify_release.sh`) + 54/54
  default; self-host fixed point 176128→**179796 lines**, Gen1==Gen2;
  verify_ir.ps1 10/10; stdlib 10/11।

- **✅ Front #2c — statically-typed सूची access fast paths** (commit
  `ced73a7`, 2026-09-06)। `सूची_सूचकांक`/`सूची_सूचकांक_सेट`/`दैशिक_लंबाई`
  हर बार runtime type-dispatch + bounds-check + throw-setup करते
  (64+ निर्देश, clang inline-threshold से ऊपर) — तो #2b (runtime as
  bitcode) के बाद भी hot loop का `स[इ]`/`लंबाई(स)` opaque कॉल रहता।
  नए slim list-only helpers `मूल_रनटाइम.सूत्र` में — `सूची_लंबाई_तेज़`
  (एक header-read), `सूची_तत्व_तेज़`/`सूची_तत्व_सेट_तेज़` (header-read +
  bounds-check + element load/store, वही throw संदेश)। छोटे → clang -O2
  inline करता → header-read loop से hoist, bounds-check अक्सर fold,
  element-access सादा `getelementptr`+`load`। emitter तब route करता जब
  base निश्चित रूप से सूची — `पढ़/लिख_अनुक्रम` के `आधार_प्रकार` से, raw
  type-tag से, या नए per-function "known-सूची" fixpoint set से
  (नव_सूची/सूची_रचना परिणाम + सूची-typed access bases, phi और
  `स = जोड़ें(स, x)` से propagate)। पाठ indexing (UTF-8 codepoint walk)
  + dict/dynamic अछूते — वो सच में general path चाहते।
  **मापा** (100k × sum-of-2000-element list, native `.exe`, 5-run min):
  x86 **22.2s → --release 1.13s (~20x)** vs `gcc -O2` 0.041s। #2c से
  पहले इसका --release build ~24s था — x86 backend से बमुश्किल बेहतर।
  gcc से अब भी दूर यहाँ (gcc का stack-array + loop-invariant sum
  hoisting), पर यही list/string barrier-हटाव है जो #2a/#2b ने setup
  किया पर अकेले नहीं दे सके। tests/compiler 54/54 via --release +
  54/54 default; self-host fixed point 179796→**181747 lines**;
  verify_ir.ps1 10/10; stdlib 10/11।

- **✅ Front #2d — statically-typed पाठ op fast paths** (commit
  `00d2660`, 2026-09-06)। #2c जैसा ही, strings के लिए। नए slim helpers:
  `पाठ_तुल्य_तेज़` (pointer-eq/null fast-out + length compare + byte
  loop, कोई `अंतर्_क्या_पाठ` नहीं → clang inline + idiom-recognize),
  `पाठ_लंबाई_तेज़` (codepoint-walk बिना type-branch, `memory(read)
  willreturn` → fixed string scan करने वाले loop से clang hoist करता,
  O(n) walk per-iteration की जगह एक बार)। UTF-8 codepoint length
  inherently O(n) — header में cached count का slot नहीं, और 16-बाइट
  object header चौड़ा करना पूरे runtime + दोनों backend को छूता।
  **safety-gated routing**: string `==`/`!=` → `पाठ_तुल्य_तेज़` केवल तब
  जब दोनों operand सच में पाठ (निम्नक की विधि="पाठ", या दोनों raw tag
  "पाठ")। "मान"→"पाठ" reroute (dynamic operand, int हो सकता) guarded
  `पाठ_तुल्य` पर रहता — एक first-cut ने वहाँ भी fast path लगाया था और
  list-of-strings element compare (elements "मान"-typed) ने int को
  string header माना → crash, पकड़ा। string `<`/`>`/`<=`/`>=`
  (codepoint compare) + `पाठ[i]` (UTF-8 index) general path पर —
  genuinely O(n)।
  **मापा** (native `.exe`, 5-run min): loop-invariant `str==` (दोनों
  static पाठ, len-12) x86 0.279s → **--release 0.018s** vs `gcc -O2`
  0.013s — near parity (clang पूरा comparison hoist करता); varied
  `str==` (list[i%6] == literal, non-hoistable) x86 2.378s →
  **--release 0.084s** vs gcc 0.042s (~2x — ज़्यादातर #2c का list
  access + tighter loop)। tests/compiler 54/54 via --release + 54/54
  default; self-host 181747→**182319**।

- **✅ Front #3 — lexer byte-cursor + byte-decode** (commit `c15ca1e`,
  2026-09-06)। मूल स्कोप "partial escape analysis + scalar replacement"
  था, पर 3-agent जाँच ने premise कमज़ोर पाया — compiler में O(n²)
  string-build पहले ही 3 ad-hoc chunk-list builders से workaround हो
  चुका, ज़्यादातर छोटे `[a,b]` lists IR instruction operand-lists में
  escape करते (scalar-replace नहीं होते), और full escape analysis
  GC-correctness-critical (precise shadow stack raw machine stack कभी
  scan नहीं करता → गलत-elided root = use-after-free) — कम बचा value,
  ऊँचा risk। Niraj ने "lexer + StringBuilder cleanup" चुना।
  असली बची churn lexer में थी (`स्वसंकलक/लेखक.सूत्र`, हर compile पर
  ~12K लाइन re-tokenize): (a) `अक्षरम्_दृश्यताम्`/`अक्षरम्_अग्रिमम्` हर
  source char को `स्रोत[i]` → `पाठ_सूचकांक` → `पाठ_प्रति` से decode
  करते — प्रति char एक ताज़ा 1-4 बाइट `पाठ` आवंटन (~6M आवंटन/self-compile),
  peek/advance जोड़ी दो बार, और हर `स्रोत[i+1]` lookahead ने sequential
  cache को cursor से आगे छोड़ा → अगली read offset 0 से rescan। अब दोनों
  UTF-8 सीधे बाइट से decode करते (`लेखक_कोडबिंदु` / `अक्षरम्_अग्रिमम्` में
  inline) एक byte-cursor `अवस्था["बाइट_अनु"]` से जो runtime की
  `पाठ_सूचकांक` walk वाली lead-byte width-table से codepoint index के
  साथ lockstep। नया `अक्षरम्_दृश्यताम्_आगे` दोनों source-index lookahead
  की जगह। (b) `पहचान_लिखो`/`संख्या_लिखो` token text को `पद_पाठ = पद_पाठ +
  char` लूप (O(L²) copies) से बनाते — अब scan किए span का एक
  `पाठ_उपखंड_बाइट` byte-slice (नया whitelisted runtime helper:
  bounds-checked `पाठ_प्रति` wrapper, O(span), कोई codepoint-गणना नहीं —
  `पाठ_उपखंड` प्रति कॉल दो whole-source walks करता)। `संख्या_लिखो`
  देवनागरी अंक तभी normalize करता (`अंक_सामान्य`) जब slice में सच में
  ≥128 बाइट — सामान्य ASCII केस zero-realloc।
  **codegen-neutral** — token stream अपरिवर्तित, `.s` byte-identical
  (verified: पुरानी `लेखक.सूत्र` pre-#3 और post-change compilers से एक ही
  assembly), line/column tracking अछूता।
  **मापा** (full self-compile, native `.exe`, back-to-back min): pre-#3
  **19.1s → 17.74s (~7% तेज़, steady ±0.1s)**। Isolated lexer microbench
  (`पद_विच्छेदन` × 120 on `विश्लेषक.सूत्र`): 21.8s → 20.8s। बड़ा
  self-compile delta lookahead cache-rescan हटने से। **सीख**: lexer का
  char-scan उतना bottleneck नहीं था जितना सोचा — असली lexer लागत
  token-object निर्माण (प्रति token 4-key `शब्दकोश`) है, जो #3 नहीं
  छूता। byte-slice अकेले (byte-decode बिना) हल्का lexer regression है
  (प्रति-char `बाइट_अनु` bookkeeping छोटे-token O(L²) से महँगा) — दोनों
  साथ land हुए।
  tests/compiler 54/54 via --release + 54/54 default + 54/54 LLVM;
  self-host fixed point 182319→**183538**; verify_ir 10/10;
  verify_compiler 56/56 (+negatives); verify_emit 16/16।
  StringBuilder consolidation (`पाठ_संचायक.सूत्र`) — plan का commit 3,
  explicitly zero-perf — deferred।

- **आगे**: lexer token-objects (प्रति-token dict → flat/interned) असली
  lexer churn है; #4 whole-program devirt + aggressive inline; #5 PGO by
  default; #6 generational GC / Perceus।
  विधि_बुलाओ/परिवर्तन/नव_पाठ(byte-form) — निम्नक आज भी emit नहीं करता।

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
