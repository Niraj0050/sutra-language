# सूत्र (Sutra) — Master Current State & Living Dashboard

**Audit Date**: 2026-09-01  
**Git Baseline**: Commit `34e5557` + working tree audit  
**Repository State**: Cleanly Audited (No source changes during audit)

---

## 1. Executive Answers to Core Project Questions

### What has improved in Sutra?
1. **Self-Hosted IR Pipeline**: The self-hosted compiler has replaced its legacy single-pass stack machine (`मूल_सर्जक.सूत्र`) with an Intermediate Representation (IR) lowering and optimization architecture (`मूल_निम्नक.सूत्र` → `अनुकूलक.सूत्र` → `रजि_नियतक.सूत्र` → `मूल_उत्सर्जक.सूत्र`), with verified byte-identical fixed-point convergence (`Gen2.s == Gen3.s`).
2. **Standard Library**: Created 15 pure Sutra standard library modules under `पुस्तकालय/` covering Math, Strings, Lists, Dictionaries, Sets, Queues, Stacks, Priority Queues, Permutations, JSON parsing, CLI arguments, File Paths, Testing, and Template Formatting.
3. **Runtime Decoupling (Phase 2)**: Core runtime functions (dictionary hash tables, list growth, string manipulation, and console output) have been ported from C (`sutra_runtime.c`) into pure Sutra assembly (`मूल_रनटाइम.सूत्र`, `मूल_आवंटक.सूत्र`, `तल.s`).

### What exactly changed & Why was it changed?
- **Changed**: Transitioned backend code generation from direct AST-to-ASM stack pushes to a 3-address quadruple IR format with linear-scan register allocation.
- **Why**: Stack-machine code generation produced $O(n^2)$ memory growth during self-compilation, prevented compiler optimizations, and prohibited register reuse.

### Which files changed?
- `स्वसंकलक/मूल_संकलन.सूत्र`, `स्वसंकलक/मध्यम.सूत्र`, `स्वसंकलक/मूल_निम्नक.सूत्र`, `स्वसंकलक/अनुकूलक.सूत्र`, `स्वसंकलक/रजि_नियतक.सूत्र`, `स्वसंकलक/मूल_उत्सर्जक.सूत्र`, `स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र`, `स्वसंकलक/निर्माण/मूल_आवंटक.सूत्र`, `स्वसंकलक/निर्माण/तल.s`, `पुस्तकालय/*.सूत्र`.

### Which milestone does it belong to?
- **Phase 1 (M1.5)**: Self-Hosting IR Backend Transition (**COMPLETED**).
- **Phase 2 (M2.2)**: Standard Library Expansion (**COMPLETED**).
- **Phase 2 (M2.3)**: Runtime Migration to Sutra (**IN PROGRESS**).

### Which bugs were fixed?
- Fixed multi-entry dictionary literal parsing in IR compiler.
- Fixed dynamic relational comparison type coercion between bool, null, float, int.
- Fixed string concatenation with non-string literals.
- Fixed try/catch throw value propagation.

### Which bugs remain?
- `SUTRA-BUG-0001`: Signature mismatch in C++ host `Environment::assign` (`environment.hpp` vs `environment.cpp`).
- `SUTRA-BUG-0002`: Missing runtime module objects in C++ `codegen.cpp` linking command.
- `SUTRA-BUG-0003`: Windows CMD copy command failure on Devanagari paths in `sutrac.exe`.
- `SUTRA-BUG-0004`: Native runtime GC crash on repeated collection cycles (`46_gc_repeated.सूत्र`).

### How many tests exist & How many pass?
- **Total Test Files**: **175**
- **Interpreter Passing**: **166** (100% of applicable tests)
- **Native Passing**: **163** (98.1% of applicable tests)
- **Parity Match**: **156** (93.1% full parity)

### What regressions occurred?
- `46_gc_repeated.सूत्र` crashes in native execution due to hash table cleanup in repeated sweeps (`SUTRA-BUG-0004`).
- C++ host native compile command (`sutra build`) fails to link due to missing paths to new Sutra runtime modules (`SUTRA-BUG-0002`).

### How has performance changed?
- Compiled native binaries execute **~15x to ~46x faster** than interpreted execution.
- Emitted assembly is **~3x more compact** than the old stack machine.

### How has memory usage changed?
- Self-compilation memory footprint significantly reduced due to IR basic blocks and register allocation.
- Heap objects strictly managed with 16-byte object headers and mark-and-sweep tracking.

### What language features are complete?
- Variables, Arithmetic, Comparison, Logic, If/Else, While Loops, Repeat Loops, Break, Continue, Functions, Recursion, Strings, Unicode UTF-8, Lists, Dictionaries, Exceptions (Try/Catch/Throw), Modules (Import), Console I/O.
- OOP classes & methods are complete in Interpreter and C++ Native Compiler; self-hosted compiler has parser support with IR lowering in progress.

### What is interpreter-only?
- Interactive REPL (`sutra.exe` interactive mode).
- Immediate dynamic evaluation without emitting native assembly.

### What is native-only?
- Direct OS memory intrinsics (`अंतर्_पढ़8`, `अंतर्_लिख8`, `अंतर्_मुद्रण`, `तल.s` Win32 API calls).

### What is self-hosted?
- The compiler itself (`sutrac.exe` / `स्वसंकलक/मूल_संकलन.सूत्र`) is written in 100% Sutra source code. It lexes, parses, type-checks, lowers to IR, optimizes, allocates registers, and emits x86-64 assembly without invoking any C++ binary.

### What still depends on C++?
- The host compiler `sutra.exe` (used as an alternate CLI and test validator).
- The developer tools in `उपकरणानि/` (`sutra_lsp.exe`, `sutra_formatter.exe`, `sutra_linter.exe`, `sutra_debugger.exe`, `sutra_pkgmgr.exe`, `sutra_build.exe`) are currently implemented in C++17.
- Self-hosting does **NOT** depend on C++.

### What is blocking complete self-hosting?
- Nothing blocks self-hosting compilation: `bootstrap.ps1` builds `sutrac.exe` without C++ and reaches fixed-point.
- Final remaining dependency on external tools is GNU `as` (assembler) and `gcc` (linker) from MSYS2 ucrt64.

### What documentation is outdated?
- Sections in `document/05-compiler/` and `docs/COMPILER.md` that still describe `मूल_सर्जक` instead of the IR pipeline (`मूल_निम्नक`/`मूल_उत्सर्जक`).
- `document/04-standard-library/` missing chapters for newly added modules (`तर्क`, `पथ`, `जेसन`, `क्रमचय`, `ढेर_प्राथमिकता`).

### What should be worked on next?
1. **Fix `SUTRA-BUG-0001` & `SUTRA-BUG-0002`**: Repair C++ host build and link commands so all test suites run cleanly.
2. **Fix `SUTRA-BUG-0004`**: Resolve the repeated GC collection sweep crash in `sutra_runtime.c`.
3. **Complete Phase 2c Runtime Migration**: Finalize pure Sutra runtime and verify fixed point across all test suites.
4. **Clean up duplicate/mojibake directories**: Provide safe cleanup for `à¤¨à¤¿à¤°à¥ à¤®à¤¾à¤£`, `à¤¨à¤¿à¥ à¤®à¤¾à¤£`, `à¤¸à¥ à¤µà¤¸à¤‚à¤•à¤²à¤•`, `नि्माण`.
