#include "sutra/semantic.hpp"
#include "sutra/memory.hpp"

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

DataType SemanticAnalyzer::get_variable_type(const std::string& name) const {
    for (auto it = m_scopes.rbegin(); it != m_scopes.rend(); ++it) {
        auto found = it->find(name);
        if (found != it->end()) {
            return found->second;
        }
    }
    return DataType::UNKNOWN;
}

void SemanticAnalyzer::declare_variable(const std::string& name, DataType type, size_t line, size_t col) {
    if (m_scopes.empty()) {
        push_scope();
    }
    if (m_scopes.back().find(name) != m_scopes.back().end()) {
        throw SemanticError("'" + name + "' नामकः चरः अस्मिन् कार्यक्षेत्रे पूर्वमेव परिभाषितः अस्ति।", line, col);
    }
    m_scopes.back()[name] = type;
}

void SemanticAnalyzer::analyze(const ProgramASTNode& program) {
    MemoryModelRegistry::get_instance().reset();

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
    m_functions["संग्रह_करो"] = FunctionSymbol{"संग्रह_करो", 0, 0, 0};
    m_functions["स्मृति_स्थिति"] = FunctionSymbol{"स्मृति_स्थिति", 0, 0, 0};

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
    MemoryModelRegistry::get_instance().push_frame("global");
    push_scope();
    for (const auto& stmt : program.global_statements) {
        analyze_statement(*stmt);
    }

    // Analyze function bodies
    for (const auto& func : program.functions) {
        analyze_function(*func);
    }
    pop_scope();
    MemoryModelRegistry::get_instance().pop_frame();
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
    MemoryModelRegistry::get_instance().push_frame(func.name);

    push_scope();

    for (const auto& param : func.params) {
        DataType type = parse_type_name(param.type_name);
        declare_variable(param.name, type, func.line, func.column);

        if (auto* frame = MemoryModelRegistry::get_instance().get_current_frame()) {
            frame->add_variable(param.name, type, m_scopes.size());
        }
    }

    if (func.body) {
        for (const auto& stmt : func.body->statements) {
            analyze_statement(*stmt);
        }
    }

    pop_scope();
    MemoryModelRegistry::get_instance().pop_frame();
}

