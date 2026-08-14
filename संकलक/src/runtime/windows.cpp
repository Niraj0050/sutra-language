#ifdef _WIN32
#include "sutra/runtime/runtime.hpp"
#include <windows.h>
#include <fstream>
#include <filesystem>
#include <iostream>
#include <stdexcept>

namespace sutra {
namespace runtime {

void WindowsPlatform::console_write(const std::string& text) {
    std::cout << text;
}

std::string WindowsPlatform::console_read() {
    std::string token;
    std::cin >> token;
    return token;
}

std::string WindowsPlatform::console_read_line() {
    std::string line;
    std::getline(std::cin, line);
    return line;
}

bool WindowsPlatform::file_exists(const std::string& path) {
    std::filesystem::path p(path);
    return std::filesystem::exists(p) && !std::filesystem::is_directory(p);
}

std::string WindowsPlatform::file_read(const std::string& path) {
    std::filesystem::path p(path);
    std::ifstream file(p, std::ios::binary);
    if (!file.is_open()) {
        throw std::runtime_error("File cannot be opened: " + path);
    }
    std::string content((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    return content;
}

void WindowsPlatform::file_write(const std::string& path, const std::string& content) {
    std::filesystem::path p(path);
    std::ofstream file(p, std::ios::binary);
    if (file.is_open()) {
        file << content;
    }
}

std::string WindowsPlatform::get_env_var(const std::string& name) {
    char buf[32767];
    DWORD len = GetEnvironmentVariableA(name.c_str(), buf, 32767);
    if (len > 0) return std::string(buf, len);
    return "";
}

std::string WindowsPlatform::get_cwd() {
    char buf[MAX_PATH];
    GetCurrentDirectoryA(MAX_PATH, buf);
    return std::string(buf);
}

std::string WindowsPlatform::get_platform_name() {
    return "Windows";
}

} // namespace runtime
} // namespace sutra
#endif
