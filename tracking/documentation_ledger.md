# सूत्र (Sutra) — Documentation Ledger & Parity Matrix

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Documentation Inventory & Status

| Document Path | Topic | Specification Alignment | Implementation Parity | Action Required |
| :--- | :--- | :--- | :--- | :--- |
| `docs/SUTRA_LANGUAGE_SPEC.md` | Core Language Specification | Synchronized | 100% Implemented | None |
| `docs/COMPILER.md` | Compiler Pipeline & Architecture | Partially Synchronized | Updated for IR pipeline; references to `मूल_सर्जक` should be marked legacy | Update legacy mentions |
| `docs/RUNTIME_IN_SUTRA.md` | Porting Runtime to Sutra | Synchronized | In Progress (Phase 2c) | Keep updated with Phase 2 progress |
| `docs/STANDARD_LIBRARY.md` | Standard Library Overview | Synchronized | 15/15 modules implemented | None |
| `docs/TOOLCHAIN.md` | Developer Toolchain Guide | Synchronized | 7/7 tools implemented | None |
| `docs/LANGUAGE_SERVER.md` | LSP Protocol Specification | Synchronized | 100% Implemented | None |
| `docs/TESTING.md` | Testing Architecture | Synchronized | Fully active | None |
| `document/02-language-specification/` (21 files) | Deep Language Reference | Synchronized | All constructs supported in interpreter and native compiler | None |
| `document/04-standard-library/` (3 files) | Stdlib deep docs | Outdated | Covers only math, io, collections; missing new modules (`तर्क`, `पथ`, `जेसन`, `क्रमचय`, `ढेर_प्राथमिकता`) | Add missing module docs |
| `document/05-compiler/` (3 files) | Compiler pipeline | Partially Synchronized | Mentions old single-pass codegen alongside IR | Modernize documentation |
| `document/06-self-hosting/` (2 files) | Self-hosting roadmap | Synchronized | Phase 1 & 2 documented | None |
| `document/07-runtime/` (2 files) | Memory & GC model | Synchronized | GC mark-and-sweep documented | None |
| `दस्तावेजाः/भाषा_विनिर्देषः.md` | Sanskrit Specification | Synchronized | Canonical Sanskrit grammar | None |
