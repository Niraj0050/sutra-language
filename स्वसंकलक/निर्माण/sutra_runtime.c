/*
 * Sutra Native Runtime 1.0
 * Minimal C runtime for Sutra native compiler.
 * Provides string, array, null, and print helpers.
 * Bootstrap dependency: C standard library (malloc, free, printf, memcpy, strcmp).
 * This runtime will eventually be replaced by a pure Sutra implementation.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#ifdef _WIN32
#include <windows.h>
#include <shellapi.h>
#endif

#define USE_LEGACY_RUNTIME

#ifndef USE_LEGACY_RUNTIME
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
extern void* sutra_native_alloc(size_t size, int type);
extern void* sutra_native_realloc(void* ptr, size_t new_size);
extern void sutra_native_gc_collect(void*** roots, int roots_count, void* active_exception);
extern int64_t native_gc_collection_count;
extern int64_t native_gc_live_allocs_count;
extern int64_t native_gc_collected_objects_count;
extern int64_t native_gc_bytes_reclaimed;
#ifdef __cplusplus
}
#endif
#endif

#include <math.h>
#include <setjmp.h>

#ifdef __cplusplus
extern "C" {
#endif

// Forward declarations
void sutra_throw_str(const char* msg);
void sutra_throw(void* ex);
int sutra_native_is_dict(void* ptr);
int sutra_native_is_string(void* ptr);
int sutra_native_is_array(void* ptr);
void* sutra_dynamic_type(void* ptr);
void sutra_print_dynamic(int64_t val);

/* ============================================================
 * EXCEPTION HANDLING RUNTIME
 * ============================================================ */
#define MAX_TRY_DEPTH 256
jmp_buf sutra_try_stack[MAX_TRY_DEPTH];
int sutra_try_gc_roots_count[MAX_TRY_DEPTH];
volatile int sutra_try_depth = 0;
void* volatile sutra_active_exception = NULL;

extern volatile int gc_roots_count;

void* sutra_exception_get_jmp_buf() {
    if (sutra_try_depth >= MAX_TRY_DEPTH) {
        fprintf(stderr, "त्रुटिः — अधिकतम प्रयत्न सीमा पार हो गई (Max try depth exceeded)\n");
        exit(1);
    }
    sutra_try_gc_roots_count[sutra_try_depth] = gc_roots_count;
    return &sutra_try_stack[sutra_try_depth++];
}

#if 0
void sutra_exception_pop() {
    if (sutra_try_depth > 0) sutra_try_depth--;
}
#endif

void sutra_str_print(void* s);

void* sutra_exception_get_active() {
    return sutra_active_exception;
}

void sutra_throw(void* ex) {
    sutra_active_exception = ex;

    if (sutra_try_depth == 0) {
        if (ex) {
            /* ex is a Sutra string: [capacity: 8 bytes][length: 8 bytes][data: N bytes] */
            int64_t len = *((int64_t*)((char*)ex + 8));
            const char* msg = (const char*)ex + 16;
            fprintf(stderr, "त्रुटिः: %.*s\n", (int)len, msg);
        } else {
            fprintf(stderr, "त्रुटिः — अनियंत्रित अपवाद (Uncaught exception)\n");
        }
        exit(1);
    }
    sutra_try_depth--;
    gc_roots_count = sutra_try_gc_roots_count[sutra_try_depth];
    longjmp(sutra_try_stack[sutra_try_depth], 1);
}

#if 0
void* sutra_get_exception_value() {
    return sutra_active_exception;
}
#endif

void* sutra_str_alloc(const char* data, int64_t len);

void sutra_throw_str(const char* msg) {
    void* err_str = sutra_str_alloc(msg, strlen(msg));
    sutra_throw(err_str);
}

void sutra_throw_div_by_zero() {
    sutra_throw_str("अनुष्ठान-त्रुटिः — शून्येन विभाजनम् न सम्भवति (Division by zero)");
}


/* ============================================================
 * GARBAGE COLLECTOR RUNTIME
 * ============================================================ */

#define GC_MAX_ROOTS 1000000
void** gc_roots[GC_MAX_ROOTS];
volatile int gc_roots_count = 0;

#if 0
void sutra_gc_push_root(void* addr) {
    if (gc_roots_count < GC_MAX_ROOTS) {
        gc_roots[gc_roots_count++] = (void**)addr;
    } else {
        fprintf(stderr, "त्रुटिः — GC root stack overflow\n");
        exit(1);
    }
}

void sutra_gc_pop_root(void* addr) {
    if (gc_roots_count > 0) {
        if (gc_roots[gc_roots_count - 1] != (void**)addr) {
            fprintf(stderr, "त्रुटिः — GC root mismatch on pop: expected %p, got %p\n", (void*)gc_roots[gc_roots_count - 1], addr);
            exit(1);
        }
        gc_roots_count--;
    }
}
#endif

typedef enum {
    GC_TYPE_STRING,
    GC_TYPE_ARRAY,
    GC_TYPE_OBJECT,
    GC_TYPE_DICTIONARY
} GCType;

typedef struct {
    void* ptr;
    size_t size;
    GCType type;
    int marked;
} GCAllocation;

#define INITIAL_GC_DB_CAPACITY 1024
GCAllocation* gc_allocs = NULL;
size_t gc_allocs_count = 0;
size_t gc_allocs_capacity = 0;

// Stats
int64_t gc_collection_count = 0;
int64_t gc_live_allocs_count = 0;
int64_t gc_bytes_allocated = 0;
int64_t gc_bytes_reclaimed = 0;
int64_t gc_collected_objects_count = 0;

/* ============================================================
 * सूचक -> gc_allocs अनुक्रमणिका hash (खुला-पता, रैखिक-probe)
 * इससे gc_register_alloc / find_gc_allocation / sutra_is_dict
 * O(heap) के बजाय O(1) हो जाते हैं — यही स्व-संकलन की गति का
 * असली अवरोध था (O(n^2))।
 * ========================================================== */
static void**  gc_hash_keys = NULL;   /* NULL स्लॉट = खाली */
static size_t* gc_hash_vals = NULL;    /* gc_allocs में अनुक्रमणिका */
static size_t  gc_hash_cap  = 0;       /* सदैव 2 की घात */
static size_t  gc_hash_used = 0;
#define GC_HASH_NONE ((size_t)-1)

static size_t gc_hash_mix(void* p) {
    uintptr_t h = (uintptr_t)p;
    h ^= h >> 33; h *= (uintptr_t)0xff51afd7ed558ccdULL; h ^= h >> 33;
    return (size_t)h;
}

static void gc_hash_put_raw(void* key, size_t val) {
    size_t mask = gc_hash_cap - 1;
    size_t i = gc_hash_mix(key) & mask;
    while (gc_hash_keys[i] != NULL) i = (i + 1) & mask;
    gc_hash_keys[i] = key;
    gc_hash_vals[i] = val;
    gc_hash_used++;
}

static void gc_hash_rebuild(size_t new_cap) {
    if (new_cap < 2048) new_cap = 2048;
    free(gc_hash_keys);
    free(gc_hash_vals);
    gc_hash_cap  = new_cap;
    gc_hash_keys = (void**)calloc(gc_hash_cap, sizeof(void*));
    gc_hash_vals = (size_t*)malloc(gc_hash_cap * sizeof(size_t));
    gc_hash_used = 0;
    if (!gc_hash_keys || !gc_hash_vals) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (gc hash rebuild)");
    }
    for (size_t i = 0; i < gc_allocs_count; i++) {
        gc_hash_put_raw(gc_allocs[i].ptr, i);
    }
}

static size_t gc_hash_get(void* key) {
    if (!gc_hash_cap) return GC_HASH_NONE;
    size_t mask = gc_hash_cap - 1;
    size_t i = gc_hash_mix(key) & mask;
    while (gc_hash_keys[i] != NULL) {
        if (gc_hash_keys[i] == key) return gc_hash_vals[i];
        i = (i + 1) & mask;
    }
    return GC_HASH_NONE;
}

/* किसी मौजूद key का संग्रहित मान (gc_allocs अनुक्रमणिका) बदलो */
static void gc_hash_setval(void* key, size_t val) {
    if (!gc_hash_cap) return;
    size_t mask = gc_hash_cap - 1;
    size_t i = gc_hash_mix(key) & mask;
    while (gc_hash_keys[i] != NULL) {
        if (gc_hash_keys[i] == key) { gc_hash_vals[i] = val; return; }
        i = (i + 1) & mask;
    }
}

/* रैखिक-probe से key हटाओ — पिछे-खिसकाव विलोपन (Knuth Alg. R) */
static void gc_hash_del(void* key) {
    if (!gc_hash_cap) return;
    size_t mask = gc_hash_cap - 1;
    size_t i = gc_hash_mix(key) & mask;
    while (gc_hash_keys[i] != NULL && gc_hash_keys[i] != key) i = (i + 1) & mask;
    if (gc_hash_keys[i] == NULL) return;
    size_t j = i;
    for (;;) {
        gc_hash_keys[i] = NULL;
        size_t k;
        do {
            j = (j + 1) & mask;
            if (gc_hash_keys[j] == NULL) { gc_hash_used--; return; }
            k = gc_hash_mix(gc_hash_keys[j]) & mask;
        } while ((i <= j) ? (i < k && k <= j) : (i < k || k <= j));
        gc_hash_keys[i] = gc_hash_keys[j];
        gc_hash_vals[i] = gc_hash_vals[j];
        i = j;
    }
}

