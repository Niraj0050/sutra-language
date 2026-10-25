# सूत्र (Sutra) — Regression Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Known Regressions & Monitored Invariants

| Invariant / Feature | Potential Failure Mode | Guarding Test Suite | Current Status |
| :--- | :--- | :--- | :--- |
| **Fixed-Point Convergence** | Assembly drift between generations (`Gen2.s != Gen3.s`) | `verify_ir_selfhost.sh` / `bootstrap.ps1` Step 5 | **VERIFIED (0 bytes drift)** |
| **Interpreter / Native Parity** | Output or exit code mismatch between `sutra.exe` and `sutrac.exe` | `run_tests.ps1` Step 3 | **MONITORED (90.6% exact match)** |
| **GC Object Graph Traversal** | Leaks or dangling pointers in cyclic data structures | `tests/compiler/45_gc_circular.सूत्र` | **VERIFIED (PASS)** |
| **Repeated GC Cycles** | Heap corruption or tombstone double-free across sweeps | `tests/compiler/46_gc_repeated.सूत्र` | **FAILING (`SUTRA-BUG-0004`)** |
| **Devanagari Unicode Indexing** | Character vs Byte offset slicing bugs in Devanagari glyphs | `tests/unicode/15_string_indexing.सूत्र` | **VERIFIED (PASS)** |
| **Dynamic Type Relational Ops** | Comparing heterogeneous types (`null`, `bool`, `float`, `int`) | `tests/compiler/48_type_inquiry.सूत्र` | **VERIFIED (PASS)** |
| **Multi-Entry Dict Literals** | Hash bucket collision or key overwrite in literal initialization | `tests/compiler/50_dict_literal.सूत्र` | **VERIFIED (PASS)** |
