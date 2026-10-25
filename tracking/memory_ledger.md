# सूत्र (Sutra) — Memory & Garbage Collection Ledger

**Date**: 2026-09-01  
**Audit Baseline**: Commit `34e5557` + working tree audit

---

## 1. Memory Architecture & Object Header Layout

In Sutra, heap-allocated values share a unified 16-byte object prefix layout across both the C runtime (`sutra_runtime.c`) and Sutra memory allocator (`मूल_आवंटक.सूत्र` / `मूल_आवंटक.s`):

```text
+-------------------+--------------------+------------------------+
| Offset 0 (8 bytes)| Offset 8 (8 bytes) | Offset 16+ (Payload)   |
+-------------------+--------------------+------------------------+
| Object Type (Tag) | Length / Capacity  | Data / Pointers        |
+-------------------+--------------------+------------------------+
```

### Type Tag Definitions
- `1` (`GC_TYPE_STRING`): UTF-8 string data (`[int64_t type=1, int64_t byte_len, char utf8_bytes...]`).
- `2` (`GC_TYPE_ARRAY` / `GC_TYPE_LIST`): List of 64-bit tagged elements (`[int64_t type=2, int64_t element_count, int64_t elements[]]`).
- `3` (`GC_TYPE_OBJECT`): Class instance object with named field array.
- `4` (`GC_TYPE_DICTIONARY`): Open-addressing hash table with packed key-value entries.

---

## 2. Garbage Collector Design & Implementation

Sutra implements an exact **Mark-and-Sweep Garbage Collector**:

1. **Root Registration**:
   - Variables on stack and active frames push addresses to the root array via `sutra_gc_push_root(void* addr)` / `सूत्र_जीसी_दबाओ()`.
   - On frame exit, roots are popped via `sutra_gc_pop_root(void* addr)` / `सूत्र_जीसी_छोड़ो()`.
   - Global variables registered permanently.
2. **Mark Phase**:
   - Traverses all registered roots recursively.
   - For Array/List (`type == 2`), traverses every pointer element.
   - For Object (`type == 3`), traverses all object fields.
   - For Dictionary (`type == 4`), traverses all key/value entries.
   - Supports cyclic references without infinite recursion by checking the mark bit.
3. **Sweep Phase**:
   - Scans the GC allocation table (`gc_allocs` / open-addressing hash table).
   - Reclaims unmarked blocks via `free()` / `सूत्र_मुक्त()`.
   - Resets mark flags on surviving objects for next cycle.

---

## 3. GC Stress Tests & Verification Results

| Test File | Test Objective | Interpreter Result | Native Result | Status |
| :--- | :--- | :--- | :--- | :--- |
| `tests/compiler/43_gc_stress.सूत्र` | Rapid allocation of 10,000 strings and lists in loop | PASS (0 leaks) | PASS (0 leaks) | **VERIFIED** |
| `tests/compiler/44_gc_status.सूत्र` | Inspection of cycle counts, active count, collected count | PASS | PASS | **VERIFIED** |
| `tests/compiler/45_gc_circular.सूत्र` | Cyclic object references (A → B → A) | PASS | PASS | **VERIFIED** |
| `tests/compiler/47_gc_realloc.सूत्र` | Repeated array reallocation and expansion | PASS | PASS | **VERIFIED** |
| `tests/compiler/46_gc_repeated.सूत्र` | Multiple consecutive explicit `gc_collect()` invocations | PASS | FAIL (`SUTRA-BUG-0004`) | **BUG IDENTIFIED** |
| `परीक्षणानि/gc_तनाव.सूत्र` | Large multi-threaded / nested structure pressure test | PASS | PASS | **VERIFIED** |
