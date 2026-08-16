#ifndef SUTRA_IR_GENERATOR_HPP
#define SUTRA_IR_GENERATOR_HPP

#include "sutra/ast.hpp"
#include "sutra/compiler/ir.hpp"

#include <memory>
#include <string>
#include <unordered_map>

namespace sutra {
namespace compiler {



class IRGenerator {
private:
    struct ClassMetadata {
        std::string name;
        std::vector<std::string> field_names;
        std::unordered_map<std::string, int> field_to_index;
        std::unordered_map<std::string, IRValueType> field_types;
    };

    std::unique_ptr<IRModule> m_module;
    IRFunction* m_current_func = nullptr;
    int m_temp_counter = 0;

    int m_label_counter = 0;
    std::vector<std::string> m_break_stack;
    std::vector<std::string> m_continue_stack;

    // Type tracking: register/variable name -> type
    std::unordered_map<std::string, IRValueType> m_type_map;
    std::unordered_map<std::string, IRValueType> m_func_return_types;

    std::unordered_map<std::string, ClassMetadata> m_class_map;
    std::unordered_map<std::string, std::string> m_class_instances;

    std::string new_temp() {
        return "t" + std::to_string(m_temp_counter++);
    }

    std::string new_label(const std::string& prefix = "L") {
        return ".L_" + prefix + "_" + std::to_string(m_label_counter++);
    }

    IRValue visit_expr(ExprASTNode* expr);
    void visit_stmt(StmtASTNode* stmt);
    void visit_function_decl(FunctionDeclASTNode* func);
    void visit_method_decl(FunctionDeclASTNode* func, const std::string& class_name);
    
    std::string add_string_literal(const std::string& val) {
        std::string str_id = "str_" + std::to_string(m_module->string_literals.size());
        m_module->string_literals.push_back(std::make_pair(str_id, val));
        return str_id;
    }
    
    IRValueType get_type(const std::string& name);

public:
    IRGenerator() = default;

    std::unique_ptr<IRModule> generate(ProgramASTNode& program, const std::string& module_name = "sutra_main");
};

} // namespace compiler
} // namespace sutra

#endif // SUTRA_IR_GENERATOR_HPP
