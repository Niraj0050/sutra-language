#include "sutra/parser.hpp"
#include "sutra/lexer.hpp"
#include "sutra/runtime/filesystem.hpp"
#include <fstream>
#include <sstream>
#include <filesystem>
#include <iostream>

namespace fs = std::filesystem;

namespace sutra {

Parser::Parser(std::vector<Token> tokens, std::string current_file_path)
    : m_tokens(std::move(tokens)), m_current_file_path(std::move(current_file_path)) {
    if (!m_imported_files) {
        m_imported_files = std::make_shared<std::set<std::string>>();
    }
}

const Token& Parser::peek() const {
    if (m_current < m_tokens.size()) {
        return m_tokens[m_current];
    }
    return m_tokens.back();
}

const Token& Parser::peek_next() const {
    if (m_current + 1 < m_tokens.size()) {
        return m_tokens[m_current + 1];
    }
    return m_tokens.back();
}

const Token& Parser::previous() const {
    if (m_current > 0) {
        return m_tokens[m_current - 1];
    }
    return m_tokens[0];
}

bool Parser::is_at_end() const {
    return peek().type == TokenType::END_OF_FILE;
}

Token Parser::advance() {
    if (!is_at_end()) {
        m_current++;
    }
    return previous();
}

bool Parser::check(TokenType type) const {
    if (is_at_end()) {
        return false;
    }
    return peek().type == type;
}

bool Parser::match(TokenType type) {
    if (check(type)) {
        advance();
        return true;
    }
    return false;
}

Token Parser::consume(TokenType type, const std::string& err_msg) {
    if (check(type)) {
        return advance();
    }

    const Token& tok = peek();
    throw ParserError(
        err_msg + " (प्राप्तम्: '" + tok.lexeme + "')",
        tok.line,
        tok.column
    );
}

std::unique_ptr<ImportStmtASTNode> Parser::parse_import_statement() {
    Token import_tok = advance(); // consumes 'आयात' or 'आयानम्'
    Token path_tok = consume(TokenType::STRING_LITERAL, "सञ्चिकायाः मार्गः (string path) अपेक्षितः");
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");
    return std::make_unique<ImportStmtASTNode>(path_tok.lexeme, import_tok.line, import_tok.column);
}

std::unique_ptr<ProgramASTNode> Parser::parse_program() {
    auto program = std::make_unique<ProgramASTNode>();

    if (!m_imported_files) {
        m_imported_files = std::make_shared<std::set<std::string>>();
    }

    if (!m_current_file_path.empty()) {
        try {
            std::string abs_p = fs::absolute(m_current_file_path).string();
            m_imported_files->insert(abs_p);
        } catch (...) {}
    }

    while (!is_at_end()) {
        if (check(TokenType::K_AAYAT)) {
            size_t l = peek().line;
            size_t c = peek().column;
            auto import_stmt = parse_import_statement();
            std::string raw_path = import_stmt->module_path;

            fs::path target_path(raw_path);
            if (!target_path.has_extension()) {
                target_path.replace_extension(".सूत्र");
            }

            fs::path resolved_path = target_path;
            if (!m_current_file_path.empty()) {
                fs::path parent_dir = fs::path(m_current_file_path).parent_path();
                fs::path candidate = parent_dir / target_path;
                if (runtime::fs_exists(candidate.string())) {
                    resolved_path = candidate;
                }
            }

            if (!runtime::fs_exists(resolved_path.string())) {
                if (runtime::fs_exists(target_path.string())) {
                    resolved_path = target_path;
                } else {
                    throw ParserError("आयात-सञ्चिका न प्राप्ता (Import file not found): '" + raw_path + "'", l, c);
                }
            }

            std::string abs_import_path = fs::absolute(resolved_path).string();
            if (m_imported_files->find(abs_import_path) == m_imported_files->end()) {
                m_imported_files->insert(abs_import_path);

                std::string code;
                try {
                    code = runtime::fs_read(resolved_path.string());
                } catch (...) {
                    throw ParserError("आयात-सञ्चिका उद्घाटयितुम् न शक्यते: '" + resolved_path.string() + "'", l, c);
                }

                Lexer lexer(code);
                auto tokens = lexer.tokenize();

                Parser sub_parser(std::move(tokens), abs_import_path);
                sub_parser.set_imported_files(m_imported_files);
                auto imported_prog = sub_parser.parse_program();

                for (auto& cl : imported_prog->classes) {
                    program->classes.push_back(std::move(cl));
                }
                for (auto& fn : imported_prog->functions) {
                    program->functions.push_back(std::move(fn));
                }
                for (auto& st : imported_prog->global_statements) {
                    program->global_statements.push_back(std::move(st));
                }
            }
        } else if (check(TokenType::K_VARGA)) {
            program->classes.push_back(parse_class_decl());
        } else if (check(TokenType::K_KARYA)) {
            program->functions.push_back(parse_function_decl());
        } else {
            program->global_statements.push_back(parse_statement());
        }
    }

    return program;
}

std::unique_ptr<ClassDeclASTNode> Parser::parse_class_decl() {
    Token varga_tok = consume(TokenType::K_VARGA, "'वर्ग' मुख्यशब्दः अपेक्षितः");
    Token name_tok = consume(TokenType::IDENTIFIER, "वर्गस्य नाम अपेक्षितम्");
    consume(TokenType::LBRACE, "'{' अपेक्षितम्");

    std::vector<std::unique_ptr<VarDeclStmtASTNode>> fields;
    std::vector<std::unique_ptr<FunctionDeclASTNode>> methods;

    while (!check(TokenType::RBRACE) && !is_at_end()) {
        if (check(TokenType::K_KARYA)) {
            methods.push_back(parse_function_decl());
        } else if (check(TokenType::K_MAAN) || check(TokenType::K_SANKHYA) ||
                   check(TokenType::K_DASHAMLAV) || check(TokenType::K_PATH) ||
                   check(TokenType::K_BOOL) || check(TokenType::K_SUCHI)) {
            fields.push_back(parse_var_decl());
        } else {
            throw ParserError("वर्गस्य अन्तः केवलम् चर-घोषणा वा कार्य-घोषणा एव सम्भवति", peek().line, peek().column);
        }
    }
    consume(TokenType::RBRACE, "'}' अपेक्षितम्");

    return std::make_unique<ClassDeclASTNode>(
        name_tok.lexeme,
        std::move(fields),
        std::move(methods),
        varga_tok.line,
        varga_tok.column
    );
}

std::unique_ptr<FunctionDeclASTNode> Parser::parse_function_decl() {
    Token karya_tok = consume(TokenType::K_KARYA, "'कार्य' मुख्यशब्दः अपेक्षितः");

    Token name_tok;
    if (check(TokenType::K_MUKHYA)) {
        name_tok = advance();
    } else {
        name_tok = consume(TokenType::IDENTIFIER, "कार्यस्य नाम अपेक्षितम्");
    }

    consume(TokenType::LPAREN, "'(' अपेक्षितम्");

    std::vector<FunctionParam> params;
    if (!check(TokenType::RPAREN)) {
        do {
            Token first_tok = peek();
            if (check(TokenType::IDENTIFIER) || 
                first_tok.type == TokenType::K_SANKHYA ||
                first_tok.type == TokenType::K_DASHAMLAV ||
                first_tok.type == TokenType::K_PATH ||
                first_tok.type == TokenType::K_BOOL ||
                first_tok.type == TokenType::K_MAAN ||
                first_tok.type == TokenType::K_SUCHI) {
                
                if (peek_next().type == TokenType::IDENTIFIER) {
                    // Typed parameter (e.g. संख्या क or छात्र क)
                    Token type_tok = advance();
                    Token name_tok = consume(TokenType::IDENTIFIER, "तर्कस्य नाम अपेक्षितम्");
                    params.push_back({type_tok.lexeme, name_tok.lexeme});
                } else {
                    // Untyped parameter (e.g. क)
                    Token name_tok = consume(TokenType::IDENTIFIER, "तर्कस्य नाम अपेक्षितम्");
                    params.push_back({"मान", name_tok.lexeme});
                }
            } else {
                throw ParserError("तर्कस्य नाम अपेक्षितम् (प्राप्तम्: '" + first_tok.lexeme + "')", first_tok.line, first_tok.column);
            }
        } while (match(TokenType::COMMA));
    }

    consume(TokenType::RPAREN, "')' अपेक्षितम्");

    auto body = parse_block_statement();

    return std::make_unique<FunctionDeclASTNode>(
        name_tok.lexeme,
        std::move(params),
        std::move(body),
        karya_tok.line,
        karya_tok.column
    );
}

std::unique_ptr<StmtASTNode> Parser::parse_statement() {
    if (check(TokenType::K_LIKHATU) ||
        check(TokenType::K_DARSHAYATU) ||
        check(TokenType::K_PANKTIM)) {
        return parse_print_statement();
    }

    if (check(TokenType::K_YADI) || check(TokenType::K_AGAR)) {
        return parse_if_statement();
    }

    if (check(TokenType::K_YAVAT) || check(TokenType::K_JABTAK)) {
        return parse_while_statement();
    }

    if (check(TokenType::K_PUNARAVRTTIH)) {
        return parse_for_statement();
    }

    if (check(TokenType::K_VIRAMAH)) {
        return parse_break_statement();
    }

    if (check(TokenType::K_JARIRAH)) {
        return parse_continue_statement();
    }

    if (check(TokenType::K_PRAYATNA)) {
        return parse_try_catch_statement();
    }

    if (check(TokenType::K_PRAKSHEPAH)) {
        return parse_throw_statement();
    }

    if (check(TokenType::K_AAYAT)) {
        return parse_import_statement();
    }

    if (check(TokenType::K_PARAT)) {
        return parse_return_statement();
    }

    if (check(TokenType::LBRACE)) {
        return parse_block_statement();
    }

    if (check(TokenType::K_MAAN) ||
        check(TokenType::K_SANKHYA) ||
        check(TokenType::K_DASHAMLAV) ||
        check(TokenType::K_PATH) ||
        check(TokenType::K_BOOL) ||
        check(TokenType::K_SUCHI)) {
        return parse_var_decl();
    }

    size_t line = peek().line;
    size_t col = peek().column;

    auto expr = parse_expression();

    if (match(TokenType::ASSIGN)) {
        auto val = parse_expression();
        consume(TokenType::SEMICOLON, "वाक्यान्ते ';' अपेक्षितम्");

        if (auto mem_acc = dynamic_cast<MemberAccessExprASTNode*>(expr.get())) {
            return std::make_unique<MemberAssignStmtASTNode>(
                std::move(mem_acc->object_expr),
                mem_acc->member_name,
                std::move(val),
                line, col
            );
        }

        if (auto id_expr = dynamic_cast<IdentifierExprASTNode*>(expr.get())) {
            return std::make_unique<AssignStmtASTNode>(
                id_expr->name,
                std::move(val),
                line, col
            );
        }

        if (auto arr_idx = dynamic_cast<ArrayIndexExprASTNode*>(expr.get())) {
            std::vector<std::unique_ptr<ExprASTNode>> index_chain;
            std::unique_ptr<ExprASTNode> current = std::move(expr);

            while (auto nested = dynamic_cast<ArrayIndexExprASTNode*>(current.get())) {
                index_chain.insert(index_chain.begin(), std::move(nested->index_expr));
                current = std::move(nested->array_expr);
            }

            if (auto id_expr = dynamic_cast<IdentifierExprASTNode*>(current.get())) {
                return std::make_unique<ArrayIndexAssignStmtASTNode>(
                    id_expr->name,
                    std::move(index_chain),
                    std::move(val),
                    line, col
                );
            }
        }

        throw ParserError("अमान्यः असाइनमेंट लक्ष्यः (Invalid assignment target)", line, col);
    }

    consume(TokenType::SEMICOLON, "वाक्यान्ते ';' अपेक्षितम्");
    return std::make_unique<ExprStmtASTNode>(std::move(expr), line, col);
}

std::unique_ptr<VarDeclStmtASTNode> Parser::parse_var_decl() {
    Token type_tok = advance();
    size_t line = type_tok.line;
    size_t col = type_tok.column;

    Token var_name_tok = consume(TokenType::IDENTIFIER, "चरस्य नाम अपेक्षितम्");

    std::string type_name = type_tok.lexeme;

    if (type_tok.type == TokenType::K_MAAN && match(TokenType::COLON)) {
        const Token& type_name_tok = peek();
        if (type_name_tok.type == TokenType::IDENTIFIER ||
            type_name_tok.type == TokenType::K_SANKHYA ||
            type_name_tok.type == TokenType::K_DASHAMLAV ||
            type_name_tok.type == TokenType::K_PATH ||
            type_name_tok.type == TokenType::K_BOOL) {
            Token explicit_type = advance();
            type_name = explicit_type.lexeme;
        } else {
            throw ParserError("प्रकारस्य नाम अपेक्षितम् (Type name expected)", peek().line, peek().column);
        }
    }

    std::unique_ptr<ExprASTNode> initializer = nullptr;
    if (match(TokenType::ASSIGN)) {
        initializer = parse_expression();
    }

    consume(TokenType::SEMICOLON, "चरनिर्वचनान्ते ';' अपेक्षितम्");

    return std::make_unique<VarDeclStmtASTNode>(
        type_name,
        var_name_tok.lexeme,
        std::move(initializer),
        line,
        col
    );
}

std::unique_ptr<AssignStmtASTNode> Parser::parse_assign_statement() {
    Token var_name_tok = consume(TokenType::IDENTIFIER, "चरस्य नाम अपेक्षितम्");
    consume(TokenType::ASSIGN, "'=' अपेक्षितम्");
    auto val_expr = parse_expression();
    consume(TokenType::SEMICOLON, "वाक्यान्ते ';' अपेक्षितम्");

    return std::make_unique<AssignStmtASTNode>(
        var_name_tok.lexeme,
        std::move(val_expr),
        var_name_tok.line,
        var_name_tok.column
    );
}

std::unique_ptr<ArrayIndexAssignStmtASTNode> Parser::parse_array_index_assign_statement() {
    Token arr_tok = consume(TokenType::IDENTIFIER, "सूच्याः नाम अपेक्षितम्");
    consume(TokenType::LBRACKET, "'[' अपेक्षितम्");
    auto idx_expr = parse_expression();
    consume(TokenType::RBRACKET, "']' अपेक्षितम्");
    consume(TokenType::ASSIGN, "'=' अपेक्षितम्");
    auto val_expr = parse_expression();
    consume(TokenType::SEMICOLON, "वाक्यान्ते ';' अपेक्षितम्");

    std::vector<std::unique_ptr<ExprASTNode>> indexes;
    indexes.push_back(std::move(idx_expr));

    return std::make_unique<ArrayIndexAssignStmtASTNode>(
        arr_tok.lexeme,
        std::move(indexes),
        std::move(val_expr),
        arr_tok.line,
        arr_tok.column
    );
}

std::unique_ptr<PrintStmtASTNode> Parser::parse_print_statement() {
    Token print_tok = advance();

    consume(TokenType::LPAREN, "'" + print_tok.lexeme + "' अनन्तरम् '(' अपेक्षितम्");
    auto expr = parse_expression();
    consume(TokenType::RPAREN, "')' अपेक्षितम्");
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");

    PrintKind kind = PrintKind::LIKHATU;
    if (print_tok.type == TokenType::K_DARSHAYATU) {
        kind = PrintKind::DARSHAYATU;
    } else if (print_tok.type == TokenType::K_PANKTIM) {
        kind = PrintKind::PANKTIM;
    }

    return std::make_unique<PrintStmtASTNode>(
        std::move(expr),
        print_tok.line,
        print_tok.column,
        kind
    );
}

std::unique_ptr<IfStmtASTNode> Parser::parse_if_statement() {
    Token if_tok = advance(); // consumes 'यदि' or 'अगर'

    consume(TokenType::LPAREN, "'" + if_tok.lexeme + "' अनन्तरम् '(' अपेक्षितम्");
    auto condition = parse_expression();
    consume(TokenType::RPAREN, "')' अपेक्षितम्");

    auto then_branch = parse_block_statement();
    std::unique_ptr<BlockStmtASTNode> else_branch = nullptr;

    if (match(TokenType::K_ANYATHA)) {
        // Support 'अन्यथा यदि' / 'अन्यथा अगर' (else-if chaining)
        if (check(TokenType::K_YADI) || check(TokenType::K_AGAR)) {
            size_t else_line = previous().line;
            size_t else_col = previous().column;
            auto nested_if = parse_if_statement();
            std::vector<std::unique_ptr<StmtASTNode>> stmts;
            stmts.push_back(std::move(nested_if));
            else_branch = std::make_unique<BlockStmtASTNode>(std::move(stmts), else_line, else_col);
        } else {
            else_branch = parse_block_statement();
        }
    }

    return std::make_unique<IfStmtASTNode>(
        std::move(condition),
        std::move(then_branch),
        std::move(else_branch),
        if_tok.line,
        if_tok.column
    );
}

std::unique_ptr<WhileStmtASTNode> Parser::parse_while_statement() {
    Token while_tok = advance(); // consumes 'यावत्' or 'जबतक'

    consume(TokenType::LPAREN, "'" + while_tok.lexeme + "' अनन्तरम् '(' अपेक्षितम्");
    auto condition = parse_expression();
    consume(TokenType::RPAREN, "')' अपेक्षितम्");

    auto body = parse_block_statement();

    return std::make_unique<WhileStmtASTNode>(
        std::move(condition),
        std::move(body),
        while_tok.line,
        while_tok.column
    );
}

std::unique_ptr<ForStmtASTNode> Parser::parse_for_statement() {
    Token for_tok = consume(TokenType::K_PUNARAVRTTIH, "'पुनरावृत्तिः' मुख्यशब्दः अपेक्षितः");

    consume(TokenType::LPAREN, "'पुनरावृत्तिः' अनन्तरम् '(' अपेक्षितम्");

    std::unique_ptr<StmtASTNode> init = nullptr;
    if (match(TokenType::SEMICOLON)) {
        init = nullptr;
    } else if (check(TokenType::K_MAAN) ||
               check(TokenType::K_SANKHYA) ||
               check(TokenType::K_DASHAMLAV) ||
               check(TokenType::K_PATH) ||
               check(TokenType::K_BOOL) ||
               check(TokenType::K_SUCHI)) {
        init = parse_var_decl();
    } else if (check(TokenType::IDENTIFIER) && peek_next().type == TokenType::ASSIGN) {
        init = parse_assign_statement();
    } else {
        size_t l = peek().line;
        size_t c = peek().column;
        auto expr = parse_expression();
        consume(TokenType::SEMICOLON, "';' अपेक्षितम्");
        init = std::make_unique<ExprStmtASTNode>(std::move(expr), l, c);
    }

    std::unique_ptr<ExprASTNode> condition = nullptr;
    if (!check(TokenType::SEMICOLON)) {
        condition = parse_expression();
    }
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");

    std::unique_ptr<StmtASTNode> update = nullptr;
    if (!check(TokenType::RPAREN)) {
        if (check(TokenType::IDENTIFIER) && peek_next().type == TokenType::ASSIGN) {
            Token var_name_tok = consume(TokenType::IDENTIFIER, "चरस्य नाम अपेक्षितम्");
            consume(TokenType::ASSIGN, "'=' अपेक्षितम्");
            auto val_expr = parse_expression();
            update = std::make_unique<AssignStmtASTNode>(
                var_name_tok.lexeme,
                std::move(val_expr),
                var_name_tok.line,
                var_name_tok.column
            );
        } else {
            size_t l = peek().line;
            size_t c = peek().column;
            auto expr = parse_expression();
            update = std::make_unique<ExprStmtASTNode>(std::move(expr), l, c);
        }
    }
    consume(TokenType::RPAREN, "')' अपेक्षितम्");

    auto body = parse_block_statement();

    return std::make_unique<ForStmtASTNode>(
        std::move(init),
        std::move(condition),
        std::move(update),
        std::move(body),
        for_tok.line,
        for_tok.column
    );
}

std::unique_ptr<BreakStmtASTNode> Parser::parse_break_statement() {
    Token break_tok = advance();
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");
    return std::make_unique<BreakStmtASTNode>(break_tok.line, break_tok.column);
}

std::unique_ptr<ContinueStmtASTNode> Parser::parse_continue_statement() {
    Token cont_tok = advance();
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");
    return std::make_unique<ContinueStmtASTNode>(cont_tok.line, cont_tok.column);
}

std::unique_ptr<TryCatchStmtASTNode> Parser::parse_try_catch_statement() {
    Token try_tok = advance();
    auto try_block = parse_block_statement();

    Token catch_tok = consume(TokenType::K_PAKADO, "'पकड़ो' अथवा 'ग्रहणम्' अपेक्षितम्");
    consume(TokenType::LPAREN, "'(' अपेक्षितम्");
    Token var_name_tok = consume(TokenType::IDENTIFIER, "त्रुटि-चरस्य नाम अपेक्षितम्");
    consume(TokenType::RPAREN, "')' अपेक्षितम्");

    auto catch_block = parse_block_statement();

    return std::make_unique<TryCatchStmtASTNode>(
        std::move(try_block),
        var_name_tok.lexeme,
        std::move(catch_block),
        try_tok.line,
        try_tok.column
    );
}

std::unique_ptr<ThrowStmtASTNode> Parser::parse_throw_statement() {
    Token throw_tok = advance();
    auto expr = parse_expression();
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");
    return std::make_unique<ThrowStmtASTNode>(std::move(expr), throw_tok.line, throw_tok.column);
}

std::unique_ptr<ReturnStmtASTNode> Parser::parse_return_statement() {
    Token ret_tok = advance();

    std::unique_ptr<ExprASTNode> val = nullptr;
    if (!check(TokenType::SEMICOLON)) {
        val = parse_expression();
    }
    consume(TokenType::SEMICOLON, "';' अपेक्षितम्");

    return std::make_unique<ReturnStmtASTNode>(
        std::move(val),
        ret_tok.line,
        ret_tok.column
    );
}

std::unique_ptr<BlockStmtASTNode> Parser::parse_block_statement() {
    Token lbrace = consume(TokenType::LBRACE, "'{' अपेक्षितम्");
    std::vector<std::unique_ptr<StmtASTNode>> stmts;

    while (!check(TokenType::RBRACE) && !is_at_end()) {
        stmts.push_back(parse_statement());
    }

    consume(TokenType::RBRACE, "'}' अपेक्षितम्");

    return std::make_unique<BlockStmtASTNode>(
        std::move(stmts),
        lbrace.line,
        lbrace.column
    );
}

std::unique_ptr<ExprASTNode> Parser::parse_expression() {
    return parse_logical_or();
}

std::unique_ptr<ExprASTNode> Parser::parse_logical_or() {
    auto expr = parse_logical_and();

    while (check(TokenType::LOGICAL_OR) || check(TokenType::K_ATHAVA)) {
        Token op_tok = advance();
        auto right = parse_logical_and();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_logical_and() {
    auto expr = parse_equality();

    while (check(TokenType::LOGICAL_AND) || check(TokenType::K_TATHA)) {
        Token op_tok = advance();
        auto right = parse_equality();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_equality() {
    auto expr = parse_comparison();

    while (check(TokenType::EQUAL) || check(TokenType::NOT_EQUAL)) {
        Token op_tok = advance();
        auto right = parse_comparison();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_comparison() {
    auto expr = parse_additive();

    while (check(TokenType::GREATER) || check(TokenType::LESS) ||
           check(TokenType::GREATER_EQUAL) || check(TokenType::LESS_EQUAL)) {
        Token op_tok = advance();
        auto right = parse_additive();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_additive() {
    auto expr = parse_multiplicative();

    while (check(TokenType::PLUS) || check(TokenType::MINUS)) {
        Token op_tok = advance();
        auto right = parse_multiplicative();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_multiplicative() {
    auto expr = parse_unary();

    while (check(TokenType::STAR) || check(TokenType::SLASH) || check(TokenType::MOD)) {
        Token op_tok = advance();
        auto right = parse_unary();
        expr = std::make_unique<BinaryExprASTNode>(
            op_tok.type,
            std::move(expr),
            std::move(right),
            op_tok.line,
            op_tok.column
        );
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_unary() {
    if (check(TokenType::LOGICAL_NOT) || check(TokenType::K_NA) || check(TokenType::MINUS)) {
        Token op_tok = advance();
        auto operand = parse_unary();
        return std::make_unique<UnaryExprASTNode>(
            op_tok.type,
            std::move(operand),
            op_tok.line,
            op_tok.column
        );
    }

    return parse_postfix();
}

std::unique_ptr<ExprASTNode> Parser::parse_postfix() {
    auto expr = parse_primary();

    while (true) {
        if (match(TokenType::LBRACKET)) {
            size_t line = previous().line;
            size_t col = previous().column;
            auto idx_expr = parse_expression();
            consume(TokenType::RBRACKET, "']' अपेक्षितम्");
            expr = std::make_unique<ArrayIndexExprASTNode>(std::move(expr), std::move(idx_expr), line, col);
        } else if (match(TokenType::DOT)) {
            size_t line = previous().line;
            size_t col = previous().column;
            Token member_tok = consume(TokenType::IDENTIFIER, "सभ्यस्य नाम अपेक्षितम्");
            if (match(TokenType::LPAREN)) {
                std::vector<std::unique_ptr<ExprASTNode>> args;
                if (!check(TokenType::RPAREN)) {
                    do {
                        args.push_back(parse_expression());
                    } while (match(TokenType::COMMA));
                }
                consume(TokenType::RPAREN, "')' अपेक्षितम्");
                expr = std::make_unique<MethodCallExprASTNode>(std::move(expr), member_tok.lexeme, std::move(args), line, col);
            } else {
                expr = std::make_unique<MemberAccessExprASTNode>(std::move(expr), member_tok.lexeme, line, col);
            }
        } else {
            break;
        }
    }

    return expr;
}

std::unique_ptr<ExprASTNode> Parser::parse_primary() {
    const Token& tok = peek();

    if (match(TokenType::INT_LITERAL)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::INT, tok.lexeme, tok.line, tok.column);
    }

    if (match(TokenType::FLOAT_LITERAL)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::FLOAT, tok.lexeme, tok.line, tok.column);
    }

    if (match(TokenType::STRING_LITERAL)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::STRING, tok.lexeme, tok.line, tok.column);
    }

    if (match(TokenType::CHAR_LITERAL)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::CHAR, tok.lexeme, tok.line, tok.column);
    }

    if (match(TokenType::K_SATYA)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::BOOL, "सत्य", tok.line, tok.column);
    }

    if (match(TokenType::K_ASATYA)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::BOOL, "असत्य", tok.line, tok.column);
    }

    if (match(TokenType::K_SHUNYAM)) {
        return std::make_unique<LiteralExprASTNode>(LiteralType::NULL_VAL, "शून्यम्", tok.line, tok.column);
    }

    if (match(TokenType::K_SVA)) {
        return std::make_unique<SelfExprASTNode>(tok.line, tok.column);
    }

    if (match(TokenType::K_NAVIN)) {
        Token class_tok = consume(TokenType::IDENTIFIER, "वर्गस्य नाम अपेक्षितम्");
        consume(TokenType::LPAREN, "'(' अपेक्षितम्");
        std::vector<std::unique_ptr<ExprASTNode>> args;
        if (!check(TokenType::RPAREN)) {
            do {
                args.push_back(parse_expression());
            } while (match(TokenType::COMMA));
        }
        consume(TokenType::RPAREN, "')' अपेक्षितम्");
        return std::make_unique<NewExprASTNode>(class_tok.lexeme, std::move(args), tok.line, tok.column);
    }

    // Console Input 'पठतु'
    if (match(TokenType::K_PATHATU)) {
        if (match(TokenType::LPAREN)) {
            consume(TokenType::RPAREN, "')' अपेक्षितम्");
        }
        return std::make_unique<InputExprASTNode>(tok.line, tok.column);
    }

    // Array Literal [elem1, elem2, ...]
    if (match(TokenType::LBRACKET)) {
        std::vector<std::unique_ptr<ExprASTNode>> elements;
        if (!check(TokenType::RBRACKET)) {
            do {
                elements.push_back(parse_expression());
            } while (match(TokenType::COMMA));
        }
        consume(TokenType::RBRACKET, "']' अपेक्षितम्");
        return std::make_unique<ArrayLiteralExprASTNode>(std::move(elements), tok.line, tok.column);
    }

    // Dictionary Literal { "key": expr, "key2": expr2 }
    if (match(TokenType::LBRACE)) {
        std::vector<std::pair<std::string, std::unique_ptr<ExprASTNode>>> elements;
        if (!check(TokenType::RBRACE)) {
            do {
                Token key_tok = consume(TokenType::STRING_LITERAL, "शब्दकोश-कुंजी (string key) अपेक्षितम्");
                consume(TokenType::COLON, "':' अपेक्षितम्");
                auto val_expr = parse_expression();
                elements.push_back({key_tok.lexeme, std::move(val_expr)});
            } while (match(TokenType::COMMA));
        }
        consume(TokenType::RBRACE, "'}' अपेक्षितम्");
        return std::make_unique<DictionaryLiteralExprASTNode>(std::move(elements), tok.line, tok.column);
    }

    if (check(TokenType::IDENTIFIER) || check(TokenType::K_MUKHYA)) {
        Token id_tok = advance();

        // Check for function call: function_name(arg1, arg2)
        if (match(TokenType::LPAREN)) {
            std::vector<std::unique_ptr<ExprASTNode>> args;
            if (!check(TokenType::RPAREN)) {
                do {
                    args.push_back(parse_expression());
                } while (match(TokenType::COMMA));
            }

            consume(TokenType::RPAREN, "')' अपेक्षितम्");
            return std::make_unique<CallExprASTNode>(id_tok.lexeme, std::move(args), id_tok.line, id_tok.column);
        }

        return std::make_unique<IdentifierExprASTNode>(id_tok.lexeme, id_tok.line, id_tok.column);
    }

    if (match(TokenType::LPAREN)) {
        auto expr = parse_expression();
        consume(TokenType::RPAREN, "')' अपेक्षितम्");
        return expr;
    }

    throw ParserError("अमान्य पदम् — पदम् न प्राप्तम्: '" + tok.lexeme + "'", tok.line, tok.column);
}

} // namespace sutra