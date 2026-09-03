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

/* ============================================================
 * Sutra allocator + GC  (स्वसंकलक/निर्माण/मूल_आवंटक.सूत्र)
 * The heap now lives in a VirtualAlloc arena managed in Sutra;
 * every object carries a hidden 16-byte prefix [tm:8][size:8] so
 * type is read from p-16 — no registry, no hash.
 * ========================================================== */
extern void*   सूत्र_आवंटन(int64_t size, int64_t type);   /* -> p (= base+16) */
extern void*   सूत्र_पुनः_आवंटन(void* p, int64_t new_size);
extern void    सूत्र_मुक्त(void* p);
extern int64_t सूत्र_ब्लॉक_प्रकार(void* p);  /* 0 = none/free, 1 str, 2 arr, 3 obj, 4 dict */
extern void    सूत्र_संग्रह(void);
extern void    सूत्र_जीसी_दबाओ(void);   /* auto-GC suppress (multi-alloc window) */
extern void    सूत्र_जीसी_छोड़ो(void);
extern int64_t सूत्र_गण_चक्र(void);
extern int64_t सूत्र_गण_सक्रिय(void);
extern int64_t सूत्र_गण_संग्रहित(void);
extern int64_t सूत्र_गण_पुनःप्राप्त(void);

#define SR_STR  1
#define SR_ARR  2
#define SR_OBJ  3
#define SR_DICT 4

/* allocating string ops, now in मूल_रनटाइम.सूत्र */
extern void* पाठ_जोड़(void* a, void* b);
extern void* संख्या_से_पाठ(int64_t v);
extern void* बूल_से_पाठ(int64_t v);
extern void* शून्य_से_पाठ(void);
extern void* अक्षर_बना(int64_t cp);
extern void* पाठ_उपखंड(void* text, int64_t start, int64_t end);

/* print — now in मूल_रनटाइम.सूत्र (via तल.s WriteFile; no printf/fwrite/fflush) */
extern int64_t पाठ_छापो(void* s);
extern int64_t शून्य_छापो(void);
extern int64_t बूल_छापो(int64_t v);
extern int64_t गतिशील_छापो(int64_t val);

/* GC roots — the Sutra collector reads them through these */
int64_t sutra_gc_root_count(void) { return gc_roots_count; }
int64_t sutra_gc_root_deref(int64_t i) {
    if (i < 0 || i >= gc_roots_count) return 0;
    void** r = gc_roots[i];
    return r ? (int64_t)(intptr_t)*r : 0;
}
extern void* volatile sutra_active_exception;
int64_t sutra_gc_active_exc(void) { return (int64_t)(intptr_t)sutra_active_exception; }

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
    sg_cache_str = NULL;
    सूत्र_संग्रह();
}

void sutra_gc_status() {
    printf("चक्र: %lld\nसक्रिय: %lld\nसंग्रहित: %lld\n",
           (long long)सूत्र_गण_चक्र(),
           (long long)सूत्र_गण_सक्रिय(),
           (long long)सूत्र_गण_संग्रहित());
}

/* adapter over the Sutra allocator's hidden [tm][size] prefix.
 * scratch is safe — no caller holds the result across another call. */
static GCAllocation* find_gc_allocation(void* ptr) {
    static GCAllocation scratch;
    if (!ptr || (uintptr_t)ptr < 65536) return NULL;
    int64_t t = सूत्र_ब्लॉक_प्रकार(ptr);
    if (t < 1 || t > 4) return NULL;
    scratch.ptr = ptr;
    scratch.type = (GCType)(t - 1);   /* Sutra 1..4 -> enum STRING..DICT */
    scratch.size = 0;
    scratch.marked = 0;
    return &scratch;
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

void sutra_print_dynamic(int64_t val) { गतिशील_छापो(val); }  /* -> मूल_रनटाइम.सूत्र */

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
    char* block = (char*)सूत्र_आवंटन(16 + cap + 1, SR_STR);
    *((int64_t*)block) = cap;
    *((int64_t*)(block + 8)) = len;
    if (len > 0 && data) {
        memcpy(block + 16, data, len);
    }
    block[16 + len] = '\0';
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

void* sutra_int_to_str(int64_t v) { return संख्या_से_पाठ(v); }  /* -> मूल_रनटाइम.सूत्र */

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

void* sutra_bool_to_str(int64_t v) { return बूल_से_पाठ(v); }   /* -> मूल_रनटाइम.सूत्र */
void* sutra_null_to_str() { return शून्य_से_पाठ(); }           /* -> मूल_रनटाइम.सूत्र */

/* Concatenate two strings -> मूल_रनटाइम.सूत्र :: पाठ_जोड़ */
void* sutra_str_concat(void* a, void* b) { return पाठ_जोड़(a, b); }

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
    /* HOT PATH — lexer calls this per token; the Sutra पाठ_उपखंड version
       regressed self-compile ~40x (unoptimised Sutra + O(n) per call, no
       cache). Keep in C until the optimiser lands. पाठ_उपखंड stays defined
       in मूल_रनटाइम.सूत्र for when codegen can route to it cheaply. */
    if (!text) return sutra_str_alloc("", 0);
    int64_t len = *((int64_t*)((char*)text + 8));
    const unsigned char* data = (const unsigned char*)text + 16;
    return sutra_utf8_substr_raw(data, len, start, end);
}

