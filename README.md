# सूत्र (Sutra)

### Sanskrit/Hindi-First, Devanagari-Native Programming Language & Self-Hosted Compiler

**सूत्र (Sutra)** is a general-purpose programming language designed around Sanskrit/Hindi-first terminology and native Devanagari syntax.

The project aims to provide a complete programming-language ecosystem rather than only a syntax experiment. It includes the Sutra language, compiler, interpreter/runtime infrastructure, memory management, standard library, developer tooling, testing infrastructure, and a self-hosted compiler written in Sutra itself.

Sutra does not claim to be the first or only Hindi/Sanskrit programming language. Its focus is on building an independent, complete, and continuously verifiable programming-language ecosystem using Devanagari as a first-class programming syntax.

---

## 🌺 प्रमुख विशेषताएँ / Implemented Features

Every feature listed below is fully implemented and verified against the reference test suite:

* **Devanagari Syntax**: Identifiers, keywords, operators, and literals are written natively in UTF-8 Devanagari syntax.
* **Type System**: Supports five primitive types (`संख्या` [Integer], `दशमलव` [Float], `बूल` [Boolean], `पाठ` [String], `शून्यम्` [Null]), and runtime type inquiry via the `प्रकार` built-in function.
* **Variables & Scope**: Dynamic (`मान`) and static type bindings with lexical block scoping.
* **Expressions & Operators**: Support for arithmetic operations (`+`, `-`, `*`, `/`, `%`), comparisons, boolean logic, and string concatenation.
* **Control Flow**: Conditional branching (`यदि` / `अन्यथा यदि` / `अन्यथा`), loops (`यावत्`, `पुनरावृत्ति`), and loop control (`break`, `continue`).
* **Functions & Recursion**: Declaring named routines with support for typed, untyped, and mixed parameter bindings, return statements, and call-stack recursion.
* **Object-Oriented Programming (OOP)**: Custom classes (`वर्ग`), constructors (`नवीन`), fields, methods, self-reference (`स्व`), and dynamic member offset array layouts on the heap.
* **Exception Handling**: Safe exception propagation using `प्रयत्न` (try), `पकड़ो` (catch), and `फेको` (throw), with automatic stack unwinding.
* **Memory Management & GC**: Automatic heap management backed by a Mark-and-Sweep garbage collector tracking active roots.
* **Modules & Imports**: Compiling multi-file codebases recursively using the `आयात` statement.
* **Standard Library**: Reference implementations for Math (`वर्गमूल`, `घात`, etc.), String helpers (`उच्च`, `निम्न`, `बदलें`, etc.), File I/O (`सञ्चिका_पठतु`, `सञ्चिका_लिखतु`), Console I/O, and pure-Sutra modules in `पुस्तकालय/` (UI model, date/time, CSV, JSON, collections, …).
* **Foreign Function Interface**: `विदेशी` declares a DLL-exported function (MS x64 ABI, both backends) so Sutra code can call Win32 APIs directly — see `rules.md` §2a.
* **Self-Hosting Compiler**: A compiler backend written in Sutra that translates Sutra source code to C++ outputs.

---

## Code Examples (कोड उदाहरण)

### 1. Hello World / प्रिंट
```sutra
कार्य मुख्य() {
    लिखतु("नमस्ते जगत्!");
}
```

### 2. Classes and Constructors (वर्ग एवं निर्माता)
```sutra
वर्ग छात्र {
    पाठ नाम;
    संख्या आयु;

    कार्य नवीन(पाठ न, संख्या आ) {
        स्व.नाम = न;
        स्व.आयु = आ;
    }

    कार्य परिचय() {
        लिखतु("नाम: " + स्व.नाम + ", आयु: " + स्व.आयु);
    }
}

    कार्य मुख्य() {
    मान विद्यार्थी = छात्र.नवीन("राम", २०);
    विद्यार्थी.परिचय();
}
```

### 3. Recursive Fibonacci (पुनरावृत्ति)
```sutra
कार्य फिबोनाची(संख्या न) {
    यदि (न <= १) {
        परत् न;
    }
    परत् फिबोनाची(न - १) + फिबोनाची(न - २);
}

कार्य मुख्य() {
    लिखतु("फिबोनाची (10): " + फिबोनाची(१०));
}
```

### 4. Exception Propagation (अपवाद)
```sutra
कार्य गणना(संख्या भाजक) {
    यदि (भाजक == ०) {
        फेको "त्रुटि: शून्य से विभाजन संभव नहीं!";
    }
    परत् १०० / भाजक;
}

कार्य मुख्य() {
    प्रयत्न {
        लिखतु(गणना(०));
    } पकड़ो (अपवाद) {
        लिखतु("अपवाद पकड़ा गया: " + अपवाद);
    }
}
```

---

## स्वसंकलक — Self-Hosted Compiler

Sutra compiler development is designed around a multi-stage bootstrap pipeline:

```text
[स्वसंकलक/विश्लेषक_परीक्षण.सूत्र] (Sutra Source)
           ↓ compiled by Gen 1 (sutra.exe)
[sutra_self.exe] (Gen 2 Compiler)
           ↓ compiles compiler source code
[विश्लेषक_परीक्षण_native.exe] (Gen 3 Compiler)
```