/* अनुक्रमिक पाठ-सूचकांक पहुँच के लिए 1-प्रविष्टि cache (लेक्सर का O(n^2) निवारण) */
static void*   sg_cache_str      = NULL;
static int64_t sg_cache_char_idx = 0;
static int64_t sg_cache_byte_off = 0;

void gc_register_alloc(void* ptr, size_t size, GCType type) {
    if (!ptr) return;
    if (ptr == sg_cache_str) sg_cache_str = NULL; /* पुनः-प्रयुक्त पता → cache अमान्य */
    // Detect duplicate allocation registration – this indicates a logic error (double allocation of same address)
    if (gc_hash_get(ptr) != GC_HASH_NONE) {
        fprintf(stderr, "त्रुटिः — डुप्लिकेट आवंटन पंजीकरण (duplicate allocation registration) for %p\n", ptr);
        exit(1);
    }
    if (!gc_allocs) {
        gc_allocs_capacity = INITIAL_GC_DB_CAPACITY;
        gc_allocs = (GCAllocation*)malloc(gc_allocs_capacity * sizeof(GCAllocation));
        if (!gc_allocs) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (gc registry init)");
        }
    }
    if (gc_allocs_count >= gc_allocs_capacity) {
        size_t new_capacity = gc_allocs_capacity * 2;
        GCAllocation* new_allocs = (GCAllocation*)realloc(gc_allocs, new_capacity * sizeof(GCAllocation));
        if (!new_allocs) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (gc registry grow)");
        }
        gc_allocs = new_allocs;
        gc_allocs_capacity = new_capacity;
    }
    size_t new_idx = gc_allocs_count;
    gc_allocs[new_idx].ptr = ptr;
    gc_allocs[new_idx].size = size;
    gc_allocs[new_idx].type = type;
    gc_allocs[new_idx].marked = 0;
    gc_allocs_count++;

    /* hash में जोड़ो — load factor 75% पार हो तो पुनर्निर्माण (नई प्रविष्टि सहित) */
    if (gc_hash_cap == 0 || (gc_hash_used + 1) * 4 >= gc_hash_cap * 3) {
        gc_hash_rebuild(gc_hash_cap ? gc_hash_cap * 2 : 2048);
    } else {
        gc_hash_put_raw(ptr, new_idx);
    }

    gc_bytes_allocated += size;
}

void gc_unregister_alloc(void* ptr) {
    if (!ptr) return;
    size_t idx = gc_hash_get(ptr);
    if (idx == GC_HASH_NONE) return;
    if (ptr == sg_cache_str) sg_cache_str = NULL;
    gc_hash_del(ptr);
    size_t last = gc_allocs_count - 1;
    if (idx != last) {
        gc_allocs[idx] = gc_allocs[last];
        gc_hash_setval(gc_allocs[idx].ptr, idx); /* खिसकाया गया तत्व अब idx पर */
    }
    gc_allocs_count--;
}

void gc_update_alloc(void* old_ptr, void* new_ptr, size_t new_size) {
    if (!old_ptr || !new_ptr) return;
    size_t idx = gc_hash_get(old_ptr);
    if (idx == GC_HASH_NONE) return;
    if (old_ptr == sg_cache_str) sg_cache_str = NULL;
    gc_allocs[idx].ptr = new_ptr;
    gc_bytes_allocated += (new_size - gc_allocs[idx].size);
    gc_allocs[idx].size = new_size;
    gc_hash_del(old_ptr);              /* O(1) एकल-key अद्यतन (पूर्ण rebuild नहीं) */
    gc_hash_put_raw(new_ptr, idx);
}

void gc_mark_allocation(void* ptr) {
    if (!ptr) return;
    if ((uintptr_t)ptr < 65536) return; // Ignore null and small integers

    // Find in registry (O(1) hash)
    size_t idx = gc_hash_get(ptr);
    if (idx == GC_HASH_NONE) return; // Not a tracked GC pointer
    if (gc_allocs[idx].marked) return; // Already marked

    gc_allocs[idx].marked = 1;

    // Recursively mark children
    if (gc_allocs[idx].type == GC_TYPE_ARRAY) {
        int64_t count = *((int64_t*)((char*)ptr + 8));
        int64_t* elements = (int64_t*)((char*)ptr + 16);
        for (int64_t i = 0; i < count; i++) {
            gc_mark_allocation((void*)elements[i]);
        }
    } else if (gc_allocs[idx].type == GC_TYPE_OBJECT) {
        int64_t count = *((int64_t*)((char*)ptr + 8));
        int64_t* fields = (int64_t*)((char*)ptr + 16);
        for (int64_t i = 0; i < count; i++) {
            gc_mark_allocation((void*)fields[i]);
        }
    } else if (gc_allocs[idx].type == GC_TYPE_DICTIONARY) {
        int64_t count = *((int64_t*)ptr);
        char* entries = (char*)(*((void**)((char*)ptr + 16)));
        if (entries) {
            for (int64_t i = 0; i < count; i++) {
                void* key = *((void**)(entries + i * 16));
                int64_t val = *((int64_t*)(entries + i * 16 + 8));
                gc_mark_allocation(key);
                gc_mark_allocation((void*)val);
            }
        }
    }
}

void sutra_gc_collect() {
#ifdef USE_LEGACY_RUNTIME
    gc_collection_count++;
    sg_cache_str = NULL; /* संग्रहण मुक्त पते बदल सकता है */

    // 1. Reset marks
    for (size_t i = 0; i < gc_allocs_count; i++) {
        gc_allocs[i].marked = 0;
    }

    // 2. Mark from registered roots
    for (int i = 0; i < gc_roots_count; i++) {
        if (gc_roots[i]) {
            void* root_ptr = *(gc_roots[i]);
            gc_mark_allocation(root_ptr);
        }
    }
    // Mark active exception if exists
    if (sutra_active_exception) {
        gc_mark_allocation(sutra_active_exception);
    }
    // 3. Sweep unmarked allocations
    gc_live_allocs_count = 0;
    size_t i = 0;
    while (i < gc_allocs_count) {
        if (!gc_allocs[i].marked) {
            void* p = gc_allocs[i].ptr;
            size_t sz = gc_allocs[i].size;

            // Clean up dictionary helper array
            if (gc_allocs[i].type == GC_TYPE_DICTIONARY) {
                void* entries = *((void**)((char*)p + 16));
                if (entries) {
                    free(entries);
                }
            }

            free(p);
            gc_bytes_reclaimed += sz;
            gc_collected_objects_count++;

            // Swap delete
            gc_allocs[i] = gc_allocs[gc_allocs_count - 1];
            gc_allocs_count--;
        } else {
            gc_live_allocs_count++;
            i++;
        }
    }
    gc_hash_rebuild(gc_hash_cap); /* sweep ने अनुक्रमणिकाएँ पुनर्व्यवस्थित कीं */
#else
    sutra_native_gc_collect(gc_roots, gc_roots_count, sutra_active_exception);
#endif
}

void sutra_gc_status() {
#ifdef USE_LEGACY_RUNTIME
    printf("चक्र: %lld\nसक्रिय: %lld\nसंग्रहित: %lld\n",
           (long long)gc_collection_count,
           (long long)gc_live_allocs_count,
           (long long)gc_collected_objects_count);
#else
    printf("चक्र: %lld\nसक्रिय: %lld\nसंग्रहित: %lld\n",
           (long long)native_gc_collection_count,
           (long long)native_gc_live_allocs_count,
           (long long)native_gc_collected_objects_count);
#endif
}

static GCAllocation* find_gc_allocation(void* ptr) {
    if (!ptr || (uintptr_t)ptr < 65536) return NULL;
    size_t idx = gc_hash_get(ptr);
    return (idx == GC_HASH_NONE) ? NULL : &gc_allocs[idx];
}

int sutra_native_is_string(void* ptr) {
    GCAllocation* alloc = find_gc_allocation(ptr);
    return (alloc && alloc->type == GC_TYPE_STRING) ? 1 : 0;
}

int sutra_native_is_array(void* ptr) {
    GCAllocation* alloc = find_gc_allocation(ptr);
    return (alloc && alloc->type == GC_TYPE_ARRAY) ? 1 : 0;
}

int sutra_native_is_dict(void* ptr) {
    GCAllocation* alloc = find_gc_allocation(ptr);
    return (alloc && alloc->type == GC_TYPE_DICTIONARY) ? 1 : 0;
}

void* sutra_dynamic_type(void* ptr) {
    if (!ptr) {
        return sutra_str_alloc("शून्यम्", strlen("शून्यम्"));
    }
    if (sutra_native_is_string(ptr)) {
        return sutra_str_alloc("पाठ", strlen("पाठ"));
    }
    if (sutra_native_is_dict(ptr)) {
        return sutra_str_alloc("शब्दकोश", strlen("शब्दकोश"));
    }
    if (sutra_native_is_array(ptr)) {
        return sutra_str_alloc("सूची", strlen("सूची"));
    }
    return sutra_str_alloc("संख्या", strlen("संख्या"));
}

