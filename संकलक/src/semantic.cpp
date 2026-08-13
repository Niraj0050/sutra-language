#include "sutra/semantic.hpp"

namespace sutra {

void SemanticAnalyzer::push_scope() {
    m_scopes.emplace_back();
}

void SemanticAnalyzer::pop_scope() {
    if (!m_scopes.empty()) {
        m_scopes.pop_back();
    }
}

bool SemanticAnalyzer::is_declared(const std::string& name) const {
    for (auto it = m_scopes.rbegin(); it != m_scopes.rend(); ++it) {
        if (it->find(name) != it->end()) {
            return true;
        }
    }
    return false;
}

void SemanticAnalyzer::declare_variable(const std::string& name, size_t line, size_t col) {
    if (m_scopes.empty()) {
        push_scope();
    }
    if (m_scopes.back().find(name) != m_scopes.back().end()) {
        throw SemanticError("'" + name + "' नामकः चरः अस्मिन् कार्यक्षेत्रे पूर्वमेव परिभाषितः अस्ति।", line, col);
    }
    m_scopes.back().insert(name);
}

void SemanticAnalyzer::analyze(const ProgramASTNode& program) {
    m_functions.clear();
    m_scopes.clear();

    // Register all functions first
    for (const auto& func : program.functions) {
        if (m_functions.find(func->name) != m_functions.end()) {
            throw SemanticError("'" + func->name + "' नामकं कार्यं पूर्वमेव परिभाषितम् अस्ति।", func->line, func->column);
        }
        m_functions[func->name] = FunctionSymbol{func->name, func->params.size(), func->line, func->column};
    }

    // Register builtin functions
    m_functions["लिखतु"] = FunctionSymbol{"लिखतु", 1, 0, 0};
    m_functions["दर्शयतु"] = FunctionSymbol{"दर्शयतु", 1, 0, 0};
    m_functions["पंक्तिं"] = FunctionSymbol{"पंक्तिं", 1, 0, 0};
    m_functions["पठतु"] = FunctionSymbol{"पठतु", 0, 0, 0};

    // Standard Library - Math
    m_functions["वर्गमूल"] = FunctionSymbol{"वर्गमूल", 1, 0, 0};
    m_functions["घात"] = FunctionSymbol{"घात", 2, 0, 0};
    m_functions["निरपेक्ष"] = FunctionSymbol{"निरपेक्ष", 1, 0, 0};
    m_functions["न्यूनतम"] = FunctionSymbol{"न्यूनतम", 2, 0, 0};
    m_functions["अधिकतम"] = FunctionSymbol{"अधिकतम", 2, 0, 0};
    m_functions["गोल"] = FunctionSymbol{"गोल", 1, 0, 0};

    // Standard Library - String & List & Utility
    m_functions["लंबाई"] = FunctionSymbol{"लंबाई", 1, 0, 0};
    m_functions["उच्च"] = FunctionSymbol{"उच्च", 1, 0, 0};
    m_functions["निम्न"] = FunctionSymbol{"निम्न", 1, 0, 0};
    m_functions["प्रकार"] = FunctionSymbol{"प्रकार", 1, 0, 0};
    m_functions["जोड़ें"] = FunctionSymbol{"जोड़ें", 2, 0, 0};

    // Analyze global statements
    push_scope();
    for (const auto& stmt : program.global_statements) {
        analyze_statement(*stmt);
    }

    // Analyze function bodies
    for (const auto& func : program.functions) {
        analyze_function(*func);
    }
    pop_scope();
}

void SemanticAnalyzer::init_repl() {
    m_functions.clear();
    m_scopes.clear();
    push_scope();

    m_functions["लिखतु"] = FunctionSymbol{"लिखतु", 1, 0, 0};
    m_functions["दर्शयतु"] = FunctionSymbol{"दर्शयतु", 1, 0, 0};
    m_functions["पंक्तिं"] = FunctionSymbol{"पंक्तिं", 1, 0, 0};
    m_functions["पठतु"] = FunctionSymbol{"पठतु", 0, 0, 0};

    // Standard Library - Math
    m_functions["वर्गमूल"] = FunctionSymbol{"वर्गमूल", 1, 0, 0};
    m_functions["घात"] = FunctionSymbol{"घात", 2, 0, 0};
    m_functions["निरपेक्ष"] = FunctionSymbol{"निरपेक्ष", 1, 0, 0};
    m_functions["न्यूनतम"] = FunctionSymbol{"न्यूनतम", 2, 0, 0};
    m_functions["अधिकतम"] = FunctionSymbol{"अधिकतम", 2, 0, 0};
    m_functions["गोल"] = FunctionSymbol{"गोल", 1, 0, 0};

    // Standard Library - String & List & Utility
    m_functions["लंबाई"] = FunctionSymbol{"लंबाई", 1, 0, 0};
    m_functions["उच्च"] = FunctionSymbol{"उच्च", 1, 0, 0};
    m_functions["निम्न"] = FunctionSymbol{"निम्न", 1, 0, 0};
    m_functions["प्रकार"] = FunctionSymbol{"प्रकार", 1, 0, 0};
    m_functions["जोड़ें"] = FunctionSymbol{"जोड़ें", 2, 0, 0};
}

void SemanticAnalyzer::analyze_repl(const ProgramASTNode& program) {
    if (m_scopes.empty()) {
        init_repl();
    }

    for (const auto& func : program.functions) {
        m_functions[func->name] = FunctionSymbol{func->name, func->params.size(), func->line, func->column};
    }

    for (const auto& stmt : program.global_statements) {
        analyze_statement(*stmt);
    }

    for (const auto& func : program.functions) {
        analyze_function(*func);
    }
}

void SemanticAnalyzer::analyze_function(const FunctionDeclASTNode& func) {
    push_scope();

    for (const auto& param : func.params) {
        declare_variable(param.name, func.line, func.column);
    }

    if (func.body) {
        for (const auto& stmt : func.body->statements) {
            analyze_statement(*stmt);
        }
    }

    pop_scope();
}

void SemanticAnalyzer::analyze_statement(const StmtASTNode& stmt) {
    if (auto var_decl = dynamic_cast<const VarDeclStmtASTNode*>(&stmt)) {
        if (var_decl->initializer) {
            analyze_expression(*var_decl->initializer);
        }
        declare_variable(var_decl->var_name, var_decl->line, var_decl->column);
    } else if (auto assign_stmt = dynamic_cast<const AssignStmtASTNode*>(&stmt)) {
        if (!is_declared(assign_stmt->var_name)) {
            throw SemanticError("'" + assign_stmt->var_name + "' नामकः चरः अपरिभाषितः अस्ति।", assign_stmt->line, assign_stmt->column);
        }
        analyze_expression(*assign_stmt->value);
    } else if (auto arr_assign_stmt = dynamic_cast<const ArrayIndexAssignStmtASTNode*>(&stmt)) {
        if (!is_declared(arr_assign_stmt->array_name)) {
            throw SemanticError("'" + arr_assign_stmt->array_name + "' नामकः चरः अपरिभाषितः अस्ति।", arr_assign_stmt->line, arr_assign_stmt->column);
        }
        analyze_expression(*arr_assign_stmt->index_expr);
        analyze_expression(*arr_assign_stmt->value_expr);
    } else if (auto print_stmt = dynamic_cast<const PrintStmtASTNode*>(&stmt)) {
        analyze_expression(*print_stmt->expression);
    } else if (auto if_stmt = dynamic_cast<const IfStmtASTNode*>(&stmt)) {
        analyze_expression(*if_stmt->condition);
        push_scope();
        for (const auto& s : if_stmt->then_branch->statements) {
            analyze_statement(*s);
        }
        pop_scope();
        if (if_stmt->else_branch) {
            push_scope();
            for (const auto& s : if_stmt->else_branch->statements) {
                analyze_statement(*s);
            }
            pop_scope();
        }
    } else if (auto while_stmt = dynamic_cast<const WhileStmtASTNode*>(&stmt)) {
        analyze_expression(*while_stmt->condition);
        m_loop_depth++;
        push_scope();
        for (const auto& s : while_stmt->body->statements) {
            analyze_statement(*s);
        }
        pop_scope();
        m_loop_depth--;
    } else if (auto for_stmt = dynamic_cast<const ForStmtASTNode*>(&stmt)) {
        m_loop_depth++;
        push_scope();
        if (for_stmt->init) {
            analyze_statement(*for_stmt->init);
        }
        if (for_stmt->condition) {
            analyze_expression(*for_stmt->condition);
        }
        if (for_stmt->update) {
            analyze_statement(*for_stmt->update);
        }
        if (for_stmt->body) {
            for (const auto& s : for_stmt->body->statements) {
                analyze_statement(*s);
            }
        }
        pop_scope();
        m_loop_depth--;
    } else if (dynamic_cast<const BreakStmtASTNode*>(&stmt)) {
        if (m_loop_depth == 0) {
            throw SemanticError("'विरामः' केवलं चक्रस्य अन्तः एव प्रयोक्तुं शक्यते। ('विरामः' only allowed inside loop)", stmt.line, stmt.column);
        }
    } else if (dynamic_cast<const ContinueStmtASTNode*>(&stmt)) {
        if (m_loop_depth == 0) {
            throw SemanticError("'जारीरह' केवलं चक्रस्य अन्तः एव प्रयोक्तुं शक्यते। ('जारीरह' only allowed inside loop)", stmt.line, stmt.column);
        }
    } else if (auto try_catch = dynamic_cast<const TryCatchStmtASTNode*>(&stmt)) {
        push_scope();
        for (const auto& s : try_catch->try_block->statements) {
            analyze_statement(*s);
        }
        pop_scope();

        push_scope();
        declare_variable(try_catch->catch_var_name, try_catch->line, try_catch->column);
        for (const auto& s : try_catch->catch_block->statements) {
            analyze_statement(*s);
        }
        pop_scope();
    } else if (auto throw_stmt = dynamic_cast<const ThrowStmtASTNode*>(&stmt)) {
        analyze_expression(*throw_stmt->expression);
    } else if (auto ret_stmt = dynamic_cast<const ReturnStmtASTNode*>(&stmt)) {
        if (ret_stmt->value) {
            analyze_expression(*ret_stmt->value);
        }
    } else if (auto mem_assign = dynamic_cast<const MemberAssignStmtASTNode*>(&stmt)) {
        analyze_expression(*mem_assign->object_expr);
        analyze_expression(*mem_assign->value_expr);
    } else if (auto block_stmt = dynamic_cast<const BlockStmtASTNode*>(&stmt)) {
        push_scope();
        for (const auto& s : block_stmt->statements) {
            analyze_statement(*s);
        }
        pop_scope();
    } else if (auto expr_stmt = dynamic_cast<const ExprStmtASTNode*>(&stmt)) {
        analyze_expression(*expr_stmt->expression);
    }
}

void SemanticAnalyzer::analyze_expression(const ExprASTNode& expr) {
    if (auto id_expr = dynamic_cast<const IdentifierExprASTNode*>(&expr)) {
        if (id_expr->name != "स्व" && !is_declared(id_expr->name)) {
            throw SemanticError("'" + id_expr->name + "' नामकः चरः अपरिभाषितः अस्ति।", id_expr->line, id_expr->column);
        }
    } else if (auto bin_expr = dynamic_cast<const BinaryExprASTNode*>(&expr)) {
        analyze_expression(*bin_expr->left);
        analyze_expression(*bin_expr->right);
    } else if (auto un_expr = dynamic_cast<const UnaryExprASTNode*>(&expr)) {
        analyze_expression(*un_expr->operand);
    } else if (auto arr_lit = dynamic_cast<const ArrayLiteralExprASTNode*>(&expr)) {
        for (const auto& elem : arr_lit->elements) {
            analyze_expression(*elem);
        }
    } else if (auto arr_idx = dynamic_cast<const ArrayIndexExprASTNode*>(&expr)) {
        analyze_expression(*arr_idx->array_expr);
        analyze_expression(*arr_idx->index_expr);
    } else if (auto new_expr = dynamic_cast<const NewExprASTNode*>(&expr)) {
        for (const auto& arg : new_expr->arguments) {
            analyze_expression(*arg);
        }
    } else if (dynamic_cast<const SelfExprASTNode*>(&expr)) {
        // 'स्व' refers to instance context
    } else if (auto mem_acc = dynamic_cast<const MemberAccessExprASTNode*>(&expr)) {
        analyze_expression(*mem_acc->object_expr);
    } else if (auto meth_call = dynamic_cast<const MethodCallExprASTNode*>(&expr)) {
        analyze_expression(*meth_call->object_expr);
        for (const auto& arg : meth_call->arguments) {
            analyze_expression(*arg);
        }
    } else if (auto call_expr = dynamic_cast<const CallExprASTNode*>(&expr)) {
        auto it = m_functions.find(call_expr->callee);
        if (it == m_functions.end()) {
            throw SemanticError("'" + call_expr->callee + "' नामकं कार्यं अपरिभाषितम् अस्ति।", call_expr->line, call_expr->column);
        }
        if (it->second.param_count != call_expr->arguments.size()) {
            throw SemanticError("'" + call_expr->callee + "' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
        }
        for (const auto& arg : call_expr->arguments) {
            analyze_expression(*arg);
        }
    }
}

} // namespace sutra
