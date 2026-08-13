#ifndef SUTRA_INTERPRETER_HPP
#define SUTRA_INTERPRETER_HPP

#include "sutra/ast.hpp"
#include "sutra/value.hpp"
#include "sutra/environment.hpp"
#include "sutra/error.hpp"
#include <unordered_map>
#include <memory>
#include <iostream>

namespace sutra {

class SutraRuntimeException : public std::runtime_error {
public:
    SutraValue error_val;
    size_t line;
    size_t column;

    SutraRuntimeException(std::string msg, size_t l = 0, size_t c = 0)
        : std::runtime_error(msg), error_val(SutraValue::make_string(msg)), line(l), column(c) {}

    SutraRuntimeException(SutraValue val, size_t l = 0, size_t c = 0)
        : std::runtime_error(val.to_string()), error_val(std::move(val)), line(l), column(c) {}
};

class Interpreter {
public:
    Interpreter();

    void execute_program(const ProgramASTNode& program, std::ostream& out = std::cout);
    void execute_repl_program(const ProgramASTNode& program, std::ostream& out = std::cout);

    std::shared_ptr<Environment> global_env() const { return m_global_env; }

    SutraValue evaluate_expr(const ExprASTNode& expr, std::shared_ptr<Environment> env);
    SutraValue execute_stmt(const StmtASTNode& stmt, std::shared_ptr<Environment> env, std::ostream& out);

private:
    std::shared_ptr<Environment> m_global_env;
    std::unordered_map<std::string, const FunctionDeclASTNode*> m_functions;
    std::unordered_map<std::string, const ClassDeclASTNode*> m_classes;

    SutraValue call_function(const std::string& name, const std::vector<SutraValue>& args, size_t line, size_t col, std::ostream& out);
};

} // namespace sutra

#endif // SUTRA_INTERPRETER_HPP