void sutra_print_dynamic(int64_t val) {
    if (val == 0) {
        printf("0\n");
        return;
    }
    GCAllocation* alloc = find_gc_allocation((void*)val);
    if (alloc) {
        if (alloc->type == GC_TYPE_STRING) {
            char* s = (char*)val;
            int64_t len = *((int64_t*)(s + 8));
            char* data = s + 16;
            fwrite(data, 1, len, stdout);
            printf("\n");
        } else if (alloc->type == GC_TYPE_DICTIONARY) {
            printf("[शब्दकोश]\n");
        } else if (alloc->type == GC_TYPE_ARRAY) {
            printf("[सूची]\n");
        } else {
            printf("%lld\n", (long long)val);
        }
    } else {
        printf("%lld\n", (long long)val);
    }
    fflush(stdout);
}

/* Forward declarations for runtime helpers used by string helpers before their definitions. */
void* sutra_arr_create(int64_t n);
void sutra_arr_set(void* arr, int64_t idx, int64_t val);

/* ============================================================
 * STRING RUNTIME
 * Memory layout: [int64_t byte_length] [char data[byte_length]] [\0]
 * The pointer points to the byte_length field.
 * ============================================================ */

void* sutra_str_alloc(const char* data, int64_t len) {
    int64_t cap = len == 0 ? 4 : len;
    /* Allocate: 16 bytes for capacity/length + cap bytes for data + 1 for null terminator */
#ifdef USE_LEGACY_RUNTIME
    char* block = (char*)malloc(16 + cap + 1);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (string alloc)");
    }
    *((int64_t*)block) = cap;
    *((int64_t*)(block + 8)) = len;
    if (len > 0 && data) {
        memcpy(block + 16, data, len);
    }
    block[16 + len] = '\0';
    gc_register_alloc(block, 16 + cap + 1, GC_TYPE_STRING);
    return block;
#else
    void* block = sutra_native_alloc(16 + cap + 1, GC_TYPE_STRING);
    *((int64_t*)block) = cap;
    *((int64_t*)((char*)block + 8)) = len;
    if (len > 0 && data) {
        memcpy((char*)block + 16, data, len);
    }
    ((char*)block)[16 + len] = '\0';
    return block;
#endif
}

extern int sutra_native_is_string(void* ptr);

void* sutra_int_to_str(int64_t v) {
    if (sutra_native_is_string((void*)v)) {
        return (void*)v;
    }
    char buf[32];
    int len = snprintf(buf, sizeof(buf), "%" PRId64, v);
    return sutra_str_alloc(buf, len);
}

/* '+' का runtime निर्णय — जब native codegen static रूप से तय नहीं कर सका
 * कि operand पाठ है या संख्या। कोई भी पक्ष पंजीकृत स्ट्रिंग हो → concat,
 * अन्यथा पूर्णांक-योग। (व्याख्याता/C++ host जैसा व्यवहार।) */
void* sutra_str_concat(void* a, void* b);
int64_t sutra_add_dynamic(int64_t a, int64_t b) {
    int a_str = sutra_native_is_string((void*)a);
    int b_str = sutra_native_is_string((void*)b);
    if (a_str || b_str) {
        void* sa = a_str ? (void*)a : sutra_int_to_str(a);
        void* sb = b_str ? (void*)b : sutra_int_to_str(b);
        return (int64_t)sutra_str_concat(sa, sb);
    }
    return a + b;
}

void* sutra_bool_to_str(int64_t v) {
    if (v) return sutra_str_alloc("सत्य", strlen("सत्य"));
    else return sutra_str_alloc("असत्य", strlen("असत्य"));
}

void* sutra_null_to_str() {
    return sutra_str_alloc("शून्यम्", strlen("शून्यम्"));
}

/* Concatenate two strings, return new string */
void* sutra_str_concat(void* a, void* b) {
    if (!a && !b) return sutra_str_alloc("", 0);
    if (!a) {
        int64_t len_b = *((int64_t*)((char*)b + 8));
        return sutra_str_alloc((char*)b + 16, len_b);
    }
    if (!b) {
        int64_t len_a = *((int64_t*)((char*)a + 8));
        return sutra_str_alloc((char*)a + 16, len_a);
    }

    int64_t len_a = *((int64_t*)((char*)a + 8));
    int64_t len_b = *((int64_t*)((char*)b + 8));
    int64_t total = len_a + len_b;

    // Always allocate a brand new block to preserve parity with the interpreter's allocation pattern
    void* new_block = sutra_str_alloc(NULL, total);
    if (len_a > 0) {
        memcpy((char*)new_block + 16, (char*)a + 16, len_a);
    }
    if (len_b > 0) {
        memcpy((char*)new_block + 16 + len_a, (char*)b + 16, len_b);
    }
    ((char*)new_block)[16 + total] = '\0';
    return new_block;
}

/* Compare two strings for equality. Returns 1 if equal, 0 otherwise. */
int64_t sutra_str_equal(void* a, void* b) {
    if (a == b) return 1;
    if (!a || !b) return 0;

    extern int sutra_native_is_string(void* ptr);
    if (!sutra_native_is_string(a) || !sutra_native_is_string(b)) {
        return 0;
    }

    int64_t len_a = *((int64_t*)((char*)a + 8));
    int64_t len_b = *((int64_t*)((char*)b + 8));
    if (len_a != len_b) return 0;
    return memcmp((char*)a + 16, (char*)b + 16, len_a) == 0 ? 1 : 0;
}

int64_t sutra_str_compare(void* a, void* b) {
    if (a == b) return 0;
    if (!a) return -1;
    if (!b) return 1;

    extern int sutra_native_is_string(void* ptr);
    if (!sutra_native_is_string(a) || !sutra_native_is_string(b)) {
        return (intptr_t)a - (intptr_t)b;
    }

    int64_t len_a = *((int64_t*)((char*)a + 8));
    int64_t len_b = *((int64_t*)((char*)b + 8));
    int64_t min_len = len_a < len_b ? len_a : len_b;
    int cmp = memcmp((char*)a + 16, (char*)b + 16, min_len);
    if (cmp != 0) return cmp;
    if (len_a < len_b) return -1;
    if (len_a > len_b) return 1;
    return 0;
}

static int64_t sutra_utf8_codepoint_count_bytes(const unsigned char* data, int64_t len) {
    int64_t count = 0;
    int64_t i = 0;
    while (i < len) {
        unsigned char c = data[i];
        if (c < 0x80) i += 1;
        else if ((c & 0xE0) == 0xC0) i += 2;
        else if ((c & 0xF0) == 0xE0) i += 3;
        else if ((c & 0xF8) == 0xF0) i += 4;
        else i += 1;
        ++count;
    }
    return count;
}

static int64_t sutra_utf8_codepoints_before_byte(const unsigned char* data, int64_t len, int64_t byte_pos) {
    int64_t count = 0;
    int64_t i = 0;
    while (i < len && i < byte_pos) {
        unsigned char c = data[i];
        if (c < 0x80) i += 1;
        else if ((c & 0xE0) == 0xC0) i += 2;
        else if ((c & 0xF0) == 0xE0) i += 3;
        else if ((c & 0xF8) == 0xF0) i += 4;
        else i += 1;
        ++count;
    }
    return count;
}

static int64_t sutra_utf8_byte_index_for_codepoint(const unsigned char* data, int64_t len, int64_t cp_index) {
    int64_t count = 0;
    int64_t i = 0;
    while (i < len) {
        int64_t start = i;
        unsigned char c = data[i];
        if (c < 0x80) i += 1;
        else if ((c & 0xE0) == 0xC0) i += 2;
        else if ((c & 0xF0) == 0xE0) i += 3;
        else if ((c & 0xF8) == 0xF0) i += 4;
        else i += 1;
        if (count == cp_index) return start;
        ++count;
    }
    return len;
}

static int64_t sutra_utf8_codepoint_at_byte(const unsigned char* data, int64_t len, int64_t byte_index) {
    int64_t i = 0;
    while (i < len && i < byte_index) {
        unsigned char c = data[i];
        if (c < 0x80) i += 1;
        else if ((c & 0xE0) == 0xC0) i += 2;
        else if ((c & 0xF0) == 0xE0) i += 3;
        else if ((c & 0xF8) == 0xF0) i += 4;
        else i += 1;
    }
    return i;
}

static int sutra_is_unicode_whitespace(uint32_t cp) {
    return cp == ' ' || cp == '\t' || cp == '\n' || cp == '\r' || cp == 0x00A0 || cp == 0x1680 ||
           (cp >= 0x2000 && cp <= 0x200A) || cp == 0x2028 || cp == 0x2029 || cp == 0x202F ||
           cp == 0x205F || cp == 0x3000;
}

static void* sutra_utf8_substr_raw(const unsigned char* data, int64_t len, int64_t start, int64_t end) {
    if (start < 0 || end < 0) {
        sutra_throw_str("त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)");
    }
    int64_t total_cp = sutra_utf8_codepoint_count_bytes(data, len);
    if (start > total_cp || end > total_cp) {
        sutra_throw_str("त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)");
    }
    if (start > end) {
        sutra_throw_str("त्रुटिः — आरंभः अन्त्यतः अधिकः अस्ति (start > end)");
    }
    if (start == end) return sutra_str_alloc("", 0);

    int64_t byte_start = 0;
    int64_t byte_end = len;
    int64_t cp = 0;
    int64_t i = 0;
    while (i < len) {
        int64_t prev = i;
        unsigned char c = data[i];
        if (c < 0x80) i += 1;
        else if ((c & 0xE0) == 0xC0) i += 2;
        else if ((c & 0xF0) == 0xE0) i += 3;
        else if ((c & 0xF8) == 0xF0) i += 4;
        else i += 1;
        if (cp == start) byte_start = prev;
        if (cp == end) {
            byte_end = prev;
            break;
        }
        ++cp;
    }
    if (byte_end == len && end == total_cp) byte_end = len;
    return sutra_str_alloc((const char*)data + byte_start, byte_end - byte_start);
}

