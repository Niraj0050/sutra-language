# Product Requirements Document (PRD) — सूत्र (Sutra)

**Language Version:** 1.0.0  
**Status:** Feature Complete & Verified  

---

## 1. Product Vision

**सूत्र (Sutra)** is a Sanskrit/Devanagari-first, general-purpose programming language. It is designed to lower the language barrier in computer science education and software engineering for Hindi and Sanskrit-speaking regions by offering a native Devanagari syntax, keyword structure, and data model.

Rather than being a simple translator or wrapper around another language, Sutra is a complete programming ecosystem featuring a custom lexer, parser, semantic analyzer, abstract syntax tree (AST) interpreter, native x86-64 machine compiler, lightweight runtime engine, dynamic memory manager, and developer toolchain.

### Vision Timeline:
* **CURRENT (1.0.0 Status)**: Dynamically typed programming language with explicit type aliases. AST-based script interpreter, interactive REPL, native x86-64 assembly-generating compiler, garbage-collected runtime, structured OOP, module system, exception handling, full developer utility tool suite (formatter, linter, debugger, package manager, build, benchmark, LSP), and a fully verified self-hosted compiler (`स्वसंकलक/`).
* **PLANNED**: Refining LSP editor integrations (VS Code extensions, autocomplete diagnostics), developing the Sutra Virtual Machine (SVM) and bytecode compiler layer for cross-platform bytecode execution.
* **FUTURE**: LLVM native back-end integration and a package repository ecosystem.

---

## 2. Problem Statement

Modern programming is heavily dependent on English. Syntax keywords, standard library APIs, documentation, and compiler diagnostics are predominantly English-only. For millions of students and educators in Sanskrit/Hindi-speaking regions, learning programming requires overcoming both logical and linguistic barriers.

Sutra addresses this by:
1. Providing a syntax fully written in Devanagari script.
2. Standardizing compiler error messages and logs in Hindi/Sanskrit.
3. Building a custom compiler/interpreter architecture that handles multi-byte UTF-8 Unicode natively at every stage of the pipeline (from source text scanning to target code generation).

---

## 3. Target Users

* **Students & Educators**: Learners in Devanagari-medium institutions who want to understand programming logic without first mastering technical English terminology.
* **Language Enthusiasts & Researchers**: Computational linguists interested in Sanskrit grammatical structures applied to programming syntax.
* **Tooling Developers**: System designers looking to build compiler tools, package structures, and editors on top of a non-ASCII native foundation.

---

## 4. Product Scope

| Component | Status | Details |
|---|---|---|
| **Lexer & Parser** | **Complete** | Unicode UTF-8 decoding, Devanagari starting characters, Devanagari numeric literals, AST builder. |
| **Semantic Analyzer** | **Complete** | Local environment scoping, type validation, jump context validation (break/continue verification). |
| **Interpreter** | **Complete** | Direct AST-walking interpreter executing files or interactive REPL inputs. |
| **Native Compiler** | **Complete** | x86-64 assembly code generator, standard C runtime linker interface (`sutra_runtime.o` via `g++.exe`). |
| **Garbage Collector** | **Complete** | Mark-and-sweep heap management. Interpreter environment scan + native execution shadow stack root scan. |
| **Standard Library** | **Complete** | Built-in math APIs, list helpers, UTF-8 string operators, and standard I/O reader/writer methods. |
| **LSP / Language Server** | **Complete** | LSP adapter implementing hover definition, format checks, compile diagnostics, and autocomplete. |
| **Formatter & Linter** | **Complete** | CLI format beautifier (`sutra_formatter`) and code analyzer (`sutra_linter`) for code safety rules L001–L008. |
| **Debugger** | **Complete** | Interactive CLI debugger (`sutra_debugger`) supporting step-into, continue, breakpoints, and scope lookup. |
| **Package & Build Managers**| **Complete** | Manifest initiator, package installer/remover (`sutra_pkgmgr`), and build pipeline builder (`sutra_build`). |
| **Benchmarking System** | **Complete** | Execution and compilation duration timing, plus GC allocation telemetry capture (`sutra_benchmark`). |
| **Self-hosting (`स्वसंकलक`)**| **Complete** | Self-hosting bootstrap and compiler parity have been implemented and verified. Current verification result: 48/48 compiler verification tests passed. |

