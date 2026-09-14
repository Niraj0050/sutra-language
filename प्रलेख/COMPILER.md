# सूत्र-संकलकः (Sutra Compiler Architecture)

This document describes the design, pipeline phases, and internals of the Sutra language compiler.

---

## 1. Compiler Pipeline

The compilation workflow is structured as a sequential pipeline:

```text
       Sutra Source (*.सूत्र)
                 ↓
     [1. Lexer / सूत्र-लेखक]  (Tokenizes UTF-8 input, validates character ranges)
                 ↓
           Token Stream
                 ↓
    [2. Parser / वाक्य-विच्छेदक] (Builds AST nodes, tracks source locations)
                 ↓
      Abstract Syntax Tree (AST)
                 ↓
[3. Semantic Analyzer / अर्थ-परीक्षक] (Analyzes scoping, types, declarations)
                 ↓
    [4. IR Generator / मध्य-रूप] (Emits intermediate control representation)
                 ↓
  [5. Native CodeGen / संकलक-इंजन] (Generates target assembly code)
                 ↓
     [6. Linker / योजक-संयोजक] (Links assembly with C runtime to produce binary)
                 ↓
       Native Binary (*.exe)
```

---

## 2. Compilation Phases

The canonical compiler pipeline is written in Sutra under the `स्वसंकलक/` directory. A native C++ host compiler wrapper is maintained locally under `संकलक/` (excluded from Git) to build and verify this self-hosted compiler.

### 2.1 Lexer (अक्षर-वाचकः)
* **Canonical Source**: `स्वसंकलक/लेखक.सूत्र` (Local Host: `संकलक/src/lexer.cpp`)
* **Purpose**: Performs UTF-8 multi-byte decoding on source buffer. Parses identifiers, numbers, operator punctuation, and literals.
* **Devanagari Enforcements**: Identifiers must start with a Devanagari letter (conforming to Unicode ranges `0x0904` to `0x097F`). English ASCII alphabetic characters (like `a-z`/`A-Z`) are strictly forbidden as identifier start characters, triggering `अज्ञातः वर्णः` errors.

### 2.2 Parser (वाक्य-विच्छेदकः)
* **Canonical Source**: `स्वसंकलक/विश्लेषक.सूत्र` (Local Host: `संकलक/src/parser.cpp`)
* **Purpose**: A recursive descent parser that validates grammatical syntax rules and constructs an Abstract Syntax Tree (AST) representing statements, loops, classes, and exceptions.

### 2.3 Semantic Analyzer (अर्थ-परीक्षकः)
* **Canonical Source**: Handled inside `स्वसंकलक/विश्लेषक.सूत्र` (Local Host: `संकलक/src/semantic.cpp`)
* **Purpose**: Walks the AST to verify symbol declaration scopes, parameter types, variable initialization, and validates loop-control contexts (rejects `विरामः` or `जारीरह` placed outside loops).

### 2.4 Code Generator (संकलक-इंजन / यन्त्र-सङ्केत-सर्जकः)
* **Canonical Source**: `स्वसंकलक/सर्जक.सूत्र` (Local Host: `संकलक/src/compiler/codegen.cpp`, `ir_generator.cpp`)
* **Purpose**: Translates intermediate scopes to C++ assembly outputs which are compiled to standalone native executables using GCC.

---

## 3. Directory Layout
* `संकलक/include/sutra/`: Compiler and toolchain header files.
* `संकलक/src/`: Core parser, lexer, semantics, and toolchain implementation source files.
* `संकलक/src/compiler/`: Native code generation, intermediate representations, and runtime execution definitions.
