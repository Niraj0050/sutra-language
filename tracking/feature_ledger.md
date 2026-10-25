# सूत्र (Sutra) — Feature Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Core Language Features

| Feature Name | Sanskrit / Hindi Keyword | Interpreter Support | Native Compiler Support | Self-Hosted Compiler Support | Specification Status | Test Coverage | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Variable Declarations | `मान`, `संख्या`, `दशमलव`, `पाठ`, `बूल` | Full | Full | Full | `document/02-language-specification/variables.md` | `tests/variables/` (5 tests) | **COMPLETE** |
| Arithmetic Operators | `+`, `-`, `*`, `/`, `%` | Full | Full | Full | `document/02-language-specification/operators.md` | `tests/operators/04_arithmetic.सूत्र` | **COMPLETE** |
| Comparison Operators | `==`, `!=`, `<`, `>`, `<=`, `>=` | Full | Full | Full | `document/02-language-specification/operators.md` | `tests/operators/05_comparison.सूत्र` | **COMPLETE** |
| Logical Operators | `&&` (`तथा`), `\|\|` (`अथवा`), `!` (`न`) | Full | Full | Full | `document/02-language-specification/operators.md` | `tests/operators/06_logical.सूत्र` | **COMPLETE** |
| Conditionals | `यदि`, `अन्यथा`, `अगर` | Full | Full | Full | `document/02-language-specification/control-flow.md` | `tests/conditions/` (4 tests) | **COMPLETE** |
| Loops (While) | `यावत्`, `जबतक` | Full | Full | Full | `document/02-language-specification/control-flow.md` | `tests/loops/08_while_loop.सूत्र` | **COMPLETE** |
| Loops (For/Repeat) | `पुनरावृत्तिः` | Full | Full | Full | `document/02-language-specification/control-flow.md` | `tests/loops/09_for_loop.सूत्र` | **COMPLETE** |
| Loop Controls | `विरामः` (`break`), `जारीरह` (`continue`) | Full | Full | Full | `document/02-language-specification/control-flow.md` | `tests/loops/10_break.सूत्र`, `10_continue.सूत्र` | **COMPLETE** |
| Functions & Calls | `कार्य`, `मुख्य`, `परत्` | Full | Full | Full | `document/02-language-specification/functions.md` | `tests/functions/` (3 tests) | **COMPLETE** |
| Recursion | `कार्य` self-call | Full | Full | Full | `document/02-language-specification/recursion.md` | `tests/functions/12_recursion.सूत्र` | **COMPLETE** |
| String Literals & Ops | `पाठ`, concatenation, indexing | Full | Full | Full | `document/02-language-specification/strings.md` | `tests/unicode/15_string_indexing.सूत्र` | **COMPLETE** |
| Unicode Devanagari | UTF-8 multi-byte glyphs | Full | Full | Full | `document/02-language-specification/unicode.md` | `tests/unicode/14_unicode.सूत्र` | **COMPLETE** |
| Lists / Arrays | `सूची` `[a, b, c]` | Full | Full | Full | `document/02-language-specification/collections.md` | `tests/arrays/` (3 tests) | **COMPLETE** |
| Dictionaries / Maps | `शब्दकोश` `{k: v}` | Full | Full | Full | `document/02-language-specification/collections.md` | `tests/compiler/50_dict_literal.सूत्र` | **COMPLETE** |
| Object-Oriented (OOP) | `वर्ग`, `नवीन`, `स्व` | Full | Full | Partial (Self-host parser supports; IR lowering partial) | `document/02-language-specification/oop.md` | `tests/oop/19_oop.सूत्र`, `परीक्षणानि/native_phase5/` | **IN_PROGRESS** |
| Exception Handling | `प्रयत्न`, `पकड़ो`, `प्रक्षेपः` | Full | Full | Full (IR lowering implemented) | `document/02-language-specification/exceptions.md` | `tests/error_handling/16_try_catch.सूत्र` | **COMPLETE** |
| Module System | `आयात "file.सूत्र"` | Full | Full | Full | `document/02-language-specification/modules.md` | `tests/modules/` (5 tests) | **COMPLETE** |
| Console I/O | `लिखतु`, `दर्शयतु`, `पठतु` | Full | Full | Full | `document/02-language-specification/input-output.md` | `tests/io/13_input.सूत्र` | **COMPLETE** |

---

## 2. Standard Library Modules (`पुस्तकालय/`)

