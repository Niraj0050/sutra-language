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
| `अंतर्_क्षेत्र_आवंटन(बाइट्स)` | 1 | OS arena request (VirtualAlloc / mmap) | ☐ |
| `अंतर्_लिख_धारा(fd, आधार, लंबाई)` | 3 | write(fd, buf, n) | ☐ |
| `अंतर्_पढ़_धारा(fd, आधार, लंबाई)` | 3 | read(fd, buf, n) | ☐ |
| `अंतर्_निकास(कोड)` | 1 | ExitProcess / exit syscall | ☐ |
| `अंतर्_पता(चर)` | 1 | address of a local (for shadow-stack roots) | ☐ |

The `अंतर्_*` intrinsics return plain 64-bit ints and are recognised by
`क्या_संख्या_अभिव्यक्ति_है`, so the `+` fast path treats offset math inline.

## Heap object layout (already fixed, see memory.md)

```
string : [cap:8][len:8][utf8 bytes][\0]
array  : [cap:8][len:8][elem:8]...
object : [cap:8][len:8][field:8]...
dict   : [cap:8][len:8][entries*:8] → [key*:8][val:8] × n
```

`अंतर्_पढ़8(s, 8)` = byte length; `अंतर्_पढ़1(s, 16)` = first payload byte;
`अंतर्_पढ़8(arr, 16 + i*8)` = element i.

## Porting order

1. **Read-only leaves** (no allocation): `sutra_str_length`, `sutra_str_equal`,
   `sutra_str_compare` + `_less`/`_greater`/…, `sutra_char_ord`,
   `sutra_arr_length`, `sutra_arr_get` (bounds-checked), `sutra_is_dict`
   via a tag scheme.  ← start here
2. **OS floor** (L0/L1): arena alloc, `write`, `exit`.  Windows = PE
   imports of `kernel32!VirtualAlloc / WriteFile / ExitProcess`; Linux =
   `syscall`.
3. **L2 allocator + GC** in restricted Sutra over the arena; replace the
   C `gc_register_alloc` / mark-sweep.
4. **Allocating string ops**: `sutra_str_alloc`, `_concat`, `_substr`,
   `sutra_int_to_str`, `_bool_to_str`, `_null_to_str`.
5. **Array / dict ops**: `sutra_list_append` (+ realloc), `sutra_dict_set`/`_get`.
6. **Print**: `sutra_print_dynamic` and friends → format into a buffer,
   `अंतर्_लिख_धारा(1, …)`.
7. **Math**: `sqrt` → `sqrtsd`; `pow` etc. → software or `libm` (last to go).
8. **Exceptions**: drop `setjmp`/`longjmp` — codegen already tracks a try
   stack; implement unwinding in the epilogue.
9. **File I/O, args**: `अंतर्_पढ़_धारा` + path handling; argv from the
   process block.

Each ported function: keep the C version, add the Sutra version, switch
the codegen symbol mapping, run `verify_intrinsics.ps1` + the 51-test
suite + the self-hosting fixed point, then delete the C version.

## What stays non-Sutra at the end

- GNU `as` + `ld` (assembler + linker) — or replace with direct `.o` / PE
  emission much later.
- The hardcoded `C:\msys64\ucrt64\bin` tool paths.
