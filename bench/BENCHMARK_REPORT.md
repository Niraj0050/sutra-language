# Sutra vs C++ — Adversarial Benchmark Audit

Auditor role: independent, adversarial. Every loss is reported as prominently
as every win. No speedup is claimed without a mechanism identified in the
generated code.

Machine: AMD Ryzen 5 5600H (Zen 3), 6C/12T, ~4.2 GHz boost, L3 16 MB,
7.5 GB RAM, Windows 11 Home 26200. Toolchain: MSYS2 UCRT64 —
`g++ 16.2.0`, `clang 22.1.8` (both `x86_64-w64-mingw32`), `-std=c++20`,
`-march=native` → `znver3`. Sutra @ commit `33c8377`.
Full methodology: [`METHODOLOGY.md`](METHODOLOGY.md). Raw data:
[`results/all.csv`](results/all.csv), [`results/rerun.csv`](results/rerun.csv).

---

## 1. Verdict

**Sutra wins 0, ties 1, loses 13 of the 14 benchmarks that produced a valid
comparison. A further 4 benchmarks could not be compared** (2 because Sutra
cannot run them at the target size, 1 because C++ optimised the whole
workload away, 1 because Sutra's default backend miscompiled it).

The single tie is **C1** (a scalar-integer linear recurrence), where Sutra's
`--release` build and `clang -O3` are both **~7.9× faster than `gcc -O3`** —
and that is a **clang-vs-gcc** result: clang unrolls the recurrence to move
the multiply off the per-iteration critical path, and Sutra's `--release`
backend *is* clang, so it inherits the win. Sutra's own x86 backend runs the
same loop fully serial, at parity with `gcc` and ~7.9× slower than clang.

Where Sutra loses, the margin is **1.3–3× on scalar/compute code** (via the
LLVM backend) and **4–27× on container, string, allocation and
composite code**, rising to **9–90× and two DNFs** for anything built on
`सूची`/`शब्दकोश`. Sutra's **own x86 backend is 3–380× slower than C++**
across the board and produced one wrong answer.

Non-speed: Sutra has **genuine, verifiable wins** — binaries depend on only
`KERNEL32`+`SHELL32` (no C runtime redistributable), array and string
accesses are bounds-checked (C++ silently corrupts), and the small-program
x86 compile is ~2× faster than `g++`. It also has **large gaps**: no
threads, no FFI, one target (x86-64 Windows), no debug info / debugger /
profiler, no sort or usable JSON parser in practice. (`दशमलव`-in-`सूची`/
`शब्दकोश` was broken during the audit; **fixed post-audit at `718a913`**,
C4/R3 re-run against it, then C2/C4/R3 re-run once more with the opt-in
`--release --native` flag on a quiesced machine — see [Addendum](#addendum).)

This is a reasonable position for a young self-hosted compiler. It is not
close to C++ on raw throughput for real-world data-structure code, and the
places it reaches C++ tier are the places its LLVM backend hands the work to
clang.

---

## 2. Scorecard

"Sutra" column = Sutra's **best** backend for that row (`--release` unless
noted). "C++ best" = fastest of `gcc -O2`, `gcc -O3 -march=native`,
`clang -O3 -march=native`. All numbers are median wall-clock of ≥10 runs
minus that binary's measured process-startup floor (≈7–11 ms). `NOISY` =
relative stddev > 5 % (spec rule: no firm conclusion). Times in seconds.

| # | Benchmark | Sutra `--release` | Sutra x86 | C++ best (which) | Result | Validity |
|---|---|---|---|---|---|---|
| C1 | scalar int, serial recurrence, N=1e9 | **0.126** | 1.024 | 0.127 (clang) / 0.997 (gcc) | **PARITY with clang; Sutra 7.9× faster than gcc** | confirmed (§4) |
| C2 | FP dot product, N=4e8 | 0.578 | 3.12 | 0.433 (clang) | `--release` **1.33×**; **`--native` 1.17×** (ties gcc -O3) | quiesced re-run, see [Addendum](#addendum) |
| C3 | `fib(43)` recursive | 1.028 | 3.42 | 0.542 (gcc -O2) | Sutra **1.9× slower** (ties clang) | OK |
| C4 | **`double`** matmul 512² | 0.078 | 11.5 | 0.016 (gcc -O3) | Sutra `--release` / `--native` **~4.7× (512) · ~5.1× (1024)**; x86 **~700×** | quiesced re-run @ `b88c0a0`, see [Addendum](#addendum) — `--native` = 0 change |
| C5 | Sieve of Eratosthenes, 50M ×12 | 2.02 | 10.2 | 0.649 (gcc -O3) | Sutra **3.1× slower** | gcc -O2 / clang NOISY |
| M1 | dynamic array, 10M appends ×10 | 4.39 | 3.77 | 0.298 (gcc, `reserve`) / 0.594 (gcc, naive) | Sutra **14.7× / 7.4× slower** | OK |
| M2 | linked-list traversal, 1M ×400 | 23.5 | 91.3 | 2.45 (clang) | Sutra **9.6× slower** | Sutra uses hash-map nodes (see §5) |
| M3 | alloc churn, 1M ×8 | 0.31 | 1.32 | ~0.001 | **INVALID** — C++ elided the alloc/free entirely | discarded (§6) |
| S1 | naive concat `s=s+"x"`, N=20k…160k | O(n) (transformed) | O(n) | O(n²) naive / O(n) idiomatic (`s+=`) | **complexity change, see §3 curve** | OK |
| S2 | string builder, 1e7 appends | 0.508 | 1.02 | 0.019 (gcc, `reserve`) | Sutra **26× slower** | OK |
| S3 | split + parse ~24 MB of integers | 1.47 | 4.59 | 0.123 (gcc -O2) | Sutra **12× slower** | OK |
| S4 | string compare in hot loop, 5e7 | 0.290 | 4.07 | 0.180 (gcc -O3 / clang) | Sutra **1.6× slower** (ties gcc -O2) | fixed to defeat hoisting; NOISY on 2 rows |
| D1 | hash map, 3M insert + 3M lookup | 5.32 | 11.3 | 2.38 (clang `unordered_map`) / 3.85 (`std::map`) | Sutra **2.2× / 1.4× slower** | OK — Sutra's best container result |
| D2 | sort 10M integers | **DNF (>300 s)** | crash | 0.65 (`std::sort`) | **Sutra cannot sort 10M elements** | Sutra: stdlib pure-Sutra merge sort |
| D3 | binary tree build + traverse, 2M ×20 | 14.6 | **wrong answer** | 1.18 (clang) | Sutra `--release` **12.3× slower**; **x86 miscompiles** | NOISY; x86 output 48896 ≠ 28680 |
| R1 | JSON parse ~4 MB | **DNF (>60 s)** | DNF | ~0.015 (hand-written) | **Sutra stdlib JSON parser unusable at scale** | — |
| R2 | word-frequency over ~12 MB | 0.274 | 1.65 | 0.062 (clang) | Sutra **4.4× slower** | OK |
| R3 | N-body, 5 bodies (**`सूची<दशमलव>` arrays**), 2M steps | 0.193 | 14.5 | 0.117 (gcc -O2) / 0.126 (gcc -O3) | `--release` **1.55×**; **`--native` 1.48×** (vs gcc -O3); x86 **~124×** | quiesced re-run @ `b88c0a0`, see [Addendum](#addendum) |

**Tally of valid comparisons:** Sutra 0 wins · 1 tie (C1) · 13 losses.
Discarded: M3, D2, R1, D3-x86.

---

## 3. The one that's interesting: S1 — naive string concatenation

This is a **complexity** result, reported as a scaling curve, not a fixed
multiplier. `net` seconds (median − floor):

| N | C++ `s = s + "x"` (naive) | C++ `s += "x"` (idiomatic) | Sutra `स = स + "x"` | Sutra, transform defeated |
|---|---|---|---|---|
| 20 000 | 0.0089 | 0.0028 | ~0 (below floor) | 0.501 |
| 40 000 | 0.0227 (×2.6) | 0.0038 | ~0 | 5.30 (×10.6) |
| 80 000 | 0.0764 (×3.4) | 0.0029 | ~0 | DNF (>300 s) |
| 160 000 | 0.2607 (×3.4) | 0.0039 | 0.0006 | DNF |

- C++ naive scales **quadratically** (~×3–4 per doubling). Its author is
  expected to know to write `s += "x"`, which is flat / linear.
- **Sutra's `पाठ_संचायक` IR pass rewrites `स = स + "x"` in a loop into a
  builder**, so the naive spelling is **O(n)**. When the pass is
  deliberately defeated (by making the accumulator escape each iteration),
  Sutra is quadratic *and worse than C++'s naive* — `पाठ_जोड़` copies more
  slowly.
- **This is an ergonomics win, not a raw-speed win**: Sutra-naive ≈
  C++-idiomatic. A competent C++ programmer pays nothing here.

**Soundness of that transform (§7): 10/10 adversarial cases produced correct
output** — self-reference `स=स+स`, prepend, mid-loop aliasing, escape into a
list each iteration, mid-loop observation, early `विरामः`, nested loops,
zero/one iteration, mid-read of the previous value. No miscompilation found.

---

## 4. Confirmed win: C1, and its mechanism

`s = s * 1000003 + i` for `i` in `0..1e9`, `s` printed mod 65536.

| | net time | ns / iter | cycles / iter @ ~4.2 GHz |
|---|---|---|---|
| gcc -O2 / -O3 | 0.992 / 0.997 | ~0.99 | ~4.2 |
| **clang -O3** | **0.127** | **0.127** | **~0.53** |
| **Sutra --release** | **0.126** | **0.126** | **~0.53** |
| Sutra x86 | 1.024 | 1.02 | ~4.3 |

- **Output is byte-identical across all five binaries** at N=1e6 (43040) and
  N=1e9 (48384) — not a miscompilation.
- **Scaling is linear** for every binary (N / 2N / 4N → ×1.9 / ×1.9), so
  nobody closed-formed the loop; all do O(N) work.
- **Roofline:** 0.53 cyc/iter for a chain whose critical op is a 3-cycle
  `imul` is impossible *for a serial loop*. Disassembly:
  - `gcc`: `imul $0xf4243,%rbx,%rbx ; add %rax,%rbx ; cmp ; jne` — the
    recurrence runs strictly serially, `imul` on the critical path every
    iteration.
  - `clang` / Sutra `--release`: the loop is **unrolled and the recurrence
    reassociated** so `imul $m^k` executes once per k iterations while the
    additive `i`-terms (an affine function of the counter) are computed off
    the critical path. **No SIMD** (`grep` for `vpmullq`/`vpaddq` in the hot
    block: 0). The multiply is simply ~k× less frequent on the dependency
    chain.
- **Attribution:** this is a clang optimisation. Sutra's `--release` path
  lowers to LLVM IR and calls `clang -O3`, so it gets the transform for
  free. Sutra's own x86 backend does **not** do it and runs at gcc's serial
  speed. So the honest phrasing is *"Sutra `--release` reaches clang, which
  here beats gcc"* — not *"Sutra beats C++"*.

No other benchmark had Sutra winning by > 2×, so no other assembly
spot-check was required by the validity gate.

---

## 5. Losses — diagnosed causes

### Scalar / compute (Sutra `--release` 1.3–3.1× slower)

- **C2 FP dot, C3 fib, C5 sieve, R3 n-body, S4 strcmp**: Sutra `--release`
  is `clang -O3` on merged bitcode, so these are *clang vs best-of-{gcc,
  clang}*. Sutra loses the FP-vectorisation battle to clang-standalone
  slightly (C2), matches clang and loses to gcc on `fib` register
  allocation (C3), and pays a fixed per-element overhead on the sieve (C5,
  3.1×) and split/parse that the C++ inner loops don't have. **R3
  (5-body, now `सूची<दशमलव>` arrays + nested pair loop — re-run at
  `718a913`) is still Sutra's closest run: 1.5× slower than `gcc -O3` /
  clang** (was 1.2×/1.8× as all-scalar). The array rewrite tightened the
  clang gap and widened the gcc one — the pair loop's `भार[j]` etc. reads
  cost Sutra a bounds check + safepoint that clang's stand-alone build
  hoists better than gcc's.
- **Sutra x86 backend: 6–16× slower** on the scalar rows; **116× on R3
  arrays** (was 6.6× all-scalar — every `वक्ष[i]` is now a bounds-checked
  `सूची` index / `सूची_सूचकांक_सेट` call instead of a register). On C4
  (`double` matmul) x86 is **~450× slower** — every `सी[i*n+k] += …` is a
  bounds-checked index + a `sutra_float_add`/`sutra_float_mul` runtime call
  + a `सूची_सूचकांक_सेट` call, and the triple loop is 1.3e8 of them.

### Containers / memory / strings (4–27×, or DNF)

The common cause: **`सूची` and `शब्दकोश` are the only aggregate types, every
element is a full 8-byte tagged word, growth goes through the GC allocator,
and element access is a bounds-checked call.** There is no compact typed
array, no `struct`, no stack allocation, no `reserve`.

- **M1 (10M appends)** — 14.7× slower than `vector` with `reserve`, 7.4×
  slower than `vector` without. Each `जोड़ें` is `x = जोड़ें(x, …)` through
  the allocator; the list stores tagged words.
- **M2 (linked list)** — 9.6× slower. **Sutra cannot express a
  pointer-linked structure**: class-typed local variables and class-typed
  fields are both parse errors, and a `मान` variable is locked to the type
  of its first assignment (so `मान head = शून्यम्` can't later hold a node).
  The list is therefore built from `शब्दकोश` nodes, and every `.next` /
  `.value` is a **hash-table lookup**, not a pointer-offset load. This is a
  language-capability gap first and a speed result second.
- **S2 (builder)** — 26× slower than `std::string::push_back` with
  `reserve`, even though `पाठ_निर्माता` is the runtime's *dedicated* fast
  path. Per-append call overhead + GC-safepoint dominate.
- **S3 (split + parse)** — 12× slower. `विभाजित` allocates a `सूची` of ~3M
  `पाठ` objects; C++ can parse in a single pass over the buffer.
- **D1 (hash map)** — 2.2× slower than `unordered_map`, **1.4× slower than
  `std::map`**. This is Sutra's *best* container showing — `शब्दकोश` is a
  real open-addressing hash table and the recent dict work paid off.
- **D2 (sort 10M)** — **DNF**. Sutra's core has **no sort builtin**
  (`छाँटें` is actually *trim-whitespace*). The only option is the stdlib
  `क्रमबद्ध`, a pure-Sutra recursive merge sort that slices (`खंड`) and
  merges into fresh lists — O(n log n) allocations, which at 10M elements
  did not finish in 300 s (`--release`) or crashed (x86). `std::sort`: 0.65 s.
- **D3 (binary tree)** — 12.3× slower (`--release`), and **the x86 backend
  produces the wrong answer** (48896 vs the 28680 that gcc, clang and Sutra
  `--release` all agree on). The pseudo-random input sequence is
  bit-identical across backends, so this is a **miscompilation in Sutra's
  default x86 backend** for recursive traversal of mutated `शब्दकोश` nodes.
- **R1 (JSON ~4 MB)** — **DNF (>60 s)**. `जेसन_पार्स` (stdlib, pure-Sutra
  recursive descent, one `शब्दकोश`/`सूची` per value) does not scale. A
  hand-written C++ parser does the same file in ~15 ms.
- **R2 (word frequency)** — 4.4× slower; correct output. `विभाजित` +
  `शब्दकोश` counting; the hash map is the good part, the tokenisation
  allocation is the cost.

---

## 6. Invalid / discarded benchmarks

| Benchmark | Why discarded |
|---|---|
| **M3 alloc churn** | `g++`/`clang` recognise the `malloc(24)…free` pair and **eliminate the allocation entirely** — net time ~1 ms and does not grow with N (fails validity gate #1). Sutra does not elide it: `--release` 0.31 s, x86 1.32 s. There is no valid speed comparison; the asymmetry itself is the finding (C++ optimises away work Sutra faithfully performs). |
| **D2 sort — Sutra** | Did not finish (see §5). C++ side is valid (`std::sort` 0.65 s) but there is nothing to compare it to. |
| **R1 JSON — Sutra** | Did not finish (>60 s on 4 MB). |
| **D3 x86 — Sutra** | Miscompilation — wrong output. The `--release` number stands; the x86 number is void. |
| **S4 clang (first attempt)** | The original S4 compared two compile-time-constant strings in the loop; `clang` hoisted the comparison out and closed-formed the counter (net 0.0006 s, fails scaling). Fixed by indexing a 5-element table by `i % 5` so no compiler can hoist; all variants then do the full loop and the numbers in §2 are from the fixed version. |
| **C1 first pass** | The initial timing run overlapped a leftover spinning process; several rows showed RSD 15–24 %. All of C1–C5 + S4 + R3 were re-run on a quiesced machine ([`results/rerun.csv`](results/rerun.csv)); those are the numbers reported. |

---

## 7. Optimisation soundness — `पाठ_संचायक` string-concat transform

Each case run as a normal build (transform active) and checked against the
hand-reasoned correct result; a reference with the transform structurally
defeated was used to confirm the un-transformed semantics.

| Case | Result | Output correct? |
|---|---|---|
| self-reference `स = स + स` (×5 → len 64) | `64 abab…` | ✅ |
| prepend `स = "x" + स` (×2000) | `2000` | ✅ (transform correctly does **not** fire) |
| aliased buffer, `त = स` at iter 50 then keep appending | alias len 51, final 100 | ✅ |
| value stored into a list every iteration | `ल[5]`=6, `ल[19]`=20 | ✅ |
| value read (`लंबाई`) every iteration | sum 55 | ✅ |
| early `विरामः` when len hits 42 | `42` | ✅ |
| nested loops (10×10 appends) | `100` | ✅ |
| zero-iteration loop | `"init" 4` | ✅ |
| single-iteration loop | `"ab"` | ✅ |
| mid-loop read of previous value into another var | 30 / 31 | ✅ |

**No miscompilation found in 10/10 adversarial cases.** (Not tested:
concurrent read from another thread — Sutra has no threads; closure capture
of the loop variable — deferred.) The `d3_bintree` x86 miscompile in §5/§6
is a **separate** codegen bug, unrelated to this pass and only in the x86
backend.

---

## 8. Non-speed dimensions

| Dimension | Sutra | C++ (mingw) |
|---|---|---|
| **Runtime deps** | **`KERNEL32.dll` + `SHELL32.dll` only.** No CRT, no redistributable. | `KERNEL32` + **11 `api-ms-win-crt-*` DLLs** (UCRT). |
| **Binary size (stripped)** | empty **68 KB**, `c1` benchmark **69 KB** | empty **13–14 KB**, `c1` **40–42 KB** |
| | Sutra statically links its whole runtime into every exe → 5× larger when empty, ~1.7× on real programs. | |
| **Startup latency** (empty prog, median of 25) | x86 **11–14 ms**, `--release` **12 ms** | gcc **8–10 ms**, clang **11 ms** |
| | Sutra is *slower* to start despite the minimal CRT — its 8 MB `gc_roots` BSS array is zero-committed on every process launch. | |
| **Compile time**, small program (`c1`, 3-run avg) | x86 **0.63 s**, `--release` **3.29 s** | `g++ -O2` 1.37 s, `-O3 -march=native` 1.23 s, `clang -O3` 1.34 s |
| | Sutra x86 compiler is **~2× faster than g++** for a small program (no heavy headers to parse). `--release` is ~2.5× *slower* — it re-runs `llvm-link` + `clang -O3` over the merged runtime every invocation, uncached. | |
| **Compile time**, large program | Sutra self-compile (≈180 k lines) **20.2 s** | not directly comparable; C++ template-heavy compile is a known pain point, Sutra has no templates |
| **Memory safety** (default builds, no sanitiser) | see matrix below | see matrix below |
| **Error messages** | line:col + a Sanskrit/Hindi phrase (`'x' नामकः चरः अपरिभाषितः अस्ति`). Correct and precisely located, but **no source-line echo, no caret, no suggestions, stops at the first error, and the language is a barrier**. Parse errors are hit before semantic ones. **Rate 3/5.** | English, source echo + caret, "did you mean", multiple errors, notes. Verbose on templates. **Rate 4/5.** |
| **Concurrency** | **None.** No thread / async / mutex / atomic primitive anywhere in the compiler or runtime. Single-threaded only. **UNMEASURED — not supported.** | `std::thread`, `<atomic>`, OpenMP available. |
| **C FFI** | **None.** No `LoadLibrary` / `dllimport` / `extern "C"` mechanism. The `अंतर्_*` intrinsics are hard-coded in the compiler, not a general FFI. **UNMEASURED — not supported.** | Full C ABI, trivially links C libraries. |
| **Portability (tested, not assumed)** | **1 target: x86-64 Windows PE.** The LLVM emitter hard-codes the `x86_64-w64-windows-gnu` triple; the native emitter is x86-64/Windows only. No ARM, Linux, macOS, WASM. | The same source cross-compiles to dozens of targets. |
| **Debugging** | **No DWARF/PDB, no line tables, no symbols beyond function names, no stack traces.** A runtime error prints one line (`त्रुटिः — सूच्याः सीमा अतिक्रान्ता`) and exits 1 — no location, no call stack. No debugger, no profiler integration. | gdb/lldb/WinDbg, `perf`/VTune/ETW, ASan/UBSan/TSan/MSan, full stack traces. |
| **Ecosystem** | ~14 pure-Sutra stdlib modules. No package manager, no third-party libraries. | Decades of libraries for essentially everything. Stated plainly. |

### Memory-safety matrix

| Deliberate bug | Sutra (default build) | C++ `-O2`, no sanitiser | C++ + ASan/UBSan |
|---|---|---|---|
| OOB array **read** | **runtime error** ("सूच्याः सीमा अतिक्रान्ता"), exit 1 | silent — printed garbage (`0`) | caught |
| OOB array **write** | **runtime error**, exit 1 | silent — "wrote" (heap corruption) | caught |
| String index OOB | **runtime error**, exit 1 | crash (`std::out_of_range` via `.at`) | caught |
| Null deref | **runtime error** (clean message) | crash (SIGSEGV, exit 139) | caught (cleaner) |
| Use-after-free / double-free | **not expressible** — GC, no manual `free` in normal code | silent — "123" / "survived" | caught |
| Uninitialised local read | prints `0` — **locals are zero-initialised** | prints `0` here (UB; value undefined) | MSan catches |
| Signed integer overflow | **wraps silently** (but `संख्या` is i64, so `2e9·3` = 6e9 fits and is *correct*) | **wraps silently** (`int` → `0`) | UBSan catches |
| `"string" * 3` (type confusion) | **compile error** | **compile error** | — |

**Summary:** Sutra bounds-checks every array and string access and
zero-initialises locals, turning several classes of C++ silent-corruption
bug into a clean process abort. It does **not** check integer overflow (same
as C++), and its i64-by-default `संख्या` reduces — but does not eliminate —
overflow incidence. C++ matches or exceeds this **only with sanitisers
enabled**, which are not the default.

---

## 9. Threats to validity

- **External-only timing for Sutra.** Sutra has no in-process clock; every
  Sutra number is `whole-process median − startup-floor`. Validated on the
  C++ side (in-process QPC agrees with `external − floor` within noise on
  every C++ row — see the `inproc` column of the CSV). Never as clean as an
  in-process measurement; ±1 % irreducible.
- **Laptop, no hardware frequency lock.** Power plan was forced to *High
  performance* (this alone changed a reference loop from 0.244 s to
  0.152 s). Sustained-load drift was measured at < 0.3 % over 30 s, but a
  ~1-hour suite on a laptop induces thermal throttling — several rows came
  back NOISY (RSD 6–22 %) and are flagged; the important compute rows were
  re-run on a quiesced, cooled machine.
- **A leftover spinning process contaminated the first C1–C5 pass.** Those
  rows were discarded and re-measured (`results/rerun.csv`).
- **C4 C++ times at n=512 are ~25–35 ms** — below the 200 ms target and
  NOISY (RSD 5–13 % on the re-run). The Sutra ratios (3–4× for `--release`,
  ~450× for x86) are far larger than that noise. The scaling run confirms
  it: at n=1024 (C++ ~190–220 ms, over the threshold) `--release` is
  **3.7× slower** than clang. Conclusion holds; the exact 512² C++ figure
  is soft.
- **mingw-w64, not MSVC.** These are GNU-toolchain results on Windows. MSVC
  could differ, especially on `std::` container constants.
- **Single machine, single micro-architecture (Zen 3), single OS.**
- **7.5 GB RAM** forced smaller inputs on S3 (~24 MB not 100 MB), R1 (~4 MB
  not 50 MB), R2 (~12 MB). Stated at each row.
- **Sutra `--release` = `clang -O3`.** Wherever `--release` reaches C++
  tier, part of the credit is "clang is good"; this report attributes it
  explicitly (see §4).
- **What this set does not prove:** anything about large multi-file
  projects, incremental builds, GC pause behaviour under load, numerical
  accuracy of Sutra's float formatting, behaviour on non-ASCII-heavy
  workloads, or any workload that needs threads / FFI / a non-Windows
  target — Sutra cannot run those at all.
- **Sutra ergonomics tax, measured in passing:** writing these 19 tiny
  benchmarks hit — keyword collisions (`न`, `मान`, `त`, any Latin letter
  cannot be an identifier), integer literals ≥ 2³¹ rejected by the lexer,
  no integer-parse / clock / `argv`→number builtin, `छाँटें` meaning *trim*
  not *sort*, `दशमलव` values corrupting when stored in `सूची`/`शब्दकोश`
  (**fixed post-audit, `718a913`**), and no class-typed variables. Several
  benchmarks had to be restructured around these.

---

## 10. Reproduction

```bash
# from the सूत्र repo root, MSYS2 UCRT64 on PATH
export PATH="/c/msys64/ucrt64/bin:$PATH"

# 1. build the timing harness
g++ -O2 -std=c++20 -o bench/bin/runner.exe bench/runner.cpp

# 2. build every benchmark (both Sutra backends + gcc -O2/-O3 + clang -O3)
#    sources: bench/sutra/*.सूत्र, bench/cpp/*.cpp
#    (Sutra --release compiles are ~50 s each)
bash bench/run_all.sh            # builds + first timing pass -> bench/results/all.csv

# 3. clean re-run of the compute benchmarks on a quiesced machine
#    (binaries are copied to an ASCII path C:\msys64\tmp\b because Win32
#     ANSI APIs can't handle the Devanagari repo path)
cp bench/bin/*.exe  /c/msys64/tmp/b/bin/
cp bench/data/*     /c/msys64/tmp/b/data/
bash /c/msys64/tmp/b/rerun.sh    # -> /c/msys64/tmp/b/results/rerun.csv

# 4. data files are regenerated deterministically by:
g++ -O2 -std=c++20 -o /tmp/gen.exe bench/gen.cpp   # (generator source in bench/)
/tmp/gen.exe words 12  > bench/data/words.txt
/tmp/gen.exe nums 3000000 > bench/data/nums.txt
/tmp/gen.exe json 100000  > bench/data/data.json

# 5. safety + error-message + soundness probes are shell one-liners in
#    the audit log; the 10 buggy programs are in bench/safety/,
#    the soundness cases are inline in §7.
```

Runner: `runner.exe <label> <iters> <warmup> -- <exe> [args…]` — times the
child with `QueryPerformanceCounter` around `CreateProcess`+`Wait`, pins it
to core 2 at `HIGH_PRIORITY_CLASS`, discards `<warmup>` runs, reports
median/min/max/stddev/RSD on stderr and per-run CSV on stdout.

Raw per-run data: [`results/all.csv`](results/all.csv) (first pass, 101
rows) and [`results/rerun.csv`](results/rerun.csv) (clean compute re-run).
Both include the `inproc` (C++ in-process QPC) column used to validate the
floor-subtraction method.

---

*Power plan is being restored to "Balanced" now that the audit is complete.*

---

## Addendum

### C4 + R3 re-run with float arrays (2026-09-07, Sutra @ `718a913`)

The audit found `दशमलव` (float) values **corrupt when stored in a `सूची` or
`शब्दकोश`** — they round-trip as raw i64 bit-patterns. Because of this, the
audit ran:

- **C4** as an *integer* matmul on both sides (not the intended `double`
  matmul), and
- **R3** as an *all-scalar* 5-body (positions/velocities in ~35 individual
  `दशमलव` locals, the 10 pairs hand-unrolled) rather than array-based.

That bug is now fixed (commit `718a913` — a `दशमलव` collection-element
propagation pass in `प्रकार_प्रसार.सूत्र`). Both benchmarks were rewritten to
their intended float-array form and re-measured against the same C++
baselines:

- **C4** — `double` matmul, `A[i]=(i%7)+1`, `B[i]=(i%5)+1` as
  integer-valued doubles so products/sums stay **exact** and the checksum
  is bit-stable across toolchains; `-ffp-contract=off` on the C++ side so
  `a*b+c` isn't fused to FMA (matches Sutra's separate `fmul`/`fadd`).
- **R3** — the 5 bodies' `x/y/z/vx/vy/vz/mass` in seven `सूची<दशमलव>`, a
  nested `i<j` pair loop over them (pair order `01 02 03 04 12 13 14 23 24
  34`, identical to the old unrolled version), `-ffp-contract=off` on C++.

**Output equality:** every variant (Sutra x86, Sutra `--release`,
`gcc -O2`, `gcc -O3`, `clang -O3`) prints the identical checksum at every
size tested — C4 `56825` at n=512, `38931` at n=1024; R3 `404136431` at 2M
steps, `681286834` at 4M.

**Caveat:** the machine was **not fully quiesced** for this re-run
(background load ~25–35 %). Sutra's longer-running binaries stayed clean
(RSD < 4 %); the sub-35 ms C++ C4 rows came back **NOISY** (RSD 5–13 %) and
are flagged. The scaling runs (where C++ crosses 200 ms) are the load-
bearing data points.

#### C4 — `double` matmul (net seconds, median of ≥10, minus startup floor)

| n | gcc -O2 | gcc -O3 | clang -O3 | Sutra `--release` | Sutra x86 | `--release` / C++ best |
|---|---|---|---|---|---|---|
| 256 | — | 0.0055 *(9 % RSD)* | 0.0039 *(4 %)* | 0.0121 | — | ~3× *(near floor)* |
| **512** | 0.0295 *(5 %)* | 0.0243 *(13 % NOISY)* | 0.0285 *(5 %)* | **0.0865** | **12.33** | **3.2×** |
| 1024 | — | 0.2184 *(13 %)* | **0.1927** *(11 %)* | **0.7128** | — | **3.7×** |

- **Sutra `--release` ≈ 3.2–3.7× slower than the best C++** (was 3.0× as
  integer matmul — the `double` version is marginally worse; the float
  array reads/writes don't vectorise as the LLVM backend emits them).
- **Sutra x86 ≈ 450× slower** (was 382× integer): the inner statement is now
  a bounds-checked `सूची` load ×3 + `sutra_float_mul` + `sutra_float_add`
  runtime calls + a `सूची_सूचकांक_सेट` call, 1.3×10⁸ times.
- Scaling is cubic for all three (n 512→1024: `--release` ×8.7, clang ×10);
  the `--release`/C++ ratio is stable at **~3.5×**.
- No mechanism makes Sutra faster here → **no assembly spot-check
  triggered** (spec rule applies only to Sutra wins > 2×).

#### R3 — array n-body, 5 bodies (net seconds)

| steps | gcc -O2 | gcc -O3 | clang -O3 | Sutra `--release` | Sutra x86 | `--release` / C++ best |
|---|---|---|---|---|---|---|
| 1M | — | 0.0679 | 0.0654 | 0.1037 | — | 1.59× |
| **2M** | 0.1244 *(5 %)* | 0.1324 | 0.1321 | **0.2021** | **15.37** | **1.53×** |
| 4M | — | 0.2855 | 0.2662 | 0.4058 | — | 1.52× |

- **Sutra `--release` ≈ 1.5× slower than `gcc -O3` / clang**, dead stable
  across 1M→4M steps (linear scaling, RSD 1–4 %). As all-scalar it was
  1.2× vs `gcc -O3` / 1.8× vs clang; the array rewrite **closed the clang
  gap and widened the gcc one** — clang's stand-alone build hoists the
  pair-loop bounds checks / safepoints better than gcc's, and Sutra
  (= clang on merged bitcode) tracks clang.
- **Sutra x86 ≈ 116× slower** — a large regression from the all-scalar
  6.6×, entirely from turning ~35 register values into bounds-checked
  `सूची` index / `सूची_सूचकांक_सेट` calls per step.
- Still Sutra's **best compute result** relative to C++.
- No Sutra win → no assembly spot-check.

#### Effect on the verdict

The tally is unchanged — **C4 and R3 were losses before and are losses
now** (0 wins · 1 tie · 13 losses). What changed:

- C4 is now the *intended* `double` matmul rather than an integer stand-in;
  the ratio is essentially the same (3.0× → 3.2–3.7×).
- R3's headline moved from "1.2× vs `gcc -O3`" (all-scalar, Sutra's single
  best number) to "1.5× vs `gcc -O3` / clang" (array-based) — a slightly
  worse but more representative figure, since real numeric code uses
  arrays.
- The "`दशमलव` in collections" item moves from *broken* to *works, ~1.5–3.7×
  the C++ cost via `--release`, ~120–450× via x86*.

Sources: [`c4r3_float.sh`](c4r3_float.sh),
[`results/c4r3_float_rerun.csv`](results/c4r3_float_rerun.csv),
[`results/c4r3_float_rerun.log`](results/c4r3_float_rerun.log).

---

### `--native` re-measurement (2026-09-09, Sutra @ `b88c0a0`)

`--release --native` (commit `b88c0a0`) is an **opt-in** flag that appends
`-march=native` (here → `znver3`, AVX2) to the whole-module `clang -O3 -c`.
Bare `--release` is unchanged — baseline x86-64, the "runs on any x86-64 /
`KERNEL32`+`SHELL32` only" default. This run re-measures the three
float benchmarks — **C2** (scalar FP reduction, no `सूची`), **C4** (`double`
matmul in `सूची<दशमलव>`), **R3** (5-body in `सूची<दशमलव>` arrays) — with a
`--release --native` column added.

**Methodology delta from the 2026-09-07 table above:** this run was on a
**quiesced machine, High-performance power plan** (RSD < 1.5 % on every
load-bearing row; two earlier attempts were discarded when a background
process pushed the startup floor 10×). The 09-07 C4/R3 run was at ~25–35 %
background load. **Where the two disagree, this table supersedes it** for
the `--release`-vs-C++ ratio — the C++ baselines run faster on a quiet
machine, which *widens* the C4 gap (see below); it is not a Sutra
regression.

Every variant prints the identical checksum at every size (C2
`104447600000000` @ 4e8; C4 `56825` @ 512 / `38931` @ 1024; R3
`404136431` @ 2M / `681286834` @ 4M).

#### net seconds (median of ≥10 runs, minus that binary's startup floor)

| bench | size | gcc -O2 | gcc -O3 | clang -O3 | `--release` | `--release --native` | Sutra x86 |
|---|---|---|---|---|---|---|---|
| **C2** FP dot   | 2e8  | —     | 0.244 | **0.217** | 0.292 | 0.254 | —     |
|                 | 4e8  | 0.499 | 0.482 | **0.433** | 0.578 | 0.506 | 3.12  |
|                 | 8e8  | —     | 0.961 | **0.865** | 1.152 | 1.005 | —     |
| **C4** matmul   | 256  | —     | **0.0044** | 0.0047 | 0.0116 | 0.0113 | —   |
|                 | 512  | 0.028 | **0.016**  | 0.017  | 0.078  | 0.078  | 11.51 |
|                 | 1024 | —     | 0.113  | **0.113** | 0.580 | 0.581 | —      |
| **R3** n-body   | 1M   | —     | **0.064** | 0.067 | 0.101 | 0.096 | —      |
|                 | 2M   | **0.117** | 0.126 | 0.127 | 0.193 | 0.186 | 14.45 |
|                 | 4M   | —     | **0.250** | 0.252 | 0.383 | 0.369 | —      |

#### what `--native` does and does not do

| bench | `--native` vs `--release` | `--release --native` vs best C++ | mechanism (from disassembly) |
|---|---|---|---|
| **C2** — scalar FP loop, **no `सूची`** | **−12 to −13 %**, every size | **1.17× clang · 1.05× gcc -O3** (was 1.33× / 1.20×) | clang unrolls the reduction and uses VEX 3-operand encoding → the `cvtsi2sd` + `fmul` overlap *off* the serial `addsd` critical path. No true SIMD — FP `+` is not reassociated without `-ffast-math`. |
| **R3** — 5-body, `सूची<दशमलव>` arrays | **−4 to −5 %**, every size | **1.48× gcc -O3 · 1.59× gcc -O2** (was 1.53× / 1.65×) | VEX encoding + marginally better scheduling of the `vsqrtsd`/div chain. Pair-loop trip count is 4 — nothing to vectorize. |
| **C4** — `double` matmul, `सूची<दशमलव>` | **0 %** (0.580 → 0.581 @ n=1024, within noise) | **~4.7× (n=512) · ~5.1× (n=1024)** — unchanged | inner loop stays scalar `vmulsd` + **three per-element bounds-check `cmp 0x8(%reg)`**. `-march=native` only re-encodes the identical scalar loop in VEX form; the bounds-check early-exit branch (`→ call @फेंको; unreachable`) still blocks clang's loop vectorizer. |

**The pattern:** `--native` pays off exactly where the hot loop carries **no
`सूची` bounds-check** (C2, −13 %), and is worth almost nothing where the loop
is a chain of bounds-checked `सूची` element access (C4 0 %, R3 −4 %).
Stripping that per-element check — a bounds-check-hoisting pass, prototyped
this cycle as `लूइनी_सीमा_उन्नयन` but **reverted** (it broke the compiler's
own self-compile via a CFG-mutation bug in never-validated loop-opt infra) —
is the prerequisite for `--native` to vectorise array compute. Measured
ceiling on a hand-written check-free matmul kernel: **2.5× (SSE2) → 3.65×
(AVX2) → clang parity**.

#### Effect on the verdict

Tally unchanged — **C2, C4, R3 were losses and remain losses**
(0 wins · 1 tie · 13 losses):

- **C2** improves from **1.33× → 1.17×** vs clang (**ties gcc -O3**) with
  `--native` — the closest scalar-compute row after C1.
- **R3** essentially unchanged at **~1.5×**.
- **C4** unchanged at a hard **~5× (LLVM backend) / ~700× (x86 backend)**
  loss. The quiesced ratio (~5.1× at n=1024) is *larger* than the 09-07
  Addendum's 3.7× because the C++ baseline ran ~40 % faster on the quiet
  machine while Sutra ran ~19 % faster — not a regression.

Sources: [`c2_native.sh`](c2_native.sh), [`c4r3_native.sh`](c4r3_native.sh),
[`results/c2_native_rerun.csv`](results/c2_native_rerun.csv),
[`results/c4r3_native_rerun.csv`](results/c4r3_native_rerun.csv) (+ `.log`
alongside each).
