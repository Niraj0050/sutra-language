#include "sutra/environment.hpp"
#include "sutra/स्मृतिसंग्राहक.hpp"

namespace sutra {

Environment::Environment(std::shared_ptr<Environment> parent)
    : m_parent(std::move(parent)) {
    GarbageCollector::get_instance().register_environment(this);
}

Environment::~Environment() {
    GarbageCollector::get_instance().unregister_environment(this);
}

void Environment::define(const std::string& name, SutraValue value) {
    m_values[name] = std::move(value);
}

void Environment::assign(const std::string& name, SutraValue value, size_t line, size_t col) {
    auto it = m_values.find(name);
    if (it != m_values.end()) {
        it->second = std::move(value);
        return;
    }
    if (m_parent) {
        m_parent->assign(name, std::move(value), line, col);
        return;
    }
    throw RuntimeError("'" + name + "' नामकः चरः अपरिभाषितः अस्ति।", line, col);
}

SutraValue Environment::get(const std::string& name, size_t line, size_t col) const {
    auto it = m_values.find(name);
    if (it != m_values.end()) {
        return it->second;
    }
    if (m_parent) {
        return m_parent->get(name, line, col);
    }
    throw RuntimeError("'" + name + "' नामकः चरः अपरिभाषितः अस्ति।", line, col);
}

} // namespace sutra
