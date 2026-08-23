# System Architecture — सूत्र (Sutra)

This document describes the canonical system architecture, compiler and interpreter pipelines, runtime integration layer, and shared developer toolchain library of the Sutra language.

---

## 1. Directory Structure Layout

The Sutra codebase is organized into key subsystem folders:
* **[`संकलक/include/sutra/`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/)**: Shared header interfaces for lexing, parsing, semantic analysis, memory model, compiler IR, code generation, and debugger/toolchain APIs.
* **[`संकलक/src/`](file:///d:/my%20project/सूत्र/संकलक/src/)**: Implementations of the language core, AST interpreter, REPL loops, and native memory management.
  - `compiler/`: Native code generation, x86-64 assembly generator, and compiler runtime files.
* **[`उपकरणानि/`](file:///d:/my%20project/सूत्र/उपकरणानि/)**: Command-line wrapper sources for formatter, linter, debugger, package manager, build system, benchmarking system, and language server (LSP).
* **[`परीक्षणानि/`](file:///d:/my%20project/सूत्र/परीक्षणानि/)** & **[`tests/`](file:///d:/my%20project/सूत्र/tests/)**: C++ unit test runner targets and stability/parity regression tests.

---

## 2. Compiler Pipeline Workflow

Sutra compiles source text files into standalone native executables through a multi-stage sequential compiler pipeline:

```text
       Sutra Source (*.सूत्र)
                 ↓
     [1. Lexer / अक्षर-वाचक]   (Decodes UTF-8 bytes, validates character ranges)
                 ↓
           Token Stream
                 ↓
     [2. Parser / वाक्य-विच्छेदक] (Builds AST nodes, records source locations)
                 ↓
       Abstract Syntax Tree (AST)
                 ↓
 [3. Semantic Analyzer / अर्थ-परीक्षक] (Resolves symbol environments, types, jumps)
                 ↓
     [4. IR Generator / मध्य-रूप] (Translates AST nodes to compiler IR)
                 ↓
  [5. Native CodeGen / संकलक-इंजन] (Generates target x86-64 assembly text)
                 ↓
      [6. Linker / योजक-संयोजक]  (Links assembly with C runtime object via g++)
                 ↓
        Native Binary (*.exe)
```

### Pipeline Components:

#### 2.1 Lexer (अक्षर-वाचकः)
* **Files**: [`lexer.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/lexer.cpp), [`lexer.hpp`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/lexer.hpp)
* **Details**: Decodes multi-byte UTF-8 streams. Enforces Devanagari character limitations on identifier starts (`0x0904` to `0x097F`). Scans literals, comments, operators, and keywords.

#### 2.2 Parser (वाक्य-विच्छेदकः)
* **Files**: [`parser.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/parser.cpp), [`ast.hpp`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/ast.hpp)
* **Details**: A recursive descent parser that validates grammatical rules. Constructs AST representations mapping expressions, loops, variables, OOP class structures, and exception handlers.

#### 2.3 Semantic Analyzer (अर्थ-परीक्षकः)
* **Files**: [`semantic.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/semantic.cpp), [`semantic.hpp`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/semantic.hpp)
* **Details**: Checks variables declarations, maps scoping levels, validates that functions parameters match argument lists, and rejects invalid control flow contexts (e.g. `विरामः` / break or `जारीरह` / continue used outside loops).

#### 2.4 IR Generator (मध्यम-संकेत-सर्जकः)
* **Files**: [`ir_generator.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/compiler/ir_generator.cpp), [`ir.hpp`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/compiler/ir.hpp)
* **Details**: Lowers the AST structure into a flat, sequential Intermediate Representation (IR) consisting of operations, labels, variable offsets, jumps, and exception scopes.

#### 2.5 Native CodeGen (यन्त्र-सङ्केत-सर्जकः)
* **Files**: [`codegen.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/compiler/codegen.cpp), [`codegen.hpp`](file:///d:/my%20project/सूत्र/संकलक/include/sutra/compiler/codegen.hpp)
* **Details**: Translates IR commands into target x86-64 assembly. Handles frame offsets, function prologue/epilogue, call conventions, exception longjmp bindings, and garbage collection roots registration.
* **Assembly linking**: Executes a system compiler subprocess calling `g++.exe` on the generated assembly code, linking it with `sutra_runtime.o` and system dependencies to create a native standalone executable.

---

## 3. Interpreter Pipeline Workflow

Sutra offers an execution mode bypassing intermediate translation to assembly.

```text
       Sutra Source (*.सूत्र)
                 ↓
         Lexer & Parser
                 ↓
     Semantic Analyzer Scopes
                 ↓
     [AST Interpreter / व्याख्याता] (Recursively executes AST nodes in-process)
```

### Components:
* **AST Interpreter**: [`interpreter.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/interpreter.cpp). Walks the AST structure, evaluating statement execution and expression resolutions in-process. Tracks current environments using the `Environment` scope map.
* **REPL Execution Loop**: [`repl.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/repl.cpp). An interactive console loop. Features a bracket brace accumulator checking `{` and `}` counts to support multi-line blocks before launching interpreter evaluations. Supports native UTF-8 console input via Windows `ReadConsoleW` wrapper functions.

---

## 4. Runtime Integration Layer

The compiled executable requires low-level support for managing allocations, UTF-8 strings, arrays, dictionary layouts, and garbage collection.

```text
+-------------------------------------------------------------+
|               Compiled Machine Code Binary                  |
+-------------------------------------------------------------+
                               | calls allocation & GC routines
                               v
+-------------------------------------------------------------+
|                  sutra_runtime.c (C Runtime)                |
+-------------------------------------------------------------+
                               | redirects allocation and GC
                               v
+-------------------------------------------------------------+
|             runtime_api.cpp (C / C++ Bridge API)            |
+-------------------------------------------------------------+
                               | maps allocations & tracks roots
                               v
+-------------------------------------------------------------+
|             memory.cpp (C++ HeapManager & GC Engine)        |
+-------------------------------------------------------------+
```

### Runtime Layer Details:
* **Native Runtime**: [`sutra_runtime.c`](file:///d:/my%20project/सूत्र/sutra_runtime.c). Implements core routines for dynamic structures, console writing (`लिखतु`), string concatenation, dictionary structures, math library calls, and exception unwinding structures using `setjmp` / `longjmp` frames.
* **C++ API Bridge**: [`runtime_api.cpp`](file:///d:/my%20project/सूत्र/संकलक/src/runtime_api.cpp). Exports runtime functions as `extern "C"` interfaces, mapping allocation types, reclaiming garbage objects, and registering allocations into the compiler validation `HeapManager`.

---

## 5. Developer Toolchain & LSP Server

All developer utilities (formatter, linter, debugger, package manager, build, benchmark, and LSP) share a common foundation library.

```text
                 sutra_toolchain (Static Library)
             [formatter.cpp, linter.cpp, debugger.cpp,
             package_manager.cpp, build_system.cpp, benchmark.cpp]
                 /               |               \
                /                |                \
               v                 v                 v
       CLI Executables       LSP Server       C++ Unit Tests
     (sutra_formatter,       (sutra_lsp,     (test_toolchain,
      sutra_linter, ...)   lsp_handlers.cpp)   test_sutra)
```

### Shared Toolchain Components:
* **Static Library (`sutra_toolchain`)**: Static library target in `CMakeLists.txt` compiling the formatter (`formatter.cpp`), linter (`linter.cpp`), debugger interface (`debugger.cpp`), package manager (`package_manager.cpp`), build backend (`build_system.cpp`), and benchmark engine (`benchmark.cpp`).
* **LSP Language Server (`sutra_lsp`)**: [`sutra_lsp.cpp`](file:///d:/my%20project/सूत्र/उपकरणानि/sutra_lsp.cpp). Handles JSON-RPC packets received from IDE clients (like VS Code or Neovim) over stdin/stdout. Uses [`lsp_handlers.cpp`](file:///d:/my%20project/सूत्र/उपकरणानि/src/lsp_handlers.cpp) and [`lsp_adapter.cpp`](file:///d:/my%20project/सूत्र/उपकरणानि/src/lsp_adapter.cpp) to call toolchain formatting, linting, and compile-diagnostics, converting results into LSP JSON format.
