# स्वयं-संकलकः (Sutra Self-Hosting Compiler Status)

This document describes the design, status, and roadmap for building a self-hosted compiler for the Sutra programming language.

---

## 1. Current Status

* **Milestone M4-11 (स्वसंकलक / Self-Hosting Compiler)**: **COMPLETE & VERIFIED**
  - **Zero-English Rule Compliance**: The self-hosted compiler source code (`स्वसंकलक/विश्लेषक.सूत्र`, `स्वसंकलक/लेखक.सूत्र`, `स्वसंकलक/सर्जक.सूत्र`) is fully compliant with the mandatory rule: zero English alphabet characters (including strings, comments, and escape representations like `\न` instead of `\n`).
  - **Compiler Parity Verified**: The self-hosted compiler compiles the entire test suite and matches the reference output. Current verification result: 48/48 compiler verification tests passed.
  - **GC & Type Conversion Optimizations**: Resolved interpreter memory issues during complex parsing phases. Fixed dynamic pointer-to-string conversion bugs when printing dictionary-retrieved node values in natively compiled binaries.

---

## 2. Directory Structure

The initial draft self-hosting compiler sources are located in:
* **[`स्वसंकलक/`](file:///d:/my%20project/सूत्र/स्वसंकलक/)**: Contains prototype code components written directly in the Sutra language.
  - `विश्लेषक_परीक्षण.सूत्र`: Early parser draft logic tests.
  - `लेखक_परीक्षण.सूत्र`: Lexer tokenizer draft tests.
  - `सरल_परीक्षण.सूत्र`: Simple validation scripts.

---

## 3. Bootstrap Roadmap

Once active, the self-hosting compiler development will progress through the following bootstrapping stages:

```text
       C++ Sutra Compiler (sutra.exe)
                     ↓ compiles
     Sutra Self-Hosted Compiler (स्वसंकलक)
                     ↓ compiles
   Self-Hosted Output Executable (स्वयं-उत्पाद)
```

1. **Stage 1 (C++ Host)**: The local C++ host compiler (`sutra.exe`) compiles the self-hosted compiler source code (written in Sutra) into a native machine binary (`sutra_self.exe`). (Complete)
2. **Stage 2 (Self-Host compile)**: The generated `sutra_self.exe` compiler is run, taking its own Sutra source files as input, to compile itself. (Complete)
3. **Stage 3 (Verification)**: The self-hosted compiler compiles the test suite and achieves output parity with the reference interpreter. (Complete - 48/48 compiler tests passed)
