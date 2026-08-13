#include "sutra/lexer.hpp"
#include "sutra/parser.hpp"
#include "sutra/semantic.hpp"
#include "sutra/interpreter.hpp"
#include "sutra/error.hpp"

#include <iostream>
#include <sstream>
#include <cassert>

#ifdef _WIN32
#include <windows.h>
#endif

void test_lexer() {
    std::cout << "[परीक्षणम् 1] Lexer Test... ";
    std::string src = "कार्य मुख्य() { लिखतु(\"नमस्ते जगत्!\"); }";
    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();

    assert(tokens.size() >= 10);
    assert(tokens[0].type == sutra::TokenType::K_KARYA);
    assert(tokens[1].type == sutra::TokenType::K_MUKHYA);
    assert(tokens[2].type == sutra::TokenType::LPAREN);
    assert(tokens[3].type == sutra::TokenType::RPAREN);
    assert(tokens[4].type == sutra::TokenType::LBRACE);
    assert(tokens[5].type == sutra::TokenType::K_LIKHATU);
    assert(tokens[6].type == sutra::TokenType::LPAREN);
    assert(tokens[7].type == sutra::TokenType::STRING_LITERAL);
    assert(tokens[7].lexeme == "नमस्ते जगत्!");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_namaste() {
    std::cout << "[परीक्षणम् 2] Execution Test (नमस्ते.सूत्र)... ";
    std::string src = "कार्य मुख्य() { लिखतु(\"नमस्ते जगत्!\"); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "नमस्ते जगत्!\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_arithmetic() {
    std::cout << "[परीक्षणम् 3] Arithmetic Test (10 + 20)... ";
    std::string src = "कार्य मुख्य() { संख्या अ = 10; संख्या ब = 20; लिखतु(अ + ब); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "30\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_conditional() {
    std::cout << "[परीक्षणम् 4] Conditional Test (यदि/अन्यथा)... ";
    std::string src = "कार्य मुख्य() { संख्या वयः = 22; यदि (वयः >= 18) { लिखतु(\"वयस्कः\"); } अन्यथा { लिखतु(\"अवयस्कः\"); } }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "वयस्कः\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_functions() {
    std::cout << "[परीक्षणम् 5] Function Test (कार्य जोड़ना)... ";
    std::string src = "कार्य जोड़ना(संख्या अ, संख्या ब) { परत् अ + ब; } कार्य मुख्य() { लिखतु(जोड़ना(15, 25)); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "40\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_semantic_undefined_variable() {
    std::cout << "[परीक्षणम् 6] Semantic Error Test (अपरिभाषितः चरः)... ";
    std::string src = "कार्य मुख्य() { लिखतु(परिणामः); }";

    try {
        sutra::Lexer lexer(src);
        auto tokens = lexer.tokenize();
        sutra::Parser parser(tokens);
        auto program = parser.parse_program();

        sutra::SemanticAnalyzer analyzer;
        analyzer.analyze(*program);
        assert(false && "Should have thrown SemanticError");
    } catch (const sutra::SemanticError& err) {
        // Expected error
    }
    std::cout << "सफलम् (PASSED)\n";
}

int main() {
#ifdef _WIN32
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
#endif

    std::cout << "=== सूत्र (Sutra) परीक्षण-प्रणाली (Automated Test Suite) ===\n";
    test_lexer();
    test_interpreter_namaste();
    test_interpreter_arithmetic();
    test_interpreter_conditional();
    test_interpreter_functions();
    test_semantic_undefined_variable();

    std::cout << "सर्वाणि परीक्षणानि सफलेन संपादितानि! (All tests passed successfully!)\n";
    return 0;
}
