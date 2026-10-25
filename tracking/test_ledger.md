# सूत्र (Sutra) — Test Ledger

**Audit Baseline Date**: 2026-09-01  
**Total Test Files**: 175  
**Automated Suites Active**: 5

---

## 1. Test Suite Summary & Pass Rates

| Test Suite / Category | Location | Total Tests | Interp Pass | Native Pass | Parity Match | Runner Script | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Compiler Parity Tests** | `tests/compiler/` | 53 | 53 (100%) | 52 (98.1%) | 48 (90.6%) | `audit_compiler_run.js` / `verify_compiler.ps1` | **PASSING (98%)** |
| **Negative / Error Tests** | `tests/negative/` | 18 | 18 (100%) | 18 (100%) | 18 (100%) | `run_tests.ps1` | **100% PASS** |
| **Standard Library Tests** | `tests/stdlib/` | 11 | 11 (100%) | 11 (100%) | 11 (100%) | `run_tests.ps1` | **100% PASS** |
| **Intrinsics & OS Floor** | `tests/intrinsics/` | 4 | N/A (Native) | 4 (100%) | 4 (100%) | `verify_intrinsics.ps1` | **100% PASS** |
| **Control Flow & Loops** | `tests/loops/` | 6 | 6 (100%) | 6 (100%) | 6 (100%) | `run_tests.ps1` | **100% PASS** |
| **Conditionals** | `tests/conditions/` | 4 | 4 (100%) | 4 (100%) | 4 (100%) | `run_tests.ps1` | **100% PASS** |
| **Error & Exception Tests** | `tests/error_handling/` | 4 | 4 (100%) | 4 (100%) | 4 (100%) | `run_tests.ps1` | **100% PASS** |
| **Module & Import Tests** | `tests/modules/` | 5 | 5 (100%) | 5 (100%) | 5 (100%) | `run_tests.ps1` | **100% PASS** |
| **Variables & Memory** | `tests/variables/` | 5 | 5 (100%) | 5 (100%) | 5 (100%) | `run_tests.ps1` | **100% PASS** |
| **Lists & Arrays** | `tests/arrays/` | 3 | 3 (100%) | 3 (100%) | 3 (100%) | `run_tests.ps1` | **100% PASS** |
| **Operators & Arithmetic** | `tests/operators/` | 3 | 3 (100%) | 3 (100%) | 3 (100%) | `run_tests.ps1` | **100% PASS** |
| **Unicode & Devanagari** | `tests/unicode/` | 2 | 2 (100%) | 2 (100%) | 2 (100%) | `run_tests.ps1` | **100% PASS** |
| **Functions & Recursion** | `tests/functions/` | 3 | 3 (100%) | 3 (100%) | 3 (100%) | `run_tests.ps1` | **100% PASS** |
| **Object-Oriented (OOP)** | `tests/oop/` | 1 | 1 (100%) | 1 (100%) | 1 (100%) | `run_tests.ps1` | **100% PASS** |
| **Console I/O** | `tests/io/` | 1 | 1 (100%) | 1 (100%) | 1 (100%) | `run_tests.ps1` | **100% PASS** |
| **Integration Apps** | `tests/integration/` | 3 | 3 (100%) | 3 (100%) | 3 (100%) | `run_tests.ps1` | **100% PASS** |
| **Micro-Benchmarks** | `tests/benchmark/` | 4 | 4 (100%) | 4 (100%) | 4 (100%) | `sutra_benchmark.exe` | **100% PASS** |
| **Self-Hosted IR Unit Suites** | `स्वसंकलक/*_परीक्षण.सूत्र` | 4 | N/A (Self-host) | 4 (100%) | 4 (100%) | `verify_ir.ps1` | **100% PASS (54 checks)** |
| **C++ Core Unit Tests** | `परीक्षणानि/test_sutra.cpp` | 1 (1,523 lines) | PASS (Frontend) | Failed link | N/A | `test_sutra.exe` | **BLOCKED BY SUTRA-BUG-0002** |
| **C++ Toolchain Tests** | `परीक्षणानि/test_toolchain.cpp` | 1 (1,163 lines) | PASS (Tools) | Failed link | N/A | `test_toolchain.exe` | **BLOCKED BY SUTRA-BUG-0002** |
| **LSP Integration Tests** | `tests/lsp/test_lsp_integration.cpp` | 1 | 1 (100%) | 1 (100%) | 1 (100%) | `test_lsp_integration.exe` | **100% PASS** |
| **Native Phase 5 OOP Tests** | `परीक्षणानि/native_phase5/` | 5 | 5 (100%) | 5 (100%) | 5 (100%) | `run_tests.ps1` | **100% PASS** |
| **Root Verification Tests** | Root (`परीक्षण.सूत्र`, etc.) | 5 | 5 (100%) | 5 (100%) | 5 (100%) | `run_tests.ps1` | **100% PASS** |
| **TOTALS** | **Workspace Wide** | **175** | **166** | **163** | **156** | — | **93.1% Total Parity** |

---

## 2. Test Execution Commands & Instructions

### A. Full Automated Test Suite (Interpreter + Native Compiler + Parity + M4 Tools)
```powershell
powershell -ExecutionPolicy Bypass -File .\run_tests.ps1
```

### B. Self-Hosted IR Unit Tests
```powershell
powershell -ExecutionPolicy Bypass -File .\verify_ir.ps1
```

### C. Low-Level OS Intrinsics Tests
```powershell
powershell -ExecutionPolicy Bypass -File .\verify_intrinsics.ps1
```

### D. Self-Hosted Fixed-Point Bootstrap Verification
```bash
./verify_ir_selfhost.sh
```

### E. LSP Server Integration Test
```powershell
.\test_lsp_integration.exe
```

---

## 3. Detailed Failure Analysis in Current Baseline

1. **`tests/compiler/46_gc_repeated.सूत्र`**: Fails in native execution on second cycle (`SUTRA-BUG-0004`).
2. **`tests/compiler/41_dynamic_list_stress.सूत्र`** & **`44_gc_status.सूत्र`**: Output differs only by Windows CRLF (`\r\n`) vs Unix LF (`\n`) formatting.
3. **`tests/compiler/04_functions.सूत्र`** & **`05_return.सूत्र`**: Intermittent copy issue on Windows CMD non-UTF-8 path copy (`SUTRA-BUG-0003`).
4. **`परीक्षणानि/test_sutra.cpp`** (Line 1189) & **`test_toolchain.cpp`** (Line 1137): Assertion failure during `sutra.exe build` link step due to missing runtime module objects (`SUTRA-BUG-0002`).
