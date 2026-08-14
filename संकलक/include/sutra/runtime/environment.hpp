#ifndef SUTRA_RUNTIME_ENVIRONMENT_HPP
#define SUTRA_RUNTIME_ENVIRONMENT_HPP

#include <string>

namespace sutra {
namespace runtime {

std::string env_get_variable(const std::string& name);
std::string env_current_directory();
std::string env_platform_name();

} // namespace runtime
} // namespace sutra

#endif // SUTRA_RUNTIME_ENVIRONMENT_HPP
