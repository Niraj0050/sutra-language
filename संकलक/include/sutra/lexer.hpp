#ifndef SUTRA_LEXER_HPP
#define SUTRA_LEXER_HPP

#include "sutra/token.hpp"
#include "sutra/error.hpp"
#include <string>
#include <vector>
#include <cstdint>

namespace sutra {

class Lexer {
public:
    explicit Lexer(std::string source);

    std::vector<Token> tokenize();

private:
    std::string m_source;
    size_t m_index{0};
    size_t m_line{1};
    size_t m_column{1};

    uint32_t peek_cp() const;
    uint32_t advance_cp();

    void skip_whitespace_and_comments();
    Token scan_identifier_or_keyword();
    Token scan_number();
    Token scan_string();
};

} // namespace sutra

#endif // SUTRA_LEXER_HPP
