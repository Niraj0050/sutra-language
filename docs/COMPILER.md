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

### 2.1 Lexer (अक्षर-वाचकः)
* **File**: `संकलक/src/lexer.cpp`, `संकलक/include/sutra/lexer.hpp`
* **Purpose**: Performs UTF-8 multi-byte decoding on source buffer. Parses identifiers, numbers, operator punctuation, and literals.
* **Devanagari Enforcements**: Identifiers must start with a Devanagari letter (conforming to Unicode ranges `0x0904` to `0x097F`). English ASCII alphabetic characters (like `a-z`/`A-Z`) are strictly forbidden as identifier start characters, triggering `अज्ञातः वर्णः` errors.

### 2.2 Parser (वाक्य-विच्छेदकः)
* **File**: `संकलक/src/parser.cpp`, `संकलक/include/sutra/parser.hpp`
* **Purpose**: A recursive descent parser that validates grammatical syntax rules and constructs an Abstract Syntax Tree (AST).
* **AST Nodes**: Declared in `संकलक/include/sutra/ast.hpp`. Includes constructs for conditions (`IfStmtASTNode`), loops (`WhileStmtASTNode`, `ForStmtASTNode`), objects, lists, and exception blocks.

### 2.3 Semantic Analyzer (अर्थ-परीक्षकः)
* **File**: `संकलक/src/semantic.cpp`, `संकलक/include/sutra/semantic.hpp`
* **Purpose**: Walks the AST to verify symbol declaration scopes, parameter types, variable initialization, and validates loop-control contexts (rejects `विरामः` or `जारीरह` placed outside loops).

### 2.4 IR Generator (मध्यम-संकेत-सर्जकः)
* **File**: `संकलक/src/compiler/ir_generator.cpp`, `संकलक/include/sutra/compiler/ir.hpp`
* **Purpose**: Translates the parsed AST representation into a structured compiler Intermediate Representation (IR), exposing execution flow instructions.

### 2.5 Native CodeGen (यन्त्र-सङ्केत-सर्जकः)
* **File**: `संकलक/src/compiler/codegen.cpp`, `संकलक/include/sutra/compiler/codegen.hpp`
* **Purpose**: Translates intermediate instructions to x86-64 assembly commands. Emits functions, loops, global declarations, and stack frames.
* **Assembly linking**: Compiles generated assembly code and links it with the precompiled C Runtime object (`sutra_runtime.o`) using `g++.exe` to produce a standalone native binary.

---

## 3. Directory Layout
* `संकलक/include/sutra/`: Compiler and toolchain header files.
* `संकलक/src/`: Core parser, lexer, semantics, and toolchain implementation source files.
* `संकलक/src/compiler/`: Native code generation, intermediate representations, and runtime execution definitions.
