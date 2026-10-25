# Sutra vs C++ — Benchmark Methodology (for review before the full run)

Auditor stance: adversarial and independent. Goal is to find where Sutra
**loses**, and to report every loss as prominently as every win. No speedup
is reported unless its mechanism is identified in the generated code.

---

## 1. Environment (captured 2026-09-07)

| | |
|---|---|
| CPU | AMD Ryzen 5 5600H (Zen 3 / `znver3`), 6 cores / 12 threads |
| Clock | 3.3 GHz base, ~4.2 GHz boost. **Reported `MaxClockSpeed` = 3301 (base only)** — Windows does not expose live per-core freq without extra tooling |
| Cache | L2 3 MB (512 KB ×6), L3 16 MB |
| RAM | 7.5 GB (7518 MB) — **tight**; caps some benchmark sizes (see §5) |
| OS | Windows 11 Home Single Language, build 26200 (10.0.26200) |
| Toolchain | MSYS2 UCRT64: `g++ (Rev3, MSYS2) 16.2.0`, `clang 22.1.8` (both target `x86_64-w64-windows-gnu`/`-mingw32`) |
| Sutra | commit `33c8377` (2026-09-07), working tree clean. `sutrac.exe` = x86 backend; `--release` = LLVM/clang backend |
| `-march=native` | resolves to `-march=znver3 -mtune=znver3` |

### Machine stabilisation

