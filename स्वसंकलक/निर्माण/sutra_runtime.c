/*
 * Sutra Native Runtime 1.0
 * Minimal C runtime for Sutra native compiler.
 * Provides string, array, null, and print helpers.
 * Bootstrap dependency: C standard library (malloc, free, printf, memcpy, strcmp).
 * This runtime will eventually be replaced by a pure Sutra implementation.
 */

/* stdio / stdlib / inttypes / string हटे — कोई libc फलन।
 * stdint/stddef सिर्फ़ types (int64_t / size_t)। memcpy/memmove/memset/
 * memcmp/strlen अब तल.s में (हाथ-asm, libc-मुक्त)। */
#include <stdint.h>
#include <stddef.h>

extern void*  memcpy(void* d, const void* s, size_t n);
extern void*  memmove(void* d, const void* s, size_t n);
extern void*  memset(void* d, int c, size_t n);
extern int    memcmp(const void* a, const void* b, size_t n);
extern size_t strlen(const char* s);

#ifdef _WIN32
#include <windows.h>   /* stderr WriteFile + sutra_gc_status stdout; file/args अब तल.s */
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

/* अपवाद-अवस्था + setjmp/longjmp — अब मूल_रनटाइम.सूत्र + तल.s में।
 * compiler `call _setjmp` (तल.s, 256-बाइट बफ़र) emit करता; try_stack /
 * try_depth / active_exception अब Sutra module global। */
extern void* अपवाद_बफ_लो(void);
extern int64_t अपवाद_पॉप(void);
extern int64_t सक्रिय_अपवाद_लो(void);
extern int64_t फेंको(int64_t ex);

/* stdout/stderr — कोई stdio, सीधे kernel32 WriteFile।
 * stdout: सिर्फ़ sutra_gc_status (स्मृति_स्थिति diagnostic — non-allocating,
 *   इसलिए अभी भी C; print/format चंक के साथ Sutra जाएगा)।
 * stderr: uncaught-अपवाद पथ। */
static void sr_fdw(DWORD which, const char* s, int n) {
    DWORD w;
    WriteFile(GetStdHandle(which), s, (DWORD)n, &w, NULL);
}
static int sr_slen(const char* s) { int n = 0; while (s[n]) n++; return n; }
static void sr_err(const char* s) { sr_fdw(STD_ERROR_HANDLE, s, sr_slen(s)); }
static void sr_out(const char* s) { sr_fdw(STD_OUTPUT_HANDLE, s, sr_slen(s)); }
static void sr_out_i64(int64_t v) {
    char b[24], t[24];
    int p = 0, tp = 0, neg = v < 0;
    if (neg) v = -v;
    if (v == 0) t[tp++] = '0';
    while (v > 0) { t[tp++] = (char)('0' + v % 10); v /= 10; }
    if (neg) b[p++] = '-';
    while (tp > 0) b[p++] = t[--tp];
    sr_fdw(STD_OUTPUT_HANDLE, b, p);
}

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
 * EXCEPTION HANDLING RUNTIME  —  state + logic in मूल_रनटाइम.सूत्र
 * ============================================================ */

/* compiler-emitted entry points → thin shims over Sutra */
void* sutra_exception_get_jmp_buf() { return अपवाद_बफ_लो(); }
void  sutra_exception_pop()         { अपवाद_पॉप(); }
void* sutra_get_exception_value()   { return (void*)(intptr_t)सक्रिय_अपवाद_लो(); }
void* sutra_exception_get_active()  { return (void*)(intptr_t)सक्रिय_अपवाद_लो(); }
void  sutra_throw(void* ex)         { फेंको((int64_t)ex); }

void sutra_str_print(void* s);
void* sutra_str_alloc(const char* data, int64_t len);

/* uncaught (try_depth == 0) — stderr + terminate। Sutra `फेंको` से बुलाया।
 * यही एकमात्र C में बचा exception-भाग (टर्मिनल error-पथ)। */
void सूत्र_अपवाद_निकास(void* ex) {
    if (ex) {
        int64_t len = *((int64_t*)((char*)ex + 8));
        const char* msg = (const char*)ex + 16;
        DWORD w;
        sr_err("त्रुटिः: ");
        WriteFile(GetStdHandle(STD_ERROR_HANDLE), msg, (DWORD)len, &w, NULL);
        sr_err("\n");
    } else {
        sr_err("त्रुटिः — अनियंत्रित अपवाद (Uncaught exception)\n");
    }
    ExitProcess(1);
}

void sutra_throw_str(const char* msg) {
    फेंको((int64_t)sutra_str_alloc(msg, strlen(msg)));
}

void sutra_throw_div_by_zero() {
    sutra_throw_str("अनुष्ठान-त्रुटिः — शून्येन विभाजनम् न सम्भवति (Division by zero)");
}


/* ============================================================
 * GARBAGE COLLECTOR RUNTIME
 * gc_roots[] + gc_roots_count अब तल.s (.bss) में; रूट-एक्सेसर
 * sutra_gc_root_count / sutra_gc_root_deref भी तल.s (हाथ-asm)।
 * ============================================================ */

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
extern int64_t पाठ_तुल्य(int64_t a, int64_t b);
extern int64_t पाठ_कोडबिंदु_तुलना(int64_t a, int64_t b);
extern void*   गतिशील_प्रकार(int64_t p);
extern void*   पाठ_अक्षर_रूप(int64_t s, int64_t upper);

