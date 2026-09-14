# विकास-मार्गदर्शिका (Sutra Development Guide)

This document provides guidelines for developers contributing to the compiler, runtime, or tools in the Sutra repository.

---

## 1. Repository Layout & Pure Sutra Policy

This repository implements a **Pure Sutra Source Representation** policy. Version control tracks only the canonical compiler source files, tests, and documentation, excluding local C++ bootstrap compilation wrappers:

### 1.1 Git-Tracked Components
* **[`स्वसंकलक/`](स्वसंकलक/)**: The canonical self-hosted compiler parser, lexer, and code generator backend written directly in Sutra.
* **[`भाषा_परीक्षण/`](भाषा_परीक्षण/)**: Automated stability and compiler validation tests.
* **[`दस्तावेजाः/`](दस्तावेजाः/) & [`प्रलेख/`](प्रलेख/)**: Specifications and developer documentation manuals.
* **`build.ps1` / `run_tests.ps1` / `verify_compiler_self.ps1`**: Build and verification scripts.

### 1.2 Local Bootstrap Components (Excluded from Git)
* **`संकलक/`**: Local C++ compiler wrapper and C runtime host system libraries.
* **`उपकरणानि/`**: Local C++ sources for formatter, linter, debugger, build systems, and LSP server adapter.
* **`परीक्षणानि/`**: Local C++ unit test harnesses.

---

## 2. Developer Workflow

Developers edit self-hosted compiler files inside `स्वसंकलक/` and run local validation pipelines:

```text
        1. Modify Compiler Source (स्वसंकलक/)
                       ↓
     2. Build Self-Hosted Driver (sutra.exe build)
                       ↓
     3. Run Verification (verify_compiler_self.ps1)
                       ↓
            4. Verification Result
            /                   \
      (Failures)              (Success)
          ↓                       ↓
    Fix regressions         Deliver changes
```

### Step 1: Rebuilding Binaries
Compile the entire project suite (compiler, tests, and all developer tools):
```powershell
powershell -File build.ps1
```
This updates executables in the root folder (`sutra.exe`, `sutra_build.exe`, `test_toolchain.exe`, etc.).

### Step 2: Executing Tests
Validate changes against unit tests, stability programs, and CLI integration matrices:
```powershell
powershell -File run_tests.ps1
```
Ensure all verification suites report `[PASS]` and exit with code `0` before committing any updates.

---

## 3. Project Conventions

* **Sanskrit/Devanagari-First**: User-facing keywords, symbols, directory names (`संकुलानि`, `निर्माण`), error messages, and package metadata must use Sanskrit/Devanagari characters.
* **Lexer Identifier Enforcements**: English letters are strictly prohibited in Sutra identifiers. All source examples and test programs must declare local variables and parameters using Devanagari characters (e.g. `मान इ = 1;` instead of `मान i = 1;`).
