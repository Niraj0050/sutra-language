#include "sutra/unicode.hpp"

namespace sutra {

uint32_t decode_utf8(const std::string& str, size_t& index) {
    if (index >= str.size()) return 0;

    unsigned char c1 = static_cast<unsigned char>(str[index]);
    if (c1 < 0x80) {
        index += 1;
        return c1;
    } else if ((c1 & 0xE0) == 0xC0) {
        if (index + 1 >= str.size()) { index = str.size(); return 0xFFFD; }
        unsigned char c2 = static_cast<unsigned char>(str[index + 1]);
        index += 2;
        return ((c1 & 0x1F) << 6) | (c2 & 0x3F);
    } else if ((c1 & 0xF0) == 0xE0) {
        if (index + 2 >= str.size()) { index = str.size(); return 0xFFFD; }
        unsigned char c2 = static_cast<unsigned char>(str[index + 1]);
        unsigned char c3 = static_cast<unsigned char>(str[index + 2]);
        index += 3;
        return ((c1 & 0x0F) << 12) | ((c2 & 0x3F) << 6) | (c3 & 0x3F);
    } else if ((c1 & 0xF8) == 0xF0) {
        if (index + 3 >= str.size()) { index = str.size(); return 0xFFFD; }
        unsigned char c2 = static_cast<unsigned char>(str[index + 1]);
        unsigned char c3 = static_cast<unsigned char>(str[index + 2]);
        unsigned char c4 = static_cast<unsigned char>(str[index + 3]);
        index += 4;
        return ((c1 & 0x07) << 18) | ((c2 & 0x3F) << 12) | ((c3 & 0x3F) << 6) | (c4 & 0x3F);
    }

    index += 1;
    return 0xFFFD; // Replacement character for invalid UTF-8
}

std::string encode_utf8(uint32_t cp) {
    std::string out;
    if (cp <= 0x7F) {
        out.push_back(static_cast<char>(cp));
    } else if (cp <= 0x7FF) {
        out.push_back(static_cast<char>(0xC0 | ((cp >> 6) & 0x1F)));
        out.push_back(static_cast<char>(0x80 | (cp & 0x3F)));
    } else if (cp <= 0xFFFF) {
        out.push_back(static_cast<char>(0xE0 | ((cp >> 12) & 0x0F)));
        out.push_back(static_cast<char>(0x80 | ((cp >> 6) & 0x3F)));
        out.push_back(static_cast<char>(0x80 | (cp & 0x3F)));
    } else if (cp <= 0x10FFFF) {
        out.push_back(static_cast<char>(0xF0 | ((cp >> 18) & 0x07)));
        out.push_back(static_cast<char>(0x80 | ((cp >> 12) & 0x3F)));
        out.push_back(static_cast<char>(0x80 | ((cp >> 6) & 0x3F)));
        out.push_back(static_cast<char>(0x80 | (cp & 0x3F)));
    }
    return out;
}

size_t utf8_codepoint_count(const std::string& str) {
    size_t count = 0;
    size_t i = 0;

    while (i < str.size()) {
        unsigned char c = static_cast<unsigned char>(str[i]);

        if (c < 0x80) {
            ++i;
        } else if ((c & 0xE0) == 0xC0) {
            i += 2;
        } else if ((c & 0xF0) == 0xE0) {
            i += 3;
        } else if ((c & 0xF8) == 0xF0) {
            i += 4;
        } else {
            ++i;
        }

        ++count;
    }

    return count;
}

bool is_devanagari_letter(uint32_t cp) {
    // Independent vowels U+0904..U+0914, Consonants U+0915..U+0939, Additional letters U+0958..U+0961, U+0972..U+097F
    return (cp >= 0x0904 && cp <= 0x0939) ||
           (cp >= 0x0958 && cp <= 0x0961) ||
           (cp >= 0x0972 && cp <= 0x097F);
}

bool is_devanagari_combining(uint32_t cp) {
    // Signs: Anusvara (0902), Visarga (0903), Chandrabindu (0901), Nukta (093C)
    // Dependent Vowel Signs (Matras): 093E..094C, 094E..094F, 0955..0957, 0962..0963
    // Virama: 094D
    return (cp >= 0x0900 && cp <= 0x0903) ||
           (cp == 0x093C) ||
           (cp >= 0x093E && cp <= 0x094F) ||
           (cp >= 0x0951 && cp <= 0x0957) ||
           (cp >= 0x0962 && cp <= 0x0963);
}

bool is_devanagari_digit(uint32_t cp) {
    return (cp >= 0x0966 && cp <= 0x096F);
}

bool is_ascii_alpha(uint32_t cp) {
    return (cp >= 'a' && cp <= 'z') || (cp >= 'A' && cp <= 'Z') || cp == '_';
}

bool is_ascii_digit(uint32_t cp) {
    return (cp >= '0' && cp <= '9');
}

bool is_identifier_start(uint32_t cp) {
    return is_devanagari_letter(cp) || is_ascii_alpha(cp);
}

bool is_identifier_continue(uint32_t cp) {
    return is_identifier_start(cp) || is_devanagari_combining(cp) || is_devanagari_digit(cp) || is_ascii_digit(cp);
}

bool is_sutra_whitespace(uint32_t cp) {
    return cp == ' ' || cp == '\t' || cp == '\r' || cp == '\n' || cp == 0xFEFF;
}

int devanagari_digit_to_int(uint32_t cp) {
    if (is_devanagari_digit(cp)) {
        return static_cast<int>(cp - 0x0966);
    }
    if (is_ascii_digit(cp)) {
        return static_cast<int>(cp - '0');
    }
    return -1;
}

} // namespace sutra
