#ifndef SUTRA_CODEGEN_HPP
#define SUTRA_CODEGEN_HPP

#include "sutra/compiler/ir.hpp"

#include <string>
#include <iostream>
#include <unordered_map>

namespace sutra {
namespace compiler {

class NativeCodeGenX86_64 {
private:
    std::unordered_map<std::string, int> m_stack_offsets;
    int m_current_stack_offset = 0;

    int get_or_alloc_stack(const std::string& name) {
        auto it = m_stack_offsets.find(name);
        if (it != m_stack_offsets.end()) return it->second;
        m_current_stack_offset -= 8;
        m_stack_offsets[name] = m_current_stack_offset;
        return m_current_stack_offset;
    }

public:
    NativeCodeGenX86_64() = default;

    std::string generate_assembly(const IRModule& module);
    bool compile_to_binary(const IRModule& module, const std::string& output_exe_path);
};

} // namespace compiler
} // namespace sutra

#endif // SUTRA_CODEGEN_HPP
