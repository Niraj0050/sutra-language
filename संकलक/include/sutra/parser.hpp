#ifndef SUTRA_PARSER_HPP
#define SUTRA_PARSER_HPP

#include "sutra/token.hpp"
#include "sutra/ast.hpp"
#include "sutra/error.hpp"
#include <vector>
#include <memory>

#include <set>

namespace sutra {

class Parser {
public:
    explicit Parser(std::vector<Token> tokens, std::string current_file_path = "");

    void set_imported_files(std::shared_ptr<std::set<std::string>> imported_files) {
        m_imported_files = imported_files;
    }

    std::unique_ptr<ProgramASTNode> parse_program();

private:
    std::vector<Token> m_tokens;
    size_t m_current{0};
    std::string m_current_file_path;
    std::shared_ptr<std::set<std::string>> m_imported_files;

    const Token& peek() const;
    const Token& peek_next() const;
    const Token& previous() const;
    bool is_at_end() const;
    Token advance();
    bool check(TokenType type) const;
    bool match(TokenType type);
    Token consume(TokenType type, const std::string& err_msg);

    // Parsing methods
    std::unique_ptr<ClassDeclASTNode> parse_class_decl();
    std::unique_ptr<FunctionDeclASTNode> parse_function_decl();
    std::unique_ptr<StmtASTNode> parse_statement();
    std::unique_ptr<VarDeclStmtASTNode> parse_var_decl();
    std::unique_ptr<AssignStmtASTNode> parse_assign_statement();
    std::unique_ptr<ArrayIndexAssignStmtASTNode> parse_array_index_assign_statement();
    std::unique_ptr<PrintStmtASTNode> parse_print_statement();
    std::unique_ptr<IfStmtASTNode> parse_if_statement();
    std::unique_ptr<WhileStmtASTNode> parse_while_statement();
    std::unique_ptr<ForStmtASTNode> parse_for_statement();
    std::unique_ptr<BreakStmtASTNode> parse_break_statement();
    std::unique_ptr<ContinueStmtASTNode> parse_continue_statement();
    std::unique_ptr<TryCatchStmtASTNode> parse_try_catch_statement();
    std::unique_ptr<ThrowStmtASTNode> parse_throw_statement();
    std::unique_ptr<ImportStmtASTNode> parse_import_statement();
    std::unique_ptr<ReturnStmtASTNode> parse_return_statement();
    std::unique_ptr<BlockStmtASTNode> parse_block_statement();

    // Expression parsing (Precedence Climbing / Recursive Descent)
    std::unique_ptr<ExprASTNode> parse_expression();
    std::unique_ptr<ExprASTNode> parse_logical_or();
    std::unique_ptr<ExprASTNode> parse_logical_and();
    std::unique_ptr<ExprASTNode> parse_equality();
    std::unique_ptr<ExprASTNode> parse_comparison();
    std::unique_ptr<ExprASTNode> parse_additive();
    std::unique_ptr<ExprASTNode> parse_multiplicative();
    std::unique_ptr<ExprASTNode> parse_unary();
    std::unique_ptr<ExprASTNode> parse_postfix();
    std::unique_ptr<ExprASTNode> parse_primary();
};

} // namespace sutra

#endif // SUTRA_PARSER_HPP
