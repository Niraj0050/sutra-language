#ifndef SUTRA_UNICODE_HPP
#define SUTRA_UNICODE_HPP

#include <string>
#include <cstdint>
#include <cstddef>

namespace sutra {

// Decode next UTF-8 codepoint from string starting at index. Advance index.
uint32_t decode_utf8(const std::string& str, size_t& index);

// Encode codepoint to UTF-8 string
std::string encode_utf8(uint32_t codepoint);

// Character classification for Sanskrit / Devanagari and ASCII
bool is_devanagari_letter(uint32_t cp);
bool is_devanagari_combining(uint32_t cp); // Matras, Visarga, Anusvara, Virama, etc.
bool is_devanagari_digit(uint32_t cp);
bool is_ascii_alpha(uint32_t cp);
bool is_ascii_digit(uint32_t cp);

bool is_identifier_start(uint32_t cp);
bool is_identifier_continue(uint32_t cp);

bool is_sutra_whitespace(uint32_t cp);

// Convert Devanagari numerals (०-९) to ASCII int value 0-9
int devanagari_digit_to_int(uint32_t cp);

} // namespace sutra

#endif // SUTRA_UNICODE_HPP