/* ============================================================
 * STRING SEARCH / TRANSFORM  —  now in मूल_रनटाइम.सूत्र
 * ============================================================
 * find / replace / split / join / trim / starts_with / ends_with →
 * पाठ_कोडबिंदु_खोज / पाठ_बदल / पाठ_विभाजन / पाठ_संयोग / पाठ_छाँट /
 * पाठ_आरंभ_में / पाठ_अंत_में. Byte-level match (UTF-8 self-synchronising).
 * sutra_substr stays in C (lexer hot path).
 */
extern int64_t पाठ_कोडबिंदु_खोज(void* hay, void* needle);
extern void*   पाठ_बदल(void* hay, void* needle, void* repl);
extern void*   पाठ_विभाजन(void* hay, void* delim);
extern void*   पाठ_संयोग(void* list, void* sep);
extern void*   पाठ_छाँट(void* text);
extern int64_t पाठ_आरंभ_में(void* text, void* prefix);
extern int64_t पाठ_अंत_में(void* text, void* suffix);

int64_t sutra_find(void* text, void* needle) {
    int sutra_native_is_string(void* ptr);
    int64_t सूची_खोज(void* arr, int64_t val);
    if (!text) return -1;
    if (sutra_native_is_string(text)) {
        if (!needle) return -1;
        return पाठ_कोडबिंदु_खोज(text, needle);
    }
    return सूची_खोज(text, (int64_t)needle);
}
void* sutra_replace(void* t, void* n, void* r) { return पाठ_बदल(t, n, r); }
void* sutra_split(void* t, void* d) { return पाठ_विभाजन(t, d); }
void* sutra_join(void* l, void* s) { return पाठ_संयोग(l, s); }
void* sutra_trim(void* t) { return पाठ_छाँट(t); }
int64_t sutra_starts_with(void* t, void* p) { return पाठ_आरंभ_में(t, p); }
int64_t sutra_ends_with(void* t, void* s) { return पाठ_अंत_में(t, s); }

/* sutra_math_sqrt (int) — अब SSE asm blob में (sqrtsd)। */

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

/* ============================================================
 * LIST RUNTIME  —  now in स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र
 * ============================================================
 * dynamic array [capacity:8][count:8][elements:8×cap], type 2.
 * These C symbols are thin shims; the real logic is in Sutra.
 * (sutra_arr_get / sutra_arr_set / sutra_arr_length keep their
 *  C string/dict dispatch — sutra_str_get has a C-side cache.)
 */
extern void*   सूची_रचना(int64_t n);
extern void*   सूची_जोड़(void* arr, int64_t val);
extern void*   सूची_निकाल(void* arr);
extern void*   सूची_डाल(void* arr, int64_t idx, int64_t val);
extern void*   सूची_हटा(void* arr, int64_t idx);
extern void*   सूची_जोड़ो_दो(void* a, void* b);
extern int64_t सूची_खोज(void* arr, int64_t val);

void* sutra_list_append(void* arr, int64_t val) { return सूची_जोड़(arr, val); }
void* sutra_list_pop(void* arr) { return सूची_निकाल(arr); }
void* sutra_list_insert(void* arr, int64_t idx, int64_t val) { return सूची_डाल(arr, idx, val); }
void* sutra_list_remove(void* arr, int64_t idx) { return सूची_हटा(arr, idx); }
void* sutra_list_concat(void* a, void* b) { return सूची_जोड़ो_दो(a, b); }
int64_t sutra_list_find(void* arr, int64_t val) { return सूची_खोज(arr, val); }



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

