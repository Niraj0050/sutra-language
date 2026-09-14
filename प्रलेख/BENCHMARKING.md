# सूत्र प्रदर्शन-मापन-तन्त्रम् (Sutra Benchmarking System Specification)

This document defines the canonical specification for the Sutra benchmarking system, implementing **Phase 10 M4-9**.

---

## 1. Purpose
The benchmarking system provides tools to measure and analyze the performance of the Sutra language compiler, interpreter execution, and heap memory management, facilitating regression tracking across development cycles.

---

## 2. Scope
The system covers:
* CLI benchmark runner tool: `sutra_benchmark.exe`.
* Benchmark suite of standard programs validating lists, strings, loops, recursion, objects, and GC behaviors.
* Measuring compilation phase timings.
* In-process interpreter GC statistics capture.
* Execution and native compilation duration tracking.

---

## 3. Architecture
The benchmarking tool is structured as a CLI utility integrated into the shared Sutra toolchain libraries. It links `sutra_toolchain` static library and `CORE_SOURCES` for in-process interpreter execution and timing, and spawns subprocesses for native binary execution tests.

---

## 4. CLI Interface
```text
sutra_benchmark <target> [options]
```

### Options:
* `<target>`: A `.सूत्र` file to benchmark, or `--suite <name>`.
* `--repeat <N>`: Run the benchmark `N` times to calculate summary statistics.
* `--suite <name>`: Execute a specific suite category of benchmarks.
* `--list`: List all available benchmark suite files.
* `--version`: Show tool version.
* `--help`: Display usage documentation.

---

## 5. Benchmark Categories
* **A. Execution Benchmark**: Evaluates total execution duration of Sutra programs in both interpreter and native modes.
* **B. Compilation Benchmark**: Measures compiler front-end and back-end pipeline phase durations (Lexer, Parser, Semantics, IR, CodeGen, Linker).
* **C. Memory / GC Benchmark**: Captures memory allocations, active objects count, GC cycle counts, and reclaimed memory size using interpreter GC metrics.

---

## 6. Measurement Methodology
* Uses high-resolution monotonic timers (`std::chrono::high_resolution_clock`) to prevent system clock adjustments from corrupting results.
* Redirects benchmarked program output (`stdout`/`stderr`) to keep benchmarking diagnostics clean and separate.
* For repeated runs (`--repeat`), computes:
  - Iterations (पुनरावृत्तिः)
  - Minimum (न्यूनतम)
  - Maximum (अधिकतम)
  - Average (औसत)
  - Median (मध्यिका)

---

## 7. Result Format
Output follows standard Sanskrit/Devanagari project conventions:
```text
सूत्र प्रदर्शन-मापन (Sutra Benchmark)
=====================================
लक्ष्य (Target): tests/benchmark/22_loop_benchmark.सूत्र
पुनरावृत्तिः (Repeat): 5

[कालः - Time (ms)]
न्यूनतम (Min): 1.02 ms
अधिकतम (Max): 1.15 ms
औसत (Avg): 1.08 ms
मध्यिका (Median): 1.07 ms

[स्मृति - GC Stats]
चक्र (GC Cycles): 2
आवंटन (Allocations): 24
सक्रिय (Live Objects): 5
संग्रहित (Collected): 19
स्थिति (Status): सफल (SUCCESS)
```

---

## 8. Baseline Methodology & Regression Detection
* Baselines are saved in a local file (e.g. `benchmarks_baseline.json` or documented locally).
* Comparing runs checks if average execution time exceeds baseline by more than a 15% threshold.
* Environmental variance is handled by calculating standard deviation across repeated runs.
* Performance tests are intentionally separated from correctness validation suites to prevent variable hardware performance from breaking the main test runner.

---

## 9. Non-Goals
* Measuring hardware-specific assembly cache misses.
* Real-time thread profiling.
* Micro-benchmarking individual C++ source lines.

---

## 10. Compatibility
* Native x86-64 code execution requires MSYS2/MinGW-w64 on Windows.
* UTF-8 Devanagari paths and symbols must be preserved.
