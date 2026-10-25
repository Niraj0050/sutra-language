# सूत्र (Sutra) — Improvement Ledger

**Tracking System**: Every codebase improvement, optimization, or architectural enhancement is assigned a permanent identifier `SUTRA-IMP-XXXX`.

---

## Completed Improvements

### SUTRA-IMP-0001: IR-Based Self-Hosted Compiler Pipeline Migration (Phase 1)

- **ID**: `SUTRA-IMP-0001`
- **Date**: 2026-08-30
- **Roadmap Phase**: Phase 1 (Compiler Architecture)
- **Milestone**: M1 (Self-Hosting Transition)
- **Sub-milestone**: M1.5 (IR Backend Migration)
- **Component**: Self-Hosted Compiler (`स्वसंकलक/`)
- **Problem**: The original self-hosted compiler used a single-pass direct stack-machine code generator (`मूल_सर्जक.सूत्र`), which produced large assembly ($O(n^2)$ memory growth) and prohibited register allocation and optimizations.
- **Root Cause**: Lack of intermediate representation in self-hosted pipeline.
- **Previous Behavior**: AST was converted directly into unoptimized x86-64 stack push/pop assembly.
- **New Behavior**: Modular 4-stage pipeline: Lowering (`मूल_निम्नक.सूत्र`) → Optimization (`अनुकूलक.सूत्र`) → Register Allocation (`रजि_नियतक.सूत्र`) → Code Emission (`मूल_उत्सर्जक.सूत्र`).
- **Implementation**: Implemented intermediate representation data structures (`मध्यम.सूत्र`), AST lowering (`मूल_निम्नक.सूत्र`), IR serializer (`मध्यम_क्रम.सूत्र`), linear-scan register allocator (`रजि_नियतक.सूत्र`), and x64 GAS emitter (`मूल_उत्सर्जक.सूत्र`).
- **Files Changed**:
  - `स्वसंकलक/मूल_संकलन.सूत्र`
  - `स्वसंकलक/मध्यम.सूत्र`
  - `स्वसंकलक/मूल_निम्नक.सूत्र`
  - `स्वसंकलक/अनुकूलक.सूत्र`
  - `स्वसंकलक/रजि_नियतक.सूत्र`
  - `स्वसंकलक/मूल_उत्सर्जक.सूत्र`
  - `स्वसंकलक/मध्यम_क्रम.सूत्र`
- **Tests Added**:
  - `स्वसंकलक/मध्यम_परीक्षण.सूत्र`
  - `स्वसंकलक/मूल_निम्नक_परीक्षण.सूत्र`
  - `स्वसंकलक/अनुकूलक_परीक्षण.सूत्र`
  - `स्वसंकलक/रजि_नियतक_परीक्षण.सूत्र`
- **Tests Modified**: `verify_ir.ps1`, `verify_ir_selfhost.sh`
- **Before Test Result**: Stack-machine emitter generated ~150K assembly lines for compiler.
- **After Test Result**: IR pipeline generates compact assembly with verified fixed-point (`Gen2.s == Gen3.s`). 4/4 IR unit suites PASS (54 checks).
- **Performance Impact**: ~3x reduction in generated assembly file size and faster native execution.
- **Memory Impact**: Significant reduction in peak compiler memory usage.
- **Compatibility Impact**: Full Windows x64 ABI support.
- **Regression Risk**: Low (Fixed point verified).
- **Documentation Impact**: Updated `docs/COMPILER.md` and `document/05-compiler/`.
- **Dependencies**: MSYS2 GNU `as`, `gcc`.
- **Verification**: `verify_ir_selfhost.sh` passes fixed-point diff test.
- **Status**: COMPLETED

---

### SUTRA-IMP-0002: Standard Library Implementation in Pure Sutra (Phase 2b)

- **ID**: `SUTRA-IMP-0002`
- **Date**: 2026-08-31
- **Roadmap Phase**: Phase 2 (Standard Library)
- **Milestone**: M2 (Stdlib Expansion)
- **Sub-milestone**: M2.2 (Data Structures & Algorithmic Modules)
- **Component**: Standard Library (`पुस्तकालय/`)
- **Problem**: Key standard collections and algorithms (Set, Queue, Stack, Priority Queue, JSON, Path, Format, Permutations) were missing or stubbed.
- **Root Cause**: Language stdlib was in early stage.
- **Previous Behavior**: Programs had to implement data structures manually.
- **New Behavior**: 15 standard library modules provided under `पुस्तकालय/` and accessible via `आयात "मानक.सूत्र"`.
- **Implementation**: Written in 100% Sutra source code with comprehensive test suites.
- **Files Changed**:
  - `पुस्तकालय/मानक.सूत्र`
  - `पुस्तकालय/गणित.सूत्र`
  - `पुस्तकालय/पाठ.सूत्र`
  - `पुस्तकालय/सूची.सूत्र`
  - `पुस्तकालय/शब्दकोश.सूत्र`
  - `पुस्तकालय/समुच्चय.सूत्र`
  - `पुस्तकालय/कतार.सूत्र`
  - `पुस्तकालय/ढेर.सूत्र`
  - `पुस्तकालय/ढेर_प्राथमिकता.सूत्र`
  - `पुस्तकालय/क्रमचय.सूत्र`
  - `पुस्तकालय/जेसन.सूत्र`
  - `पुस्तकालय/तर्क.सूत्र`
  - `पुस्तकालय/पथ.सूत्र`
  - `पुस्तकालय/परीक्षण.सूत्र`
  - `पुस्तकालय/प्रारूप.सूत्र`
