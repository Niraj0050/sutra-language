#ifndef SUTRA_ENVIRONMENT_HPP
#define SUTRA_ENVIRONMENT_HPP

#include "sutra/value.hpp"
#include "sutra/error.hpp"
#include <unordered_map>
#include <memory>
#include <string>

namespace sutra {

class Environment : public std::enable_shared_from_this<Environment> {
public:
    explicit Environment(std::shared_ptr<Environment> parent = nullptr)
        : m_parent(std::move(parent)) {}

    void define(const std::string& name, SutraValue value);
    void assign(const std::string& name, SutraValue value, size_t line, size_t col);
    SutraValue get(const std::string& name, size_t line, size_t col) const;

    std::shared_ptr<Environment> parent() const { return m_parent; }

private:
    std::shared_ptr<Environment> m_parent;
    std::unordered_map<std::string, SutraValue> m_values;
};

} // namespace sutra

#endif // SUTRA_ENVIRONMENT_HPP