void* sutra_substr(void* text, int64_t start, int64_t end) {
    if (!text) return sutra_str_alloc("", 0);
    int64_t len = *((int64_t*)((char*)text + 8));
    const unsigned char* data = (const unsigned char*)text + 16;
    return sutra_utf8_substr_raw(data, len, start, end);
}

int64_t sutra_find(void* text, void* needle) {
    int sutra_native_is_string(void* ptr);
    int64_t sutra_list_find(void* arr, int64_t val);
    if (!text) return -1;
    if (sutra_native_is_string(text)) {
        if (!needle) return -1;
        int64_t hay_len = *((int64_t*)((char*)text + 8));
        int64_t needle_len = *((int64_t*)((char*)needle + 8));
        const unsigned char* hay = (const unsigned char*)text + 16;
        const unsigned char* need = (const unsigned char*)needle + 16;
        if (needle_len == 0) {
            sutra_throw_str("त्रुटिः — खोजें: रिक्त खोज पाठ मान्य न अस्ति।");
        }
        for (int64_t pos = 0; pos + needle_len <= hay_len; ++pos) {
            if (memcmp(hay + pos, need, (size_t)needle_len) == 0) {
                return sutra_utf8_codepoints_before_byte(hay, hay_len, pos);
            }
        }
        return -1;
    } else {
        return sutra_list_find(text, (int64_t)needle);
    }
}

void* sutra_replace(void* text, void* needle, void* replacement) {
    if (!text || !needle || !replacement) {
        sutra_throw_str("त्रुटिः — बदलें में शून्य पाठ मान्य नहीं है");
    }
    int64_t hay_len = *((int64_t*)((char*)text + 8));
    int64_t needle_len = *((int64_t*)((char*)needle + 8));
    const unsigned char* hay = (const unsigned char*)text + 16;
    const unsigned char* need = (const unsigned char*)needle + 16;
    const unsigned char* repl = (const unsigned char*)replacement + 16;
    int64_t repl_len = *((int64_t*)((char*)replacement + 8));

    if (needle_len == 0) {
        sutra_throw_str("त्रुटिः — बदलें: रिक्त खोज पाठ मान्य न अस्ति।");
    }

    for (int64_t pos = 0; pos + needle_len <= hay_len; ++pos) {
        if (memcmp(hay + pos, need, (size_t)needle_len) == 0) {
            int64_t prefix_len = pos;
            int64_t suffix_len = hay_len - (pos + needle_len);
            int64_t out_len = prefix_len + repl_len + suffix_len;
            void* out = sutra_str_alloc(NULL, out_len);
            char* out_data = (char*)out + 16;
            if (prefix_len > 0) memcpy(out_data, hay, (size_t)prefix_len);
            if (repl_len > 0) memcpy(out_data + prefix_len, repl, (size_t)repl_len);
            if (suffix_len > 0) memcpy(out_data + prefix_len + repl_len, hay + pos + needle_len, (size_t)suffix_len);
            return out;
        }
    }
    return text;
}

void* sutra_split(void* text, void* delim) {
    if (!text || !delim) {
        sutra_throw_str("त्रुटिः — विभाजित के तर्क शून्य नहीं हो सकते");
    }
    int64_t hay_len = *((int64_t*)((char*)text + 8));
    int64_t delim_len = *((int64_t*)((char*)delim + 8));
    const unsigned char* hay = (const unsigned char*)text + 16;
    const unsigned char* d = (const unsigned char*)delim + 16;
    if (delim_len == 0) {
        sutra_throw_str("त्रुटिः — विभाजित: रिक्त विभाजक मान्य न अस्ति।");
    }

    int64_t count = 1;
    int64_t pos = 0;
    while (pos + delim_len <= hay_len) {
        if (memcmp(hay + pos, d, (size_t)delim_len) == 0) {
            ++count;
            pos += delim_len;
        } else {
            ++pos;
        }
    }

    void* arr = sutra_arr_create(count);
    int64_t idx = 0;
    int64_t start = 0;
    while (start <= hay_len) {
        int64_t next = start;
        while (next + delim_len <= hay_len && memcmp(hay + next, d, (size_t)delim_len) != 0) {
            ++next;
        }
        if (next + delim_len > hay_len) {
            next = hay_len;
        }
        void* part = sutra_str_alloc((const char*)hay + start, next - start);
        sutra_arr_set(arr, idx, (int64_t)part);
        ++idx;
        if (next + delim_len > hay_len) break;
        start = next + delim_len;
    }
    return arr;
}

void* sutra_join(void* list, void* sep) {
    if (!list) return sutra_str_alloc("", 0);
    int64_t count = *((int64_t*)((char*)list + 8));
    const unsigned char* delim = sep ? ((const unsigned char*)sep + 16) : (const unsigned char*)"";
    int64_t delim_len = sep ? *((int64_t*)((char*)sep + 8)) : 0;

    int64_t total = 0;
    for (int64_t i = 0; i < count; ++i) {
        int64_t elem_ptr = *((int64_t*)((char*)list + 16 + i * 8));
        if ((uint64_t)elem_ptr < 65536) {
            sutra_throw_str("त्रुटिः — संयोजित में सूची के सभी तत्व पाठ होने चाहिए।");
        }
        int64_t elem_len = *((int64_t*)((char*)(void*)elem_ptr + 8));
        total += elem_len;
        if (i + 1 < count) total += delim_len;
    }

    void* out = sutra_str_alloc(NULL, total);
    char* out_data = (char*)out + 16;
    int64_t pos = 0;
    for (int64_t i = 0; i < count; ++i) {
        int64_t elem_ptr = *((int64_t*)((char*)list + 16 + i * 8));
        int64_t elem_len = *((int64_t*)((char*)(void*)elem_ptr + 8));
        const unsigned char* elem_data = (const unsigned char*)(void*)elem_ptr + 16;
        if (elem_len > 0) memcpy(out_data + pos, elem_data, (size_t)elem_len), pos += elem_len;
        if (i + 1 < count && delim_len > 0) memcpy(out_data + pos, delim, (size_t)delim_len), pos += delim_len;
    }
    return out;
}

