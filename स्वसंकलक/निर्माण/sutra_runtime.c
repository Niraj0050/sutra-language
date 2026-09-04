/*
 * Sutra Native Runtime — जो C में बचा।
 * हर उत्पन्न binary में लिंक होता। धीरे-धीरे मूल_रनटाइम.सूत्र + तल.s में
 * जा रहा है (Phase 2)। अब बचा: stderr-पथ (uncaught अपवाद), gc_status
 * diagnostic, कुछ पतले shims, और pow/ln/exp (bit-reinterpret चाहिए)।
 */

/* कोई libc फलन। stdint/stddef सिर्फ़ types। memcpy/strlen तल.s में। */
#include <stdint.h>
#include <stddef.h>

extern void*  memcpy(void* d, const void* s, size_t n);
extern size_t strlen(const char* s);

#ifdef _WIN32
#include <windows.h>   /* stderr WriteFile + gc_status stdout — यही एकमात्र OS-उपयोग */
#endif

/* अपवाद-अवस्था + setjmp/longjmp — मूल_रनटाइम.सूत्र + तल.s में। */
extern void* अपवाद_बफ_लो(void);
extern int64_t अपवाद_पॉप(void);
extern int64_t सक्रिय_अपवाद_लो(void);
extern int64_t फेंको(int64_t ex);

/* stdout/stderr — कोई stdio, सीधे kernel32 WriteFile।
 * stdout: सिर्फ़ sutra_gc_status (non-allocating diagnostic)।
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

/* ============================================================
 * मूल_रनटाइम.सूत्र / तल.s के symbols (extern) — नीचे के shims इन्हें बुलाते
 * ============================================================ */
extern void*   पाठ_रचना(int64_t raw, int64_t len);   /* पूर्व sutra_str_alloc */
extern void*   पाठ_जोड़(void* a, void* b);
extern void*   संख्या_से_पाठ(int64_t v);
extern void*   बूल_से_पाठ(int64_t v);
extern void*   शून्य_से_पाठ(void);
extern void*   अक्षर_बना(int64_t cp);
extern void*   गतिशील_प्रकार(int64_t p);
extern int64_t पाठ_छापो(void* s);
extern int64_t शून्य_छापो(void);
extern int64_t बूल_छापो(int64_t v);
extern int64_t गतिशील_छापो(int64_t val);
extern void*   पाठ_बदल(void* hay, void* needle, void* repl);
extern void*   पाठ_विभाजन(void* hay, void* delim);
extern void*   पाठ_संयोग(void* list, void* sep);
extern void*   पाठ_छाँट(void* text);
extern int64_t पाठ_आरंभ_में(void* text, void* prefix);
extern int64_t पाठ_अंत_में(void* text, void* suffix);
extern void*   सूची_रचना(int64_t n);
extern void*   सूची_जोड़(void* arr, int64_t val);
extern void*   सूची_निकाल(void* arr);
extern void*   सूची_डाल(void* arr, int64_t idx, int64_t val);
extern void*   सूची_हटा(void* arr, int64_t idx);
extern void*   सूची_जोड़ो_दो(void* a, void* b);
extern int64_t सूची_खोज(void* arr, int64_t val);
extern void*   शब्दकोश_रचना(void);
extern int64_t शब्दकोश_पाओ(void* dict, void* key);
extern void    शब्दकोश_सेट(void* dict, void* key, int64_t val);
extern int64_t शब्दकोश_कुंजी_है(void* dict, void* key);
extern void*   शब्दकोश_हटाओ(void* dict, void* key);
extern int64_t सूत्र_गण_चक्र(void);
extern int64_t सूत्र_गण_सक्रिय(void);
extern int64_t सूत्र_गण_संग्रहित(void);

/* ============================================================
 * EXCEPTION — uncaught पथ ही C में (stderr + terminate)
 * ============================================================ */

/* compiler-emitted entry points → thin shims over Sutra */
void* sutra_exception_get_jmp_buf() { return अपवाद_बफ_लो(); }
void  sutra_exception_pop()         { अपवाद_पॉप(); }
void* sutra_get_exception_value()   { return (void*)(intptr_t)सक्रिय_अपवाद_लो(); }
void* sutra_exception_get_active()  { return (void*)(intptr_t)सक्रिय_अपवाद_लो(); }

/* uncaught (try_depth == 0) — stderr + terminate। Sutra `फेंको` से बुलाया। */
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
    फेंको((int64_t)पाठ_रचना((int64_t)msg, (int64_t)strlen(msg)));
}

