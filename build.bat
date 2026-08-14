@echo off
chcp 65001 > nul
echo [सूत्र] संकलकस्य निर्माणम् प्रचलति (Building Sutra Compiler)...
g++ -std=c++17 -finput-charset=UTF-8 -fexec-charset=UTF-8 -I"संकलक/include" संकलक/src/unicode.cpp संकलक/src/token.cpp संकलक/src/lexer.cpp संकलक/src/ast.cpp संकलक/src/parser.cpp संकलक/src/semantic.cpp संकलक/src/value.cpp संकलक/src/types.cpp संकलक/src/memory.cpp  संकलक/src/स्मृतिसंग्राहक.cpp संकलक/src/runtime/runtime.cpp संकलक/src/runtime/io.cpp संकलक/src/runtime/environment.cpp संकलक/src/runtime/filesystem.cpp संकलक/src/runtime/windows.cpp संकलक/src/runtime/linux.cpp संकलक/src/environment.cpp संकलक/src/interpreter.cpp संकलक/src/main.cpp -o sutra.exe
if %ERRORLEVEL% EQU 0 (
    if not exist build mkdir build
    copy /Y sutra.exe build\sutra.exe > nul
    echo [सफलम्] sutra.exe निर्मितम्! (Build Successful!)
) else (
    echo [त्रुटिः] निर्माणम् असफलम् (Build Failed!)
)
