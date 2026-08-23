# परीक्षण-पद्धतिः (Sutra Testing & Verification)

This document describes the testing architecture, validation scripts, and test suites integrated into the Sutra compiler validation loop.

---

## 1. Test Architecture

The verification suite includes both local integration testing and canonical self-hosted compiler verification:

### 1.1 Local Host Integration Runner (`run_tests.ps1`)
This script executes in the local development environment using MSYS2/MinGW to verify:
- Local C++ Unit Tests (`test_sutra.exe`, `test_toolchain.exe`, `test_lsp_integration.exe`). Note: the source files for these tests reside locally and are excluded from Git.
- Stability Integration Suite, compiling and running all integration test scripts under the host wrapper compiler.
- Toolchain CLI testing (checking linter, formatter, and LSP communication logs).

### 1.2 Canonical Compiler Parity Runner (`verify_compiler_self.ps1`)
This script uses the natively compiled self-hosted compiler (`sutra_self.exe`) to compile the test suite under the `tests/compiler` directory.
- Runs target scripts through both the interpreter and compiled native binaries.
- Compares console stdout outputs and exit code results.
- **Current verification result**: 48/48 compiler verification tests passed.

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

### 3.1 Run Local Developer Tests
To build local binaries and run the complete developer test suite:
```powershell
powershell -File run_tests.ps1
```

### 3.2 Run Self-Hosted Compiler Verification
To compile the self-hosted parser/codegen in Sutra and verify all compiler test cases:
```powershell
# Compile self-hosted driver using host wrapper compiler
.\sutra.exe build "स्वसंकलक/विश्लेषक_परीक्षण.सूत्र"

# Run tests under compiled driver
powershell -ExecutionPolicy Bypass -File verify_compiler_self.ps1
```
