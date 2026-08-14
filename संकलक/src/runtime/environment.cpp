#include "sutra/runtime/environment.hpp"
#include "sutra/runtime/runtime.hpp"

namespace sutra {
namespace runtime {

std::string env_get_variable(const std::string& name) {
    return Runtime::get_instance().platform().get_env_var(name);
}

std::string env_current_directory() {
    return Runtime::get_instance().platform().get_cwd();
}

std::string env_platform_name() {
    return Runtime::get_instance().platform().get_platform_name();
}

} // namespace runtime
} // namespace sutra
