# रनटाइम-इन-सूत्र (Porting the runtime to Sutra)

Goal: replace `sutra_runtime.c` (~2.1k lines of C, linked into every Sutra
binary) with Sutra source, leaving only an irreducible primitive floor.

## Layering

```
┌────────────────────────────────────────────────────────────┐
│  L3  उच्च-स्तर रनटाइम   (सामान्य .सूत्र)                        │
│      string / array / dict ops, print formatting,           │
│      int↔str↔float, math, file wrappers, arg parsing        │
├────────────────────────────────────────────────────────────┤
│  L2  आवंटक + GC        (प्रतिबंधित .सूत्र — कोई string/सूची/  │
│      bump/free-list allocator over an OS arena,   शब्दकोश)   │
│      mark-and-sweep, root shadow stack                      │
├────────────────────────────────────────────────────────────┤
│  L1  अंतर्निर्देश (intrinsics) — codegen सीधे machine निर्देश  │
│      बनाता है, कोई call नहीं                                  │
├────────────────────────────────────────────────────────────┤
│  L0  OS floor          — kernel32 imports / raw syscall      │
│      arena alloc, write(fd), read(fd), exit                 │
└────────────────────────────────────────────────────────────┘
```

L3 code compiles like any Sutra. L2 must be written in a **restricted
subset**: only integers + intrinsics, no high-level `पाठ` / `सूची` / `शब्दकोश`
(those are what L2 implements — using them there is circular).

## L1 intrinsics

Handled in `मूल_सर्जक.सूत्र` → `अभिव्यक्ति_कॉल`, and whitelisted in
`सार्थक_विश्लेषक.सूत्र`.

| Intrinsic | Args | Emits | Status |
|---|---|---|---|
| `अंतर्_पढ़8(आधार, ऑफ)` | 2 | `movq (base,off), %rax` | ✅ done |
| `अंतर्_पढ़1(आधार, ऑफ)` | 2 | `movzbq (base,off), %rax` | ✅ done |
| `अंतर्_लिख8(आधार, ऑफ, मान)` | 3 | `movq val, (base,off)` → मान | ✅ done |
| `अंतर्_लिख1(आधार, ऑफ, मान)` | 3 | `movb val8, (base,off)` → मान | ✅ done |
| `अंतर्_क्षेत्र_आवंटन(बाइट्स)` | 1 | `call सूत्र_तल_आवंटन` (VirtualAlloc) → पता | ✅ done |
| `अंतर्_क्षेत्र_मुक्त(पता)` | 1 | `call सूत्र_तल_मुक्त` (VirtualFree) | ✅ done |
| `अंतर्_मुद्रण(आधार, ऑफ, लंबाई)` | 3 | `call सूत्र_तल_मुद्रण` (GetStdHandle + WriteFile) | ✅ done |
| `अंतर्_निकास(कोड)` | 1 | `call सूत्र_तल_निकास` (ExitProcess) | ✅ done |
| `अंतर्_पढ़_धारा(आधार, ऑफ, लंबाई)` | 3 | ReadFile(stdin) | ☐ |
| `अंतर्_पता(चर)` | 1 | address of a local (for shadow-stack roots) | ☐ |

The read/write/alloc `अंतर्_*` return plain 64-bit ints and are recognised by
`क्या_संख्या_अभिव्यक्ति_है`, so the `+` fast path treats offset math inline.

## L0 — the OS floor (`स्वसंकलक/निर्माण/तल.s`)

Hand-written GAS, **no C**. Wraps kernel32 — the Windows floor, since there is
no stable syscall ABI below it:

```
सूत्र_तल_आवंटन(rcx=बाइट्स)          → VirtualAlloc(NULL, n, MEM_COMMIT|RESERVE, RW)
सूत्र_तल_मुक्त(rcx=पता)              → VirtualFree(p, 0, MEM_RELEASE)
सूत्र_तल_मुद्रण(rcx=पता, rdx=लंबाई)  → GetStdHandle(-11); WriteFile(...)
सूत्र_तल_निकास(rcx=कोड)             → ExitProcess(code)
```

