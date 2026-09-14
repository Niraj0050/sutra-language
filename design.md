# Language and Tooling Design Philosophy — सूत्र (Sutra)

This document describes the design values, language syntax choices, zero-configuration tooling architectures, and testing principles of the Sutra project.

---

## 1. Language Design Principles

Sutra is built on three core syntactic principles:

### 1.1 Devanagari First-Class Citizen
Many non-English programming languages are designed as simple macro preprocessors or transpilers converting local language tokens to equivalent English keywords before sending them to standard compilers.

Sutra is designed as a fully native, Devanagari-first compiler. The lexer, scanner, symbol tables, and semantic analyzers operate directly on Devanagari UTF-8 strings.
* **Lexer Enforcement**: English letters are strictly prohibited as identifier starting characters. This ensures that all variables, functions, and classes are written natively in Devanagari characters, maintaining the visual and linguistic purity of the code.

### 1.2 Dynamic Typing with Expressive Type Aliasing
To make the language accessible to beginners while supporting complex algorithms:
* Variables are dynamically typed under the hood.
* Developers can declare variables using the untyped keyword `मान` or explicit keyword type-aliases:
  - `संख्या` (int)
  - `दशमलव` (float)
  - `पाठ` (string)
  - `बूल` (bool)
  - `सूची` (list)
  - `शब्दकोश` (dictionary)
* This dual approach offers the ease of dynamic variable assignments alongside the self-documenting readability of explicit type declarations.

### 1.3 End-to-End UTF-8 Unicode Support
Devanagari characters are multi-byte representations under UTF-8. A single Devanagari letter or vowel combination can consume 3 or more bytes.
* **Codepoint-based indexing**: The standard library function `लंबाई` calculates length based on actual Unicode codepoints rather than raw bytes. String indexing (`पाठ[इ]`) similarly indexes the correct multi-byte character boundary rather than returning partial bytes.
* **Console Safety**: Output writers use standard UTF-8 encoders, and Windows REPL input readers wrap `ReadConsoleW` to prevent input characters from undergoing corruption during transmission.

---

## 2. Tooling Design Principles

Sutra's developer utilities are built around simplification and separation of concerns:

### 2.1 Zero-Configuration Philosophy (Native Manifests)
Modern toolchains often require developers to learn multiple secondary markup formats (JSON, YAML, XML, TOML) to manage package dependencies and build systems.

Sutra avoids secondary configuration formats entirely. The project manifest file ([`पैकेज.सूत्र`](file:///d:/my%20project/सूत्र/प्रलेख/TOOLCHAIN.md#L142-L154)) is written directly in standard Sutra dictionary syntax:
```sutra
मान पैकेज = {
    "नाम": "नूतन_संकुलम्",
    "वर्जन": "1.0.0",
    "निर्भरताएँ": {
        "सहायक": "^1.0.0"
    }
};
```
* **Benefit**: The compiler's parser and lexer can parse the package configuration file directly into AST representations. No JSON or YAML parsing library is needed by the package manager (`sutra_pkgmgr.exe`) or build system (`sutra_build.exe`).

### 2.2 Decoupled Performance Regression Tracking
Performance testing and functional testing have different validation goals. Hardware variance, background CPU loads, and operating system scheduling can cause execution timings to fluctuate.
* **Correctness Validation**: The stability suite [`run_tests.ps1`](file:///d:/my%20project/सूत्र/run_tests.ps1) verifies program outputs and exit codes, ensuring absolute interpreter/compiler execution parity. It does not check execution duration.
* **Performance Telemetry**: Timings and GC counts are handled by the benchmark utility [`sutra_benchmark.exe`](file:///d:/my%20project/सूत्र/प्रलेख/BENCHMARKING.md), which runs target scripts multiple times to calculate median averages and standard deviation baselines.
* **Benefit**: Functional test pipelines remain fast, stable, and deterministic, while performance statistics are tracked separately without triggering false test failures under loaded test hardware.
