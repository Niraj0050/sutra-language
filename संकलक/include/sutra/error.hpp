#ifndef SUTRA_ERROR_HPP
#define SUTRA_ERROR_HPP

#include <string>
#include <stdexcept>
#include <cstddef>

namespace sutra {

class SutraError : public std::runtime_error {
public:
    size_t line;
    size_t column;
    std::string message;

    SutraError(const std::string& msg, size_t l = 0, size_t c = 0)
        : std::runtime_error(format_sutra_error(msg, l, c)), line(l), column(c), message(msg) {}

    static std::string format_sutra_error(const std::string& msg, size_t l, size_t c) {
        if (l > 0) {
            return "त्रुटिः [पङ्क्तिः " + std::to_string(l) + ", स्तम्भः " + std::to_string(c) + "]: " + msg;
        }
        return "त्रुटिः: " + msg;
    }
};

class LexerError : public SutraError {
public:
    LexerError(const std::string& msg, size_t l, size_t c)
        : SutraError("अक्षर-वाचन-त्रुटिः — " + msg, l, c) {}
};

class ParserError : public SutraError {
public:
    ParserError(const std::string& msg, size_t l, size_t c)
        : SutraError("वाक्य-विच्छेद-त्रुटिः — " + msg, l, c) {}
};

class SemanticError : public SutraError {
public:
    SemanticError(const std::string& msg, size_t l = 0, size_t c = 0)
        : SutraError("अर्थ-परीक्षण-त्रुटिः — " + msg, l, c) {}
};

class RuntimeError : public SutraError {
public:
    RuntimeError(const std::string& msg, size_t l = 0, size_t c = 0)
        : SutraError("अनुष्ठान-त्रुटिः — " + msg, l, c) {}
};

class MemoryError : public SutraError {
public:
    MemoryError(const std::string& msg, size_t l = 0, size_t c = 0)
        : SutraError("स्मृति-त्रुटिः — " + msg, l, c) {}
};

} // namespace sutra

#endif // SUTRA_ERROR_HPP