void* sutra_trim(void* text) {
    if (!text) return sutra_str_alloc("", 0);
    int64_t len = *((int64_t*)((char*)text + 8));
    const unsigned char* data = (const unsigned char*)text + 16;

    typedef struct { int64_t start; int64_t end; uint32_t cp; } Span;
    int64_t cp_count = 0;
    int64_t i = 0;
    while (i < len) {
        int64_t start = i;
        uint32_t cp = 0;
        unsigned char c = data[i];
        if (c < 0x80) { cp = c; i += 1; }
        else if ((c & 0xE0) == 0xC0 && i + 1 < len) { cp = ((uint32_t)(c & 0x1F) << 6) | (data[i + 1] & 0x3F); i += 2; }
        else if ((c & 0xF0) == 0xE0 && i + 2 < len) { cp = ((uint32_t)(c & 0x0F) << 12) | ((uint32_t)(data[i + 1] & 0x3F) << 6) | (data[i + 2] & 0x3F); i += 3; }
        else if ((c & 0xF8) == 0xF0 && i + 3 < len) { cp = ((uint32_t)(c & 0x07) << 18) | ((uint32_t)(data[i + 1] & 0x3F) << 12) | ((uint32_t)(data[i + 2] & 0x3F) << 6) | (data[i + 3] & 0x3F); i += 4; }
        else { cp = c; i += 1; }
        ++cp_count;
    }

    Span* spans = (Span*)malloc((size_t)cp_count * sizeof(Span));
    if (!spans) { sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (trim)"); }

    int64_t j = 0;
    i = 0;
    while (i < len) {
        int64_t start = i;
        uint32_t cp = 0;
        unsigned char c = data[i];
        if (c < 0x80) { cp = c; i += 1; }
        else if ((c & 0xE0) == 0xC0 && i + 1 < len) { cp = ((uint32_t)(c & 0x1F) << 6) | (data[i + 1] & 0x3F); i += 2; }
        else if ((c & 0xF0) == 0xE0 && i + 2 < len) { cp = ((uint32_t)(c & 0x0F) << 12) | ((uint32_t)(data[i+1] & 0x3F) << 6) | (data[i + 2] & 0x3F); i += 3; }
        else if ((c & 0xF8) == 0xF0 && i + 3 < len) { cp = ((uint32_t)(c & 0x07) << 18) | ((uint32_t)(data[i+1] & 0x3F) << 12) | ((uint32_t)(data[i+2] & 0x3F) << 6) | (data[i + 3] & 0x3F); i += 4; }
        else { cp = c; i += 1; }
        spans[j].start = start;
        spans[j].end = i;
        spans[j].cp = cp;
        ++j;
    }

    int64_t first = 0;
    while (first < cp_count && sutra_is_unicode_whitespace(spans[first].cp)) ++first;
    int64_t last = cp_count;
    while (last > first && sutra_is_unicode_whitespace(spans[last - 1].cp)) --last;

    if (first == last) {
        free(spans);
        return sutra_str_alloc("", 0);
    }

    int64_t start_byte = spans[first].start;
    int64_t end_byte = spans[last - 1].end;
    int64_t trimmed_len = end_byte - start_byte;
    free(spans);
    return sutra_str_alloc((const char*)data + start_byte, trimmed_len);
}

int64_t sutra_starts_with(void* text, void* prefix) {
    if (!text || !prefix) return 1;
    int64_t text_len = *((int64_t*)((char*)text + 8));
    int64_t prefix_len = *((int64_t*)((char*)prefix + 8));
    const unsigned char* text_data = (const unsigned char*)text + 16;
    const unsigned char* prefix_data = (const unsigned char*)prefix + 16;
    if (prefix_len == 0) return 1;
    if (text_len < prefix_len) return 0;
    return memcmp(text_data, prefix_data, (size_t)prefix_len) == 0 ? 1 : 0;
}

int64_t sutra_ends_with(void* text, void* suffix) {
    if (!text || !suffix) return 1;
    int64_t text_len = *((int64_t*)((char*)text + 8));
    int64_t suffix_len = *((int64_t*)((char*)suffix + 8));
    const unsigned char* text_data = (const unsigned char*)text + 16;
    const unsigned char* suffix_data = (const unsigned char*)suffix + 16;
    if (suffix_len == 0) return 1;
    if (text_len < suffix_len) return 0;
    return memcmp(text_data + text_len - suffix_len, suffix_data, (size_t)suffix_len) == 0 ? 1 : 0;
}

int64_t sutra_math_sqrt(int64_t v) {
    return (int64_t)llround(sqrt((double)v));
}

int64_t sutra_math_pow(int64_t base, int64_t exp) {
    int64_t result = 1;
    int64_t e = exp;
    int64_t b = base;
    if (e < 0) {
        return 0;
    }
    while (e > 0) {
        if (e & 1) result *= b;
        b *= b;
        e >>= 1;
    }
    return result;
}

int64_t sutra_math_abs(int64_t v) {
    return v < 0 ? -v : v;
}

int64_t sutra_math_min(int64_t a, int64_t b) {
    return a < b ? a : b;
}

int64_t sutra_math_max(int64_t a, int64_t b) {
    return a > b ? a : b;
}

int64_t sutra_math_round(int64_t v) {
    return v;
}

void* sutra_list_append(void* arr, int64_t val) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर जोड़ना असंभव");
    }

    int64_t capacity = *((int64_t*)arr);
    int64_t count = *((int64_t*)((char*)arr + 8));

    if (count < capacity) {
        int64_t* elements = (int64_t*)((char*)arr + 16);
        elements[count] = val;
        *((int64_t*)((char*)arr + 8)) = count + 1;
        return arr;
    } else {
        int64_t new_cap = capacity == 0 ? 4 : capacity * 2;
#ifdef USE_LEGACY_RUNTIME
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (!new_block) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (list append)");
        }
        gc_update_alloc(arr, new_block, 16 + new_cap * 8);
#else
        void* new_block = sutra_native_realloc(arr, 16 + new_cap * 8);
#endif
        arr = new_block;
        *((int64_t*)arr) = new_cap;
        *((int64_t*)((char*)arr + 8)) = count + 1;

        int64_t* elements = (int64_t*)((char*)arr + 16);
        elements[count] = val;
        return arr;
    }
}

void* sutra_list_pop(void* arr) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची से तत्व नहीं निकाला जा सकता।");
    }
    int64_t capacity = *((int64_t*)arr);
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (count <= 0) {
        sutra_throw_str("त्रुटिः — शून्य सूची से तत्व नहीं निकाला जा सकता।");
    }

    int64_t* elements = (int64_t*)((char*)arr + 16);
    elements[count - 1] = 0;
    count--;
    *((int64_t*)((char*)arr + 8)) = count;

    // Check shrink
    if (count <= capacity / 4 && capacity > 4) {
        int64_t new_cap = capacity / 2;
        if (new_cap < 4) new_cap = 4;
#ifdef USE_LEGACY_RUNTIME
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            gc_update_alloc(arr, new_block, 16 + new_cap * 8);
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
#else
        void* new_block = sutra_native_realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
#endif
    }
    return arr;
}

void* sutra_list_insert(void* arr, int64_t idx, int64_t val) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर डालना असंभव");
    }
    int64_t capacity = *((int64_t*)arr);
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (idx < 0 || idx > count) {
        sutra_throw_str("त्रुटिः — डालें: सूचकांक सीमा से बाहर");
    }

    if (count < capacity) {
        int64_t* elements = (int64_t*)((char*)arr + 16);
        for (int64_t i = count; i > idx; --i) {
            elements[i] = elements[i - 1];
        }
        elements[idx] = val;
        *((int64_t*)((char*)arr + 8)) = count + 1;
        return arr;
    } else {
        int64_t new_cap = capacity == 0 ? 4 : capacity * 2;
#ifdef USE_LEGACY_RUNTIME
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (!new_block) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (list insert)");
        }
        gc_update_alloc(arr, new_block, 16 + new_cap * 8);
#else
        void* new_block = sutra_native_realloc(arr, 16 + new_cap * 8);
#endif
        arr = new_block;
        *((int64_t*)arr) = new_cap;
        *((int64_t*)((char*)arr + 8)) = count + 1;

        int64_t* elements = (int64_t*)((char*)arr + 16);
        for (int64_t i = count; i > idx; --i) {
            elements[i] = elements[i - 1];
        }
        elements[idx] = val;
        return arr;
    }
}

void* sutra_list_remove(void* arr, int64_t idx) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची से तत्व हटाना असंभव");
    }
    int64_t capacity = *((int64_t*)arr);
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (idx < 0 || idx >= count) {
        sutra_throw_str("त्रुटिः — हटाएं: सूचकांक सीमा से बाहर");
    }

    int64_t* elements = (int64_t*)((char*)arr + 16);
    for (int64_t i = idx; i < count - 1; ++i) {
        elements[i] = elements[i + 1];
    }
    elements[count - 1] = 0;
    count--;
    *((int64_t*)((char*)arr + 8)) = count;

    // Check shrink
    if (count <= capacity / 4 && capacity > 4) {
        int64_t new_cap = capacity / 2;
        if (new_cap < 4) new_cap = 4;
#ifdef USE_LEGACY_RUNTIME
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            gc_update_alloc(arr, new_block, 16 + new_cap * 8);
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
#else
        void* new_block = sutra_native_realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
#endif
    }
    return arr;
}

void* sutra_list_concat(void* arr1, void* arr2) {
    int64_t count1 = arr1 ? *((int64_t*)((char*)arr1 + 8)) : 0;
    int64_t count2 = arr2 ? *((int64_t*)((char*)arr2 + 8)) : 0;
    void* new_arr = sutra_arr_create(count1 + count2);
    if (count1 > 0) {
        memcpy((char*)new_arr + 16, (char*)arr1 + 16, count1 * 8);
    }
    if (count2 > 0) {
        memcpy((char*)new_arr + 16 + count1 * 8, (char*)arr2 + 16, count2 * 8);
    }
    return new_arr;
}

int64_t sutra_list_find(void* arr, int64_t val) {
    if (!arr) return -1;
    int64_t count = *((int64_t*)((char*)arr + 8));
    int64_t* elements = (int64_t*)((char*)arr + 16);
    for (int64_t i = 0; i < count; ++i) {
        if (elements[i] == val) {
            return i;
        }
    }
    return -1;
}


static void* sutra_str_map_case(void* s, int upper) {
    if (!s) return sutra_str_alloc("", 0);

    int64_t len = *((int64_t*)((char*)s + 8));
    const unsigned char* data = (const unsigned char*)s + 16;
    void* out = sutra_str_alloc(NULL, len);
    char* out_data = (char*)out + 16;

    for (int64_t i = 0; i < len; ++i) {
        unsigned char c = data[i];
        if (c >= 'a' && c <= 'z') {
            out_data[i] = upper ? (char)(c - 'a' + 'A') : (char)c;
        } else if (c >= 'A' && c <= 'Z') {
            out_data[i] = upper ? (char)c : (char)(c - 'A' + 'a');
        } else {
            out_data[i] = (char)c;
        }
    }
    return out;
}

int64_t sutra_str_upper(void* s) {
    return (int64_t)sutra_str_map_case(s, 1);
}

int64_t sutra_str_lower(void* s) {
    return (int64_t)sutra_str_map_case(s, 0);
}

