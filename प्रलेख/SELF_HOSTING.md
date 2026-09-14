# स्वयं-संकलकः (Sutra Self-Hosting Compiler Status)

This document describes the design, status, and roadmap for building a self-hosted compiler for the Sutra programming language.

---

## 1. Current Status

Two self-hosted back ends exist, both written in zero-English Devanagari Sutra:

| Back end | Entry | Emits | Tests |
|---|---|---|---|
| **C++ transpiler** | `स्वसंकलक/विश्लेषक_परीक्षण.सूत्र` (`विश्लेषक` + `सर्जक`) | Sutra → C++ → `g++` | 53/53 |
| **Native x86-64** | `स्वसंकलक/मूल_संकलन.सूत्र` (`विश्लेषक` + `मूल_सर्जक` + `सार्थक_विश्लेषक`) | Sutra → GAS asm → `as`/`ld` | 51/51 |

* **Native back end reaches its self-hosting fixed point**: Gen1 (built by the C++
  host) compiles the compiler → Gen2; Gen2 compiles the compiler → Gen3. Gen2 and
  Gen3 emit **byte-identical assembly** for the compiler (≈140k lines), and each
  passes 51/51. The C++ host is no longer in the correctness chain.
* **Bootstrap without the C++ host**: `स्वसंकलक/निर्माण/मूल_संकलन.s` is a frozen
  assembly image of the whole native compiler. `bootstrap.ps1` assembles + links
  it (against the tracked `sutra_runtime.c`) into a seed compiler, which then
  rebuilds the current source. Only `as`/`gcc`/`ld` are needed — no C++.
* **Zero-English Rule Compliance**: `विश्लेषक.सूत्र`, `लेखक.सूत्र`, `सर्जक.सूत्र` contain
  zero English alphabet characters (strings, comments, and escapes such as `\न`).
* Remaining C in the pipeline: the ~2.1k-line C runtime (`sutra_runtime.c`,
  linked into every output) and the GNU assembler/linker.

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

1. **Stage 1 (C++ Host)**: The local C++ host compiler (`sutra.exe`) compiles the self-hosted compiler source code (written in Sutra) into a native machine binary. (Complete)
2. **Stage 2 (Self-Host compile)**: The generated compiler is run, taking its own Sutra source files as input, to compile itself. (Complete)
3. **Stage 3 (Verification)**: The self-hosted compiler compiles the test suite and achieves output parity with the reference interpreter. (Complete — transpiler 53/53, native 51/51)
4. **Stage 4 (Fixed point)**: Gen2 → Gen3 emit byte-identical assembly for the compiler. (Complete, native back end)
5. **Stage 5 (Seedable bootstrap)**: A frozen `.s` seed (`स्वसंकलक/निर्माण/`) + `bootstrap.ps1` build the compiler with no C++ host. (Complete)

### Still C / non-Sutra

* `sutra_runtime.c` — allocator, GC, string/array/dict ops, print, exceptions,
  file I/O, argv. Linked into every binary. To be ported to Sutra once the
  language has raw-memory / syscall primitives.
* GNU `as` + `ld` (via `gcc`) — assembler and linker.
* C++ host (`संकलक/`) — kept as an alternate front end and recovery path; not
  required for the build.
