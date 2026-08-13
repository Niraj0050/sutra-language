#include "sutra/repl.hpp"
#include "sutra/lexer.hpp"
#include "sutra/parser.hpp"
#include "sutra/semantic.hpp"
#include "sutra/interpreter.hpp"
#include "sutra/error.hpp"

#include <iostream>
#include <set>
#include <string>
#include <vector>
#include <cstdlib>
#include <algorithm>

#ifdef _WIN32
#include <windows.h>

static bool read_win32_console_line(std::string& out_utf8) {
    HANDLE hIn = GetStdHandle(STD_INPUT_HANDLE);
    if (hIn == INVALID_HANDLE_VALUE || GetFileType(hIn) != FILE_TYPE_CHAR) {
        return false; // Not interactive console input handle or redirected
    }

    std::wstring wline;
    wchar_t ch;
    DWORD read_count = 0;

    while (ReadConsoleW(hIn, &ch, 1, &read_count, NULL) && read_count > 0) {
        if (ch == L'\r') {
            continue;
        }
        if (ch == L'\n') {
            break;
        }
        wline.push_back(ch);
    }

    if (wline.empty() && read_count == 0) {
        return false;
    }

    int len = WideCharToMultiByte(CP_UTF8, 0, wline.c_str(), static_cast<int>(wline.size()), nullptr, 0, nullptr, nullptr);
    if (len > 0) {
        out_utf8.resize(len);
        WideCharToMultiByte(CP_UTF8, 0, wline.c_str(), static_cast<int>(wline.size()), &out_utf8[0], len, nullptr, nullptr);
    } else {
        out_utf8.clear();
    }
    return true;
}
#endif

static bool get_input_line(std::string& line) {
#ifdef _WIN32
    if (read_win32_console_line(line)) {
        return true;
    }
#endif
    return static_cast<bool>(std::getline(std::cin, line));
}

namespace sutra {

static std::string trim(const std::string& str) {
    size_t first = str.find_first_not_of(" \t\r\n");
    if (first == std::string::npos) return "";
    size_t last = str.find_last_not_of(" \t\r\n");
    return str.substr(first, (last - first + 1));
}

static int count_net_braces(const std::string& line) {
    int count = 0;
    bool in_string = false;
    for (size_t i = 0; i < line.size(); ++i) {
        char c = line[i];
        if (c == '"' && (i == 0 || line[i - 1] != '\\')) {
            in_string = !in_string;
        } else if (!in_string) {
            if (c == '{') count++;
            else if (c == '}') count--;
        }
    }
    return count;
}

static void print_banner() {
    std::cout << "╔══════════════════════════════════════╗\n"
              << "║             सूत्र Terminal            ║\n"
              << "║       Hindi Programming REPL          ║\n"
              << "║            संस्करण 1.0.0              ║\n"
              << "╚══════════════════════════════════════╝\n\n";
}

static void print_help() {
    std::cout << "सहायता    - सहायता दिखाएँ\n"
              << "बाहर / निकास / निर्गमः - सूत्र Terminal बंद करें\n"
              << "साफ       - terminal साफ करें\n"
              << "संस्करण   - Sutra version दिखाएँ\n";
}

static void clear_screen() {
#ifdef _WIN32
    system("cls");
#else
    system("clear");
#endif
}

void run_repl() {
    print_banner();

    Interpreter interpreter;
    SemanticAnalyzer analyzer;
    analyzer.init_repl();

    std::string accumulated_source;
    int net_braces = 0;

    while (true) {
        if (net_braces == 0) {
            std::cout << "सूत्र> ";
        } else {
            std::cout << "... ";
        }

        std::string line;
        if (!get_input_line(line)) {
            std::cout << "\n";
            break;
        }

        std::string trimmed = trim(line);

        // Handle single-line Builtin REPL commands when not inside a multi-line block
        if (net_braces == 0) {
            if (trimmed == "बाहर" || trimmed == "निकास" || trimmed == "निर्गमः" || trimmed == "exit" || trimmed == "quit") {
                break;
            }
            if (trimmed == "सहायता" || trimmed == "help") {
                print_help();
                continue;
            }
            if (trimmed == "संस्करण" || trimmed == "version") {
                std::cout << "सूत्र भाषा 1.0.0 (Sutra 1.0.0)\n";
                continue;
            }
            if (trimmed == "साफ" || trimmed == "clear" || trimmed == "cls") {
                clear_screen();
                continue;
            }
        }

        net_braces += count_net_braces(line);
        accumulated_source += line + "\n";

        if (net_braces > 0) {
            continue; // Continue reading multi-line block
        }

        // Reset brace tracking for next statement block
        net_braces = 0;
        std::string code_to_run = accumulated_source;
        accumulated_source.clear();

        if (trim(code_to_run).empty()) {
            continue;
        }

        try {
            Lexer lexer(code_to_run);
            std::vector<Token> tokens = lexer.tokenize();

            if (tokens.size() <= 1 && tokens[0].type == TokenType::END_OF_FILE) {
                continue;
            }

            Parser parser(tokens, "repl_input.सूत्र");
            parser.set_imported_files(std::make_shared<std::set<std::string>>());
            auto program = parser.parse_program();

            analyzer.analyze_repl(*program);
            interpreter.execute_repl_program(*program, std::cout);

        } catch (const SutraError& err) {
            std::cout << err.what() << "\n";
        } catch (const std::exception& ex) {
            std::cout << "त्रुटिः: " << ex.what() << "\n";
        }
    }
}

} // namespace sutra
