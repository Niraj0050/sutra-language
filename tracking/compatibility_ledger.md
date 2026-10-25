# सूत्र (Sutra) — Platform & Compatibility Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Platform Support & ABI Matrix

| Subsystem | Windows x86-64 | Linux x86-64 | macOS / ARM64 |
| :--- | :--- | :--- | :--- |
| **C++ Host Compiler (`sutra.exe`)** | **Supported** (MinGW-w64 UCRT / MSVC) | **Supported** (GCC / Clang) | Untested |
| **Calling Convention** | Microsoft x64 (`%rcx`, `%rdx`, `%r8`, `%r9` + 32-byte shadow space) | System V AMD64 (`%rdi`, `%rsi`, `%rdx`, `%rcx`, `%r8`, `%r9`) | N/A |
| **Stack Alignment** | 16-byte aligned before `call` | 16-byte aligned | N/A |
| **Floating Point ABI** | `%xmm0`–`%xmm3` parameter passing, `%xmm0` return | `%xmm0`–`%xmm7` parameter passing, `%xmm0` return | N/A |
| **Self-Hosted Compiler (`sutrac.exe`)**| **Supported** (Direct Windows Win32 API via `तल.s`) | **Architecture Prepared** (Linux syscall layer in `तल.s`) | Untested |
| **Console I/O & Codepage** | UTF-8 (`WriteFile` to `STD_OUTPUT_HANDLE`) | UTF-8 (`sys_write` stdout fd 1) | N/A |

---

## 2. Character Encoding & Unicode Specification

1. **UTF-8 Source Files**: All `.सूत्र` files must be UTF-8 encoded without BOM.
2. **Multi-Byte Devanagari Characters**:
   - Devanagari code block: `U+0900` to `U+097F` (typically 3 bytes per code point in UTF-8).
   - String indexing (`लंबाई(s)` and `s[i]`): Handled at UTF-8 code point boundary rather than raw byte offset in high-level APIs.
   - Identifier recognition: Lexer permits any valid UTF-8 lead byte `>= 0x80` in identifier continuations.

---

## 3. Known Platform Incompatibilities & Fixes

- **Windows Console Path Copying**: `cmd.exe` does not default to UTF-8 without `chcp 65001`, causing copy failures on Devanagari file paths (`SUTRA-BUG-0003`).
- **Line Endings (CRLF vs LF)**: Output comparisons in test scripts normalize `\r\n` to `\n` to prevent spurious diff mismatches across Windows and POSIX environments.
