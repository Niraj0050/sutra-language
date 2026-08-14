#include "sutra/runtime/runtime.hpp"

namespace sutra {
namespace runtime {

Runtime::Runtime() {
    initialize();
}

void Runtime::initialize(std::unique_ptr<OSPlatform> platform) {
    if (platform) {
        m_platform = std::move(platform);
    } else {
#ifdef _WIN32
        m_platform = std::make_unique<WindowsPlatform>();
#else
        m_platform = std::make_unique<LinuxPlatform>();
#endif
    }
}

void Runtime::write(const std::string& text) {
    if (m_out_stream) {
        *m_out_stream << text;
    } else {
        m_platform->console_write(text);
    }
}

void Runtime::write_line(const std::string& text) {
    write(text + "\n");
}

std::string Runtime::read() {
    if (m_in_stream) {
        std::string token;
        if (*m_in_stream >> token) {
            return token;
        }
        return "";
    }
    return m_platform->console_read();
}

std::string Runtime::read_line() {
    if (m_in_stream) {
        std::string line;
        if (std::getline(*m_in_stream, line)) {
            return line;
        }
        return "";
    }
    return m_platform->console_read_line();
}

} // namespace runtime
} // namespace sutra
