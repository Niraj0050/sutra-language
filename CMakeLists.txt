cmake_minimum_required(VERSION 3.16)
project(Sutra LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use system-provided nlohmann_json if available
find_package(nlohmann_json 3.11.2 QUIET)
if (NOT nlohmann_json_FOUND)
    message(STATUS "nlohmann_json not found, falling back to FetchContent")
    set(CMAKE_POLICY_VERSION_MINIMUM 3.5)
    include(FetchContent)
    # Use an ASCII-only base directory for fetching to avoid Unicode path issues
    set(FETCHCONTENT_BASE_DIR "C:/temp/_deps")
    FetchContent_Declare(
        nlohmann_json
        GIT_REPOSITORY https://github.com/nlohmann/json.git
        GIT_TAG v3.2.0
    )
    FetchContent_MakeAvailable(nlohmann_json)
endif()

set(SUTRA_SRC "${PROJECT_SOURCE_DIR}/संकलक/src")
set(SUTRA_INC "${PROJECT_SOURCE_DIR}/संकलक/include")
set(TEST_SRC "${PROJECT_SOURCE_DIR}/परीक्षणानि")

include_directories("${SUTRA_INC}")
include_directories("${PROJECT_SOURCE_DIR}/external")

set(CORE_SOURCES
    "${SUTRA_SRC}/unicode.cpp"
    "${SUTRA_SRC}/token.cpp"
    "${SUTRA_SRC}/lexer.cpp"
    "${SUTRA_SRC}/ast.cpp"
    "${SUTRA_SRC}/parser.cpp"
    "${SUTRA_SRC}/semantic.cpp"
    "${SUTRA_SRC}/value.cpp"
    "${SUTRA_SRC}/types.cpp"
    "${SUTRA_SRC}/memory.cpp"
    "${SUTRA_SRC}/स्मृतिसंग्राहक.cpp"
    "${SUTRA_SRC}/environment.cpp"
    "${SUTRA_SRC}/interpreter.cpp"
    "${SUTRA_SRC}/repl.cpp"
    "${SUTRA_SRC}/runtime_api.cpp"
    "${SUTRA_SRC}/compiler/ir.cpp"
    "${SUTRA_SRC}/compiler/ir_generator.cpp"
    "${SUTRA_SRC}/compiler/codegen.cpp"
)

# ---------- Main compiler executable ----------
add_executable(sutra
    ${CORE_SOURCES}
    "${SUTRA_SRC}/main.cpp"
)

# ---------- Toolchain library (M4-1, M4-2, M4-3, M4-4, M4-5, M4-6) ----------
add_library(sutra_toolchain STATIC
    "${SUTRA_SRC}/toolchain.cpp"
    "${SUTRA_SRC}/formatter.cpp"
    "${SUTRA_SRC}/linter.cpp"
    "${SUTRA_SRC}/debugger.cpp"
    "${SUTRA_SRC}/package_manager.cpp"
    "${SUTRA_SRC}/build_system.cpp"
    "${SUTRA_SRC}/benchmark.cpp"
    "${SUTRA_SRC}/unicode.cpp"
    "${SUTRA_SRC}/token.cpp"
    "${SUTRA_SRC}/lexer.cpp"
)

target_include_directories(sutra_toolchain PUBLIC "${SUTRA_INC}")

# ---------- Toolchain executables ----------
add_executable(sutra_formatter
    "${PROJECT_SOURCE_DIR}/उपकरणानि/formatter/formatter.cpp"
)
target_link_libraries(sutra_formatter PRIVATE sutra_toolchain)

add_executable(sutra_linter
    "${PROJECT_SOURCE_DIR}/उपकरणानि/linter/linter.cpp"
)
target_link_libraries(sutra_linter PRIVATE sutra_toolchain)

add_executable(sutra_debugger
    "${PROJECT_SOURCE_DIR}/उपकरणानि/debugger/debugger.cpp"
)
target_link_libraries(sutra_debugger PRIVATE sutra_toolchain)

add_executable(sutra_pkgmgr
    "${PROJECT_SOURCE_DIR}/उपकरणानि/package_manager/package_manager.cpp"
)
target_link_libraries(sutra_pkgmgr PRIVATE sutra_toolchain)

add_executable(sutra_build
    "${PROJECT_SOURCE_DIR}/उपकरणानि/build_system/build_system.cpp"
)
target_link_libraries(sutra_build PRIVATE sutra_toolchain)

add_executable(sutra_benchmark
    ${CORE_SOURCES}
    "${PROJECT_SOURCE_DIR}/उपकरणानि/benchmark/benchmark.cpp"
)
target_link_libraries(sutra_benchmark PRIVATE sutra_toolchain)

# ---------- Language Server (M4-10) ----------
add_executable(sutra_lsp
    "${PROJECT_SOURCE_DIR}/उपकरणानि/sutra_lsp.cpp"
    "${PROJECT_SOURCE_DIR}/उपकरणानि/src/lsp_handlers.cpp"
    "${PROJECT_SOURCE_DIR}/उपकरणानि/src/lsp_adapter.cpp"
)
# Link against toolchain for formatter/linter APIs and nlohmann_json
target_link_libraries(sutra_lsp PRIVATE sutra_toolchain nlohmann_json::nlohmann_json)

# ---------- Existing test executable ----------
add_executable(test_sutra
    ${CORE_SOURCES}
    "${TEST_SRC}/test_sutra.cpp"
)

# ---------- Toolchain test executable (M4-1) ----------
add_executable(test_toolchain
    "${TEST_SRC}/test_toolchain.cpp"
)

target_link_libraries(test_toolchain PRIVATE sutra_toolchain)

# ---------- CTest registration ----------
enable_testing()
# LSP integration test
add_executable(test_lsp_integration
    tests/lsp/test_lsp_integration.cpp
)
target_link_libraries(test_lsp_integration PRIVATE sutra_toolchain)
add_test(NAME lsp_integration_test COMMAND test_lsp_integration)
add_test(NAME sutra_tests COMMAND test_sutra)
add_test(NAME toolchain_tests COMMAND test_toolchain)