- **Power plan switched `Balanced` → `High performance`** for the run.
  This matters a lot here: the same 200 M-iteration loop measured **0.244 s
  on Balanced vs 0.152 s on High performance** — Balanced was running the
  core at a reduced clock. *I will restore the plan to `Balanced` when the
  audit finishes* (disclosure: this is a system-setting change on the
  user's machine).
- Runner pins each child process to **core 2** (`SetProcessAffinityMask`)
  and raises it to **`HIGH_PRIORITY_CLASS`**.
- **Cannot** hard-lock CPU frequency (Windows Home, no `cpupower`
  equivalent). Mitigation: measured thermal/turbo drift directly — 5
  batches of the same benchmark spaced over ~30 s of sustained load gave
  medians 0.15355 / 0.15345 / 0.15311 / 0.15315 / 0.15318 s (spread
  < 0.3 %). Laptop thermals will be re-checked by re-baselining a
  reference benchmark between suite sections.
- Other workloads closed; still a desktop OS with background services —
  disclosed, not eliminable.

---

## 2. Timing

### 2.1 The core problem: Sutra has no in-process clock

Sutra exposes **no monotonic-clock / performance-counter builtin** (no
`QueryPerformanceCounter`, `GetTickCount`, `clock`, `rdtsc` — checked the
whole builtin table and the OS floor `तल.s`). Per the audit rules I am
**not** adding one ("do not modify Sutra's runtime"). So Sutra can only be
timed **externally** (whole-process wall clock).

### 2.2 What makes external timing trustworthy here

1. **Dedicated C++ runner** (`bench/runner.cpp`): `QueryPerformanceCounter`
   immediately around `CreateProcess` + `WaitForSingleObject`. Child
   stdout/stderr → `NUL`. 3 warm-up runs discarded, then ≥ 12 measured.
   Emits per-run CSV + a summary (median / min / max / stddev / RSD).
   Same code times Sutra and C++ binaries — identical overhead on both
   sides, so it cancels in comparisons.

   With High-performance + core-pin + high-priority, this runner gives
   **RSD 0.4–1.5 %** on compute benchmarks (vs ~14 % without those
   settings). Harness is solid.

2. **Startup floor**, measured with the same runner on an empty program in
   each language/backend, 20+ runs:

   | binary | floor median | RSD |
   |---|---|---|
   | gcc -O2 | 10.1 ms | 15 % |
   | gcc -O3 | 7.7–10.3 ms | 5–9 % |
   | clang -O3 | 11.1 ms | 9 % |
   | Sutra x86 | 11.5–13.8 ms | 5–6 % |
   | Sutra --release | 11.9 ms | 6 % |

   The floor is dominated by the Windows process-spawn tax (PE load,
   kernel32/shell32 resolution), **not** CRT init. Sutra starts ~2–4 ms
   *slower* than C++ despite its minimal CRT — traced to its **8 MB
   `gc_roots` BSS array being zero-committed on every process start**.
   Floor RSD is high in % terms but ~1 ms in absolute terms.

   **Every reported wall-clock number = `external_median − floor(that
   binary)`, and both numbers are shown in the CSV.** Benchmarks are sized
   so runtime ≥ 1 s (§5), making the floor < 1 % and its noise < 0.1 %.

3. **Floor-subtraction is validated, not assumed.** Every C++ benchmark
   *also* prints an in-process `QueryPerformanceCounter` delta to stderr.
   The report will show, per benchmark: `C++ in-process` vs
   `C++ (external − floor)`. If they disagree by more than noise, the
   whole external method is flagged unreliable for that benchmark and the
   Sutra number is marked **UNMEASURED**. Because the runner times both
   languages identically, agreement on the C++ side is direct evidence the
   Sutra `(external − floor)` number is sound to the same tolerance.

4. **Teardown symmetry.** Sutra's emitted `main` does **no** exit-time work
   — `call sutra_main; xor eax,eax; ret` → `mainCRTStartup` → `ExitProcess`
   (verified in disassembly). No GC sweep, no `atexit`. The OS reclaims
   everything. So for a fair external comparison, **C++ benchmarks call
   `std::_Exit(result & 0xFF)` after printing** — skipping destructors and
   static teardown — so neither side pays teardown in the timed window.
   For the memory/allocation benchmarks I will **additionally** report C++
   with normal RAII teardown vs `_Exit`, because "C++ pays for
   deterministic destruction, Sutra defers to the OS" is a real
   *semantic* difference worth showing — but it is labelled as such, not
   folded into a raw-speed number.

### 2.3 Statistics

- **Median is the headline.** min / max / stddev / RSD always reported.
- 3 warm-up + ≥ 12 measured. More (30–50) for anything close.
- **RSD > 5 % → tagged `NOISY`; no conclusion drawn.**
- Two results are **different** only if the gap exceeds **3 × combined
  stddev**; otherwise **`PARITY`** (not a win, not a loss).
- Ratios written in words: "Sutra is 1.4× **slower**" / "1.4× **faster**".

---

## 3. Dead-code-elimination guards (applied to every benchmark, both sides)

- The result **escapes**: printed to stdout *and* returned as
  `exit code = result & 0xFF`.
- **Output equality is checked**: both languages must print the
  byte-identical result line. **A benchmark whose outputs differ is
  `INVALID`, not a win.** (Already caught one in a methodology probe: my
  first scalar-loop draft used signed `int64_t` `>>` on the C++ side and
  Sutra's `दक्षिण_सरक` gave a different value — that comparison is void
  until the arithmetic is matched.)
- **N comes from `argv`**, never a literal, so the optimiser cannot
  constant-fold the loop. Sutra has **no int-parse builtin** — each Sutra
  benchmark carries a hand-written `से_संख्या(पाठ) -> संख्या` digit loop
  (benchmark code, not a runtime change).
- **Validity gate** (§4) is the real DCE defence — if time doesn't grow
  with N, the work was eliminated and the benchmark is discarded.

---

## 4. Fairness rules

- C++ compiled and reported at **`-O2`**, **`-O3 -march=native`**, and
  **`clang++ -O3 -march=native`**. `-O0`/debug is never used. `-std=c++20`
  throughout.
- Same algorithm, same data types, same output on both sides. Any place
  Sutra's semantics force a different algorithm is stated explicitly.
- Containers & strings get **two** C++ versions:
  **(a) naive** (`s = s + "x"`, `vector` no `reserve`, `std::map`) and
  **(b) idiomatic** (`s += `, `reserve()`, `unordered_map`, move). Sutra
  is reported against both; beating (a) while losing to (b) is reported as
  an **ergonomics** result, not a speed win.

## 4b. Validity gate — every result must pass before it enters the scorecard

1. **Scaling**: run N, 2N, 4N; time must grow as the algorithm predicts
   (linear → ×2, quadratic → ×4). Flat ⇒ `INVALID — DCE`.
2. **Roofline**: ops/sec ÷ clock ⇒ ops/cycle. Scalar loop > ~4 ops/cyc, or
   memory loop > measured DRAM bandwidth ⇒ `INVALID — impossible`.
3. **Cross-benchmark consistency**: if X does k× the work of Y but reports
   less time, flag it.
4. **Assembly spot-check**: for any benchmark where Sutra wins by > 2×, dump
   both sides' asm/IR and name the exact mechanism (fewer allocs / layout /
   eliminated work / vectorised). No mechanism found ⇒ win **not confirmed**.

---

## 5. Benchmark suite & sizing

All sized for ≥ 1 s runtime at base N (so floor < 1 %). N from argv.

| # | Benchmark | base N | notes |
|---|---|---|---|
| C1 | Scalar int accumulate (serial dep) | 5×10⁸ | |
| C2 | FP dot product | 2×10⁸ | |
| C3 | `fib(35)` recursive | fixed | call overhead |
| C4 | Matmul 512×512 (`double`) | fixed | cache + vectorise; 3×2 MB fits RAM |
| C5 | Sieve of Eratosthenes → 10⁷ | fixed | |
| M1 | Dynamic array: 10⁷ appends | | naive vs `reserve` |
| M2 | Linked-list traversal 10⁶ nodes | | pointer chase |
| M3 | Alloc churn 10⁶ alloc/free | | |
| S1 | Naive concat O(n²), N = 20/40/80/160 k | | complexity, not a fixed ratio |
| S2 | Builder/append pattern | | |
| S3 | Split + parse ~50 MB text | | RAM-limited (not 100 MB) |
| S4 | String compare in hot loop | | |
| D1 | Hash map 3M ins + 3M lookup | | vs `unordered_map` **and** `map` |
| D2 | Sort 10⁷ ints | | vs `std::sort` |
| D3 | Binary tree build + traverse | | |
| R1 | JSON parse ~30–50 MB | | RAM-limited |
| R2 | Word-frequency over large text | | |
| R3 | N-body, 1000 steps | | |

