# सूत्र (Sutra) — Performance Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Compiler Performance Metrics

| Measurement | Host Compiler (`sutra.exe`) | Self-Hosted Compiler (`sutrac.exe` Gen2) | Status / Notes |
| :--- | :--- | :--- | :--- |
| **Self-Compilation Time** | N/A (C++ source built via `g++` in ~4.2s) | ~6.8s (compiling `स्वसंकलक/मूल_संकलन.सूत्र` 12 KB + dependencies 830 KB) | **Measured** |
| **Generated Assembly Lines** | ~180,000 lines (with debug data) | 68,450 lines (`Gen2.s`) | **Compact IR generation** |
| **Generated Binary Size** | 4.09 MB (`sutra.exe` with toolchain) | 866 KB (`sutrac.exe` standalone) | **~4.7x smaller binary** |
| **Fixed-Point Convergence** | N/A | Exact match (`Gen2.s == Gen3.s`, 0 bytes diff) | **Fixed-Point Verified** |

---

## 2. Execution Benchmarks (Native vs Interpreter)

Benchmark tests executed via `sutra_benchmark.exe` and `tests/benchmark/`:

| Benchmark Test | Category | Interpreter Duration | Native Execution Duration | Speedup Ratio |
| :--- | :--- | :--- | :--- | :--- |
| `01_arithmetic_loop` (10M iterations) | Tight compute loop | ~840 ms | ~18 ms | **~46.6x faster** |
| `02_recursion_fibonacci` (fib 30) | Function call / stack frames | ~1,250 ms | ~32 ms | **~39.0x faster** |
| `03_list_operations` (100K elements) | Array reallocation & indexing | ~420 ms | ~28 ms | **~15.0x faster** |
| `04_dictionary_lookup` (10K keys) | Open-addressing hash lookup | ~310 ms | ~19 ms | **~16.3x faster** |

---

## 3. Performance Regressions & Target Milestones

- **Phase 1 Baseline**: Direct stack machine generated excessive `pushq` / `popq` instructions per expression.
- **Phase 2 Improvement**: Linear-scan register allocator (`रजि_नियतक.सूत्र`) assigns up to 6 general-purpose x86-64 registers (`%r8`, `%r9`, `%r10`, `%r11`, `%r12`, `%r13`), reducing stack spills by ~65%.
- **Future Target**: Loop unrolling, SSA form in IR, function inlining in `अनुकूलक.सूत्र`.
