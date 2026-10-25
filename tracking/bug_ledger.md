# सूत्र (Sutra) — Bug Ledger

**Tracking System**: Every bug in the Sutra ecosystem is assigned a permanent, unique identifier `SUTRA-BUG-XXXX`.

---

## Active & Audited Bugs

### SUTRA-BUG-0001: Environment::assign Signature Mismatch in C++ Compiler Host

- **Bug ID**: `SUTRA-BUG-0001`
- **Bug**: C++ build failure during `build.ps1` compilation of `environment.cpp`.
- **Severity**: High (Blocks rebuilding C++ host targets `sutra.exe`, `test_sutra.exe`).
- **Reproduction**: Run `.\build.ps1` or `g++ -std=c++17 -Iसंकलक/include -c संकलक/src/environment.cpp`.
- **Expected**: `environment.cpp` compiles cleanly into `build/obj/environment.o`.
- **Actual**: Compiler error: `no declaration matches 'void sutra::Environment::assign(const std::string&, const sutra::SutraValue&, size_t, size_t)'`.
- **Root Cause**: `संकलक/include/sutra/environment.hpp` line 18 declares `void assign(const std::string& name, SutraValue value, size_t line, size_t col);` (pass-by-value) while `संकलक/src/environment.cpp` line 19 defines it with `const SutraValue& value` (pass-by-const-ref).
- **Affected Components**: C++ Frontend (`संकलक/include/sutra/environment.hpp`, `संकलक/src/environment.cpp`).
- **Fix**: Synchronize parameter types between declaration in header and definition in cpp file.
- **Regression Test**: Run `build.ps1` and `test_sutra.exe`.
- **Verification**: Compilation succeeds without errors.
- **Status**: OPEN

---

### SUTRA-BUG-0002: Missing Sutra Runtime Modules in C++ Codegen Link Command

- **Bug ID**: `SUTRA-BUG-0002`
- **Bug**: `sutra.exe build <file>` and `test_sutra.exe` native compiler tests fail with linker undefined references (`सूत्र_आवंटन`, `सूत्र_पुनः_आवंटन`, `सूत्र_मुक्त`, `सूत्र_ब्लॉक_प्रकार`, `संख्या_से_पाठ`, `पाठ_जोड़`, `बूल_से_पाठ`, `शून्य_से_पाठ`, `अक्षर_बना`, `सूत्र_संग्रह`).
- **Severity**: High (Breaks C++ host native compilation command `sutra build <file>` and toolchain tests).
- **Reproduction**: Run `.\test_sutra.exe` or `.\sutra.exe build tests/compiler/01_arithmetic.सूत्र`.
- **Expected**: Native executable compiles and links cleanly.
- **Actual**: GNU `ld.exe` reports undefined references to Devanagari runtime symbols from `sutra_runtime_temp.o`.
- **Root Cause**: In Phase 2, core allocation and string/object functions in `sutra_runtime.c` were converted to external declarations resolved by Sutra assembly modules (`तल.s`, `मूल_रनटाइम.s`, `मूल_आवंटक.s`). In `संकलक/src/compiler/codegen.cpp`, the path lookup for these `.s` files in `स्वसंकलक/निर्माण/` fails when running outside specific working directories, or the prebuilt object files (`sutra_alloc.o`, `sutra_srt.o`, `sutra_floor.o`) are not linked.
- **Affected Components**: C++ Native Backend (`संकलक/src/compiler/codegen.cpp`).
- **Fix**: Ensure robust absolute path resolution or fallback prebuilt object linking in `codegen.cpp`.
- **Regression Test**: `test_sutra.exe` (Line 1189) and `run_tests.ps1` Step 2.
- **Verification**: `test_sutra.exe` passes with 0 failures.
- **Status**: OPEN

---

### SUTRA-BUG-0003: Windows CMD Devanagari Copy Failure in Self-Hosted Compiler

- **Bug ID**: `SUTRA-BUG-0003`
- **Bug**: `sutrac.exe` fails to copy `sutra_native_temp.exe` to final `<name>_native.exe` when destination path contains Devanagari characters.
- **Severity**: Medium (Leaves stale test binaries on disk, causing incorrect test results).
- **Reproduction**: Run `.\sutrac.exe tests/compiler/04_functions.सूत्र` in Windows console.
- **Expected**: Produces `tests/compiler/04_functions.सूत्र_native.exe`.
- **Actual**: `cmd /c copy /y sutra_native_temp.exe "<file>_native.exe"` fails due to non-UTF-8 console codepage in `cmd.exe`, leaving old or nonexistent executable.
- **Root Cause**: `स्वसंकलक/मूल_संकलन.सूत्र` invokes `cmd /c copy` without setting UTF-8 codepage (`chcp 65001`), or does not use direct `gcc -o` output path.
- **Affected Components**: Self-Hosted Compiler Driver (`स्वसंकलक/मूल_संकलन.सूत्र`).
- **Fix**: Pass destination binary path directly to GCC linker `-o` argument or execute copy via UTF-8-aware process.
- **Regression Test**: Compile a Devanagari-named test file and assert modification timestamp of destination `.exe`.
- **Verification**: Fresh executable created with correct output.
- **Status**: OPEN

---

### SUTRA-BUG-0004: Native Runtime GC Crash on Repeated Garbage Collection Cycles

- **Bug ID**: `SUTRA-BUG-0004`
- **Bug**: `tests/compiler/46_gc_repeated.सूत्र` crashes during native execution on subsequent collection cycles.
- **Severity**: Medium (Native GC stability during long-running programs).
- **Reproduction**: Run `.\sutrac.exe tests/compiler/46_gc_repeated.सूत्र` and execute the resulting binary.
- **Expected**: Output prints:
  ```text
  प्रारम्भः
  समाप्तम्
  प्रारम्भः
  समाप्तम्
  ```
- **Actual**: Process terminates abnormally after the first cycle (`प्रारम्भः` printed, followed by crash).
- **Root Cause**: In `स्वसंकलक/निर्माण/sutra_runtime.c`, during repeated mark-and-sweep cycles, the hash table entries for reclaimed allocations are not properly cleared or tombstones cause double-free/dangling pointer access on subsequent sweep.
- **Affected Components**: Native Runtime GC (`स्वसंकलक/निर्माण/sutra_runtime.c`, `sutra_gc_collect`).
- **Fix**: Fix open-addressing hash table deletion / tombstone cleanup in `gc_hash_del` and mark state reset in `sutra_runtime.c`.
- **Regression Test**: `tests/compiler/46_gc_repeated.सूत्र`.
- **Verification**: `46_gc_repeated.सूत्र_native.exe` exits 0 with exact matching output.
- **Status**: OPEN
