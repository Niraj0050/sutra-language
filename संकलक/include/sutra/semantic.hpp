#ifndef SUTRA_SEMANTIC_HPP
#define SUTRA_SEMANTIC_HPP

#include "sutra/ast.hpp"
#include "sutra/error.hpp"
#include <unordered_map>
#include <unordered_set>
#include <string>
#include <vector>

namespace sutra {

struct FunctionSymbol {
    std::string name;
    size_t param_count;
    size_t line;
    size_t column;
};

class SemanticAnalyzer {
public:
    void analyze(const ProgramASTNode& program);
    void init_repl();
    void analyze_repl(const ProgramASTNode& program);

private:
    std::unordered_map<std::string, FunctionSymbol> m_functions;
    std::vector<std::unordered_set<std::string>> m_scopes;
    size_t m_loop_depth{0};

    void push_scope();
    void pop_scope();
    bool is_declared(const std::string& name) const;
    void declare_variable(const std::string& name, size_t line, size_t col);

    void analyze_function(const FunctionDeclASTNode& func);
    void analyze_statement(const StmtASTNode& stmt);
    void analyze_expression(const ExprASTNode& expr);
};

} // namespace sutra

#endif // SUTRA_SEMANTIC_HPP
