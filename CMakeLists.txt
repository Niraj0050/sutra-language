cmake_minimum_required(VERSION 3.16)
project(Sutra LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Configure include directories
include_directories(${PROJECT_SOURCE_DIR}/संकलक/include)

# Core library source files
set(CORE_SOURCES
    "${PROJECT_SOURCE_DIR}/संकलक/src/unicode.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/token.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/lexer.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/ast.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/parser.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/semantic.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/value.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/types.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/memory.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/स्मृतिसंग्राहक.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/runtime.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/io.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/environment.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/filesystem.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/windows.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/runtime/linux.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/environment.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/interpreter.cpp"
    "${PROJECT_SOURCE_DIR}/संकलक/src/repl.cpp"
)

# Sutra Compiler Executable Target
add_executable(sutra
    ${CORE_SOURCES}
    "${PROJECT_SOURCE_DIR}/संकलक/src/main.cpp"
)

# Automated Test Suite Executable Target
add_executable(test_sutra
    ${CORE_SOURCES}
    "${PROJECT_SOURCE_DIR}/परीक्षणानि/test_sutra.cpp"
)