`मूल_संकलन.सूत्र` reads `स्वसंकलक/निर्माण/तल.s`, assembles it to `sutra_floor.o`
(best-effort) and links it when present; `bootstrap.ps1` assembles it up front.
`भाषा_परीक्षण/intrinsics/02_os_floor.सूत्र` allocates, fills, writes to stdout, and frees
with zero libc on that path.

Linux port later: `सूत्र_तल_*` become raw `syscall` (mmap/write/exit) and the
binary links `-nostdlib`.

## Heap object layout (already fixed, see memory.md)

```
string : [cap:8][len:8][utf8 bytes][\0]
array  : [cap:8][len:8][elem:8]...
object : [cap:8][len:8][field:8]...
dict   : [cap:8][len:8][entries*:8] → [key*:8][val:8] × n
```

`अंतर्_पढ़8(s, 8)` = byte length; `अंतर्_पढ़1(s, 16)` = first payload byte;
`अंतर्_पढ़8(arr, 16 + i*8)` = element i.

## The Sutra runtime module (`स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र`)

L3 runtime functions written in Sutra. Compiled to `मूल_रनटाइम.s` (committed,
`.gitattributes -text`), assembled to `sutra_srt.o` and linked into every
native-asm output (`मूल_संकलन.सूत्र` does it best-effort, `bootstrap.ps1` up
front). A source with no `मुख्य` and no top-level code emits **no `main`
wrapper** (library mode) so its `.o` links cleanly.

Pure Devanagari names — no `sutra_` prefix.

## Porting order

1. **Read-only leaves** (no allocation) — ✅ done:
   - batch 1: `अक्षर_कोडबिंदु` (was `sutra_char_ord`), `पाठ_कोडबिंदु_गणना`
     (`sutra_str_length`), `पाठ_तुल्य` (`sutra_str_equal`), `सञ्चय_गणना`
     (`sutra_arr_length`), `दैशिक_लंबाई` (`sutra_dynamic_length`)
   - batch 2: `पाठ_कोडबिंदु_तुलना` (`sutra_utf8_cmp_codepoints`) +
     `पाठ_न्यून` / `पाठ_अधिक` / `पाठ_न्यून_सम` / `पाठ_अधिक_सम`
     (`sutra_str_less` / `_greater` / `_less_equal` / `_greater_equal`)

   Codegen retargeted: `लंबाई` → `दैशिक_लंबाई`, `अक्षर_मान`/`अक्षरम्` →
   `अक्षर_कोडबिंदु`, string `==`/`!=` → `पाठ_तुल्य`, string `<`/`>`/`<=`/`>=`
   → `पाठ_न्यून` etc. Type checks still call C via `अंतर्_क्या_पाठ` /
   `अंतर्_क्या_शब्दकोश` (→ `sutra_native_is_string` / `sutra_is_dict`) until
   the GC moves. `sutra_str_compare` is dead code (no callers).
   Still C: `sutra_arr_get`, `sutra_str_get` (their string / substring
   branches allocate — go with the allocating batch).