| Module | Purpose | Exported Functions / Classes | Test Suite | Status |
| :--- | :--- | :--- | :--- | :--- |
| `मानक.सूत्र` | Umbrella standard library import | Imports all 14 standard modules | `tests/stdlib/18_stdlib.सूत्र` | **COMPLETE** |
| `गणित.सूत्र` | Advanced mathematical functions & constants | 24 functions (`वर्गमूल`, `घातांक`, `साइन`, `कोसाइन`, `पाई`, `ई`, etc.) | `tests/stdlib/गणित_परीक्षण.सूत्र` | **COMPLETE** |
| `पाठ.सूत्र` | String manipulation & search | 15 functions (`दोहराओ`, `बाएँ_भरो`, `उलटा_पाठ`, `पंक्तियाँ`, `समाहित_पाठ`, etc.) | `tests/stdlib/पाठ_परीक्षण.सूत्र` | **COMPLETE** |
| `सूची.सूत्र` | Higher-order list algorithms & utilities | 28 functions (`उलटा`, `योग`, `न्यूनतम_का`, `अधिकतम_का`, `अद्वितीय`, `समतल`, etc.) | `tests/stdlib/सूची_परीक्षण.सूत्र` | **COMPLETE** |
| `शब्दकोश.सूत्र` | Dictionary helpers & transformations | 12 functions (`मान_सूची`, `युग्म_सूची`, `विलय`, `उलट`, `चुनो`, `कुंजी_का`, etc.) | `tests/stdlib/संग्रह_परीक्षण.सूत्र` | **COMPLETE** |
| `समुच्चय.सूत्र` | Set data structure (HashSet equivalent) | `वर्ग समुच्चय` (11 methods: `जोड़ो`, `है`, `हटाओ`, `संघ`, `प्रतिच्छेद`, etc.) | `tests/stdlib/संग्रह_परीक्षण.सूत्र` | **COMPLETE** |
| `कतार.सूत्र` | FIFO Queue data structure | `वर्ग कतार` (7 methods: `धक्का`, `निकालो`, `झांको`, `खाली_है`, etc.) | `tests/stdlib/संग्रह_परीक्षण.सूत्र` | **COMPLETE** |
| `ढेर.सूत्र` | LIFO Stack data structure | `वर्ग ढेर` (7 methods: `धक्का`, `निकालो`, `झांको`, `खाली_है`, etc.) | `tests/stdlib/संग्रह_परीक्षण.सूत्र` | **COMPLETE** |
| `ढेर_प्राथमिकता.सूत्र` | Binary Min-Heap Priority Queue | `वर्ग प्राथमिकता_कतार` (8 methods: `धक्का`, `निकालो`, `झांको`, `ढेर_क्रम`, etc.) | `tests/stdlib/संग्रह_परीक्षण.सूत्र` | **COMPLETE** |
| `क्रमचय.सूत्र` | Combinatorics & Permutations | 8 functions (`क्रमचय`, `संयोजन`, `कार्तीय_गुणन`, `घातांक_समुच्चय`, etc.) | `tests/stdlib/क्रमचय_परीक्षण.सूत्र` | **COMPLETE** |
| `जेसन.सूत्र` | JSON Parser and Serializer | 14 functions (`जेसन_पार्स`, `जेसन_स्ट्रिंग`, `जेसन_प्रारूप`, etc.) | `tests/stdlib/जेसन_परीक्षण.सूत्र` | **COMPLETE** |
| `तर्क.सूत्र` | Command-Line Argument Parser | `वर्ग तर्क_विश्लेषक` (9 methods: `ध्वज`, `विकल्प`, `विश्लेषण`, `सहायता`) | `tests/stdlib/तर्क_परीक्षण.सूत्र` | **COMPLETE** |
| `पथ.सूत्र` | Cross-Platform Filesystem Paths | 10 functions (`पथ_जोड़ो`, `आधार_नाम`, `निर्देशिका`, `विस्तार`, `पथ_सामान्य`) | `tests/stdlib/पथ_परीक्षण.सूत्र` | **COMPLETE** |
| `परीक्षण.सूत्र` | Unit Testing & Assertion Framework | 8 functions (`जाँच`, `जाँच_सत्य`, `जाँच_असत्य`, `जाँच_निकट`, `परीक्षण_सारांश`) | `tests/stdlib/परीक्षण_परीक्षण.सूत्र` | **COMPLETE** |
| `प्रारूप.सूत्र` | String Templates & Number Formatting | 15 functions (`प्रारूप`, `बाएँ_संरेखित`, `संख्या_प्रारूप`, `प्रतिशत`, `हेक्स`) | `tests/stdlib/प्रारूप_परीक्षण.सूत्र` | **COMPLETE** |

---

## 3. Developer Toolchain (`उपकरणानि/`)

| Tool Executable | Component | Capabilities | Verification Test | Status |
| :--- | :--- | :--- | :--- | :--- |
| `sutra_lsp.exe` | Language Server Protocol (LSP) | Diagnostics, Autocomplete, Hover, Definition, Formatting over JSON-RPC 2.0 | `tests/lsp/test_lsp_integration.cpp` (PASS) | **COMPLETE** |
| `sutra_formatter.exe`| Code Formatter | Checks and auto-indents Sutra files according to canonical style rules | `run_tests.ps1` Step 4.1 (PASS) | **COMPLETE** |
| `sutra_linter.exe` | Static Analysis Linter | Detects unused variables, unreachable code, unassigned variables | `run_tests.ps1` Step 4.2 (PASS) | **COMPLETE** |
| `sutra_debugger.exe`| Interactive Debugger | Breakpoints, stepping, environment inspection, frame stack | Toolchain test suite | **COMPLETE** |
| `sutra_pkgmgr.exe` | Package Manager | Package initialization (`init`), dependency check (`install`), listing (`list`) | `run_tests.ps1` Step 4.3 (PASS) | **COMPLETE** |
| `sutra_build.exe` | Build System Driver | Automated multi-file compilation, dependency tracking, clean tasks | `run_tests.ps1` Step 4.4 (PASS) | **COMPLETE** |
| `sutra_benchmark.exe`| Micro-Benchmarking | Execution timing, iteration statistics, memory delta measurements | `tests/benchmark/` (4 tests) | **COMPLETE** |