void SemanticAnalyzer::analyze_statement(const StmtASTNode& stmt) {
    if (auto var_decl = dynamic_cast<const VarDeclStmtASTNode*>(&stmt)) {
        DataType declared_type = parse_type_name(var_decl->type_name);
        DataType init_type = DataType::RIKT;
        if (var_decl->initializer) {
            analyze_expression(*var_decl->initializer);
            init_type = determine_type(*var_decl->initializer);
        }

        if (declared_type == DataType::UNKNOWN) {
            if (var_decl->initializer) {
                declared_type = init_type;
            } else {
                declared_type = DataType::RIKT;
            }
        } else {
            if (var_decl->initializer) {
                if (!is_assignable(declared_type, init_type)) {
                    throw SemanticError("त्रुटि: '" + var_decl->var_name + "' के लिए अपेक्षित प्रकार '" +
                                        data_type_to_string(declared_type) + "' है, लेकिन '" +
                                        data_type_to_string(init_type) + "' प्राप्त हुआ।",
                                        var_decl->line, var_decl->column);
                }
            }
        }
        declare_variable(var_decl->var_name, declared_type, var_decl->line, var_decl->column);

        if (auto* frame = MemoryModelRegistry::get_instance().get_current_frame()) {
            frame->add_variable(var_decl->var_name, declared_type, m_scopes.size());
        }
    } else if (auto assign_stmt = dynamic_cast<const AssignStmtASTNode*>(&stmt)) {
        if (!is_declared(assign_stmt->var_name)) {
            throw SemanticError("'" + assign_stmt->var_name + "' नामकः चरः अपरिभाषितः अस्ति।", assign_stmt->line, assign_stmt->column);
        }
        analyze_expression(*assign_stmt->value);

        DataType target_type = get_variable_type(assign_stmt->var_name);
        DataType val_type = determine_type(*assign_stmt->value);
        if (!is_assignable(target_type, val_type)) {
            throw SemanticError("त्रुटि: '" + assign_stmt->var_name + "' के लिए अपेक्षित प्रकार '" +
                                data_type_to_string(target_type) + "' है, लेकिन '" +
                                data_type_to_string(val_type) + "' प्राप्त हुआ।",
                                assign_stmt->line, assign_stmt->column);
        }
    } else if (auto arr_assign_stmt = dynamic_cast<const ArrayIndexAssignStmtASTNode*>(&stmt)) {
        if (!is_declared(arr_assign_stmt->array_name)) {
            throw SemanticError("'" + arr_assign_stmt->array_name + "' नामकः चरः अपरिभाषितः अस्ति।", arr_assign_stmt->line, arr_assign_stmt->column);
        }
        for (const auto& idx_expr : arr_assign_stmt->index_exprs) {
            analyze_expression(*idx_expr);
        }
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
        declare_variable(try_catch->catch_var_name, DataType::UNKNOWN, try_catch->line, try_catch->column);
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

DataType SemanticAnalyzer::determine_type(const ExprASTNode& expr) {
    if (auto lit_expr = dynamic_cast<const LiteralExprASTNode*>(&expr)) {
        switch (lit_expr->lit_type) {
            case LiteralType::INT: {
                try {
                    long long val = std::stoll(lit_expr->value);
                    if (val >= -2147483648LL && val <= 2147483647LL) {
                        return DataType::POORNAK;
                    }
                    return DataType::BADA_POORNAK;
                } catch (const std::out_of_range&) {
                    throw SemanticError("त्रुटि: पूर्णांक संख्यायाः मानं अधिकं वर्तते (Numeric overflow)", lit_expr->line, lit_expr->column);
                }
            }
            case LiteralType::FLOAT:
                return DataType::DASHAMLAV;
            case LiteralType::STRING:
                return DataType::PAATH;
            case LiteralType::BOOL:
                return DataType::TARK;
            case LiteralType::NULL_VAL:
                return DataType::RIKT;
            case LiteralType::CHAR:
                return DataType::AKSHAR;
        }
    }

    if (auto id_expr = dynamic_cast<const IdentifierExprASTNode*>(&expr)) {
        if (id_expr->name == "स्व") return DataType::UNKNOWN;
        return get_variable_type(id_expr->name);
    }

    if (auto bin_expr = dynamic_cast<const BinaryExprASTNode*>(&expr)) {
        DataType left = determine_type(*bin_expr->left);
        DataType right = determine_type(*bin_expr->right);

        // String concatenation
        if (bin_expr->op == TokenType::PLUS && (left == DataType::PAATH || right == DataType::PAATH)) {
            return DataType::PAATH;
        }

        // Logic operators
        if (bin_expr->op == TokenType::LOGICAL_AND || bin_expr->op == TokenType::LOGICAL_OR ||
            bin_expr->op == TokenType::K_TATHA || bin_expr->op == TokenType::K_ATHAVA) {
            if (left != DataType::UNKNOWN && left != DataType::TARK) {
                throw SemanticError("त्रुटि: तर्कसंक्रिया केवलं तार्किकमूल्येषु एव सम्भवति। (Logical operations only allowed for booleans)", bin_expr->line, bin_expr->column);
            }
            if (right != DataType::UNKNOWN && right != DataType::TARK) {
                throw SemanticError("त्रुटि: तर्कसंक्रिया केवलं तार्किकमूल्येषु एव सम्भवति। (Logical operations only allowed for booleans)", bin_expr->line, bin_expr->column);
            }
            return DataType::TARK;
        }

        // Comparison operators
        if (bin_expr->op == TokenType::EQUAL || bin_expr->op == TokenType::NOT_EQUAL ||
            bin_expr->op == TokenType::GREATER || bin_expr->op == TokenType::LESS ||
            bin_expr->op == TokenType::GREATER_EQUAL || bin_expr->op == TokenType::LESS_EQUAL) {
            return DataType::TARK;
        }

        // Modulo operator (integers only)
        if (bin_expr->op == TokenType::MOD) {
            if (left == DataType::DASHAMLAV || right == DataType::DASHAMLAV) {
                throw SemanticError("त्रुटि: भागशेषसंक्रिया केवलं पूर्णांकयोः एव सम्भवति। (Modulo only allowed for integers)", bin_expr->line, bin_expr->column);
            }
            if (left == DataType::BADA_POORNAK || right == DataType::BADA_POORNAK) {
                return DataType::BADA_POORNAK;
            }
            return DataType::POORNAK;
        }

        // Standard arithmetic
        if (bin_expr->op == TokenType::PLUS || bin_expr->op == TokenType::MINUS ||
            bin_expr->op == TokenType::STAR || bin_expr->op == TokenType::SLASH) {
            
            const TypeInfo& left_info = get_type_info(left);
            const TypeInfo& right_info = get_type_info(right);
            
            if (left != DataType::UNKNOWN && right != DataType::UNKNOWN) {
                if (!left_info.is_numeric() || !right_info.is_numeric()) {
                    throw SemanticError("त्रुटि: अङ्कगणितीयसंक्रिया केवलं सङ्ख्यासु एव सम्भवति। (Arithmetic operations only allowed for numbers)", bin_expr->line, bin_expr->column);
                }
            }
        }

        if (left == DataType::DASHAMLAV || right == DataType::DASHAMLAV) {
            return DataType::DASHAMLAV;
        }
        if (left == DataType::BADA_POORNAK || right == DataType::BADA_POORNAK) {
            return DataType::BADA_POORNAK;
        }
        return DataType::POORNAK;
    }

    if (auto un_expr = dynamic_cast<const UnaryExprASTNode*>(&expr)) {
        DataType operand_type = determine_type(*un_expr->operand);
        if (un_expr->op == TokenType::LOGICAL_NOT || un_expr->op == TokenType::K_NA) {
            if (operand_type != DataType::UNKNOWN && operand_type != DataType::TARK) {
                throw SemanticError("त्रुटि: तर्कसंक्रिया केवलं तार्किकमूल्येषु एव सम्भवति। (Logical NOT only allowed for booleans)", un_expr->line, un_expr->column);
            }
            return DataType::TARK;
        }
        if (un_expr->op == TokenType::MINUS) {
            if (operand_type != DataType::UNKNOWN && !get_type_info(operand_type).is_numeric()) {
                throw SemanticError("त्रुटि: ऋणात्मकसंक्रिया केवलं सङ्ख्यासु एव सम्भवति। (Unary minus only allowed for numbers)", un_expr->line, un_expr->column);
            }
            return operand_type;
        }
    }

    return DataType::UNKNOWN;
}

} // namespace sutra
