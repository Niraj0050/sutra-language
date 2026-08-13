#ifndef SUTRA_TOKEN_HPP
#define SUTRA_TOKEN_HPP

#include <string>
#include <unordered_map>
#include <cstddef>

namespace sutra {

enum class TokenType {
    // Keywords
    K_KARYA,         // कार्य
    K_MUKHYA,        // मुख्य
    K_LIKHATU,       // लिखतु
    K_DARSHAYATU,    // दर्शयतु
    K_PANKTIM,       // पंक्तिं
    K_YADI,          // यदि
    K_AGAR,          // अगर
    K_ANYATHA,       // अन्यथा
    K_PUNARAVRTTIH,  // पुनरावृत्तिः
    K_YAVAT,         // यावत्
    K_JABTAK,        // जबतक
    K_PATHATU,       // पठतु
    K_VIRAMAH,       // विरामः
    K_JARIRAH,       // जारीरह / अग्रिमः
    K_PRAYATNA,      // प्रयत्न / प्रयासः (try)
    K_PAKADO,        // पकड़ो / ग्रहणम् (catch)
    K_PRAKSHEPAH,    // प्रक्षेपः / फेको (throw)
    K_AAYAT,         // आयात (import)
    K_PARAT,         // परत्
    K_SATYA,         // सत्य
    K_ASATYA,        // असत्य
    K_SHUNYAM,       // शून्यम्
    K_MAAN,          // मान
    K_SANKHYA,       // संख्या
    K_DASHAMLAV,     // दशमलव
    K_PATH,          // पाठ
    K_BOOL,          // बूल
    K_SUCHI,         // सूची
    K_VARGA,         // वर्ग
    K_NAVIN,         // नवीन
    K_SVA,           // स्व
    K_TATHA,         // तथा
    K_ATHAVA,        // अथवा
    K_NA,            // न

    // Identifiers and Literals
    IDENTIFIER,
    INT_LITERAL,
    FLOAT_LITERAL,
    STRING_LITERAL,

    // Operators
    PLUS,           // +
    MINUS,          // -
    STAR,           // *
    SLASH,          // /
    MOD,            // %
    ASSIGN,         // =
    EQUAL,          // ==
    NOT_EQUAL,      // !=
    GREATER,        // >
    LESS,           // <
    GREATER_EQUAL,  // >=
    LESS_EQUAL,     // <=
    LOGICAL_AND,    // &&
    LOGICAL_OR,     // ||
    LOGICAL_NOT,    // !

    // Delimiters
    LPAREN,         // (
    RPAREN,         // )
    LBRACE,         // {
    RBRACE,         // }
    LBRACKET,       // [
    RBRACKET,       // ]
    COMMA,          // ,
    SEMICOLON,      // ;
    DOT,            // .

    // Special
    END_OF_FILE,
    UNKNOWN_TOKEN
};

struct Token {
    TokenType type;
    std::string lexeme;
    size_t line;
    size_t column;

    Token() : type(TokenType::END_OF_FILE), lexeme(""), line(0), column(0) {}
    Token(TokenType t, std::string lex, size_t l, size_t c)
        : type(t), lexeme(std::move(lex)), line(l), column(c) {}
};

std::string token_type_to_string(TokenType type);
TokenType lookup_keyword(const std::string& identifier);

} // namespace sutra

#endif // SUTRA_TOKEN_HPP
