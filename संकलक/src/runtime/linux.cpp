#ifndef _WIN32
#include "sutra/runtime/runtime.hpp"
#include <unistd.h>
#include <limits.h>
#include <fstream>
#include <filesystem>
#include <iostream>
#include <cstdlib>
#include <stdexcept>

namespace sutra {
namespace runtime {

void LinuxPlatform::console_write(const std::string& text) {
    std::cout << text;
}

std::string LinuxPlatform::console_read() {
    std::string token;
    std::cin >> token;
    return token;
}

std::string LinuxPlatform::console_read_line() {
    std::string line;
    std::getline(std::cin, line);
    return line;
}

bool LinuxPlatform::file_exists(const std::string& path) {
    std::filesystem::path p(path);
    return std::filesystem::exists(p) && !std::filesystem::is_directory(p);
}

std::string LinuxPlatform::file_read(const std::string& path) {
    std::filesystem::path p(path);
    std::ifstream file(p, std::ios::binary);
    if (!file.is_open()) {
        throw std::runtime_error("File cannot be opened: " + path);
    }
    std::string content((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    return content;
}

void LinuxPlatform::file_write(const std::string& path, const std::string& content) {
    std::filesystem::path p(path);
    std::ofstream file(p, std::ios::binary);
    if (file.is_open()) {
        file << content;
    }
}

std::string LinuxPlatform::get_env_var(const std::string& name) {
    char* val = std::getenv(name.c_str());
    return val ? std::string(val) : "";
}

std::string LinuxPlatform::get_cwd() {
    char buf[PATH_MAX];
    if (getcwd(buf, sizeof(buf)) != nullptr) {
        return std::string(buf);
    }
    return "";
}

std::string LinuxPlatform::get_platform_name() {
    return "Linux";
}

} // namespace runtime
} // namespace sutra
#endif
