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
#include <stdint.h>

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
        fprintf(stderr, "त्रुटिः — स्मृति आवंटन विफल (string alloc)\n");
        exit(1);
    }
    *((int64_t*)block) = len;
    if (len > 0 && data) {
        memcpy(block + 8, data, len);
    }
    block[8 + len] = '\0';
    return block;
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
        fprintf(stderr, "त्रुटिः — स्मृति आवंटन विफल (string concat)\n");
        exit(1);
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
        return sutra_arr_create(1);
    }

    int64_t count = *((int64_t*)arr);
    char* block = (char*)malloc(8 + (count + 1) * 8);
    if (!block) {
        fprintf(stderr, "त्रुटिः — स्मृति आवंटन विफल (list append)\n");
        exit(1);
    }
    *((int64_t*)block) = count + 1;
    memcpy(block + 8, (char*)arr + 8, count * 8);
    int64_t* elements = (int64_t*)((char*)block + 8);
    elements[count] = val;
    return block;
}

static void* sutra_str_map_case(void* s, int upper) {
    if (!s) return sutra_str_alloc("", 0);

    int64_t len = *((int64_t*)s);
    const unsigned char* data = (const unsigned char*)s + 8;
    char* out = (char*)malloc(8 + len + 1);
    if (!out) {
        fprintf(stderr, "त्रुटिः — स्मृति आवंटन विफल (string case transform)\n");
        exit(1);
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
        fprintf(stderr, "त्रुटिः — शून्य पाठ पर सूचकांक प्रयास\n");
        exit(1);
    }
    if (idx < 0) {
        fprintf(stderr, "त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\n");
        exit(1);
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

    fprintf(stderr, "त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\n");
    exit(1);
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
    char* block = (char*)malloc(8 + n * 8);
    if (!block) {
        fprintf(stderr, "त्रुटिः — स्मृति आवंटन विफल (array alloc)\n");
        exit(1);
    }
    *((int64_t*)block) = n;
    /* Zero-initialize elements */
    memset(block + 8, 0, n * 8);
    return block;
}

/* Bounds-checked array read */
int64_t sutra_arr_get(void* arr, int64_t idx) {
    if (!arr) {
        fprintf(stderr, "त्रुटिः — शून्य सूची पर सूचकांक प्रयास\n");
        exit(1);
    }
    int64_t count = *((int64_t*)arr);
    if (idx < 0 || idx >= count) {
        fprintf(stderr, "त्रुटिः — सूची सूचकांक सीमा से बाहर: %lld (सीमा: 0-%lld)\n",
                (long long)idx, (long long)(count - 1));
        exit(1);
    }
    int64_t* elements = (int64_t*)((char*)arr + 8);
    return elements[idx];
}

/* Bounds-checked array write */
void sutra_arr_set(void* arr, int64_t idx, int64_t val) {
    if (!arr) {
        fprintf(stderr, "त्रुटिः — शून्य सूची पर सूचकांक प्रयास\n");
        exit(1);
    }
    int64_t count = *((int64_t*)arr);
    if (idx < 0 || idx >= count) {
        fprintf(stderr, "त्रुटिः — सूची सूचकांक सीमा से बाहर: %lld (सीमा: 0-%lld)\n",
                (long long)idx, (long long)(count - 1));
        exit(1);
    }
    int64_t* elements = (int64_t*)((char*)arr + 8);
    elements[idx] = val;
}

/* Return array length */
int64_t sutra_arr_length(void* arr) {
    if (!arr) return 0;
    return *((int64_t*)arr);
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
