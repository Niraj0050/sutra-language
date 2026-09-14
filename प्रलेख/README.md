# सूत्र प्रलेखनम् (Sutra Developer Documentation Index)

Welcome to the official developer documentation system for the Sutra programming language.

---

## 1. Documentation Index

Please refer to the following documents for design, architecture, and developer workflow details:

* **[Sutra Language Specification](file:///d:/my%20project/सूत्र/प्रलेख/SUTRA_LANGUAGE_SPEC.md)**: Deep dive into language grammar, Devanagari rules, operators, expressions, control structures, and OOP.
* **[Sutra Compiler Architecture](file:///d:/my%20project/सूत्र/प्रलेख/COMPILER.md)**: Details compiler pipeline phases (Lexer, Parser, Semantics, IR, Native CodeGen).
* **[Sutra Runtime Environment](file:///d:/my%20project/सूत्र/प्रलेख/RUNTIME.md)**: Covers Heap/Memory allocations, structure layouts for arrays/strings/objects, and GC Mark-and-Sweep.
* **[Sutra Standard Library](file:///d:/my%20project/सूत्र/प्रलेख/STANDARD_LIBRARY.md)**: Reference APIs for Math, String/List helpers, and Console I/O.
* **[Sutra Developer Toolchain](file:///d:/my%20project/सूत्र/प्रलेख/TOOLCHAIN.md)**: Covers Formatter, Linter, Debugger, Package Manager, and Build System CLIs.
* **[Sutra Language Server (LSP)](file:///d:/my%20project/सूत्र/प्रलेख/LANGUAGE_SERVER.md)**: Describes the LSP server transport protocols, methods, and configurations.
* **[Sutra Testing Framework](file:///d:/my%20project/सूत्र/प्रलेख/TESTING.md)**: Describes the test suites structure, runner scripts, and validation steps.
* **[Developer Contribution Guide](file:///d:/my%20project/सूत्र/प्रलेख/DEVELOPMENT.md)**: Set up the dev environment, compile binaries, and execute regression test pipelines.
* **[Self-Hosting Compiler Roadmap](file:///d:/my%20project/सूत्र/प्रलेख/SELF_HOSTING.md)**: Details bootstrap roadmap and current status of `स्वसंकलक`.

---

## 2. Quick Commands

### Build Project
```powershell
powershell -File build.ps1
```

### Run All Tests
```powershell
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"; powershell -File run_tests.ps1
```
