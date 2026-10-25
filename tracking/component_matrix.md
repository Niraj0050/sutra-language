# सूत्र (Sutra) — Master Component Matrix

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

| Component | Implementation File(s) | Test Suite | Verification | Docs | Interp | Native | Self-Host | Known Bugs |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Lexer** | `संकलक/src/lexer.cpp`, `स्वसंकलक/लेखक.सूत्र` | `परीक्षणानि/test_sutra.cpp`, `स्वसंकलक/लेखक_परीक्षण.सूत्र` | Automated | `docs/SUTRA_LANGUAGE_SPEC.md` | Yes | Yes | Yes | None |
| **Tokenizer** | `संकलक/src/token.cpp` | `परीक्षणानि/test_sutra.cpp` | Automated | `document/02-language-specification/lexical-structure.md` | Yes | Yes | Yes | None |
| **Unicode** | `संकलक/src/unicode.cpp` | `tests/unicode/14_unicode.सूत्र`, `15_string_indexing.सूत्र` | Automated | `document/02-language-specification/unicode.md` | Yes | Yes | Yes | None |
| **Parser** | `संकलक/src/parser.cpp`, `स्वसंकलक/विश्लेषक.सूत्र` | `परीक्षणानि/test_sutra.cpp`, `स्वसंकलक/विश्लेषक_परीक्षण.सूत्र` | Automated | `document/03-language-reference/grammar.md` | Yes | Yes | Yes | None |
| **AST** | `संकलक/include/sutra/ast.hpp`, `संकलक/src/ast.cpp` | `परीक्षणानि/test_sutra.cpp` | Automated | `document/05-compiler/frontend.md` | Yes | Yes | Yes | None |
| **Semantic Analyzer** | `संकलक/src/semantic.cpp`, `स्वसंकलक/सार्थक_विश्लेषक.सूत्र`| `tests/negative/`, `स्वसंकलक/सार्थक_विश्लेषक_परीक्षण.सूत्र`| Automated | `document/05-compiler/frontend.md` | Yes | Yes | Yes | None |
| **Types** | `संकलक/src/types.cpp` | `tests/variables/03_typed_variables.सूत्र`, `04_type_checking.सूत्र` | Automated | `document/02-language-specification/types.md` | Yes | Yes | Yes | None |
| **Environment** | `संकलक/src/environment.cpp`, `संकलक/include/sutra/environment.hpp` | `tests/variables/02_variables.सूत्र` | Automated | `document/07-runtime/memory_model.md` | Yes | Yes | Yes | `SUTRA-BUG-0001` |
| **Interpreter** | `संकलक/src/interpreter.cpp` | `tests/` (144 test suites) | Automated | `docs/DEVELOPMENT.md` | Yes | N/A | N/A | None |
| **IR** | `संकलक/src/compiler/ir.cpp`, `स्वसंकलक/मध्यम.सूत्र` | `स्वसंकलक/मध्यम_परीक्षण.सूत्र` | Automated | `docs/COMPILER.md` | N/A | Yes | Yes | None |
| **IR Generator** | `संकलक/src/compiler/ir_generator.cpp`, `स्वसंकलक/मूल_निम्नक.सूत्र` | `स्वसंकलक/मूल_निम्नक_परीक्षण.सूत्र` | Automated | `docs/COMPILER.md` | N/A | Yes | Yes | None |
| **Optimizer** | `स्वसंकलक/अनुकूलक.सूत्र` | `स्वसंकलक/अनुकूलक_परीक्षण.सूत्र` | Automated | `docs/PERFORMANCE_ROADMAP.md` | N/A | Yes | Yes | None |
| **Register Allocator**| `स्वसंकलक/रजि_नियतक.सूत्र` | `स्वसंकलक/रजि_नियतक_परीक्षण.सूत्र` | Automated | `docs/COMPILER.md` | N/A | Yes | Yes | None |
| **Code Generator** | `संकलक/src/compiler/codegen.cpp`, `स्वसंकलक/मूल_उत्सर्जक.सूत्र` | `tests/compiler/` (53 tests) | Automated | `docs/COMPILER.md` | N/A | Yes | Yes | `SUTRA-BUG-0002` |
| **Runtime** | `sutra_runtime.c`, `मूल_रनटाइम.सूत्र`/`.s`, `तल.s` | `tests/intrinsics/` | Automated | `docs/RUNTIME.md`, `docs/RUNTIME_IN_SUTRA.md` | Yes | Yes | Yes | None |
| **Memory Allocator** | `संकलक/src/memory.cpp`, `मूल_आवंटक.सूत्र`/`.s` | `tests/variables/05_memory_layout.सूत्र` | Automated | `memory.md`, `document/07-runtime/memory_model.md` | Yes | Yes | Yes | None |
| **Garbage Collector** | `संकलक/src/स्मृतिसंग्राहक.cpp`, `sutra_runtime.c` | `tests/compiler/43_gc_stress.सूत्र`..`47_gc_realloc.सूत्र` | Automated | `document/07-runtime/gc.md` | Yes | Yes | Yes | `SUTRA-BUG-0004` |
| **Strings** | Builtin + `पुस्तकालय/पाठ.सूत्र` | `tests/unicode/15_string_indexing.सूत्र`, `tests/stdlib/पाठ_परीक्षण.सूत्र` | Automated | `document/02-language-specification/strings.md` | Yes | Yes | Yes | None |
| **Lists** | Builtin + `पुस्तकालय/सूची.सूत्र` | `tests/arrays/`, `tests/stdlib/सूची_परीक्षण.सूत्र` | Automated | `document/02-language-specification/collections.md` | Yes | Yes | Yes | None |
| **Dictionaries** | Builtin + `पुस्तकालय/शब्दकोश.सूत्र` | `tests/compiler/50_dict_literal.सूत्र`, `tests/stdlib/संग्रह_परीक्षण.सूत्र` | Automated | `document/02-language-specification/collections.md` | Yes | Yes | Yes | None |
| **OOP** | `संकलक/src/value.cpp`, AST node `ClassDeclASTNode` | `tests/oop/19_oop.सूत्र`, `परीक्षणानि/native_phase5/` | Automated | `document/02-language-specification/oop.md` | Yes | Yes | Partial | None |
| **Exceptions** | AST nodes `TryCatchStmtASTNode`, `ThrowStmtASTNode` | `tests/error_handling/16_try_catch.सूत्र`, `tests/compiler/49_exceptions.सूत्र` | Automated | `document/02-language-specification/exceptions.md` | Yes | Yes | Yes | None |
| **Modules** | AST node `ImportStmtASTNode` | `tests/modules/` (5 tests) | Automated | `document/02-language-specification/modules.md` | Yes | Yes | Yes | None |
| **Stdlib** | `पुस्तकालय/` (15 modules) | `tests/stdlib/` (11 test suites) | Automated | `पुस्तकालय/README.md`, `docs/STANDARD_LIBRARY.md` | Yes | Yes | Yes | None |
| **Toolchain** | `संकलक/src/toolchain.cpp`, `उपकरणानि/` | `परीक्षणानि/test_toolchain.cpp`, `run_tests.ps1` Step 4 | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **LSP** | `उपकरणानि/sutra_lsp.cpp`, `उपकरणानि/src/` | `tests/lsp/test_lsp_integration.cpp` | Automated | `docs/LANGUAGE_SERVER.md` | Yes | Yes | Yes | None |
| **Formatter** | `संकलक/src/formatter.cpp`, `उपकरणानि/formatter/` | `run_tests.ps1` Step 4.1 | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **Linter** | `संकलक/src/linter.cpp`, `उपकरणानि/linter/` | `run_tests.ps1` Step 4.2 | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **Debugger** | `संकलक/src/debugger.cpp`, `उपकरणानि/debugger/` | `परीक्षणानि/test_toolchain.cpp` | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **Package Manager** | `संकलक/src/package_manager.cpp`, `उपकरणानि/package_manager/` | `run_tests.ps1` Step 4.3 | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **Build System** | `संकलक/src/build_system.cpp`, `उपकरणानि/build_system/` | `run_tests.ps1` Step 4.4 | Automated | `docs/TOOLCHAIN.md` | Yes | Yes | Yes | None |
| **Self-Hosting** | `स्वसंकलक/मूल_संकलन.सूत्र` (IR pipeline) | `verify_ir.ps1`, `verify_ir_selfhost.sh` | Automated | `docs/SELF_HOSTING.md`, `document/06-self-hosting/` | N/A | Yes | Yes | `SUTRA-BUG-0003` |
| **Bootstrap** | `bootstrap.ps1`, `स्वसंकलक/निर्माण/मूल_संकलन.s` | `bootstrap.ps1` Step 5 | Automated | `docs/SELF_HOSTING.md`, `document/06-self-hosting/bootstrap.md` | N/A | Yes | Yes | None |
| **Documentation** | `docs/`, `document/`, `दस्तावेजाः/` | Manual cross-check against AST & test suites | Verified | `docs/README.md`, `document/index.md` | Yes | Yes | Yes | Minor drift |
| **Tests** | `tests/`, `परीक्षणानि/`, `स्वसंकलक/*_परीक्षण.सूत्र` | Automated test runners (`run_tests.ps1`, `verify_ir.ps1`) | Empirical | `docs/TESTING.md`, `document/09-testing/` | Yes | Yes | Yes | None |
