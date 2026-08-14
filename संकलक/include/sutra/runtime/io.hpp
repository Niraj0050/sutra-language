#ifndef SUTRA_RUNTIME_IO_HPP
#define SUTRA_RUNTIME_IO_HPP

#include <string>

namespace sutra {
namespace runtime {

void io_write(const std::string& text);
void io_write_line(const std::string& text);
std::string io_read();
std::string io_read_line();

} // namespace runtime
} // namespace sutra

#endif // SUTRA_RUNTIME_IO_HPP
