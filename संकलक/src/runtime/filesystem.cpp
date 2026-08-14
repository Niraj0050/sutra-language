#include "sutra/runtime/filesystem.hpp"
#include "sutra/runtime/runtime.hpp"

namespace sutra {
namespace runtime {

bool fs_exists(const std::string& path) {
    return Runtime::get_instance().platform().file_exists(path);
}

std::string fs_read(const std::string& path) {
    return Runtime::get_instance().platform().file_read(path);
}

void fs_write(const std::string& path, const std::string& content) {
    Runtime::get_instance().platform().file_write(path, content);
}

} // namespace runtime
} // namespace sutra