/* NOTE: sutra_utf8_cmp_codepoints + sutra_str_less/_greater/_less_equal/
 * _greater_equal are now in Sutra (मूल_रनटाइम.सूत्र :: पाठ_कोडबिंदु_तुलना /
 * पाठ_न्यून / पाठ_अधिक / पाठ_न्यून_सम / पाठ_अधिक_सम). C copies stay for the
 * C++ host path. */
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

/* NOTE: sutra_str_length / sutra_arr_length / sutra_dynamic_length /
 * sutra_char_ord are now implemented in Sutra
 * (स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र :: पाठ_कोडबिंदु_गणना / सञ्चय_गणना /
 * दैशिक_लंबाई / अक्षर_कोडबिंदु). The self-hosted native-asm compiler emits
 * calls to those. The C copies below stay only for the C++ host path and
 * go away when the C++ host is removed. */

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

/* Print a string + '\n' — now in मूल_रनटाइम.सूत्र (तल.s WriteFile) */
void sutra_str_print(void* s) { पाठ_छापो(s); }

/* ============================================================
 * ARRAY RUNTIME
 * Memory layout: [int64_t element_count] [int64_t elem_0] [int64_t elem_1] ...
 * The pointer points to the element_count field.
 * ============================================================ */

/* Allocate an array of n int64 elements (initialized to 0) */
void* sutra_arr_create(int64_t n) { return सूची_रचना(n); }  /* -> मूल_रनटाइम.सूत्र */

int64_t sutra_dict_get(void* dict, void* key);
void sutra_dict_set(void* dict, void* key, int64_t val);
int sutra_is_dict(void* ptr);