RAM note: 100 MB text + 50 MB JSON as specified would risk paging on a
7.5 GB machine also running the OS; I will use ~50 MB / ~30 MB and **state
the reduced size** rather than let swap contaminate the numbers.

---

## 6. Non-speed dimensions (measured, not estimated)

compile time · stripped binary size · peak RSS (`Get-Process`/`time` proxy
on Windows — method noted) · memory-safety matrix (10 buggy programs:
compile error / runtime trap / silent corruption; C++ also run under
ASan/UBSan separately) · error-message quality (10 mistakes, verbatim,
rated 1–5) · startup latency (already measured) · concurrency (Sutra
threading support to be verified — **may be UNMEASURED**) · C FFI (to be
verified — likely **UNMEASURED / not supported**) · portability (what
targets Sutra actually builds for today — test, don't assume) · debugger /
stack traces / profiler (yes/no with evidence) · ecosystem (plain honest
note).

---

## 7. Optimisation soundness (the `पाठ_संचायक` string-concat transform)

10 adversarial cases, each run with the transform effectively ON (normal
build) — and I will build a **reference** by structurally defeating the
pass (e.g. inserting an escape) to get the un-transformed O(n²) semantics,
then diff outputs:
self-reference `स = स + स` · prepend `स = "x" + स` · aliased buffer
mutated · value escapes loop (stored to list/map each iter) · value
observed mid-loop (printed each iter) · early `विराम`/`परत्`/throw ·
nested loops · zero-iteration · single-iteration · very large N (OOM
behaviour). **Any output difference = miscompilation = blocking bug.**

---

## 8. Sutra friction already hit while writing probes (ergonomics data)

- Keywords cannot be identifiers — `न` (not), and single Latin letters —
  cost two rewrites in trivial benchmark code.
- **Integer literals ≥ 2³¹ are rejected by the lexer** (`2654435761`
  failed) — forces awkward constant construction in benchmarks.
- No int-parse, no clock, no `argv`-to-number — hand-rolled each time.
- `x = जोड़ें(x, …)` must never be bare (list append may relocate).

---

## 9. Threats to validity (will be expanded in the report)

- **External-only timing for Sutra.** Mitigated by the validated
  floor-subtraction (§2.2) but never as clean as an in-process clock.
- **Laptop, no hardware frequency lock.** Drift measured < 0.3 % over
  sustained load, but not zero; long suite may see thermal creep.
- **Windows process-spawn floor ~8–14 ms, RSD 5–15 %.** < 1 % of a sized
  benchmark, but it is real and subtracted with its own ~1 ms noise.
- **mingw-w64, not MSVC.** C++ results are for the GNU toolchain on
  Windows; MSVC could differ.
- **Single machine, single architecture (Zen 3).**
- **7.5 GB RAM** forces smaller inputs on 3 benchmarks.
- Sutra `--release` shells out to `clang -O3` — the LLVM backend's wins
  are partly "clang is good", which the report will attribute explicitly.

---

## 10. Deliverables

`bench/BENCHMARK_REPORT.md` in the mandated section order, headline =
win/tie/loss record. `bench/results/*.csv` raw per-run data. All sources
in `bench/sutra/` and `bench/cpp/`. Reproduction commands included.

---

## 11. Post-audit re-run (2026-09-07, Sutra @ `718a913`)

C4 and R3 were run during the audit as an integer matmul and an all-scalar
5-body because `दशमलव` values corrupted in `सूची`/`शब्दकोश`. That is fixed
(`718a913`); both were rewritten to their intended float-array form
(C4 = `double` matmul, R3 = 5 bodies in seven `सूची<दशमलव>` + nested pair
loop) and re-measured against the same C++ baselines, same methodology,
`-ffp-contract=off` on the C++ side of both. Machine was not fully
quiesced (~25–35 % background load) — noted per row in the Addendum.
Script: [`c4r3_float.sh`](c4r3_float.sh).

## 12. `--native` re-run (2026-09-09, Sutra @ `b88c0a0`)

The opt-in `--release --native` flag (`-march=native`) was added at
`b88c0a0`. C2 (scalar FP), C4 (`double` matmul), R3 (array n-body) were
re-measured with a `--release --native` column added, this time on a
**quiesced machine, High-performance power plan** (RSD < 1.5 % on the
load-bearing rows; two contaminated attempts were discarded when a
stray process inflated the startup floor 10×). Same floor-subtraction,
same C++ baselines, `-ffp-contract=off` on C4/R3. Where this run's
`--release`-vs-C++ ratios differ from §11's, this run supersedes it (the
C++ baselines are faster on a quiet machine). Scripts:
[`c2_native.sh`](c2_native.sh), [`c4r3_native.sh`](c4r3_native.sh).
Finding: `--native` is −12 % on C2, −4 % on R3, **0 % on C4** — it helps
only where the hot loop has no `सूची` bounds-check. Detail in the Addendum.
