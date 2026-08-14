#include "sutra/runtime/io.hpp"
#include "sutra/runtime/runtime.hpp"

namespace sutra {
namespace runtime {

void io_write(const std::string& text) {
    Runtime::get_instance().write(text);
}

void io_write_line(const std::string& text) {
    Runtime::get_instance().write_line(text);
}

std::string io_read() {
    return Runtime::get_instance().read();
}

std::string io_read_line() {
    return Runtime::get_instance().read_line();
}

} // namespace runtime
} // namespace sutra
