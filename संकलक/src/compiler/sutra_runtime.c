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

/* Return byte length of string */
int64_t sutra_str_length(void* s) {
    if (!s) return 0;
    return *((int64_t*)s);
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