static int64_t sutra_utf8_cmp_codepoints(void* a, void* b) {
    if (!a || !b) {
        if (!a && !b) return 0;
        return a ? 1 : -1;
    }

    const unsigned char* data_a = (const unsigned char*)a + 16;
    const unsigned char* data_b = (const unsigned char*)b + 16;
    int64_t len_a = *((int64_t*)((char*)a + 8));
    int64_t len_b = *((int64_t*)((char*)b + 8));
    int64_t i = 0;
    int64_t j = 0;

    while (i < len_a && j < len_b) {
        int64_t ai = i;
        int64_t bj = j;
        uint32_t ca = 0;
        uint32_t cb = 0;

        if (data_a[i] < 0x80) {
            ca = data_a[i++];
        } else if ((data_a[i] & 0xE0) == 0xC0 && i + 1 < len_a) {
            ca = ((uint32_t)(data_a[i] & 0x1F) << 6) |
                 (uint32_t)(data_a[i + 1] & 0x3F);
            i += 2;
        } else if ((data_a[i] & 0xF0) == 0xE0 && i + 2 < len_a) {
            ca = ((uint32_t)(data_a[i] & 0x0F) << 12) |
                 ((uint32_t)(data_a[i + 1] & 0x3F) << 6) |
                 (uint32_t)(data_a[i + 2] & 0x3F);
            i += 3;
        } else if ((data_a[i] & 0xF8) == 0xF0 && i + 3 < len_a) {
            ca = ((uint32_t)(data_a[i] & 0x07) << 18) |
                 ((uint32_t)(data_a[i + 1] & 0x3F) << 12) |
                 ((uint32_t)(data_a[i + 2] & 0x3F) << 6) |
                 (uint32_t)(data_a[i + 3] & 0x3F);
            i += 4;
        } else {
            ca = data_a[i++];
        }

        if (data_b[j] < 0x80) {
            cb = data_b[j++];
        } else if ((data_b[j] & 0xE0) == 0xC0 && j + 1 < len_b) {
            cb = ((uint32_t)(data_b[j] & 0x1F) << 6) |
                 (uint32_t)(data_b[j + 1] & 0x3F);
            j += 2;
        } else if ((data_b[j] & 0xF0) == 0xE0 && j + 2 < len_b) {
            cb = ((uint32_t)(data_b[j] & 0x0F) << 12) |
                 ((uint32_t)(data_b[j + 1] & 0x3F) << 6) |
                 (uint32_t)(data_b[j + 2] & 0x3F);
            j += 3;
        } else if ((data_b[j] & 0xF8) == 0xF0 && j + 3 < len_b) {
            cb = ((uint32_t)(data_b[j] & 0x07) << 18) |
                 ((uint32_t)(data_b[j + 1] & 0x3F) << 12) |
                 ((uint32_t)(data_b[j + 2] & 0x3F) << 6) |
                 (uint32_t)(data_b[j + 3] & 0x3F);
            j += 4;
        } else {
            cb = data_b[j++];
        }

        if (ca != cb) return (ca < cb) ? -1 : 1;
    }

    if (i == len_a && j == len_b) return 0;
    return (i == len_a) ? -1 : 1;
}

int64_t sutra_str_less(void* a, void* b) {
    return sutra_utf8_cmp_codepoints(a, b) < 0 ? 1 : 0;
}

int64_t sutra_str_greater(void* a, void* b) {
    return sutra_utf8_cmp_codepoints(a, b) > 0 ? 1 : 0;
}

int64_t sutra_str_less_equal(void* a, void* b) {
    return sutra_utf8_cmp_codepoints(a, b) <= 0 ? 1 : 0;
}

int64_t sutra_str_greater_equal(void* a, void* b) {
    return sutra_utf8_cmp_codepoints(a, b) >= 0 ? 1 : 0;
}

/* Return UTF-8 character count (number of Unicode codepoints) */
int64_t sutra_str_length(void* s) {
    if (!s) return 0;

    const unsigned char* data = (const unsigned char*)s + 16;
    int64_t len = *((int64_t*)((char*)s + 8));
    int64_t count = 0;

    for (int64_t i = 0; i < len; ) {
        unsigned char c = data[i];
        if (c < 0x80) {
            i += 1;
        } else if ((c & 0xE0) == 0xC0) {
            i += 2;
        } else if ((c & 0xF0) == 0xE0) {
            i += 3;
        } else if ((c & 0xF8) == 0xF0) {
            i += 4;
        } else {
            i += 1;
        }
        ++count;
    }

    return count;
}

/* Return the UTF-8 codepoint at position index as a new Sutra string. */
void* sutra_str_get(void* s, int64_t idx) {
    if (!s) {
        sutra_throw_str("त्रुटिः — शून्य पाठ पर सूचकांक प्रयास");
    }
    if (idx < 0) {
        sutra_throw_str("त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)");
    }

    const unsigned char* data = (const unsigned char*)s + 16;
    int64_t len = *((int64_t*)((char*)s + 8));
    int64_t count = 0;
    int64_t i = 0;
    int64_t start = 0;
    int64_t end = 0;

    /* अनुक्रमिक पहुँच cache: लेक्सर 0,1,2,... क्रम में पढ़ता है →
       हर बार शुरू से UTF-8 डिकोड करने के बजाय पिछली स्थिति से आगे बढ़ो */
    if (s == sg_cache_str && idx >= sg_cache_char_idx) {
        i = sg_cache_byte_off;
        count = sg_cache_char_idx;
    }

    for (; i < len; ) {
        start = i;
        unsigned char c = data[i];
        if (c < 0x80) {
            i += 1;
        } else if ((c & 0xE0) == 0xC0) {
            i += 2;
        } else if ((c & 0xF0) == 0xE0) {
            i += 3;
        } else if ((c & 0xF8) == 0xF0) {
            i += 4;
        } else {
            i += 1;
        }
        end = i;
        if (count == idx) {
            sg_cache_str = s;
            sg_cache_char_idx = count;
            sg_cache_byte_off = start;
            int64_t char_len = end - start;
            return sutra_str_alloc((const char*)data + start, char_len);
        }
        ++count;
    }

    sutra_throw_str("त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)");
    return sutra_str_alloc("", 0);
}

/* Print a string (UTF-8 safe via fwrite) */
void sutra_str_print(void* s) {
    if (!s) {
        printf("शून्यम्\n");
        return;
    }
    int64_t len = *((int64_t*)((char*)s + 8));
    char* data = (char*)s + 16;
    fwrite(data, 1, len, stdout);
    printf("\n");
    fflush(stdout);
}

/* ============================================================
 * ARRAY RUNTIME
 * Memory layout: [int64_t element_count] [int64_t elem_0] [int64_t elem_1] ...
 * The pointer points to the element_count field.
 * ============================================================ */

/* Allocate an array of n int64 elements (initialized to 0) */
void* sutra_arr_create(int64_t n) {
#ifdef USE_LEGACY_RUNTIME
    char* block = (char*)malloc(16 + n * 8);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (array alloc)");
    }
    *((int64_t*)block) = n; // capacity
    *((int64_t*)(block + 8)) = n; // count
    /* Zero-initialize elements */
    memset(block + 16, 0, n * 8);
    gc_register_alloc(block, 16 + n * 8, GC_TYPE_ARRAY);
    return block;
#else
    void* block = sutra_native_alloc(16 + n * 8, GC_TYPE_ARRAY);
    *((int64_t*)block) = n; // capacity
    *((int64_t*)((char*)block + 8)) = n; // count
    /* Zero-initialize elements */
    memset((char*)block + 16, 0, n * 8);
    return block;
#endif
}

int64_t sutra_dict_get(void* dict, void* key);
void sutra_dict_set(void* dict, void* key, int64_t val);
int sutra_is_dict(void* ptr);

/* Bounds-checked array read */
int64_t sutra_arr_get(void* arr, int64_t idx) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर सूचकांक प्रयास");
    }
    if (sutra_native_is_string(arr)) {
        return (int64_t)sutra_substr(arr, idx, idx + 1);
    }
    if (sutra_is_dict(arr)) {
        return sutra_dict_get(arr, (void*)idx);
    }
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (idx < 0 || idx >= count) {
        sutra_throw_str("त्रुटिः — सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)");
    }
    int64_t* elements = (int64_t*)((char*)arr + 16);
    return elements[idx];
}

/* Bounds-checked array write */
void sutra_arr_set(void* arr, int64_t idx, int64_t val) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर सूचकांक प्रयास");
    }
    if (sutra_is_dict(arr)) {
        sutra_dict_set(arr, (void*)idx, val);
        return;
    }
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (idx < 0 || idx >= count) {
        sutra_throw_str("त्रुटिः — सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)");
    }
    int64_t* elements = (int64_t*)((char*)arr + 16);
    elements[idx] = val;
}

int sutra_is_dict(void* ptr) {
#ifdef USE_LEGACY_RUNTIME
    size_t idx = gc_hash_get(ptr);
    return (idx != GC_HASH_NONE && gc_allocs[idx].type == GC_TYPE_DICTIONARY) ? 1 : 0;
#else
    return sutra_native_is_dict(ptr);
#endif
}

int64_t sutra_arr_length(void* arr) {
    if (!arr) return 0;
    if (sutra_is_dict(arr)) {
        return *((int64_t*)arr);
    }
    return *((int64_t*)((char*)arr + 8));
}

int64_t sutra_dynamic_length(void* obj) {
    if (!obj) return 0;
    if (sutra_native_is_string(obj)) {
        return sutra_str_length(obj);
    }
    return sutra_arr_length(obj);
}

/* ============================================================
 * OBJECT RUNTIME
 * ============================================================ */

void* sutra_obj_alloc(int64_t field_count) {
#ifdef USE_LEGACY_RUNTIME
    char* block = (char*)malloc(16 + field_count * 8);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (object alloc)");
    }
    *((int64_t*)block) = field_count; // capacity
    *((int64_t*)(block + 8)) = field_count; // count
    memset(block + 16, 0, field_count * 8);
    gc_register_alloc(block, 16 + field_count * 8, GC_TYPE_OBJECT);
    return block;
#else
    void* block = sutra_native_alloc(16 + field_count * 8, GC_TYPE_OBJECT);
    *((int64_t*)block) = field_count; // capacity
    *((int64_t*)((char*)block + 8)) = field_count; // count
    memset((char*)block + 16, 0, field_count * 8);
    return block;
