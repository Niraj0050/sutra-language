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

// Forward declarations
void sutra_throw_str(const char* msg);
void sutra_throw(void* ex);
#include <math.h>
#include <setjmp.h>

/* ============================================================
 * EXCEPTION HANDLING RUNTIME
 * ============================================================ */
#define MAX_TRY_DEPTH 256
jmp_buf sutra_try_stack[MAX_TRY_DEPTH];
int sutra_try_depth = 0;
void* sutra_active_exception = NULL;

void* sutra_exception_get_jmp_buf() {
    if (sutra_try_depth >= MAX_TRY_DEPTH) {
        fprintf(stderr, "त्रुटिः — अधिकतम प्रयत्न सीमा पार हो गई (Max try depth exceeded)\n");
        exit(1);
    }
    return &sutra_try_stack[sutra_try_depth++];
}

void sutra_exception_pop() {
    if (sutra_try_depth > 0) sutra_try_depth--;
}

void sutra_throw(void* ex) {
    sutra_active_exception = ex;
    if (sutra_try_depth == 0) {
        if (ex) {
            /* ex is a Sutra string: [int64_t byte_length][char data...]['\0'] */
            int64_t len = *((int64_t*)ex);
            const char* msg = (const char*)ex + 8;
            fprintf(stderr, "त्रुटिः: %.*s\n", (int)len, msg);
        } else {
            fprintf(stderr, "त्रुटिः — अनियंत्रित अपवाद (Uncaught exception)\n");
        }
        exit(1);
    }
    sutra_try_depth--;
    longjmp(sutra_try_stack[sutra_try_depth], 1);
}

void* sutra_get_exception_value() {
    return sutra_active_exception;
}

void* sutra_str_alloc(const char* data, int64_t len);

void sutra_throw_str(const char* msg) {
    void* err_str = sutra_str_alloc(msg, strlen(msg));
    sutra_throw(err_str);
}

void sutra_throw_div_by_zero() {
    sutra_throw_str("अनुष्ठान-त्रुटिः — शून्येन विभाजनम् न सम्भवति (Division by zero)");
}


/* ============================================================
 * GARBAGE COLLECTOR RUNTIME (Mock for Native)
 * ============================================================ */
void sutra_gc_status() {
    printf("चक्र: 0\nसक्रिय: 0\nसंग्रहित: 0\n");
}

void sutra_gc_collect() {
    // Native compiler currently does not implement GC.
}

/* Forward declarations for runtime helpers used by string helpers before their definitions. */
void* sutra_arr_create(int64_t n);
void sutra_arr_set(void* arr, int64_t idx, int64_t val);

/* ============================================================
 * STRING RUNTIME
 * Memory layout: [int64_t byte_length] [char data[byte_length]] [\0]
 * The pointer points to the byte_length field.
 * ============================================================ */

/* Allocate a new string from raw UTF-8 data and byte length */
void* sutra_str_alloc(const char* data, int64_t len) {
    /* Allocate: 8 bytes for length + len bytes for data + 1 for null terminator */
    char* block = (char*)malloc(8 + len + 1);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (string alloc)");
    }
    *((int64_t*)block) = len;
    if (len > 0 && data) {
        memcpy(block + 8, data, len);
    }
    block[8 + len] = '\0';
    return block;
}

void* sutra_int_to_str(int64_t v) {
    char buf[32];
    int len = snprintf(buf, sizeof(buf), "%" PRId64, v);
    return sutra_str_alloc(buf, len);
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
    if (!a) return b;
    if (!b) return a;

    int64_t len_a = *((int64_t*)a);
    int64_t len_b = *((int64_t*)b);
    int64_t total = len_a + len_b;

    char* block = (char*)malloc(8 + total + 1);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (string concat)");
    }
    *((int64_t*)block) = total;
    if (len_a > 0) memcpy(block + 8, (char*)a + 8, len_a);
    if (len_b > 0) memcpy(block + 8 + len_a, (char*)b + 8, len_b);
    block[8 + total] = '\0';
    return block;
}

/* Compare two strings for equality. Returns 1 if equal, 0 otherwise. */
int64_t sutra_str_equal(void* a, void* b) {
    if (a == b) return 1;
    if (!a || !b) return 0;

    int64_t len_a = *((int64_t*)a);
    int64_t len_b = *((int64_t*)b);
    if (len_a != len_b) return 0;
    return memcmp((char*)a + 8, (char*)b + 8, len_a) == 0 ? 1 : 0;
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
    int64_t len = *((int64_t*)text);
    const unsigned char* data = (const unsigned char*)text + 8;
    return sutra_utf8_substr_raw(data, len, start, end);
}