/* print — now in मूल_रनटाइम.सूत्र (via तल.s WriteFile; no printf/fwrite/fflush) */
extern int64_t पाठ_छापो(void* s);
extern int64_t शून्य_छापो(void);
extern int64_t बूल_छापो(int64_t v);
extern int64_t गतिशील_छापो(int64_t val);

/* GC roots — sutra_gc_root_count / sutra_gc_root_deref अब तल.s (asm)।
 * sutra_gc_active_exc हटा — उत्सर्जक अब अंतर्_सक्रिय_अपवाद को सीधे
 * सक्रिय_अपवाद_लो (मूल_रनटाइम.सूत्र) पर भेजता। */

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

/* अनुक्रमिक पाठ-सूचकांक पहुँच के लिए 1-प्रविष्टि cache (लेक्सर का O(n^2) निवारण) */
static void*   sg_cache_str      = NULL;
static int64_t sg_cache_char_idx = 0;
static int64_t sg_cache_byte_off = 0;

/* पूर्व यहाँ: gc_allocs सरणी + सूचक→अनुक्रमणिका hash + gc_register/unregister/
 * update/mark_allocation (~190 line, malloc/free/calloc/realloc सहित)।
 * Route-C (Sutra arena, USE_LEGACY_RUNTIME) से सब मृत — find_gc_allocation अब
 * सीधे सूत्र_ब्लॉक_प्रकार पूछता, चिह्नित मूल_आवंटक.सूत्र में। */

void sutra_gc_collect() {
    sg_cache_str = NULL;
    सूत्र_संग्रह();
}

/* स्मृति_स्थिति diagnostic — non-allocating (sr_out, कोई पाठ-आवंटन) ताकि
 * यह उन्हीं गणकों को न बिगाड़े जो यह छापता है। print/format चंक के साथ जाएगा। */
void sutra_gc_status() {
    sr_out("चक्र: ");     sr_out_i64(सूत्र_गण_चक्र());     sr_out("\n");
    sr_out("सक्रिय: ");   sr_out_i64(सूत्र_गण_सक्रिय());   sr_out("\n");
    sr_out("संग्रहित: "); sr_out_i64(सूत्र_गण_संग्रहित()); sr_out("\n");
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

void* sutra_dynamic_type(void* ptr) { return गतिशील_प्रकार((int64_t)ptr); }  /* -> मूल_रनटाइम.सूत्र */

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

/* समानता / lexicographic तुलना — अब मूल_रनटाइम.सूत्र में
 * (पाठ_तुल्य = byte-loop; पाठ_कोडबिंदु_तुलना = codepoint order = UTF-8 byte order)। */
int64_t sutra_str_equal(void* a, void* b) {
    return पाठ_तुल्य((int64_t)a, (int64_t)b);
}

int64_t sutra_str_compare(void* a, void* b) {
    extern int sutra_native_is_string(void* ptr);
    if (a != b && a && b && (!sutra_native_is_string(a) || !sutra_native_is_string(b)))
        return (intptr_t)a - (intptr_t)b;
    return पाठ_कोडबिंदु_तुलना((int64_t)a, (int64_t)b);
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



int64_t sutra_str_upper(void* s) { return (int64_t)पाठ_अक्षर_रूप((int64_t)s, 1); }  /* -> मूल_रनटाइम.सूत्र */
int64_t sutra_str_lower(void* s) { return (int64_t)पाठ_अक्षर_रूप((int64_t)s, 0); }

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

/* ============================================================
 * OBJECT RUNTIME
 * ============================================================ */

void* sutra_obj_alloc(int64_t field_count) {
#ifdef USE_LEGACY_RUNTIME
    /* सूत्र_आवंटन शून्य-भरा देता → अलग memset की ज़रूरत नहीं */
    char* block = (char*)सूत्र_आवंटन(16 + field_count * 8, SR_OBJ);
    *((int64_t*)block) = field_count; // capacity
    *((int64_t*)(block + 8)) = field_count; // count
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
 * FILE I/O + तर्क + समादेश  —  अब मूल_रनटाइम.सूत्र + तल.s में।
 * kernel32/shell32 पतले wrappers तल.s (सूत्र_तल_सञ्चिका_* / _पढ़ो /
 * _लिखो / _समादेश / _समादेश_विभाजन / …); loop + बफ़र + UTF-8↔UTF-16
 * रचना मूल_रनटाइम.सूत्र (सञ्चिका_पढ़ो_रन / _लिखो_रन / _है_रन /
 * समादेश_चलाओ_रन / तर्क_सूची_रन)। निम्नक वहाँ भेजता; तर्क अब आलसी
 * (main से sutra_init_args कॉल हटी)।
 * ============================================================ */

void* sutra_char_chr(int64_t cp) { return अक्षर_बना(cp); }  /* -> मूल_रनटाइम.सूत्र */

// Float support runtime helper functions

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


#ifdef __cplusplus
}
#endif