#endif
}

/* ============================================================
 * NULL RUNTIME
 * ============================================================ */

void sutra_print_null(void) {
    printf("शून्यम्\n");
    fflush(stdout);
}

void sutra_print_bool(int64_t v) {
    if (v) {
        printf("सत्य\n");
    } else {
        printf("असत्य\n");
    }
    fflush(stdout);
}

/* ============================================================
 * DICTIONARY RUNTIME
 * ============================================================ */

/* Memory layout:
 * A dictionary block is 24 bytes:
 * int64_t count; (8 bytes)
 * int64_t capacity; (8 bytes)
 * void* entries; (8 bytes pointer to array of 16-byte entries)
 */
void* sutra_dict_create(void) {
#ifdef USE_LEGACY_RUNTIME
    char* dict = (char*)malloc(24);
    if (!dict) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (dict alloc)");
    }
    int64_t initial_cap = 4;
    void* entries = malloc(initial_cap * 16);
    if (!entries) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (dict entries alloc)");
    }
    *((int64_t*)dict) = 0;
    *((int64_t*)(dict + 8)) = initial_cap;
    *((void**)(dict + 16)) = entries;
    gc_register_alloc(dict, 24, GC_TYPE_DICTIONARY);
    return dict;
#else
    void* dict = sutra_native_alloc(24, GC_TYPE_DICTIONARY);
    int64_t initial_cap = 4;
    void* entries = malloc(initial_cap * 16);
    if (!entries) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (dict entries alloc)");
    }
    *((int64_t*)dict) = 0;
    *((int64_t*)((char*)dict + 8)) = initial_cap;
    *((void**)((char*)dict + 16)) = entries;
    return dict;
#endif
}

int64_t sutra_dict_get(void* dict, void* key) {
    if (!dict) return 0;
    int64_t count = *((int64_t*)dict);
    char* entries = (char*)(*((void**)((char*)dict + 16)));
    for (int64_t i = 0; i < count; i++) {
        void* k = *((void**)(entries + i * 16));
        if (sutra_str_equal(k, key)) {
            return *((int64_t*)(entries + i * 16 + 8));
        }
    }
    return 0; /* null (शून्यम्) */
}

void sutra_dict_set(void* dict, void* key, int64_t val) {
    if (!dict) {
        sutra_throw_str("त्रुटिः — शून्य शब्दकोश पर सेट प्रयास");
    }
    int64_t count = *((int64_t*)dict);
    int64_t capacity = *((int64_t*)((char*)dict + 8));
    char* entries = (char*)(*((void**)((char*)dict + 16)));

    for (int64_t i = 0; i < count; i++) {
        void* k = *((void**)(entries + i * 16));
        if (sutra_str_equal(k, key)) {
            *((int64_t*)(entries + i * 16 + 8)) = val;
            return;
        }
    }

    if (count >= capacity) {
        int64_t new_cap = capacity * 2;
        char* new_entries = (char*)malloc(new_cap * 16);
        if (!new_entries) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (dict grow)");
        }
        memcpy(new_entries, entries, count * 16);
        free(entries);
        entries = new_entries;
        *((int64_t*)((char*)dict + 8)) = new_cap;
        *((void**)((char*)dict + 16)) = entries;
    }

    *((void**)(entries + count * 16)) = key;
    *((int64_t*)(entries + count * 16 + 8)) = val;
    *((int64_t*)dict) = count + 1;
}

int64_t sutra_dict_has_key(void* dict, void* key) {
    if (!dict) return 0;
    int64_t count = *((int64_t*)dict);
    char* entries = (char*)(*((void**)((char*)dict + 16)));
    for (int64_t i = 0; i < count; i++) {
        void* k = *((void**)(entries + i * 16));
        if (sutra_str_equal(k, key)) return 1;
    }
    return 0;
}

void* sutra_dict_keys(void* dict) {
    if (!dict) return sutra_arr_create(0);
    int64_t count = *((int64_t*)dict);
    void* arr = sutra_arr_create(count);
    char* entries = (char*)(*((void**)((char*)dict + 16)));
    for (int64_t i = 0; i < count; i++) {
        void* k = *((void**)(entries + i * 16));
        sutra_arr_set(arr, i, (int64_t)k);
    }
    return arr;
}

void* sutra_dict_remove(void* dict, void* key) {
    if (!dict) return dict;
    int64_t count = *((int64_t*)dict);
    char* entries = (char*)(*((void**)((char*)dict + 16)));

    for (int64_t i = 0; i < count; i++) {
        void* k = *((void**)(entries + i * 16));
        if (sutra_str_equal(k, key)) {
            /* Shift remaining entries left by 1 */
            for (int64_t j = i; j < count - 1; j++) {
                *((void**)(entries + j * 16)) = *((void**)(entries + (j + 1) * 16));
                *((int64_t*)(entries + j * 16 + 8)) = *((int64_t*)(entries + (j + 1) * 16 + 8));
            }
            *((int64_t*)dict) = count - 1;
            break;
        }
    }

    return dict;
}

/* ============================================================
 * FILE I/O RUNTIME
 * ============================================================ */

#ifdef _WIN32
static FILE* sutra_fopen_utf8(const char* path_utf8, const char* mode_utf8) {
    int len_path = MultiByteToWideChar(CP_UTF8, 0, path_utf8, -1, NULL, 0);
    int len_mode = MultiByteToWideChar(CP_UTF8, 0, mode_utf8, -1, NULL, 0);
    if (len_path <= 0 || len_mode <= 0) return NULL;
    wchar_t* wpath = (wchar_t*)malloc(len_path * sizeof(wchar_t));
    wchar_t* wmode = (wchar_t*)malloc(len_mode * sizeof(wchar_t));
    MultiByteToWideChar(CP_UTF8, 0, path_utf8, -1, wpath, len_path);
    MultiByteToWideChar(CP_UTF8, 0, mode_utf8, -1, wmode, len_mode);
    FILE* f = _wfopen(wpath, wmode);
    free(wpath);
    free(wmode);
    return f;
}
#define fopen(path, mode) sutra_fopen_utf8(path, mode)
#endif


int64_t sutra_file_exists(void* path_ptr) {
    if (!path_ptr) return 0;
    const char* path = (const char*)path_ptr + 16;
    FILE* f = sutra_fopen_utf8(path, "r");
    if (f) {
        fclose(f);
        return 1;
    }
    return 0;
}

int64_t sutra_command_run(void* cmd_ptr) {
    if (!cmd_ptr) return -1;
    const char* cmd = (const char*)cmd_ptr + 16;
#ifdef _WIN32
    int wlen = MultiByteToWideChar(CP_UTF8, 0, cmd, -1, NULL, 0);
    wchar_t* wcmd = (wchar_t*)malloc(wlen * sizeof(wchar_t));
    MultiByteToWideChar(CP_UTF8, 0, cmd, -1, wcmd, wlen);
    int res = _wsystem(wcmd);
    free(wcmd);
    return res;
#else
    return system(cmd);
#endif
}

void* sutra_file_read(void* path_ptr) {
    if (!path_ptr) return sutra_str_alloc("", 0);
    const char* path = (const char*)path_ptr + 16;
    FILE* f = sutra_fopen_utf8(path, "rb");
    if (!f) return sutra_str_alloc("", 0);
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);

    char* buf = (char*)malloc(size);
    if (!buf && size > 0) {
        fclose(f);
        return sutra_str_alloc("", 0);
    }
    size_t read_bytes = fread(buf, 1, size, f);
    fclose(f);

    void* str = sutra_str_alloc(buf, read_bytes);
    free(buf);
    return str;
}

int64_t sutra_file_write(void* path_ptr, void* content_ptr) {
    if (!path_ptr || !content_ptr) return 0;
    const char* path = (const char*)path_ptr + 16;
    const char* content = (const char*)content_ptr + 16;
    int64_t len = *((int64_t*)((char*)content_ptr + 8));

    FILE* f = sutra_fopen_utf8(path, "wb");
    if (!f) return 0;

    size_t written = fwrite(content, 1, len, f);
    fclose(f);

    return written == (size_t)len ? 1 : 0;
}

int sutra_argc = 0;
char** sutra_argv = NULL;