---

## 5. Functional Requirements

### 5.1 Lexical & Syntactic Requirements
* All identifier start characters must fall strictly inside the Devanagari range (`0x0904` to `0x097F`). Identifier continuation characters can include combining marks, Devanagari numerals (`०-९`), ASCII digits (`0-9`), and underscores `_`.
* ASCII English characters (`a-z`, `A-Z`) are strictly forbidden as identifier start characters to enforce Devanagari-first codebases.
* Statements must terminate with a semicolon `;`.

### 5.2 Scoping & Variables
* Scoping must support block lexical scopes. Local variables are declared using untyped declaration `मान` or type-aliased keywords (`संख्या`, `दशमलव`, `पाठ`, `बूल`, `सूची`, `शब्दकोश`).

### 5.3 Control Flow & Jumps
* Conditional branching using `यदि` / `अगर` and `अन्यथा`.
* Loops using `yaavata` / `यावत्` (while) and `punaraavrittih` / `पुनरावृत्तिः` (for).
* Loop interruption using `विरामः` (break) and iteration skip using `जारीरह` / `अग्रिमः` (continue). Using jump statements outside active loops must throw semantic validation errors.

### 5.4 Object-Oriented Programming (OOP)
* Class declarations via `वर्ग`, instantiation via `नवीन`, self-reference pointer mapping via `स्व`, and custom initialization constructors using `रचना`.

### 5.5 Exception Handling
* Try-catch-throw mechanisms via `प्रयत्न`, `पकड़ो`, and `प्रक्षेपः` / `फेको`.

### 5.6 Runtime & Garbage Collection
* Automated memory reclamation using a Mark-and-Sweep garbage collector. Tracked memory objects: UTF-8 strings (`GC_TYPE_STRING`), dynamic arrays (`GC_TYPE_ARRAY`), class objects (`GC_TYPE_OBJECT`), and hash dictionaries (`GC_TYPE_DICTIONARY`).

---

## 6. Non-Functional Requirements

* **Encoding Parity**: The compiler, interpreter, diagnostics engine, and CLI tools must use UTF-8 as their primary encoding, ensuring Hindi and Sanskrit text inputs are parsed, manipulated, and displayed without corruption.
* **Execution Parity**: Programs executed through the C++ AST interpreter must produce identical console output and exit code values when compiled and executed as a native machine binary.
* **Beautification & Static Analysis**: Code formatters and linters must guarantee idempotency and catch L001–L008 safety diagnostics.
* **Platform Independence**: Core interpretation, formatting, linting, packaging, and LSP services are platform-neutral, while native x86-64 machine-code compilation runs on Windows (using MSYS2/MinGW `g++`) and Unix systems.

---

## 7. Current Product Status

Sutra version 1.0.0 is stabilized and fully verified.
* **Core Unit Tests**: 100% of C++ compiler tests (`test_sutra.exe`) and toolchain tests (`test_toolchain.exe`) pass.
* **Parity Integration Suite**: All 115 stability test files pass verification testing under interpreter and compiler modes, showing 100% parity correctness.
* **Developer Tools**: Formatter, linter, debugger, package manager, build system, benchmark runner, and LSP server are fully operational.

---

## 8. Future Vision

* **Bytecode VM (SVM)**: Transitioning compiler IR to optimized bytecode instructions running inside a lightweight, sandboxed VM to enable cross-platform sandboxed execution.
* **LLVM Target backend**: Replacing the intermediate x86-64 text-assembly generator and `g++` linker setup with direct LLVM assembly generation, enabling target optimization passes.
* **Self-Hosting Compiler**: Continuous optimization of the completed self-hosted compiler under `स्वसंकलक/` and expanding standard library support.