int64_t sutra_find(void* text, void* needle) {
    if (!text || !needle) {
        sutra_throw_str("त्रुटिः — खोजें में शून्य पाठ मान्य नहीं है");
    }
    int64_t hay_len = *((int64_t*)text);
    int64_t needle_len = *((int64_t*)needle);
    const unsigned char* hay = (const unsigned char*)text + 8;
    const unsigned char* need = (const unsigned char*)needle + 8;
    if (needle_len == 0) {
        sutra_throw_str("त्रुटिः — खोजें: रिक्त खोज पाठ मान्य न अस्ति।");
    }
    for (int64_t pos = 0; pos + needle_len <= hay_len; ++pos) {
        if (memcmp(hay + pos, need, (size_t)needle_len) == 0) {
            return sutra_utf8_codepoints_before_byte(hay, hay_len, pos);
        }
    }
    return -1;
}

void* sutra_replace(void* text, void* needle, void* replacement) {
    if (!text || !needle || !replacement) {
        sutra_throw_str("त्रुटिः — बदलें में शून्य पाठ मान्य नहीं है");
    }
    int64_t hay_len = *((int64_t*)text);
    int64_t needle_len = *((int64_t*)needle);
    const unsigned char* hay = (const unsigned char*)text + 8;
    const unsigned char* need = (const unsigned char*)needle + 8;
    const unsigned char* repl = (const unsigned char*)replacement + 8;
    int64_t repl_len = *((int64_t*)replacement);

    if (needle_len == 0) {
        sutra_throw_str("त्रुटिः — बदलें: रिक्त खोज पाठ मान्य न अस्ति।");
    }

    for (int64_t pos = 0; pos + needle_len <= hay_len; ++pos) {
        if (memcmp(hay + pos, need, (size_t)needle_len) == 0) {
            int64_t prefix_len = pos;
            int64_t suffix_len = hay_len - (pos + needle_len);
            int64_t out_len = prefix_len + repl_len + suffix_len;
            char* out = (char*)malloc(8 + out_len + 1);
            if (!out) { sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (replace)"); }
            *((int64_t*)out) = out_len;
            if (prefix_len > 0) memcpy(out + 8, hay, (size_t)prefix_len);
            if (repl_len > 0) memcpy(out + 8 + prefix_len, repl, (size_t)repl_len);
            if (suffix_len > 0) memcpy(out + 8 + prefix_len + repl_len, hay + pos + needle_len, (size_t)suffix_len);
            out[8 + out_len] = '\0';
            return out;
        }
    }
    return text;
}

void* sutra_split(void* text, void* delim) {
    if (!text || !delim) {
        sutra_throw_str("त्रुटिः — विभाजित के तर्क शून्य नहीं हो सकते");
    }
    int64_t hay_len = *((int64_t*)text);
    int64_t delim_len = *((int64_t*)delim);
    const unsigned char* hay = (const unsigned char*)text + 8;
    const unsigned char* d = (const unsigned char*)delim + 8;
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
    const unsigned char* delim = sep ? ((const unsigned char*)sep + 8) : (const unsigned char*)"";
    int64_t delim_len = sep ? *((int64_t*)sep) : 0;

    int64_t total = 0;
    for (int64_t i = 0; i < count; ++i) {
        int64_t elem_ptr = *((int64_t*)((char*)list + 16 + i * 8));
        if ((uint64_t)elem_ptr < 65536) {
            sutra_throw_str("त्रुटिः — संयोजित में सूची के सभी तत्व पाठ होने चाहिए।");
        }
        int64_t elem_len = *((int64_t*)(void*)elem_ptr);
        total += elem_len;
        if (i + 1 < count) total += delim_len;
    }

    char* out = (char*)malloc(8 + total + 1);
    if (!out) { sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (join)"); }
    *((int64_t*)out) = total;
    int64_t pos = 0;
    for (int64_t i = 0; i < count; ++i) {
        int64_t elem_ptr = *((int64_t*)((char*)list + 16 + i * 8));
        int64_t elem_len = *((int64_t*)(void*)elem_ptr);
        const unsigned char* elem_data = (const unsigned char*)(void*)elem_ptr + 8;
        if (elem_len > 0) memcpy(out + 8 + pos, elem_data, (size_t)elem_len), pos += elem_len;
        if (i + 1 < count && delim_len > 0) memcpy(out + 8 + pos, delim, (size_t)delim_len), pos += delim_len;
    }
    out[8 + total] = '\0';
    return out;
}

void* sutra_trim(void* text) {
    if (!text) return sutra_str_alloc("", 0);
    int64_t len = *((int64_t*)text);
    const unsigned char* data = (const unsigned char*)text + 8;

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
    int64_t text_len = *((int64_t*)text);
    int64_t prefix_len = *((int64_t*)prefix);
    const unsigned char* text_data = (const unsigned char*)text + 8;
    const unsigned char* prefix_data = (const unsigned char*)prefix + 8;
    if (prefix_len == 0) return 1;
    if (text_len < prefix_len) return 0;
    return memcmp(text_data, prefix_data, (size_t)prefix_len) == 0 ? 1 : 0;
}

int64_t sutra_ends_with(void* text, void* suffix) {
    if (!text || !suffix) return 1;
    int64_t text_len = *((int64_t*)text);
    int64_t suffix_len = *((int64_t*)suffix);
    const unsigned char* text_data = (const unsigned char*)text + 8;
    const unsigned char* suffix_data = (const unsigned char*)suffix + 8;
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
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (!new_block) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (list append)");
        }
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
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
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
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (!new_block) {
            sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (list insert)");
        }
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
        void* new_block = realloc(arr, 16 + new_cap * 8);
        if (new_block) {
            arr = new_block;
            *((int64_t*)arr) = new_cap;
        }
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

    int64_t len = *((int64_t*)s);
    const unsigned char* data = (const unsigned char*)s + 8;
    char* out = (char*)malloc(8 + len + 1);
    if (!out) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (string case transform)");
    }
    *((int64_t*)out) = len;

    for (int64_t i = 0; i < len; ++i) {
        unsigned char c = data[i];
        if (c >= 'a' && c <= 'z') {
            out[8 + i] = upper ? (char)(c - 'a' + 'A') : (char)c;
        } else if (c >= 'A' && c <= 'Z') {
            out[8 + i] = upper ? (char)c : (char)(c - 'A' + 'a');
        } else {
            out[8 + i] = (char)c;
        }
    }
    out[8 + len] = '\0';
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

    const unsigned char* data_a = (const unsigned char*)a + 8;
    const unsigned char* data_b = (const unsigned char*)b + 8;
    int64_t len_a = *((int64_t*)a);
    int64_t len_b = *((int64_t*)b);
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

    const unsigned char* data = (const unsigned char*)s + 8;
    int64_t len = *((int64_t*)s);
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

    const unsigned char* data = (const unsigned char*)s + 8;
    int64_t len = *((int64_t*)s);
    int64_t count = 0;
    int64_t start = 0;
    int64_t end = 0;

    for (int64_t i = 0; i < len; ) {
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
    int64_t len = *((int64_t*)s);
    char* data = (char*)s + 8;
    fwrite(data, 1, len, stdout);
    printf("\n");
}

/* ============================================================
 * ARRAY RUNTIME
 * Memory layout: [int64_t element_count] [int64_t elem_0] [int64_t elem_1] ...
 * The pointer points to the element_count field.
 * ============================================================ */

/* Allocate an array of n int64 elements (initialized to 0) */
void* sutra_arr_create(int64_t n) {
    char* block = (char*)malloc(16 + n * 8);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (array alloc)");
    }
    *((int64_t*)block) = n; // capacity
    *((int64_t*)(block + 8)) = n; // count
    /* Zero-initialize elements */
    memset(block + 16, 0, n * 8);
    return block;
}

