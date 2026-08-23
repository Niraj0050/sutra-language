# सूत्र-अनुष्ठान-तन्त्रम् (Sutra Runtime Environment)

This document describes the design, memory layout, dynamic allocations, and garbage collection mechanisms of the Sutra language runtime.

---

## 1. Runtime Overview

Sutra executes natively by linking compiled C++ output code with a lightweight runtime engine. In accordance with the Pure Sutra Git policy, the C++ runtime files reside in the local workspace for compilation and are excluded from Git tracking:
* **Core Runtime Source (Local)**: Located at `संकलक/src/compiler/sutra_runtime.c`.
* **C API Bridge (Local)**: Located at `संकलक/src/runtime_api.cpp` and headers in `संकलक/include/sutra/runtime_api.hpp`.

---

## 2. Memory Layout

Sutra dynamic objects (strings, lists, dictionary tables, and OOP instances) are allocated on a garbage-collected heap. Every allocation contains metadata headers prefixing the raw payload.

### 2.1 String Memory Layout (`GC_TYPE_STRING`)
Strings are UTF-8 byte arrays, dynamically allocated with capacity and count prefix headers:
```text
+---------------------+-------------------+------------------------+-------------------+
| capacity (8 bytes)  |  length (8 bytes) | UTF-8 chars (N bytes)  | '\0' (1 byte null) |
+---------------------+-------------------+------------------------+-------------------+
0                     8                   16                       16 + N
```
* **Capacity**: Reserved byte capacity.
* **Length**: Number of UTF-8 encoded bytes in string value.
* **Payload**: UTF-8 bytes followed by a null terminator byte.

### 2.2 List/Array Memory Layout (`GC_TYPE_ARRAY`)
Lists represent homogeneous or heterogeneous arrays of values:
```text
+---------------------+-------------------+--------------------------------------------+
| capacity (8 bytes)  |  length (8 bytes) | element_0 (8B) | ... | element_N-1 (8B)    |
+---------------------+-------------------+--------------------------------------------+
0                     8                   16                                           16 + N*8
```
* **Capacity**: Max elements array can hold before resizing.
* **Length**: Current number of active elements.
* **Payload**: Direct array elements, where each element is an 8-byte value (encoded as raw integer, floating-point bits, or pointers to heap objects).

### 2.3 Object/Class Instance Layout (`GC_TYPE_OBJECT`)
Sutra class instances:
```text
+---------------------+-------------------+--------------------------------------------+
| capacity (8 bytes)  |  length (8 bytes) | field_0 (8B) | ... | field_N-1 (8B)        |
+---------------------+-------------------+--------------------------------------------+
0                     8                   16
```
Payload contains the object fields, ordered according to declaration.

### 2.4 Dictionary Layout (`GC_TYPE_DICTIONARY`)
Dictionaries utilize a dynamically managed hash table struct (24 bytes) referencing keys and values array pointers.

---

## 3. Garbage Collector (स्मृति-संग्रहकः)

Sutra implements a custom **Mark-and-Sweep Garbage Collector** operating on heap pointers:
* **Root Scan (Shadow Stack)**: Active references, local environments, and temporary registers are registered on a shadow stack during compiler code execution.
* **Mark Phase**: The GC walks active pointer references starting from registered root pointers, marking reachable headers.
* **Sweep Phase**: Unmarked heap objects are garbage collected, freeing native buffers.
* **Performance Metrics**: Exposed through:
  - `native_gc_collection_count`: total GC runs.
  - `native_gc_live_allocs_count`: live heap buffers.
  - `native_gc_collected_objects_count`: reclaimed buffers.
  - `native_gc_bytes_reclaimed`: reclaimed memory size in bytes.