2. **OS floor** (L0/L1) — ✅ done (`तल.s`, see above).
3. **L2 allocator + GC** — ✅ done (`स्वसंकलक/निर्माण/मूल_आवंटक.सूत्र`).
   VirtualAlloc arena (16 MB chunks, linked list) + first-fit free list +
   bump; every block carries a hidden 32-byte-aligned prefix
   `[tag:8][size:8]` (tag = type 1–4, +256 = GC mark), so the returned
   pointer is 16-aligned and `p-16` is the header. Mark-and-sweep walks
   the arena linearly. `सूत्र_आवंटन` / `सूत्र_पुनः_आवंटन` / `सूत्र_मुक्त` /
   `सूत्र_ब्लॉक_प्रकार` / `सूत्र_संग्रह`. The whole module is typed `संख्या`
   throughout (no `मान`) so no `+` ever falls to `sutra_add_dynamic` —
   that path recurses via the type check. C keeps thin shims:
   `sutra_str_alloc` etc. now just call `सूत्र_आवंटन`; `find_gc_allocation`
   is a 6-line adapter over `सूत्र_ब्लॉक_प्रकार`; `sutra_gc_collect` →
   `सूत्र_संग्रह`. GC roots stay in the fixed C `gc_roots[]` array, read by
   the Sutra collector through `sutra_gc_root_count` / `_deref` /
   `sutra_gc_active_exc` (via new intrinsics `अंतर्_जड़_संख्या` /
   `अंतर्_जड़_मान` / `अंतर्_सक्रिय_अपवाद`). Old C `gc_allocs` hash is dead
   code, deleted next.
   Library-mode codegen: a source whose top level is only `कठन_चर_घोषणा`
   (no `मुख्य`) emits no `main` wrapper — globals are `.data .quad 0`.
4. **Allocating string ops** — ✅ done (`स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र`).
   `पाठ_आवंटित` (`sutra_str_alloc`), `पाठ_जोड़` (`_concat`),
   `पाठ_उपखंड` (`_substr`), `संख्या_से_पाठ` (`sutra_int_to_str`),
   `बूल_से_पाठ` (`_bool_to_str`), `शून्य_से_पाठ` (`_null_to_str`),
   `अक्षर_बना` (`sutra_char_chr`). Shared `खंड_प्रतिलिपि` block-copy
   helper (8-byte words + byte tail) — no `memcpy` on the concat path.
   `बूल_से_पाठ` / `शून्य_से_पाठ` write the सत्य/असत्य/शून्यम् UTF-8 bytes
   literally (no string constants in a module that has no string leaves).
   C shims: `sutra_str_concat` etc. are now one-liners forwarding to the
   Sutra symbols; `sutra_str_alloc` already routed through `सूत्र_आवंटन`
   in batch 3. Semantic analyzer: builtins carry an `अंतर्निहित` flag so a
   user `कार्य` (e.g. `मूल_आवंटक.सूत्र`'s own `सूत्र_आवंटन`) may override
   one without a redefinition error.

   ⚠️ **`sutra_substr` reverted to C** (Phase-0 perf) — the lexer calls
   `स्रोत[i]` per char, and unoptimised Sutra `पाठ_उपखंड` (O(n) per call,
   no cache) regressed self-compile ~40×. `पाठ_उपखंड` stays defined and
   tested (`04_string_ops`); codegen routes `x[i]` on a string to C
   `sutra_str_get` (sequential cache) for now. Re-wire to Sutra once the
   optimiser lands. See `प्रलेख/PERFORMANCE_ROADMAP.md`.
5. **Array / dict ops**: `sutra_list_append` (+ realloc), `sutra_dict_set`/`_get`.
6. **Print**: `sutra_print_dynamic` and friends → format into a buffer,
   `अंतर्_मुद्रण(buf, 0, n)`.
7. **Math**: `sqrt` → `sqrtsd`; `pow` etc. → software or `libm` (last to go).
8. **Exceptions**: drop `setjmp`/`longjmp` — codegen already tracks a try
   stack; implement unwinding in the epilogue.
9. **File I/O, args**: `अंतर्_पढ़_धारा` + path handling; argv from the
   process block.

Each ported function: keep the C version (C++ host still needs it), add
the Sutra version, retarget the native codegen symbol, run
`verify_intrinsics.ps1` + the 51-test suite + the self-hosting fixed
point. C versions are deleted when the C++ host is removed.

## What stays non-Sutra at the end

- GNU `as` + `ld` (assembler + linker) — or replace with direct `.o` / PE
  emission much later.
- The hardcoded `C:\msys64\ucrt64\bin` tool paths.
