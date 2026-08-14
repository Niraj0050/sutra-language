#ifndef SUTRA_RUNTIME_FILESYSTEM_HPP
#define SUTRA_RUNTIME_FILESYSTEM_HPP

#include <string>

namespace sutra {
namespace runtime {

bool fs_exists(const std::string& path);
std::string fs_read(const std::string& path);
void fs_write(const std::string& path, const std::string& content);

} // namespace runtime
} // namespace sutra

#endif // SUTRA_RUNTIME_FILESYSTEM_HPP