void sutra_init_args(int argc, char** argv) {
#ifdef _WIN32
    int wargc = 0;
    wchar_t** wargv = CommandLineToArgvW(GetCommandLineW(), &wargc);
    if (wargv) {
        sutra_argc = wargc;
        sutra_argv = (char**)malloc(wargc * sizeof(char*));
        for (int i = 0; i < wargc; ++i) {
            int len = WideCharToMultiByte(CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
            if (len > 0) {
                sutra_argv[i] = (char*)malloc(len);
                WideCharToMultiByte(CP_UTF8, 0, wargv[i], -1, sutra_argv[i], len, NULL, NULL);
            } else {
                sutra_argv[i] = "";
            }
        }
        LocalFree(wargv);
    } else {
        sutra_argc = argc;
        sutra_argv = argv;
    }
#else
    sutra_argc = argc;
    sutra_argv = argv;
#endif
}

void* sutra_args_get() {
    void* arr = sutra_arr_create(sutra_argc);
    for (int i = 0; i < sutra_argc; i++) {
        void* s = sutra_str_alloc(sutra_argv[i], strlen(sutra_argv[i]));
        sutra_arr_set(arr, i, (int64_t)s);
    }
    return arr;
}

// Self-hosting support - Unicode codepoint operations
int64_t sutra_char_ord(void* str) {
    if (!str) return -1;
    int64_t len = *((int64_t*)((char*)str + 8));
    if (len <= 0) return -1;
    const unsigned char* data = (const unsigned char*)((char*)str + 16);
    unsigned char c1 = data[0];
    if (c1 < 0x80) {
        return (int64_t)c1;
    } else if ((c1 & 0xE0) == 0xC0 && len >= 2) {
        return (int64_t)(((c1 & 0x1F) << 6) | (data[1] & 0x3F));
    } else if ((c1 & 0xF0) == 0xE0 && len >= 3) {
        return (int64_t)(((c1 & 0x0F) << 12) | ((data[1] & 0x3F) << 6) | (data[2] & 0x3F));
    } else if ((c1 & 0xF8) == 0xF0 && len >= 4) {
        return (int64_t)(((c1 & 0x07) << 18) | ((data[1] & 0x3F) << 12) | ((data[2] & 0x3F) << 6) | (data[3] & 0x3F));
    }
    return 0xFFFD;
}

void* sutra_char_chr(int64_t cp) {
    char buf[4];
    int len = 0;
    if (cp <= 0x7F) {
        buf[0] = (char)cp;
        len = 1;
    } else if (cp <= 0x7FF) {
        buf[0] = (char)(0xC0 | ((cp >> 6) & 0x1F));
        buf[1] = (char)(0x80 | (cp & 0x3F));
        len = 2;
    } else if (cp <= 0xFFFF) {
        buf[0] = (char)(0xE0 | ((cp >> 12) & 0x0F));
        buf[1] = (char)(0x80 | ((cp >> 6) & 0x3F));
        buf[2] = (char)(0x80 | (cp & 0x3F));
        len = 3;
    } else if (cp <= 0x10FFFF) {
        buf[0] = (char)(0xF0 | ((cp >> 18) & 0x07));
        buf[1] = (char)(0x80 | ((cp >> 12) & 0x3F));
        buf[2] = (char)(0x80 | ((cp >> 6) & 0x3F));
        buf[3] = (char)(0x80 | (cp & 0x3F));
        len = 4;
    } else {
        buf[0] = (char)0xEF; buf[1] = (char)0xBF; buf[2] = (char)0xBD;
        len = 3;
    }
    return sutra_str_alloc(buf, len);
}

// Float support runtime helper functions
#if 0
int64_t sutra_int_to_float(int64_t v) {
    double d = (double)v;
    int64_t res;
    memcpy(&res, &d, 8);
    return res;
}

int64_t sutra_float_to_int(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    return (int64_t)d;
}
#endif

void* sutra_float_to_str(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    char buf[64];
    snprintf(buf, sizeof(buf), "%f", d);
    char* dot = strchr(buf, '.');
    if (dot) {
        char* end = buf + strlen(buf) - 1;
        while (end > dot && *end == '0') {
            *end = '\0';
            end--;
        }
        if (*end == '.') {
            *end = '\0';
        }
    }
    return sutra_str_alloc(buf, strlen(buf));
}

void sutra_print_float(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    char buf[64];
    snprintf(buf, sizeof(buf), "%f", d);
    char* dot = strchr(buf, '.');
    if (dot) {
        char* end = buf + strlen(buf) - 1;
        while (end > dot && *end == '0') {
            *end = '\0';
            end--;
        }
        if (*end == '.') {
            *end = '\0';
        }
    }
    printf("%s\n", buf);
    fflush(stdout);
}

#if 0
int64_t sutra_float_add(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    double res = a + b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_float_sub(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    double res = a - b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_float_mul(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    double res = a * b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_float_div(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    if (b == 0.0) {
        sutra_throw_div_by_zero();
    }
    double res = a / b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_float_eq(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a == b ? 1 : 0;
}

int64_t sutra_float_ne(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a != b ? 1 : 0;
}

int64_t sutra_float_lt(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a < b ? 1 : 0;
}

int64_t sutra_float_gt(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a > b ? 1 : 0;
}

int64_t sutra_float_le(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a <= b ? 1 : 0;
}

int64_t sutra_float_ge(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    return a >= b ? 1 : 0;
}
#endif

int64_t sutra_math_sqrt_f(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    double res = sqrt(d);
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_math_pow_f(int64_t b_bits, int64_t e_bits) {
    double b, e;
    memcpy(&b, &b_bits, 8);
    memcpy(&e, &e_bits, 8);
    double res = pow(b, e);
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_math_abs_f(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    double res = fabs(d);
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_math_min_f(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    double res = a < b ? a : b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_math_max_f(int64_t a_bits, int64_t b_bits) {
    double a, b;
    memcpy(&a, &a_bits, 8);
    memcpy(&b, &b_bits, 8);
    double res = a > b ? a : b;
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
}

int64_t sutra_math_round_f(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    return (int64_t)llround(d);
}

#if defined(__x86_64__) || defined(_M_X64)
__asm__(
R"(
  .text

  .globl sutra_float_add
  .def sutra_float_add; .scl 2; .type 32; .endef
sutra_float_add:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  addsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_sub
  .def sutra_float_sub; .scl 2; .type 32; .endef
sutra_float_sub:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  subsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_mul
  .def sutra_float_mul; .scl 2; .type 32; .endef
sutra_float_mul:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  mulsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_div
  .def sutra_float_div; .scl 2; .type 32; .endef
sutra_float_div:
  movq %rdx, %xmm1
  xorpd %xmm2, %xmm2
  ucomisd %xmm2, %xmm1
  jne .Lfdiv_ok_inline
  jp .Lfdiv_ok_inline
  # b == 0.0, throw division by zero
  subq $40, %rsp
  call sutra_throw_div_by_zero
  addq $40, %rsp
.Lfdiv_ok_inline:
  movq %rcx, %xmm0
  divsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_eq
  .def sutra_float_eq; .scl 2; .type 32; .endef
sutra_float_eq:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  sete %al
  setnp %cl
  andb %cl, %al
  movzbq %al, %rax
  ret

  .globl sutra_float_ne
  .def sutra_float_ne; .scl 2; .type 32; .endef
sutra_float_ne:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  setne %al
  setp %cl
  orb %cl, %al
  movzbq %al, %rax
  ret

  .globl sutra_float_lt
  .def sutra_float_lt; .scl 2; .type 32; .endef
sutra_float_lt:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm0, %xmm1
  seta %al
  movzbq %al, %rax
  ret

  .globl sutra_float_gt
  .def sutra_float_gt; .scl 2; .type 32; .endef
sutra_float_gt:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  seta %al
  movzbq %al, %rax
  ret

  .globl sutra_float_le
  .def sutra_float_le; .scl 2; .type 32; .endef
sutra_float_le:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm0, %xmm1
  setae %al
  movzbq %al, %rax
  ret

  .globl sutra_float_ge
  .def sutra_float_ge; .scl 2; .type 32; .endef
sutra_float_ge:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  setae %al
  movzbq %al, %rax
  ret

  .globl sutra_int_to_float
  .def sutra_int_to_float; .scl 2; .type 32; .endef
sutra_int_to_float:
  cvtsi2sdq %rcx, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_to_int
  .def sutra_float_to_int; .scl 2; .type 32; .endef
sutra_float_to_int:
  movq %rcx, %xmm0
  cvttsd2siq %xmm0, %rax
  ret

  .globl sutra_gc_push_root
  .def sutra_gc_push_root; .scl 2; .type 32; .endef
sutra_gc_push_root:
  movl gc_roots_count(%rip), %eax
  cmpl $1000000, %eax
  jge .Lgc_push_overflow_inline
  leaq gc_roots(%rip), %rdx
  movslq %eax, %r8
  movq %rcx, (%rdx,%r8,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)
  ret
.Lgc_push_overflow_inline:
  movl $1, %ecx
  subq $32, %rsp
  call exit
  addq $32, %rsp
  ret

  .globl sutra_gc_pop_root
  .def sutra_gc_pop_root; .scl 2; .type 32; .endef
sutra_gc_pop_root:
  movl gc_roots_count(%rip), %eax
  testl %eax, %eax
  jle .Lgc_pop_done_inline
  decl %eax
  leaq gc_roots(%rip), %rdx
  movslq %eax, %r8
  cmpq %rcx, (%rdx,%r8,8)
  jne .Lgc_pop_mismatch_inline
  movl %eax, gc_roots_count(%rip)
.Lgc_pop_done_inline:
  ret
.Lgc_pop_mismatch_inline:
  movl $1, %ecx
  subq $32, %rsp
  call exit
  addq $32, %rsp
  ret

  .globl sutra_exception_pop
  .def sutra_exception_pop; .scl 2; .type 32; .endef
sutra_exception_pop:
  movl sutra_try_depth(%rip), %eax
  testl %eax, %eax
  jle .Lexcpop_done_inline
  decl %eax
  movl %eax, sutra_try_depth(%rip)
.Lexcpop_done_inline:
  ret

  .globl sutra_get_exception_value
  .def sutra_get_exception_value; .scl 2; .type 32; .endef
sutra_get_exception_value:
  movq sutra_active_exception(%rip), %rax
  ret
)"
);
#endif

#ifdef __cplusplus
}
#endif
