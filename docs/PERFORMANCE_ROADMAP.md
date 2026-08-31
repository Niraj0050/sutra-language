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

**1h. auto-GC — अगला काम।** अभी compile के दौरान कोई GC नहीं → 5500-line
   self-compile arena ~1 GB, RAM-तंग machine पर कभी OOM। `सूत्र_आवंटन`
   में byte-threshold trigger चाहिए (roots पहले से सही हैं)।

फिर: `मूल_संकलन.सूत्र` को *default* रूप से IR path पर (अभी `मूल_संकलन_ir`
अलग से coexist करता); कठन_प्रयत्न lowering (driver में साफ़ errors)।

- **Milestone: compiled सूत्र ~1.5-2× of C (scalar)। self-compile seconds।
  push/pop 13,670 → ~कुछ सौ। अब hot code C→सूत्र move करना safe है।**

### Phase 2 — Runtime port complete, BUILT properly। ~1 महीना (optimiser के बाद)
list / dict (open-addressing hash) / print / float / exceptions /
fileIO — हर एक designed, अब बिना regression। dead C GC hash delete।
अभी सिर्फ़ cold paths (error formatting वग़ैरह) move हो सकते हैं।
- **Milestone: `sutra_runtime.c` DELETED. हर binary = सूत्र + तल.s
  (76 लाइन)। शून्य C, शून्य libc। → Level 1 independence**

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