/* तल.s का sutra_float_div शून्य-भाजक पर इसे बुलाता */
void sutra_throw_div_by_zero() {
    sutra_throw_str("अनुष्ठान-त्रुटिः — शून्येन विभाजनम् न सम्भवति (Division by zero)");
}

/* स्मृति_स्थिति — non-allocating (sr_out) ताकि यह उन्हीं गणकों को न बिगाड़े
 * जो यह छापता है। बाकी GC-bridge / str-hot-path अब मूल_रनटाइम.सूत्र में। */
void sutra_gc_status() {
    sr_out("चक्र: ");     sr_out_i64(सूत्र_गण_चक्र());     sr_out("\n");
    sr_out("सक्रिय: ");   sr_out_i64(सूत्र_गण_सक्रिय());   sr_out("\n");
    sr_out("संग्रहित: "); sr_out_i64(सूत्र_गण_संग्रहित()); sr_out("\n");
}

/* ============================================================
 * पतले shims — compiler अभी इन नामों पर भेजता; असली logic मूल_रनटाइम.सूत्र।
 * (str_alloc / str_get / substr / arr_get/set / obj_alloc / add_dynamic /
 *  find / dict_keys / native_is_* / gc_collect — सब हट गए; उत्सर्जक/निम्नक
 *  सीधे रन_क्या_* / पाठ_रचना / पाठ_सूचकांक / पाठ_उपखंड / सूची_सूचकांक(_सेट) /
 *  वस्तु_रचना / पाठ_योग_गतिक / पाठ_खोज_गतिक / शब्दकोश_कुंजियाँ_रन /
 *  पाठ_बड़ा/छोटा / संग्रह_रन भेजते।)
 * ============================================================ */
void* sutra_dynamic_type(void* ptr)   { return गतिशील_प्रकार((int64_t)ptr); }
void  sutra_print_dynamic(int64_t v)   { गतिशील_छापो(v); }
void* sutra_int_to_str(int64_t v)      { return संख्या_से_पाठ(v); }
void* sutra_bool_to_str(int64_t v)     { return बूल_से_पाठ(v); }
void* sutra_null_to_str()              { return शून्य_से_पाठ(); }
void  sutra_str_print(void* s)         { पाठ_छापो(s); }
void  sutra_print_null(void)           { शून्य_छापो(); }
void  sutra_print_bool(int64_t v)      { बूल_छापो(v); }
void* sutra_char_chr(int64_t cp)       { return अक्षर_बना(cp); }

void* sutra_replace(void* t, void* n, void* r) { return पाठ_बदल(t, n, r); }
void* sutra_split(void* t, void* d)     { return पाठ_विभाजन(t, d); }
void* sutra_join(void* l, void* s)      { return पाठ_संयोग(l, s); }
void* sutra_trim(void* t)               { return पाठ_छाँट(t); }
int64_t sutra_starts_with(void* t, void* p) { return पाठ_आरंभ_में(t, p); }
int64_t sutra_ends_with(void* t, void* s)   { return पाठ_अंत_में(t, s); }

void* sutra_list_append(void* arr, int64_t val) { return सूची_जोड़(arr, val); }
void* sutra_list_pop(void* arr)         { return सूची_निकाल(arr); }
void* sutra_list_insert(void* arr, int64_t idx, int64_t val) { return सूची_डाल(arr, idx, val); }
void* sutra_list_remove(void* arr, int64_t idx) { return सूची_हटा(arr, idx); }
void* sutra_list_concat(void* a, void* b) { return सूची_जोड़ो_दो(a, b); }
int64_t sutra_list_find(void* arr, int64_t val) { return सूची_खोज(arr, val); }

int64_t sutra_dict_get(void* d, void* k) { return शब्दकोश_पाओ(d, k); }
void  sutra_dict_set(void* d, void* k, int64_t v) { शब्दकोश_सेट(d, k, v); }
int64_t sutra_dict_has_key(void* d, void* k) { return शब्दकोश_कुंजी_है(d, k); }
void* sutra_dict_remove(void* d, void* k) { return शब्दकोश_हटाओ(d, k); }

/* ============================================================
 * pow(b,e) — पूर्णांक घातांक = repeated-multiply; भिन्नात्मक = exp(e·ln b)।
 * bit-reinterpret (double↔int64) चाहिए जो सूत्र नहीं कर सकता → C में।
 * कोडबेस में केवल पूर्णांक घातांक इस्तेमाल होता; कोई libm।
 * ============================================================ */
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
