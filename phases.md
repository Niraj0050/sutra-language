# Reconstructed Roadmap and Milestone Phases — सूत्र (Sutra)

This document contains the project roadmap, listing the completed implementation history, active milestones, and deferred future milestones.

---

## 1. Reconstructed Language Roadmap

Sutra's core language evolution progresses through six distinct architectural phases:

### Phase 1: Basic Language & Interpreter
* **Status**: **Completed**
* **Features**: Core lexer, token structures, recursive descent parsing, block scoping environment mappings, C++ AST interpreter, arithmetic/logical operations, and standard console I/O (`लिखतु`).

### Phase 2: Dynamic Structures & Object-Oriented Programming (OOP)
* **Status**: **Completed**
* **Features**: Dynamic array list literal representations (` सूची`), class declarations (`वर्ग`), class instantiation (`नवीन`), instance scopes constructors (`रचना`), and self-reference pointer structures (`स्व`).

### Phase 3: Standard Library Integration
* **Status**: **Completed**
* **Features**: Math libraries (`वर्गमूल`, `घात`, `गोल`, etc.), list functions (`जोड़ें`), UTF-8 codepoint length counters (`लंबाई`), and console input readers (`पठतु`).

### Phase 4: Bytecode & Virtual Machine (SVM)
* **Status**: **Planned**
* **Features**: Translating intermediate AST scopes into custom bytecode instructions running inside a lightweight, sandbox-protected Virtual Machine environment (Sutra Virtual Machine).

### Phase 5: Native Code Generation & Compilation
* **Status**: **Completed**
* **Features**: Custom IR intermediate structure generator, target x86-64 assembly generation, compiler C runtime integration (`sutra_runtime.c`), and native executables output linking via `g++.exe`.
* **Future extension**: LLVM assembly generation (LLVM backend replacement).

#### Phase 5 Audit: Token Files

* Exact filename `token.txt`: **not present** anywhere in the repository.
* `स्वसंकलक/tokens.txt`: `SECRET_PRESENT = NO`; this is generated compiler diagnostic/test data, specifically a lexer token dump of self-hosted compiler source.
* References/dependencies: no source file, script, build file, or tool references this path. `स्वसंकलक/लेखक_परीक्षण.सूत्र` emits lexer output to standard output, so the dump may have been captured manually; it is not a build output or input.
* Sutra compiler dependency: **NO**. Self-hosted compiler dependency: **NO**.
* Required for building: **NO**. Required for testing: **NO**. Required for running: **NO**. Required for self-hosting: **NO**.
* Secret ignore status: the existing `.gitignore` entry for `स्वसंकलक/tokens.txt` is sufficient; no additional secret ignore rule is required because the file contains no detected credentials or secrets.

### Phase 6: Self-hosting Compiler (`स्वसंकलक`)
* **Status**: **Completed & Verified (M4-11)**
* **Features**: Complete zero-English self-hosted parser (`स्वसंकलक/विश्लेषक.सूत्र`), lexer (`स्वसंकलक/लेखक.सूत्र`), and code generator (`स्वसंकलक/सर्जक.सूत्र`) written in Sutra.
  - **Stage 1 (Host compile)**: The local C++ host compiler (`sutra.exe`) compiles the self-hosted compiler source code to produce `sutra_self.exe`. (Complete)
  - **Stage 2 (Self-host compile)**: The generated `sutra_self.exe` compiler compiles its own source files, generating a natively compiled compiler binary. (Complete)
  - **Stage 3 (Verification)**: The self-hosted compiler runs the test suite and passes verification. Current verification result: 53/53 compiler verification tests passed.

---

## 2. Toolchain Milestone Phases (Milestone M4)

The developer toolchain utilities are categorized and implemented under Milestone M4:

```text
+-----------------------------------------------------------+
|                      Milestone M4                         |
+-----------------------------------------------------------+
|                                                           |
|  [M4-1] Toolchain infrastructure & library base          |
|  [M4-2] Code Formatter (sutra_formatter.exe)              |
|  [M4-3] Static Linter (sutra_linter.exe)                  |
|  [M4-4] Interactive Debugger (sutra_debugger.exe)        |
|  [M4-5] Package Manager (sutra_pkgmgr.exe)                |
|  [M4-6] Project Build System (sutra_build.exe)            |
|  [M4-9] Benchmarking Telemetry (sutra_benchmark.exe)      |
|  [M4-10] Language Server LSP Protocol (sutra_lsp.exe)     |
|  [M4-11] Self-Hosting Compiler Foundation                 |
|                                                           |
+-----------------------------------------------------------+
```

### M4-1: Toolchain Library Foundation & Unit Testing
* **Status**: **Completed**
* **Details**: Compiles the shared `sutra_toolchain` static library in [`CMakeLists.txt`](file:///d:/my%20project/सूत्र/CMakeLists.txt#L58-L70). Integrates unit tests runner [`test_toolchain.cpp`](file:///d:/my%20project/सूत्र/परीक्षणानि/test_toolchain.cpp).

### M4-2: Sutra Formatter
* **Status**: **Completed**
* **Details**: Beautifier CLI (`sutra_formatter.exe`) applying indentation, operator spacing, and idempotency rules to `.सूत्र` files.

### M4-3: Sutra Linter
* **Status**: **Completed**
* **Details**: Static code quality checker (`sutra_linter.exe`) verifying rules L001–L008 (unused variables, empty blocks, self assignment, etc.).

### M4-4: Sutra Debugger
* **Status**: **Completed**
* **Details**: Interactive console debugger CLI (`sutra_debugger.exe`) implementing Sanskrit step operations (`पग`, `डग`), breakpoint hooks, and variable environments lookup.

### M4-5: Sutra Package Manager
* **Status**: **Completed**
* **Details**: Package manager CLI (`sutra_pkgmgr.exe`) using manifest formats (`पैकेज.सूत्र`) written as native Sutra dictionaries to handle local package indexing.

### M4-6: Sutra Build System
* **Status**: **Completed**
* **Details**: Build system CLI (`sutra_build.exe`) reading package build configurations (entry point, output executable names) to compile, lint, and clean projects.

### M4-9: Sutra Benchmarking System
* **Status**: **Completed**
* **Details**: CLI telemetry runner (`sutra_benchmark.exe`) measuring compile phase durations and interpreter GC metrics (reclaimed memory, active instances).

### M4-10: Language Server (LSP)
* **Status**: **Completed**
* **Details**: Language Server CLI executable (`sutra_lsp.exe`) enabling IDE features (autocomplete,hover metadata, check diagnostics) via JSON-RPC.

### M4-11: Self-Hosting Compiler Foundation (`स्वसंकलक आधार-सुदृढीकरण`)
* **Status**: **Completed**
* **Details**: Establishes and verifies the complete self-hosting compiler pipeline. Cleans up the self-hosted parser and lexer source code to fully adhere to the zero-English rule. Resolves core compiler memory/GC constraints and dynamic type checking issues, verifying AST output identity equivalence between Stage 0 and Stage 1 parser runs.
