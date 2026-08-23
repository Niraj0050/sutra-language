# परीक्षण-पद्धतिः (Sutra Testing & Verification)

This document describes the testing architecture, validation scripts, and test suites integrated into the Sutra compiler validation loop.

---

## 1. Test Architecture

The verification suite runs sequentially in four phases under a single command runner:

```text
               run_tests.ps1
                     ↓
+------------------------------------------+
| Phase 1: Compile All Targets (build.ps1) |
+------------------------------------------+
                     ↓
+------------------------------------------+
| Phase 2: Run C++ Unit Tests              |
| - test_sutra.exe (20 compiler tests)     |
| - test_toolchain.exe (59 tool tests)     |
+------------------------------------------+
                     ↓
+------------------------------------------+
| Phase 3: Execute Stability Suite         |
| - 106 integration tests                  |
| - Validates compiler/interpreter parity  |
+------------------------------------------+
                     ↓
+------------------------------------------+
| Phase 4: Run CLI Integration Tests       |
| - Formatter, Linter, PkgMgr, Build       |
+------------------------------------------+
```

---

## 2. Test Suites Detail

### 2.1 C++ Unit Tests
* **Compiler Tests (`test_sutra.exe`)**: 20 tests. Checks UTF-8 lexing, parse rules, symbol resolution, type casting, AST correctness, and compiler scoping rules.
* **Toolchain Tests (`test_toolchain.exe`)**: 59 tests. Checks formatter rules, linter rules, debugger breakpoint hooks, package manifest saving, and build compilation configurations.

### 2.2 Stability Integration Suite (106 Files)
Scans for `.सूत्र` files in:
* `tests/`
* `परीक्षण_इनपुट.सूत्र`
Runs each program in:
1. **Interpreter mode** (`sutra.exe <file>`).
2. **Compiler mode** (generates native executable and runs it).
Compares console output and exit code returns. Any difference triggers a `PARITY MISMATCH` error.

### 2.3 CLI integration Tests
Validates the execution commands of M4 tools in real conditions:
* **`sutra_formatter.exe`**: In-place edits, check flags, and idempotency checks.
* **`sutra_linter.exe`**: Warning output checks and exit code rules.
* **`sutra_pkgmgr.exe`**: Project init, metadata parsing, and list checks.
* **`sutra_build.exe`**: End-to-end manifest parsing, native building, executable validation, and cleanup.

---

## 3. Running Tests

To build all dependencies and run the complete test suite:
```powershell
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"; powershell -File run_tests.ps1
```
This requires a valid MSYS2 GCC/MinGW-w64 environment for compiling test binaries.
