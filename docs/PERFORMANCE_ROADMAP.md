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

**1b. AST → IR lowering** (`मूल_सर्जक.सूत्र` का काम बदलेगा —
   AST→text की जगह AST→IR)। यहीं `स = स + piece` वाला O(n²) खत्म —
   IR instrs एक growable array में push होते हैं।

**1c. passes** (`स्वसंकलक/अनुकूलक.सूत्र` — नई फ़ाइल), क्रम में:
   - const-fold + const-prop
   - copy-prop
   - dead-code-elim (कोई use नहीं → हटाओ)
   - mem2reg — local `load`/`store` को SSA values बनाओ (सबसे बड़ा जीत:
     stack traffic खत्म)
   - simple inlining (छोटे leaf functions)
   - LICM (loop-invariant code motion) — बाद में

**1d. register allocator** — linear-scan (SSA live intervals से)।
   अभी हर value memory/stack में; इसके बाद rax/rcx/rdx/r8-r15 में।
   caller/callee-saved, spill slots।

**1e. IR → x86-64** (`मूल_सर्जक.सूत्र` का backend हिस्सा) — अब यह IR
   instrs पर चलता है, register assignments के साथ। text एक बार, अंत में।

**1f. GC roots** — precise: IR में `gc_root` pseudo-instrs, stack map
   generate करो। auto-GC unblock (byte threshold `सूत्र_आवंटन` में)।

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