/* Bounds-checked array read */
int64_t sutra_arr_get(void* arr, int64_t idx) {
    if (!arr) {
        sutra_throw_str("त्रुटिः — शून्य सूची पर सूचकांक प्रयास");
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
    int64_t count = *((int64_t*)((char*)arr + 8));
    if (idx < 0 || idx >= count) {
        sutra_throw_str("त्रुटिः — सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)");
    }
    int64_t* elements = (int64_t*)((char*)arr + 16);
    elements[idx] = val;
}

/* Return array length */
int64_t sutra_arr_length(void* arr) {
    if (!arr) return 0;
    return *((int64_t*)((char*)arr + 8));
}

/* ============================================================
 * OBJECT RUNTIME
 * ============================================================ */

void* sutra_obj_alloc(int64_t field_count) {
    char* block = (char*)malloc(16 + field_count * 8);
    if (!block) {
        sutra_throw_str("त्रुटिः — स्मृति आवंटन विफल (object alloc)");
    }
    *((int64_t*)block) = field_count; // capacity
    *((int64_t*)(block + 8)) = field_count; // count
    memset(block + 16, 0, field_count * 8);
    return block;
}

/* ============================================================
 * NULL RUNTIME
 * ============================================================ */

void sutra_print_null(void) {
    printf("शून्यम्\n");
}

void sutra_print_bool(int64_t v) {
    if (v) {
        printf("सत्य\n");
    } else {
        printf("असत्य\n");
    }
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
    return dict;
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

int64_t sutra_file_exists(void* path_ptr) {
    if (!path_ptr) return 0;
    const char* path = (const char*)path_ptr + 8;
    FILE* f = fopen(path, "r");
    if (f) {
        fclose(f);
        return 1;
    }
    return 0;
}

void* sutra_file_read(void* path_ptr) {
    if (!path_ptr) return sutra_str_alloc("", 0);
    const char* path = (const char*)path_ptr + 8;
    FILE* f = fopen(path, "rb");
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
    const char* path = (const char*)path_ptr + 8;
    const char* content = (const char*)content_ptr + 8;
    int64_t len = *((int64_t*)content_ptr);
    
    FILE* f = fopen(path, "wb");
    if (!f) return 0;
    
    size_t written = fwrite(content, 1, len, f);
    fclose(f);
    
    return written == (size_t)len ? 1 : 0;
}

// Float support runtime helper functions
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

void* sutra_float_to_str(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    char buf[64];
    snprintf(buf, sizeof(buf), "%g", d);
    return sutra_str_alloc(buf, strlen(buf));
}

void sutra_print_float(int64_t v_bits) {
    double d;
    memcpy(&d, &v_bits, 8);
    printf("%g\n", d);
}

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