/* Bounds-checked array read */
int64_t sutra_arr_get(void* arr, int64_t idx) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर सूचकांक प्रयास");
    }
    if (sutra_native_is_string(arr)) {
        /* sutra_str_get carries a sequential-access cache — the lexer reads
           स्रोत[0], स्रोत[1], ... so this turns per-char reads from O(n)
           (full UTF-8 recount) into O(1) amortised. Same 1-char-string
           result and bounds errors as sutra_substr(arr, idx, idx+1). */
        return (int64_t)sutra_str_get(arr, idx);
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
    return सूत्र_ब्लॉक_प्रकार(ptr) == 4 ? 1 : 0;
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
    char* block = (char*)सूत्र_आवंटन(16 + field_count * 8, SR_OBJ);
    *((int64_t*)block) = field_count; // capacity
    *((int64_t*)(block + 8)) = field_count; // count
    memset(block + 16, 0, field_count * 8);
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

void sutra_print_null(void) { शून्य_छापो(); }        /* -> मूल_रनटाइम.सूत्र */
void sutra_print_bool(int64_t v) { बूल_छापो(v); }    /* -> मूल_रनटाइम.सूत्र */

/* ============================================================
 * DICTIONARY RUNTIME  —  now in स्वसंकलक/निर्माण/मूल_रनटाइम.सूत्र
 * ============================================================
 * open-addressing hash index over a packed insertion-order entries
 * array. Block layout (40 bytes, type 4):
 *   +0  count      (GC reads this — unchanged offset)
 *   +8  entries-capacity (in pairs)
 *   +16 entries*   packed [key:8][val:8] (GC traces `count` — unchanged)
 *   +24 index*     int64 slot array, slot = entry_index+1 (0 = empty)
 *   +32 hash-capacity (power of 2)
 * These C symbols are thin shims; the real logic is in Sutra.
 * sutra_dict_keys still reads the packed array directly (layout kept).
 */
extern void*   शब्दकोश_रचना(void);
extern int64_t शब्दकोश_पाओ(void* dict, void* key);
extern void    शब्दकोश_सेट(void* dict, void* key, int64_t val);
extern int64_t शब्दकोश_कुंजी_है(void* dict, void* key);
extern void*   शब्दकोश_हटाओ(void* dict, void* key);

void* sutra_dict_create(void) { return शब्दकोश_रचना(); }
int64_t sutra_dict_get(void* dict, void* key) { return शब्दकोश_पाओ(dict, key); }
void sutra_dict_set(void* dict, void* key, int64_t val) { शब्दकोश_सेट(dict, key, val); }
int64_t sutra_dict_has_key(void* dict, void* key) { return शब्दकोश_कुंजी_है(dict, key); }
void* sutra_dict_remove(void* dict, void* key) { return शब्दकोश_हटाओ(dict, key); }

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

/* ============================================================
 * FILE I/O RUNTIME
 * ============================================================ */

/* ============================================================
 * File I/O + args — Win32 सीधे (कोई libc: _wfopen/fread/fwrite/malloc)।
 * kernel32 (CreateFileW/ReadFile/WriteFile/CloseHandle/…) + shell32
 * (CommandLineToArgvW) — यही OS-तल है, जैसे तल.s।
 * ============================================================ */

/* UTF-8 → UTF-16, stack बफ़र में (मार्ग/कमांड छोटे होते)। सफल? */
static int sr_u8_to_w(const char* s, wchar_t* out, int cap) {
    return MultiByteToWideChar(CP_UTF8, 0, s, -1, out, cap) > 0;
}

int64_t sutra_file_exists(void* path_ptr) {
    if (!path_ptr) return 0;
    wchar_t wp[2048];
    if (!sr_u8_to_w((const char*)path_ptr + 16, wp, 2048)) return 0;
    DWORD a = GetFileAttributesW(wp);
    return (a != INVALID_FILE_ATTRIBUTES && !(a & FILE_ATTRIBUTE_DIRECTORY)) ? 1 : 0;
}

int64_t sutra_command_run(void* cmd_ptr) {
    if (!cmd_ptr) return -1;
    wchar_t wcmd[8192];
    static const wchar_t pfx[] = L"cmd.exe /c ";
    int pn = (int)(sizeof(pfx) / sizeof(wchar_t)) - 1;
    for (int i = 0; i < pn; i++) wcmd[i] = pfx[i];
    if (MultiByteToWideChar(CP_UTF8, 0, (const char*)cmd_ptr + 16, -1, wcmd + pn, 8192 - pn) <= 0)
        return -1;
    STARTUPINFOW si = {0};
    PROCESS_INFORMATION pi = {0};
    si.cb = sizeof(si);
    if (!CreateProcessW(NULL, wcmd, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi))
        return -1;
    WaitForSingleObject(pi.hProcess, INFINITE);
    DWORD code = 0;
    GetExitCodeProcess(pi.hProcess, &code);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return (int64_t)(int)code;
}

void* sutra_file_read(void* path_ptr) {
    if (!path_ptr) return sutra_str_alloc("", 0);
    wchar_t wp[2048];
    if (!sr_u8_to_w((const char*)path_ptr + 16, wp, 2048)) return sutra_str_alloc("", 0);
    HANDLE h = CreateFileW(wp, GENERIC_READ, FILE_SHARE_READ, NULL,
                           OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) return sutra_str_alloc("", 0);
    LARGE_INTEGER sz;
    if (!GetFileSizeEx(h, &sz) || sz.QuadPart < 0 || sz.QuadPart > 0x7FFFFFFF) {
        CloseHandle(h);
        return sutra_str_alloc("", 0);
    }
    int64_t n = (int64_t)sz.QuadPart;
    /* सीधे Sutra-string में पढ़ो — कोई malloc, कोई copy */
    char* block = (char*)sutra_str_alloc(NULL, n);
    int64_t got = 0;
    while (got < n) {
        DWORD chunk = 0;
        if (!ReadFile(h, block + 16 + got, (DWORD)(n - got), &chunk, NULL) || chunk == 0) break;
        got += chunk;
    }
    *((int64_t*)(block + 8)) = got;      /* वास्तविक लंबाई (CRLF-रूपांतरण नहीं — binary) */
    block[16 + got] = '\0';
    CloseHandle(h);
    return block;
}

int64_t sutra_file_write(void* path_ptr, void* content_ptr) {
    if (!path_ptr || !content_ptr) return 0;
    wchar_t wp[2048];
    if (!sr_u8_to_w((const char*)path_ptr + 16, wp, 2048)) return 0;
    const char* content = (const char*)content_ptr + 16;
    int64_t len = *((int64_t*)((char*)content_ptr + 8));
    HANDLE h = CreateFileW(wp, GENERIC_WRITE, 0, NULL,
                           CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) return 0;
    int64_t put = 0;
    int ok = 1;
    while (put < len) {
        DWORD chunk = 0;
        if (!WriteFile(h, content + put, (DWORD)(len - put), &chunk, NULL) || chunk == 0) { ok = 0; break; }
        put += chunk;
    }
    CloseHandle(h);
    return (ok && put == len) ? 1 : 0;
}

int sutra_argc = 0;
char** sutra_argv = NULL;

void sutra_init_args(int argc, char** argv) {
    (void)argc; (void)argv;
    int wargc = 0;
    wchar_t** wargv = CommandLineToArgvW(GetCommandLineW(), &wargc);
    if (!wargv) { sutra_argc = 0; sutra_argv = NULL; return; }
    /* एक बार, कभी मुक्त नहीं — VirtualAlloc (तल), libc heap नहीं */
    int64_t need = (int64_t)wargc * (int64_t)sizeof(char*);
    for (int i = 0; i < wargc; i++)
        need += WideCharToMultiByte(CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
    char* pool = (char*)VirtualAlloc(NULL, (SIZE_T)need + 16, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
    if (!pool) { LocalFree(wargv); sutra_argc = 0; sutra_argv = NULL; return; }
    sutra_argv = (char**)pool;
    char* strs = pool + (int64_t)wargc * (int64_t)sizeof(char*);
    for (int i = 0; i < wargc; i++) {
        int need_i = WideCharToMultiByte(CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
        if (need_i > 0) {
            WideCharToMultiByte(CP_UTF8, 0, wargv[i], -1, strs, need_i, NULL, NULL);
            sutra_argv[i] = strs;
            strs += need_i;
        } else {
            sutra_argv[i] = strs;
            *strs++ = '\0';
        }
    }
    sutra_argc = wargc;
    LocalFree(wargv);
}

void* sutra_args_get() {
    सूत्र_जीसी_दबाओ();
    void* arr = sutra_arr_create(sutra_argc);
    for (int i = 0; i < sutra_argc; i++) {
        const char* a = sutra_argv[i];
        int64_t n = 0;
        while (a[n]) n++;
        void* s = sutra_str_alloc(a, n);
        sutra_arr_set(arr, i, (int64_t)s);
    }
    सूत्र_जीसी_छोड़ो();
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

void* sutra_char_chr(int64_t cp) { return अक्षर_बना(cp); }  /* -> मूल_रनटाइम.सूत्र */

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

/* "%f"-जैसा दशमलव प्रारूप (6 अंश-अंक, trailing zeros छँटे) — कोई libc नहीं
 * (SSE अंकगणित + पूर्णांक लूप)। buf ≥ 40 बाइट। लौटाता: लिखे गए बाइट। */
static int sr_fmt_float(double d, char* buf) {
    int p = 0;
    if (d != d) { buf[0] = 'n'; buf[1] = 'a'; buf[2] = 'n'; buf[3] = '\0'; return 3; }
    if (d < 0.0) { buf[p++] = '-'; d = -d; }
    if (d > 1.7976931348623157e308) { buf[p++]='i'; buf[p++]='n'; buf[p++]='f'; buf[p]='\0'; return p; }
    char tmp[24];
    int tp = 0;
    if (d >= 9.007199254740992e15) {
        /* ≥ 2^53 : अंश प्रस्तुत नहीं हो सकता → पूर्ण भाग ही */
        int64_t ip = (int64_t)d;
        if (ip == 0) tmp[tp++] = '0';
        while (ip > 0) { tmp[tp++] = (char)('0' + ip % 10); ip /= 10; }
        while (tp > 0) buf[p++] = tmp[--tp];
        buf[p] = '\0';
        return p;
    }
    int64_t total = (int64_t)(d * 1000000.0 + 0.5);
    int64_t ip = total / 1000000;
    int64_t fp = total % 1000000;
    if (ip == 0) tmp[tp++] = '0';
    while (ip > 0) { tmp[tp++] = (char)('0' + ip % 10); ip /= 10; }
    while (tp > 0) buf[p++] = tmp[--tp];
    int fd[6];
    for (int i = 5; i >= 0; i--) { fd[i] = (int)(fp % 10); fp /= 10; }
    int last = 5;
    while (last >= 0 && fd[last] == 0) last--;
    if (last >= 0) {
        buf[p++] = '.';
        for (int i = 0; i <= last; i++) buf[p++] = (char)('0' + fd[i]);
    }
    buf[p] = '\0';
    return p;
}

void* sutra_float_to_str(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    char buf[48];
    int n = sr_fmt_float(d, buf);
    return sutra_str_alloc(buf, n);
}

void sutra_print_float(int64_t v_bits) {
    पाठ_छापो(sutra_float_to_str(v_bits));   /* → मूल_रनटाइम.सूत्र (तल.s WriteFile) */
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

/* sutra_math_sqrt_f / abs_f / min_f / max_f / round_f — अब SSE asm blob में
 * (sqrtsd / btrq $63 / minsd / maxsd / cvtsd2si)। कोई libm नहीं। */

/* pow(b,e) — पूर्णांक घातांक = सटीक repeated-multiply; भिन्नात्मक = exp(e·ln b)
 * pure-C series से (कोई libm)। कोडबेस में केवल पूर्णांक घातांक इस्तेमाल होता। */
static double sr_ln(double x) {
    if (x <= 0.0) return 0.0;
    int64_t xb; memcpy(&xb, &x, 8);
    int k = (int)((xb >> 52) & 0x7FF) - 1023;
    xb = (xb & 0x000FFFFFFFFFFFFFLL) | (1023LL << 52);
    double m; memcpy(&m, &xb, 8);
    if (m > 1.4142135623730951) { m *= 0.5; k += 1; }
    double s = (m - 1.0) / (m + 1.0);
    double s2 = s * s, term = s, sum = 0.0;
    for (int i = 1; i < 40; i += 2) { sum += term / i; term *= s2; }
    return 2.0 * sum + k * 0.6931471805599453;
}
static double sr_exp(double x) {
    double kf = x * 1.4426950408889634;
    int64_t k = (int64_t)(kf + (kf >= 0.0 ? 0.5 : -0.5));
    if (k > 1000) k = 1000; else if (k < -1000) k = -1000;
    double r = x - (double)k * 0.6931471805599453;
    double term = 1.0, sum = 1.0;
    for (int i = 1; i < 20; i++) { term *= r / i; sum += term; }
    int64_t bits = (k + 1023) << 52;
    double p2; memcpy(&p2, &bits, 8);
    return sum * p2;
}
int64_t sutra_math_pow_f(int64_t b_bits, int64_t e_bits) {
    double b, e;
    memcpy(&b, &b_bits, 8);
    memcpy(&e, &e_bits, 8);
    double res;
    if ((double)(int64_t)e == e && e >= -1024.0 && e <= 1024.0) {
        int64_t n = (int64_t)e;
        int neg = n < 0;
        if (neg) n = -n;
        double acc = 1.0, base = b;
        while (n > 0) { if (n & 1) acc *= base; base *= base; n >>= 1; }
        res = neg ? 1.0 / acc : acc;
    } else if (b > 0.0) {
        res = sr_exp(e * sr_ln(b));
    } else {
        res = 0.0;
    }
    int64_t res_bits;
    memcpy(&res_bits, &res, 8);
    return res_bits;
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

  # ---- गणित (float) : SSE, कोई libm नहीं ----

  .globl sutra_math_sqrt_f
  .def sutra_math_sqrt_f; .scl 2; .type 32; .endef
sutra_math_sqrt_f:
  movq %rcx, %xmm0
  sqrtsd %xmm0, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_math_abs_f
  .def sutra_math_abs_f; .scl 2; .type 32; .endef
sutra_math_abs_f:
  movq %rcx, %rax
  btrq $63, %rax
  ret

  .globl sutra_math_min_f
  .def sutra_math_min_f; .scl 2; .type 32; .endef
sutra_math_min_f:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  minsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_math_max_f
  .def sutra_math_max_f; .scl 2; .type 32; .endef
sutra_math_max_f:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  maxsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  # गोल: half-away-from-zero (llround जैसा) = trunc(x + copysign(0.5, x))
  .globl sutra_math_round_f
  .def sutra_math_round_f; .scl 2; .type 32; .endef
sutra_math_round_f:
  movq %rcx, %xmm0
  movq %rcx, %rax
  movabsq $0x8000000000000000, %rdx
  andq %rdx, %rax
  movabsq $0x3FE0000000000000, %rdx
  orq %rdx, %rax
  movq %rax, %xmm1
  addsd %xmm1, %xmm0
  cvttsd2siq %xmm0, %rax
  ret

  .globl sutra_math_sqrt
  .def sutra_math_sqrt; .scl 2; .type 32; .endef
sutra_math_sqrt:
  cvtsi2sdq %rcx, %xmm0
  sqrtsd %xmm0, %xmm0
  movabsq $0x3FE0000000000000, %rax
  movq %rax, %xmm1
  addsd %xmm1, %xmm0
  cvttsd2siq %xmm0, %rax
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
