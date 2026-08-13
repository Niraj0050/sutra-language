#include "sutra/lexer.hpp"
#include "sutra/unicode.hpp"

namespace sutra {

Lexer::Lexer(std::string source)
    : m_source(std::move(source)) {}

uint32_t Lexer::peek_cp() const {

    if (m_index >= m_source.size()) {
        return 0;
    }

    size_t tmp = m_index;

    return decode_utf8(m_source, tmp);
}

uint32_t Lexer::advance_cp() {

    if (m_index >= m_source.size()) {
        return 0;
    }

    size_t prev_index = m_index;

    uint32_t cp = decode_utf8(
        m_source,
        m_index
    );

    if (cp == '\n') {

        m_line++;
        m_column = 1;

    } else {

        m_column += (m_index - prev_index);
    }

    return cp;
}

void Lexer::skip_whitespace_and_comments() {

    while (m_index < m_source.size()) {

        uint32_t cp = peek_cp();

        if (is_sutra_whitespace(cp)) {

            advance_cp();
            continue;
        }

        if (cp == '/') {

            size_t next_idx = m_index;

            decode_utf8(
                m_source,
                next_idx
            );

            uint32_t next_cp =
                (next_idx < m_source.size())
                    ? decode_utf8(m_source, next_idx)
                    : 0;

            if (next_cp == '/') {

                advance_cp();
                advance_cp();

                while (
                    m_index < m_source.size() &&
                    peek_cp() != '\n'
                ) {
                    advance_cp();
                }

                continue;

            } else if (next_cp == '*') {

                advance_cp();
                advance_cp();

                while (m_index < m_source.size()) {

                    uint32_t c = advance_cp();

                    if (
                        c == '*' &&
                        peek_cp() == '/'
                    ) {
                        advance_cp();
                        break;
                    }
                }

                continue;
            }
        }

        break;
    }
}

Token Lexer::scan_identifier_or_keyword() {

    size_t start_line = m_line;
    size_t start_col = m_column;

    std::string lexeme;

    while (m_index < m_source.size()) {

        uint32_t cp = peek_cp();

        if (is_identifier_continue(cp)) {

            lexeme += encode_utf8(cp);
            advance_cp();

        } else {
            break;
        }
    }

    TokenType type = lookup_keyword(lexeme);

    return Token(
        type,
        lexeme,
        start_line,
        start_col
    );
}

Token Lexer::scan_number() {

    size_t start_line = m_line;
    size_t start_col = m_column;

    std::string lexeme;

    bool is_float = false;

    while (m_index < m_source.size()) {

        uint32_t cp = peek_cp();

        if (
            is_ascii_digit(cp) ||
            is_devanagari_digit(cp)
        ) {

            if (is_devanagari_digit(cp)) {

                lexeme += std::to_string(
                    devanagari_digit_to_int(cp)
                );

            } else {

                lexeme += encode_utf8(cp);
            }

            advance_cp();

        } else if (cp == '.' && !is_float) {

            size_t next_idx = m_index;

            decode_utf8(
                m_source,
                next_idx
            );

            uint32_t next_cp =
                (next_idx < m_source.size())
                    ? decode_utf8(m_source, next_idx)
                    : 0;

            if (
                is_ascii_digit(next_cp) ||
                is_devanagari_digit(next_cp)
            ) {

                is_float = true;

                lexeme += '.';

                advance_cp();

            } else {

                break;
            }

        } else {

            break;
        }
    }

    TokenType type =
        is_float
            ? TokenType::FLOAT_LITERAL
            : TokenType::INT_LITERAL;

    return Token(
        type,
        lexeme,
        start_line,
        start_col
    );
}

Token Lexer::scan_string() {

    size_t start_line = m_line;
    size_t start_col = m_column;

    advance_cp();

    std::string lexeme;

    bool closed = false;

    while (m_index < m_source.size()) {

        uint32_t cp = advance_cp();

        if (cp == '"') {

            closed = true;
            break;

        } else if (cp == '\\') {

            if (m_index >= m_source.size()) {
                break;
            }

            uint32_t next_cp = advance_cp();

            if (next_cp == 'n') {
                lexeme += '\n';
            } else if (next_cp == 't') {
                lexeme += '\t';
            } else if (next_cp == 'r') {
                lexeme += '\r';
            } else if (next_cp == '"') {
                lexeme += '"';
            } else if (next_cp == '\\') {
                lexeme += '\\';
            } else {
                lexeme += encode_utf8(next_cp);
            }

        } else {

            lexeme += encode_utf8(cp);
        }
    }

    if (!closed) {

        throw LexerError(
            "पाठस्य समाप्तिः न दृष्टा "
            "(Unterminated string literal)",
            start_line,
            start_col
        );
    }

    return Token(
        TokenType::STRING_LITERAL,
        lexeme,
        start_line,
        start_col
    );
}

std::vector<Token> Lexer::tokenize() {

    std::vector<Token> tokens;

    while (m_index < m_source.size()) {

        skip_whitespace_and_comments();

        if (m_index >= m_source.size()) {
            break;
        }

        size_t start_line = m_line;
        size_t start_col = m_column;

        uint32_t cp = peek_cp();

        if (is_identifier_start(cp)) {

            tokens.push_back(
                scan_identifier_or_keyword()
            );

        } else if (
            is_ascii_digit(cp) ||
            is_devanagari_digit(cp)
        ) {

            tokens.push_back(
                scan_number()
            );

        } else if (cp == '"') {

            tokens.push_back(
                scan_string()
            );

        } else {

            advance_cp();

            switch (cp) {

                case '+':
                    tokens.emplace_back(
                        TokenType::PLUS,
                        "+",
                        start_line,
                        start_col
                    );
                    break;

                case '-':
                    tokens.emplace_back(
                        TokenType::MINUS,
                        "-",
                        start_line,
                        start_col
                    );
                    break;

                case '*':
                    tokens.emplace_back(
                        TokenType::STAR,
                        "*",
                        start_line,
                        start_col
                    );
                    break;

                case '/':
                    tokens.emplace_back(
                        TokenType::SLASH,
                        "/",
                        start_line,
                        start_col
                    );
                    break;

                case '%':
                    tokens.emplace_back(
                        TokenType::MOD,
                        "%",
                        start_line,
                        start_col
                    );
                    break;

                case '(':
                    tokens.emplace_back(
                        TokenType::LPAREN,
                        "(",
                        start_line,
                        start_col
                    );
                    break;

                case ')':
                    tokens.emplace_back(
                        TokenType::RPAREN,
                        ")",
                        start_line,
                        start_col
                    );
                    break;

                case '{':
                    tokens.emplace_back(
                        TokenType::LBRACE,
                        "{",
                        start_line,
                        start_col
                    );
                    break;

                case '}':
                    tokens.emplace_back(
                        TokenType::RBRACE,
                        "}",
                        start_line,
                        start_col
                    );
                    break;

                case '[':
                    tokens.emplace_back(
                        TokenType::LBRACKET,
                        "[",
                        start_line,
                        start_col
                    );
                    break;

                case ']':
                    tokens.emplace_back(
                        TokenType::RBRACKET,
                        "]",
                        start_line,
                        start_col
                    );
                    break;

                case ',':
                    tokens.emplace_back(
                        TokenType::COMMA,
                        ",",
                        start_line,
                        start_col
                    );
                    break;

                case ';':
                    tokens.emplace_back(
                        TokenType::SEMICOLON,
                        ";",
                        start_line,
                        start_col
                    );
                    break;

                case '.':
                    tokens.emplace_back(
                        TokenType::DOT,
                        ".",
                        start_line,
                        start_col
                    );
                    break;

                case '=':

                    if (peek_cp() == '=') {

                        advance_cp();

                        tokens.emplace_back(
                            TokenType::EQUAL,
                            "==",
                            start_line,
                            start_col
                        );

                    } else {

                        tokens.emplace_back(
                            TokenType::ASSIGN,
                            "=",
                            start_line,
                            start_col
                        );
                    }

                    break;

                case '&':
                    if (peek_cp() == '&') {
                        advance_cp();
                        tokens.emplace_back(
                            TokenType::LOGICAL_AND,
                            "&&",
                            start_line,
                            start_col
                        );
                    } else {
                        throw LexerError(
                            "अमान्यः प्रतीकः '&'",
                            start_line,
                            start_col
                        );
                    }
                    break;

                case '|':
                    if (peek_cp() == '|') {
                        advance_cp();
                        tokens.emplace_back(
                            TokenType::LOGICAL_OR,
                            "||",
                            start_line,
                            start_col
                        );
                    } else {
                        throw LexerError(
                            "अमान्यः प्रतीकः '|'",
                            start_line,
                            start_col
                        );
                    }
                    break;

                case '!':

                    if (peek_cp() == '=') {

                        advance_cp();

                        tokens.emplace_back(
                            TokenType::NOT_EQUAL,
                            "!=",
                            start_line,
                            start_col
                        );

                    } else {
                        tokens.emplace_back(
                            TokenType::LOGICAL_NOT,
                            "!",
                            start_line,
                            start_col
                        );
                    }

                    break;

                case '>':

                    if (peek_cp() == '=') {

                        advance_cp();

                        tokens.emplace_back(
                            TokenType::GREATER_EQUAL,
                            ">=",
                            start_line,
                            start_col
                        );

                    } else {

                        tokens.emplace_back(
                            TokenType::GREATER,
                            ">",
                            start_line,
                            start_col
                        );
                    }

                    break;

                case '<':

                    if (peek_cp() == '=') {

                        advance_cp();

                        tokens.emplace_back(
                            TokenType::LESS_EQUAL,
                            "<=",
                            start_line,
                            start_col
                        );

                    } else {

                        tokens.emplace_back(
                            TokenType::LESS,
                            "<",
                            start_line,
                            start_col
                        );
                    }

                    break;

                default:

                    throw LexerError(
                        "अज्ञातः वर्णः '" +
                        encode_utf8(cp) +
                        "'",
                        start_line,
                        start_col
                    );
            }
        }
    }

    tokens.emplace_back(
        TokenType::END_OF_FILE,
        "",
        m_line,
        m_column
    );

    return tokens;
}

} // namespace sutra