# विकास-मार्गदर्शिका (Sutra Development Guide)

This document provides guidelines for developers contributing to the compiler, runtime, or tools in the Sutra repository.

---

## 1. Repository Layout

* **[`संकलक/`](file:///d:/my%20project/सूत्र/संकलक/)**: The main C++ source code of the compiler, lexer, parser, codegen, and runtime API bridge.
* **[`उपकरणानि/`](file:///d:/my%20project/सूत्र/उपकरणानि/)**: Executable CLI wrapper sources for formatting, linting, debugging, package management, and building.
* **[`परीक्षणानि/`](file:///d:/my%20project/सूत्र/परीक्षणानि/)**: Main test harness implementations.
* **[`tests/`](file:///d:/my%20project/सूत्र/tests/)**: The stability test suite comprising 106 `.सूत्र` integration files.
* **[`दस्तावेजाः/`](file:///d:/my%20project/सूत्र/दस्तावेजाः/)** & **[`docs/`](file:///d:/my%20project/सूत्र/docs/)**: English and Sanskrit project documentation.

---

## 2. Developer Workflow

Sutra development follows a sequential validation cycle:

```text
       1. Modify Compiler/Runtime Source
                       ↓
         2. Compile via build.ps1
                       ↓
   3. Run Unified Tests via run_tests.ps1
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
