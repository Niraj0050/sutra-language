# सूत्र (Sutra) — Dependency Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. External Build & Toolchain Dependencies

| Dependency | Required Version | Purpose | Component | Mandatory / Optional |
| :--- | :--- | :--- | :--- | :--- |
| **GNU Assembler (`as`)** | Binutils 2.40+ (MSYS2 ucrt64) | Assembles emitted `.s` into object `.o` files | Native Compiler & Bootstrap | **Mandatory** for Native Build |
| **GNU Compiler (`gcc`)** | GCC 13.0+ / 16.1+ (MSYS2 ucrt64) | Links object files & compiles minimal C runtime | Native Linker | **Mandatory** for Native Linking |
| **C++17 Compiler (`g++`)** | G++ 11.0+ / MSVC 2019+ / Clang 14+ | Compiles the C++ host compiler and CLI tools | C++ Compiler Host | **Optional** for pure self-host |
| **`nlohmann/json.hpp`** | v3.11.2 (Header-Only) | JSON serialization for LSP JSON-RPC protocol | `sutra_lsp.exe` | **Mandatory** for LSP |
| **Windows SDK (`shell32.lib`, `kernel32.lib`)** | Windows 10/11 | OS APIs (`WriteFile`, console handlers, file operations) | Runtime & OS Floor | **Mandatory** on Windows |

---

## 2. Internal Subsystem Dependencies

```text
[sutra.exe] (C++ Host)
 ├── संकलक/src/ (Lexer, Parser, AST, Semantic, Environment, Interpreter)
 └── संकलक/src/compiler/ (IR Generator, Codegen)

[sutrac.exe] (Self-Hosted Native Compiler)
 ├── स्वसंकलक/ (विश्लेषक, सार्थक_विश्लेषक, मध्यम, मूल_निम्नक, अनुकूलक, रजि_नियतक, मूल_उत्सर्जक)
 └── स्वसंकलक/निर्माण/ (मूल_संकलन.s, sutra_runtime.c, तल.s, मूल_रनटाइम.s, मूल_आवंटक.s)

[पुस्तकालय/] (Standard Library)
 └── Pure Sutra code (No C++ dependencies)
```