### Architecture Divisions:
1. **Canonical Sutra Compiler Source (`स्वसंकलक/`)**: The parser, lexer, and code generator backend written entirely in zero-English Devanagari Sutra code.
2. **Local Native Bootstrap Implementation (`संकलक/`)**: A native C++ compiler and interpreter wrapper. This C++ code acts as the host build environment (`Gen 1`) to compile the self-hosted codebase into a standalone binary.
3. **Generated Compiler Artifacts**: Temporary transpiled C++ files and intermediate executables generated during compilation. These are excluded from repository tracking.
4. **Verification**: Staged compilers compile the test suite, validating that the native compiled output matches the reference interpreter execution.

---

## Pure Sutra Source Repository

This repository adheres to a **Pure Sutra Source Representation** policy. To keep the repository clean and language-focused:
- **Tracked in Git**: Canonical compiler code written in Sutra (`स्वसंकलक/`), the bootstrap seed (`स्वसंकलक/निर्माण/` — a frozen assembly image of the compiler plus the C runtime, so a fresh clone can build **without the C++ host**), specification documentation, verification scripts, and compiler tests (`tests/`).
- **Local-Only (Not in Git)**: The native C++ host implementation (`संकलक/`), toolchain C++ sources (`उपकरणानि/`), testing binaries (`*.exe`), and downloaded libraries (`external/`). The C++ host is now **bootstrap-optional** — it produces the same compiler the seed does, and is kept only as an alternate/recovery path.

---

## Repository Structure (परियोजना-संरचना)

The current Git-tracked layout of the codebase is structured as follows:

* **[`स्वसंकलक/`](स्वसंकलक/)**: Zero-English Sutra sources for the self-hosted compiler.
* **[`tests/`](tests/)**: Automated stability and compiler parity test suites.
* **[`दस्तावेजाः/`](दस्तावेजाः/)**: Devanagari specifications documentation.
* **[`docs/`](docs/)**: Deep-dive system documentation.
* **`build.ps1` / `run_tests.ps1`**: Local building and testing runner scripts.
* **`verify_compiler_self.ps1`**: Self-hosted compiler regression verifier.
* **`CMakeLists.txt`**: C++ project build configurations.

---

## Documentation (प्रलेखनम्)

Refer to the following files for compiler and language design details:

* **[Language Specification](docs/SUTRA_LANGUAGE_SPEC.md)**: Language syntax, grammar, operators, classes, and types.
* **[System Architecture](architecture.md)**: Repository layout and pipeline architecture.
* **[Compiler Pipeline Spec](docs/COMPILER.md)**: Compiler phases, code emission, and transpiler patterns.
* **[Runtime Environment Spec](docs/RUNTIME.md)**: Memory manager, garbage collector (GC), and structures layouts.
* **[Standard Library reference](docs/STANDARD_LIBRARY.md)**: Reference manual for built-in Math, String, List, and I/O APIs.
* **[Self-Hosting Roadmap](docs/SELF_HOSTING.md)**: Bootstrapping stages, milestones, and development roadmap.
* **[Testing Framework Specs](docs/TESTING.md)**: Parity checks, test runners, and test suites structure.
* **[Developer contribution Guide](docs/DEVELOPMENT.md)**: Local build environment setup and developer guidelines.
* **[Language Server Spec (LSP)](docs/LANGUAGE_SERVER.md)**: LSP integration endpoints and formatting features.
* **[Developer Toolchain](docs/TOOLCHAIN.md)**: Formatter, linter, debugger, and package manager specifications.
* **[Internals Design](design.md)**: High-level compiler design models.

---

## Bootstrap (from a fresh clone, no C++ host)

```powershell
powershell -ExecutionPolicy Bypass -File bootstrap.ps1
```

This assembles the frozen seed (`स्वसंकलक/निर्माण/मूल_संकलन.s`), links it against
the C runtime into a seed compiler, then rebuilds the current Sutra source with
that seed and checks the self-hosting fixed point. Requires only MSYS2 ucrt64
(`as`, `gcc`, `ld`) — no C++ compiler, no `sutra.exe`. See
[`स्वसंकलक/निर्माण/README.md`](स्वसंकलक/निर्माण/README.md).

## Verification & Testing (परीक्षण)

To compile the self-hosted compiler and run the verification test suite locally:

```powershell
# 1. Compile the self-hosted compiler (either via the seed's output, or the host)
.\sutra.exe build "स्वसंकलक/विश्लेषक_परीक्षण.सूत्र"

# 2. Run all compiler tests under the compiled self-hosted compiler
powershell -ExecutionPolicy Bypass -File verify_compiler_self.ps1
```

Expected output:
```text
========================================================
         NATIVE COMPILER VERIFICATION SUMMARY
========================================================
  TOTAL  : 48
  PASSED : 48
  FAILED : 0

[SUCCESS] SUTRA SELF-HOSTED COMPILER VERIFIED - All tests passed.
```

---

## Development

The native bootstrap C++ environment (`संकलक/`) is utilized locally for bootstrapping, building, and running test runners, while the self-hosted compiler translates code. Executables generated during build processes are ignored by Git.

---

## Project Direction

Future roadmap goals focus on extending the coverage of standard library routines, optimizing generated C++ outputs, and enhancing self-hosted toolchain helper scripts.

---

## Philosophy

The Sutra language philosophy is centered on providing a Sanskrit/Hindi-first and Devanagari-first design to make modern computing concepts naturally accessible in Indian languages.

---

## License
MIT License