- **Tests Added**:
  - `tests/stdlib/गणित_परीक्षण.सूत्र`
  - `tests/stdlib/पाठ_परीक्षण.सूत्र`
  - `tests/stdlib/सूची_परीक्षण.सूत्र`
  - `tests/stdlib/संग्रह_परीक्षण.सूत्र`
  - `tests/stdlib/क्रमचय_परीक्षण.सूत्र`
  - `tests/stdlib/जेसन_परीक्षण.सूत्र`
  - `tests/stdlib/तर्क_परीक्षण.सूत्र`
  - `tests/stdlib/पथ_परीक्षण.सूत्र`
  - `tests/stdlib/प्रारूप_परीक्षण.सूत्र`
  - `tests/stdlib/परीक्षण_परीक्षण.सूत्र`
- **Tests Modified**: `tests/stdlib/18_stdlib.सूत्र`
- **Before Test Result**: Stdlib tests covered only basic builtins.
- **After Test Result**: 11/11 stdlib test suites pass 100% on both interpreter and native compiler.
- **Performance Impact**: High-efficiency pure Sutra data structures.
- **Memory Impact**: Standard heap allocation via Sutra runtime.
- **Compatibility Impact**: Fully portable.
- **Regression Risk**: None.
- **Documentation Impact**: Created `पुस्तकालय/README.md` and updated `docs/STANDARD_LIBRARY.md`.
- **Dependencies**: Native compiler or interpreter.
- **Verification**: `tests/stdlib/*.सूत्र` all pass.
- **Status**: COMPLETED

---

### SUTRA-IMP-0003: Runtime Porting to Sutra — Strings, Lists, Dicts & OS Floor (Phase 2c)

- **ID**: `SUTRA-IMP-0003`
- **Date**: 2026-09-01
- **Roadmap Phase**: Phase 2 (Runtime in Sutra)
- **Milestone**: M2 (Runtime Independence)
- **Sub-milestone**: M2.3 (C Runtime Reduction)
- **Component**: Runtime (`स्वसंकलक/निर्माण/`)
- **Problem**: Heavy dependency on C runtime functions in `sutra_runtime.c` for strings, list slicing, dictionary hash tables, and console I/O.
- **Root Cause**: Bootstrap legacy where all runtime was written in C.
- **Previous Behavior**: `printf`, `malloc`, and C-based dictionary lookups with $O(n)$ linear scan.
- **New Behavior**: Pure Sutra memory allocator (`मूल_आवंटक.सूत्र`), Sutra string/list/dict runtime (`मूल_रनटाइम.सूत्र`), and assembly OS floor (`तल.s` using direct `WriteFile` Win32 API).
- **Implementation**: Ported open-addressing dictionary hash table, list growth, string transforms, and low-level memory intrinsics to Sutra.
- **Files Changed**:
  - `स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र` / `.s`
  - `स्वसंकलक/निर्माण/मूल_आवंटक.सूत्र` / `.s`
  - `स्वसंकलक/निर्माण/तल.s`
  - `स्वसंकलक/निर्माण/sutra_runtime.c`
  - `स्वसंकलक/मूल_उत्सर्जक.सूत्र`
- **Tests Added**:
  - `tests/intrinsics/01_raw_memory.सूत्र`
  - `tests/intrinsics/02_os_floor.सूत्र`
  - `tests/intrinsics/03_runtime_leaves.सूत्र`
  - `tests/intrinsics/04_string_ops.सूत्र`
- **Tests Modified**: `verify_intrinsics.ps1`, `verify_emit.sh`
- **Before Test Result**: 72 KB `sutra_runtime.c` handling all operations.
- **After Test Result**: C runtime reduced to 54 KB, runtime modules assembled into `sutra_alloc.o`, `sutra_srt.o`, `sutra_floor.o`.
- **Performance Impact**: $O(1)$ dictionary operations, zero-C-overhead OS floor.
- **Memory Impact**: Exact GC object headers and managed blocks.
- **Compatibility Impact**: Windows x64 tested; Linux abstraction prepared.
- **Regression Risk**: Medium (Active in progress; requires careful parity checking).
- **Documentation Impact**: Created `docs/RUNTIME_IN_SUTRA.md`.
- **Dependencies**: GNU `as`, `gcc`.
- **Verification**: `verify_intrinsics.ps1` PASS (4/4).
- **Status**: IN_PROGRESS
