#include "sutra/lexer.hpp"
#include "sutra/parser.hpp"
#include "sutra/semantic.hpp"
#include "sutra/interpreter.hpp"
#include "sutra/repl.hpp"
#include "sutra/error.hpp"
#include "sutra/compiler/ir_generator.hpp"
#include "sutra/compiler/codegen.hpp"

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#ifdef _WIN32
#include <windows.h>
#include <shellapi.h>
#endif

void configure_utf8_console() {
#ifdef _WIN32
    SetConsoleOutputCP(CP_UTF8);
    SetConsoleCP(CP_UTF8);

    HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    if (hOut != INVALID_HANDLE_VALUE) {
        DWORD dwMode = 0;
        if (GetConsoleMode(hOut, &dwMode)) {
            dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
            SetConsoleMode(hOut, dwMode);
        }
    }

    HANDLE hIn = GetStdHandle(STD_INPUT_HANDLE);
    if (hIn != INVALID_HANDLE_VALUE) {
        DWORD dwMode = 0;
        if (GetConsoleMode(hIn, &dwMode)) {
            dwMode |= ENABLE_EXTENDED_FLAGS;
            SetConsoleMode(hIn, dwMode);
        }
    }
#endif
}

std::string read_file_utf8(const std::string& path_utf8) {
#ifdef _WIN32
    int len = MultiByteToWideChar(
        CP_UTF8, 0, path_utf8.c_str(), -1, nullptr, 0
    );

    if (len <= 1) {
        throw sutra::SutraError(
            "सञ्चिका न लब्धा (File not found): " + path_utf8
        );
    }

    std::wstring wpath(len - 1, 0);

    MultiByteToWideChar(
        CP_UTF8,
        0,
        path_utf8.c_str(),
        -1,
        &wpath[0],
        len
    );

    std::ifstream file(
        wpath.c_str(),
        std::ios::in | std::ios::binary
    );
#else
    std::ifstream file(
        path_utf8,
        std::ios::in | std::ios::binary
    );
#endif

    if (!file.is_open()) {
        throw sutra::SutraError(
            "सञ्चिका न लब्धा (File not found): " + path_utf8
        );
    }

    std::ostringstream ss;
    ss << file.rdbuf();

    return ss.str();
}

void print_version() {
    std::cout << "सूत्र भाषा 1.0.0 (Sutra 1.0.0)\n";
}

void print_usage() {
    std::cout
        << "=== सूत्र (Sutra) प्रोग्रामिंग भाषा v1.0.0 ===\n"
        << "उपयोगः:\n"
        << "  sutra                          (REPL Terminal Mode)\n"
        << "  sutra <file.सूत्र>              (File Execution Mode - Interpreter)\n"
        << "  sutra चलाओ <सञ्चिका.सूत्र>        (File Execution Mode - Interpreter)\n"
        << "  sutra build <सञ्चिका.सूत्र>      (Native x86-64 Compiler Mode)\n"
        << "  sutra संकलन <सञ्चिका.सूत्र>      (Native x86-64 Compiler Mode)\n"
        << "  sutra --help | -h              (Display Usage Information)\n"
        << "  sutra --version | -v           (Display Version Information)\n";
}

int run_sutra(const std::vector<std::string>& args) {
    if (args.size() <= 1) {
        sutra::run_repl();
        return 0;
    }

    std::string arg1 = args[1];

    if (arg1 == "--version" || arg1 == "-v" || arg1 == "संस्करण") {
        print_version();
        return 0;
    }

    if (arg1 == "--help" || arg1 == "-h" || arg1 == "सहायता") {
        print_usage();
        return 0;
    }

    bool compile_native = false;
    std::string file_path;

    if ((arg1 == "build" || arg1 == "संकलन") && args.size() >= 3) {
        compile_native = true;
        file_path = args[2];
    } else if ((arg1 == "चलाओ" || arg1 == "run") && args.size() >= 3) {
        file_path = args[2];
    } else {
        file_path = arg1;
    }

    try {
        std::string source = read_file_utf8(file_path);

        // शाब्दिक विश्लेषण
        sutra::Lexer lexer(source);
        std::vector<sutra::Token> tokens = lexer.tokenize();

        // // DEBUG: token dump
        // for (const auto& token : tokens) {
        //     std::cout << "[" << token.line << ":" << token.column << "] "
        //               << sutra::token_type_to_string(token.type)
        //               << " => '" << token.lexeme << "'\n";
        // }

        // वाक्यविन्यास विश्लेषण
        sutra::Parser parser(tokens, file_path);
        auto program = parser.parse_program();

        // अर्थगत विश्लेषण
        sutra::SemanticAnalyzer analyzer;
        analyzer.analyze(*program);

        if (compile_native) {
            std::cout << "[SUTRA COMPILER] Generating IR and x86-64 Machine Code...\n";
            sutra::compiler::IRGenerator ir_gen;
            auto ir_module = ir_gen.generate(*program, file_path);

            std::string out_exe = file_path;
            if (out_exe.find_last_of('.') != std::string::npos) {
                out_exe = out_exe.substr(0, out_exe.find_last_of('.'));
            }
            out_exe += "_native.exe";

            sutra::compiler::NativeCodeGenX86_64 codegen;
            if (codegen.compile_to_binary(*ir_module, out_exe)) {
                std::cout << "[SUTRA COMPILER] Native binary generated successfully: " << out_exe << "\n";
            } else {
                std::cerr << "[SUTRA COMPILER ERROR] Failed to generate native executable.\n";
                return 1;
            }
            return 0;
        }

        // निष्पादन (Interpreter Mode)
        sutra::Interpreter interpreter;
        interpreter.execute_program(*program, std::cout);

    } catch (const sutra::SutraError& err) {
        std::cerr << err.what() << "\n";
        return 1;

    } catch (const std::exception& ex) {
        std::cerr << "अज्ञात-त्रुटिः: "
                  << ex.what()
                  << "\n";
        return 1;
    }

    return 0;
}

int main(int argc, char* argv[]) {
    configure_utf8_console();

    std::vector<std::string> utf8_args;

#ifdef _WIN32

    int wargc = 0;

    wchar_t** wargv =
        CommandLineToArgvW(
            GetCommandLineW(),
            &wargc
        );

    if (wargv) {
        for (int i = 0; i < wargc; ++i) {

            int len = WideCharToMultiByte(
                CP_UTF8,
                0,
                wargv[i],
                -1,
                nullptr,
                0,
                nullptr,
                nullptr
            );

            if (len > 1) {

                std::string str(len - 1, 0);

                WideCharToMultiByte(
                    CP_UTF8,
                    0,
                    wargv[i],
                    -1,
                    &str[0],
                    len,
                    nullptr,
                    nullptr
                );

                utf8_args.push_back(str);

            } else {
                utf8_args.push_back("");
            }
        }

        LocalFree(wargv);
    }

#else

    for (int i = 0; i < argc; ++i) {
        utf8_args.push_back(argv[i]);
    }

#endif

    return run_sutra(utf8_args);
}
