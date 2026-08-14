#include "sutra/compiler/ir_generator.hpp"
#include "sutra/error.hpp"
#include <cstdint>

namespace sutra {
namespace compiler {

static IRValueType infer_expr_type_static(ExprASTNode* expr, FunctionDeclASTNode* func, const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_funcs, const std::unordered_map<std::string, IRValueType>& current_func_types) {
    if (!expr) return IRValueType::INT;
    
    if (auto lit = dynamic_cast<LiteralExprASTNode*>(expr)) {
        if (lit->lit_type == LiteralType::STRING) return IRValueType::STRING;
        if (lit->lit_type == LiteralType::BOOL) return IRValueType::BOOL;
        if (lit->lit_type == LiteralType::NULL_VAL) return IRValueType::NULL_VAL;
        return IRValueType::INT;
    }
    
    if (auto id = dynamic_cast<IdentifierExprASTNode*>(expr)) {
        if (func) {
            for (const auto& p : func->params) {
                if (p.name == id->name) {
                    if (p.type_name == "पाठ") return IRValueType::STRING;
                    if (p.type_name == "बूल" || p.type_name == "तर्क") return IRValueType::BOOL;
                    if (p.type_name == "सूची") return IRValueType::ARRAY;
                    return IRValueType::INT;
                }
            }
            
            struct VarDeclScanner {
                std::string target;
                FunctionDeclASTNode* f;
                const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_f;
                const std::unordered_map<std::string, IRValueType>& ft;
                IRValueType found = IRValueType::UNKNOWN;
                
                void scan(StmtASTNode* s) {
                    if (!s || found != IRValueType::UNKNOWN) return;
                    if (auto decl = dynamic_cast<VarDeclStmtASTNode*>(s)) {
                        if (decl->var_name == target) {
                            if (decl->type_name == "पाठ") found = IRValueType::STRING;
                            else if (decl->type_name == "बूल" || decl->type_name == "तर्क") found = IRValueType::BOOL;
                            else if (decl->type_name == "सूची") found = IRValueType::ARRAY;
                            else if (decl->type_name == "मान" && decl->initializer) {
                                found = infer_expr_type_static(decl->initializer.get(), f, all_f, ft);
                            } else {
                                found = IRValueType::INT;
                            }
                            return;
                        }
                    }
                    if (auto block = dynamic_cast<BlockStmtASTNode*>(s)) {
                        for (const auto& child : block->statements) scan(child.get());
                    } else if (auto if_stmt = dynamic_cast<IfStmtASTNode*>(s)) {
                        if (if_stmt->then_branch) scan(if_stmt->then_branch.get());
                        if (if_stmt->else_branch) scan(if_stmt->else_branch.get());
                    } else if (auto while_stmt = dynamic_cast<WhileStmtASTNode*>(s)) {
                        if (while_stmt->body) scan(while_stmt->body.get());
                    } else if (auto for_stmt = dynamic_cast<ForStmtASTNode*>(s)) {
                        if (for_stmt->init) scan(for_stmt->init.get());
                        if (for_stmt->body) scan(for_stmt->body.get());
                    } else if (auto try_catch = dynamic_cast<TryCatchStmtASTNode*>(s)) {
                        if (try_catch->try_block) scan(try_catch->try_block.get());
                        if (try_catch->catch_block) scan(try_catch->catch_block.get());
                    }
                }
            };
            VarDeclScanner scanner{id->name, func, all_funcs, current_func_types, IRValueType::UNKNOWN};
            if (func->body) {
                scanner.scan(func->body.get());
            }
            if (scanner.found != IRValueType::UNKNOWN) {
                return scanner.found;
            }
        }
        return IRValueType::INT;
    }
    
    if (auto bin = dynamic_cast<BinaryExprASTNode*>(expr)) {
        if (bin->op == TokenType::PLUS) {
            if (infer_expr_type_static(bin->left.get(), func, all_funcs, current_func_types) == IRValueType::STRING ||
                infer_expr_type_static(bin->right.get(), func, all_funcs, current_func_types) == IRValueType::STRING) {
                return IRValueType::STRING;
            }
        }
        bool is_bool_op = (bin->op == TokenType::EQUAL || bin->op == TokenType::NOT_EQUAL ||
                           bin->op == TokenType::LESS || bin->op == TokenType::GREATER ||
                           bin->op == TokenType::LESS_EQUAL || bin->op == TokenType::GREATER_EQUAL ||
                           bin->op == TokenType::LOGICAL_AND || bin->op == TokenType::K_TATHA ||
                           bin->op == TokenType::LOGICAL_OR || bin->op == TokenType::K_ATHAVA);
        if (is_bool_op) return IRValueType::BOOL;
        return IRValueType::INT;
    }
    
    if (auto call = dynamic_cast<CallExprASTNode*>(expr)) {
        if (call->callee == "लिखतु" || call->callee == "दर्शयतु") return IRValueType::INT;
        if (call->callee == "लंबाई") return IRValueType::INT;
        if (call->callee == "उच्च" || call->callee == "निम्न") return IRValueType::STRING;
        auto it = current_func_types.find(call->callee);
        if (it != current_func_types.end()) {
            return it->second;
        }
    }
    
    return IRValueType::INT;
}

static void find_return_types_static(StmtASTNode* stmt, std::vector<IRValueType>& types, FunctionDeclASTNode* func, const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_funcs, const std::unordered_map<std::string, IRValueType>& current_func_types) {
    if (!stmt) return;
    if (auto block = dynamic_cast<BlockStmtASTNode*>(stmt)) {
        for (const auto& child : block->statements) {
            find_return_types_static(child.get(), types, func, all_funcs, current_func_types);
        }
    } else if (auto if_stmt = dynamic_cast<IfStmtASTNode*>(stmt)) {
        if (if_stmt->then_branch) {
            find_return_types_static(if_stmt->then_branch.get(), types, func, all_funcs, current_func_types);
        }
        if (if_stmt->else_branch) {
            find_return_types_static(if_stmt->else_branch.get(), types, func, all_funcs, current_func_types);
        }
    } else if (auto while_stmt = dynamic_cast<WhileStmtASTNode*>(stmt)) {
        if (while_stmt->body) {
            find_return_types_static(while_stmt->body.get(), types, func, all_funcs, current_func_types);
        }
    } else if (auto for_stmt = dynamic_cast<ForStmtASTNode*>(stmt)) {
        if (for_stmt->body) {
            find_return_types_static(for_stmt->body.get(), types, func, all_funcs, current_func_types);
        }
    } else if (auto try_catch = dynamic_cast<TryCatchStmtASTNode*>(stmt)) {
        if (try_catch->try_block) {
            find_return_types_static(try_catch->try_block.get(), types, func, all_funcs, current_func_types);
        }
        if (try_catch->catch_block) {
            find_return_types_static(try_catch->catch_block.get(), types, func, all_funcs, current_func_types);
        }
    } else if (auto ret = dynamic_cast<ReturnStmtASTNode*>(stmt)) {
        if (ret->value) {
            types.push_back(infer_expr_type_static(ret->value.get(), func, all_funcs, current_func_types));
        } else {
            types.push_back(IRValueType::INT);
        }
    }
}

std::unique_ptr<IRModule> IRGenerator::generate(ProgramASTNode& program, const std::string& module_name) {
    m_module = std::make_unique<IRModule>(module_name);
    m_type_map.clear();
    m_func_return_types.clear();

    // Initialize function return types
    for (const auto& func : program.functions) {
        m_func_return_types[func->name] = IRValueType::INT;
    }

    // Run passes to resolve function return types
    for (int pass = 0; pass < 3; ++pass) {
        for (const auto& func : program.functions) {
            std::vector<IRValueType> ret_types;
            if (func->body) {
                find_return_types_static(func->body.get(), ret_types, func.get(), program.functions, m_func_return_types);
            }
            IRValueType inferred = IRValueType::INT;
            for (auto t : ret_types) {
                if (t == IRValueType::STRING) {
                    inferred = IRValueType::STRING;
                    break;
                }
                if (t == IRValueType::BOOL) {
                    inferred = IRValueType::BOOL;
                }
                if (t == IRValueType::ARRAY) {
                    inferred = IRValueType::ARRAY;
                }
            }
            m_func_return_types[func->name] = inferred;
        }
    }

    // 1. Process Functions
    for (const auto& func : program.functions) {
        visit_function_decl(func.get());
    }

    // 2. Process Global Statements into main wrapper if global statements exist
    if (!program.global_statements.empty()) {
        bool has_main = false;
        for (const auto& func : m_module->functions) {
            if (func->name == "मुख्य" || func->name == "main") {
                has_main = true;
                break;
            }
        }

        if (!has_main) {
            auto main_func = std::make_unique<IRFunction>("main", std::vector<std::string>{});
            m_current_func = main_func.get();

            for (const auto& stmt : program.global_statements) {
                visit_stmt(stmt.get());
            }

            IRInstruction ret_inst(IROpcode::RET);
            ret_inst.arg1 = IRValue::make_int(0);
            m_current_func->instructions.push_back(ret_inst);

            m_module->functions.push_back(std::move(main_func));
        }
    }

    return std::move(m_module);
}

void IRGenerator::visit_function_decl(FunctionDeclASTNode* func) {
    std::vector<std::string> param_names;
    for (const auto& p : func->params) {
        param_names.push_back(p.name);
    }

    std::string fname = func->name;
    if (fname == "मुख्य") fname = "main";

    auto ir_func = std::make_unique<IRFunction>(fname, param_names);
    m_current_func = ir_func.get();

    // Allocate stack space for parameters
    for (const auto& p : func->params) {
        IRInstruction alloc(IROpcode::ALLOCA);
        alloc.dest = p.name;
        m_current_func->instructions.push_back(alloc);

        IRInstruction store(IROpcode::STORE);
        store.arg1 = IRValue::make_var(p.name);
        store.dest = p.name;
        m_current_func->instructions.push_back(store);

        // Track parameter types from type annotations
        if (p.type_name == "पाठ") {
            m_type_map[p.name] = IRValueType::STRING;
        } else if (p.type_name == "सूची") {
            m_type_map[p.name] = IRValueType::ARRAY;
        } else if (p.type_name == "बूल" || p.type_name == "तर्क") {
            m_type_map[p.name] = IRValueType::INT;
        } else {
            m_type_map[p.name] = IRValueType::INT;
        }
    }

    if (func->body) {
        for (const auto& stmt : func->body->statements) {
            visit_stmt(stmt.get());
        }
    }

    // Default return 0 if no return statement at function end
    if (m_current_func->instructions.empty() || m_current_func->instructions.back().opcode != IROpcode::RET) {
        IRInstruction ret(IROpcode::RET);
        ret.arg1 = IRValue::make_int(0);
        m_current_func->instructions.push_back(ret);
    }

    m_module->functions.push_back(std::move(ir_func));
}

IRValueType IRGenerator::get_type(const std::string& name) {
    auto it = m_type_map.find(name);
    if (it != m_type_map.end()) return it->second;
    return IRValueType::UNKNOWN;
}

void IRGenerator::visit_stmt(StmtASTNode* stmt) {
    if (auto var_decl = dynamic_cast<VarDeclStmtASTNode*>(stmt)) {
        IRInstruction alloc(IROpcode::ALLOCA);
        alloc.dest = var_decl->var_name;
        m_current_func->instructions.push_back(alloc);

        // Track type from type annotation
        if (var_decl->type_name == "पाठ") {
            m_type_map[var_decl->var_name] = IRValueType::STRING;
        } else if (var_decl->type_name == "सूची") {
            m_type_map[var_decl->var_name] = IRValueType::ARRAY;
        } else if (var_decl->type_name == "बूल" || var_decl->type_name == "तर्क") {
            m_type_map[var_decl->var_name] = IRValueType::BOOL;
        } else {
            m_type_map[var_decl->var_name] = IRValueType::INT;
        }

        if (var_decl->initializer) {
            IRValue val = visit_expr(var_decl->initializer.get());
            IRInstruction store(IROpcode::STORE);
            store.arg1 = val;
            store.dest = var_decl->var_name;
            m_current_func->instructions.push_back(store);

            // Infer type from initializer if type annotation is generic (मान)
            if (var_decl->type_name == "मान" || var_decl->type_name.empty()) {
                if (val.kind == IRValue::Kind::REGISTER) {
                    IRValueType expr_type = get_type(val.str_val);
                    if (expr_type != IRValueType::UNKNOWN) {
                        m_type_map[var_decl->var_name] = expr_type;
                    }
                }
            }
        }
    } else if (auto assign = dynamic_cast<AssignStmtASTNode*>(stmt)) {
        IRValue val = visit_expr(assign->value.get());
        IRInstruction store(IROpcode::STORE);
        store.arg1 = val;
        store.dest = assign->var_name;
        m_current_func->instructions.push_back(store);

    } else if (auto arr_assign = dynamic_cast<ArrayIndexAssignStmtASTNode*>(stmt)) {
        // Array element assignment: अंक[i] = val; and nested updates like अंक[i][j] = val;
        if (arr_assign->index_exprs.empty()) {
            return;
        }

        std::string temp_arr = new_temp();
        IRInstruction load_arr(IROpcode::LOAD);
        load_arr.dest = temp_arr;
        load_arr.arg1 = IRValue::make_var(arr_assign->array_name);
        m_current_func->instructions.push_back(load_arr);
        m_type_map[temp_arr] = IRValueType::ARRAY;

        for (size_t i = 0; i < arr_assign->index_exprs.size(); ++i) {
            IRValue idx_val = visit_expr(arr_assign->index_exprs[i].get());
            if (i + 1 == arr_assign->index_exprs.size()) {
                IRValue val = visit_expr(arr_assign->value_expr.get());
                IRInstruction set_inst(IROpcode::ARRAY_SET);
                set_inst.arg1 = IRValue::make_reg(temp_arr);
                set_inst.arg2 = idx_val;
                set_inst.call_args.push_back(val);
                m_current_func->instructions.push_back(set_inst);
                break;
            }

            std::string next_temp = new_temp();
            IRInstruction get_inst(IROpcode::ARRAY_GET);
            get_inst.dest = next_temp;
            get_inst.arg1 = IRValue::make_reg(temp_arr);
            get_inst.arg2 = idx_val;
            m_current_func->instructions.push_back(get_inst);
            m_type_map[next_temp] = IRValueType::ARRAY;
            temp_arr = next_temp;
        }

    } else if (auto print_stmt = dynamic_cast<PrintStmtASTNode*>(stmt)) {
        IRValue val = visit_expr(print_stmt->expression.get());

        // Determine type of the value being printed
        IRValueType val_type = IRValueType::INT;
        if (val.kind == IRValue::Kind::REGISTER) {
            val_type = get_type(val.str_val);
        } else if (val.kind == IRValue::Kind::STR_LITERAL) {
            val_type = IRValueType::STRING;
        }

        if (val_type == IRValueType::STRING) {
            IRInstruction print_inst(IROpcode::PRINT_STR);
            print_inst.arg1 = val;
            m_current_func->instructions.push_back(print_inst);
        } else if (val_type == IRValueType::NULL_VAL) {
            IRInstruction print_inst(IROpcode::PRINT_NULL);
            m_current_func->instructions.push_back(print_inst);
        } else if (val_type == IRValueType::BOOL) {
            IRInstruction print_inst(IROpcode::PRINT_BOOL);
            print_inst.arg1 = val;
            m_current_func->instructions.push_back(print_inst);
        } else {
            IRInstruction print_inst(IROpcode::PRINT_INT);
            print_inst.arg1 = val;
            m_current_func->instructions.push_back(print_inst);
        }

    } else if (auto ret_stmt = dynamic_cast<ReturnStmtASTNode*>(stmt)) {
        IRValue val;
        if (ret_stmt->value) {
            val = visit_expr(ret_stmt->value.get());
        } else {
            val = IRValue::make_int(0);
        }
        IRInstruction ret(IROpcode::RET);
        ret.arg1 = val;
        m_current_func->instructions.push_back(ret);

    } else if (auto if_stmt = dynamic_cast<IfStmtASTNode*>(stmt)) {
        std::string else_lbl = new_label("else");
        std::string end_lbl = new_label("if_end");

        IRValue cond_val = visit_expr(if_stmt->condition.get());

        IRInstruction jz(IROpcode::JUMP_IF_ZERO);
        jz.arg1 = cond_val;
        jz.label = if_stmt->else_branch ? else_lbl : end_lbl;
        m_current_func->instructions.push_back(jz);

        if (if_stmt->then_branch) {
            visit_stmt(if_stmt->then_branch.get());
        }

        if (if_stmt->else_branch) {
            IRInstruction jmp_end(IROpcode::JUMP);
            jmp_end.label = end_lbl;
            m_current_func->instructions.push_back(jmp_end);

            IRInstruction lbl_else(IROpcode::LABEL);
            lbl_else.label = else_lbl;
            m_current_func->instructions.push_back(lbl_else);

            visit_stmt(if_stmt->else_branch.get());
        }

        IRInstruction lbl_end(IROpcode::LABEL);
        lbl_end.label = end_lbl;
        m_current_func->instructions.push_back(lbl_end);

    } else if (auto while_stmt = dynamic_cast<WhileStmtASTNode*>(stmt)) {
        std::string cond_lbl = new_label("while_cond");
        std::string end_lbl = new_label("while_end");

        m_break_stack.push_back(end_lbl);
        m_continue_stack.push_back(cond_lbl);

        IRInstruction lbl_cond(IROpcode::LABEL);
        lbl_cond.label = cond_lbl;
        m_current_func->instructions.push_back(lbl_cond);

        IRValue cond_val = visit_expr(while_stmt->condition.get());
        IRInstruction jz(IROpcode::JUMP_IF_ZERO);
        jz.arg1 = cond_val;
        jz.label = end_lbl;
        m_current_func->instructions.push_back(jz);

        if (while_stmt->body) {
            visit_stmt(while_stmt->body.get());
        }

        IRInstruction jmp_cond(IROpcode::JUMP);
        jmp_cond.label = cond_lbl;
        m_current_func->instructions.push_back(jmp_cond);

        IRInstruction lbl_end(IROpcode::LABEL);
        lbl_end.label = end_lbl;
        m_current_func->instructions.push_back(lbl_end);

        m_break_stack.pop_back();
        m_continue_stack.pop_back();

    } else if (auto for_stmt = dynamic_cast<ForStmtASTNode*>(stmt)) {
        if (for_stmt->init) {
            visit_stmt(for_stmt->init.get());
        }

        std::string cond_lbl = new_label("for_cond");
        std::string update_lbl = new_label("for_upd");
        std::string end_lbl = new_label("for_end");

        m_break_stack.push_back(end_lbl);
        m_continue_stack.push_back(update_lbl);

        IRInstruction lbl_cond(IROpcode::LABEL);
        lbl_cond.label = cond_lbl;
        m_current_func->instructions.push_back(lbl_cond);

        if (for_stmt->condition) {
            IRValue cond_val = visit_expr(for_stmt->condition.get());
            IRInstruction jz(IROpcode::JUMP_IF_ZERO);
            jz.arg1 = cond_val;
            jz.label = end_lbl;
            m_current_func->instructions.push_back(jz);
        }

        if (for_stmt->body) {
            visit_stmt(for_stmt->body.get());
        }

        IRInstruction lbl_upd(IROpcode::LABEL);
        lbl_upd.label = update_lbl;
        m_current_func->instructions.push_back(lbl_upd);

        if (for_stmt->update) {
            visit_stmt(for_stmt->update.get());
        }

        IRInstruction jmp_cond(IROpcode::JUMP);
        jmp_cond.label = cond_lbl;
        m_current_func->instructions.push_back(jmp_cond);

        IRInstruction lbl_end(IROpcode::LABEL);
        lbl_end.label = end_lbl;
        m_current_func->instructions.push_back(lbl_end);

        m_break_stack.pop_back();
        m_continue_stack.pop_back();

    } else if (dynamic_cast<BreakStmtASTNode*>(stmt)) {
        if (!m_break_stack.empty()) {
            IRInstruction jmp(IROpcode::JUMP);
            jmp.label = m_break_stack.back();
            m_current_func->instructions.push_back(jmp);
        }
    } else if (dynamic_cast<ContinueStmtASTNode*>(stmt)) {
        if (!m_continue_stack.empty()) {
            IRInstruction jmp(IROpcode::JUMP);
            jmp.label = m_continue_stack.back();
            m_current_func->instructions.push_back(jmp);
        }
    } else if (auto expr_stmt = dynamic_cast<ExprStmtASTNode*>(stmt)) {
        if (expr_stmt->expression) {
            visit_expr(expr_stmt->expression.get());
        }
    } else if (auto block = dynamic_cast<BlockStmtASTNode*>(stmt)) {
        for (const auto& s : block->statements) {
            visit_stmt(s.get());
        }
    }
}

IRValue IRGenerator::visit_expr(ExprASTNode* expr) {
    if (auto lit = dynamic_cast<LiteralExprASTNode*>(expr)) {
        if (lit->lit_type == LiteralType::INT) {
            long long v = 0;
            try { v = std::stoll(lit->value); } catch (...) {}
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CONST_INT);
            inst.dest = temp;
            inst.arg1 = IRValue::make_int(v);
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::INT;
            return IRValue::make_reg(temp);
        } else if (lit->lit_type == LiteralType::BOOL) {
            long long v = (lit->value == "सत्य" || lit->value == "true" || lit->value == "1") ? 1 : 0;
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CONST_INT);
            inst.dest = temp;
            inst.arg1 = IRValue::make_int(v);
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::BOOL;
            return IRValue::make_reg(temp);
        } else if (lit->lit_type == LiteralType::STRING) {
            std::string str_id = "str_" + std::to_string(m_module->string_literals.size());
            m_module->string_literals.push_back(std::make_pair(str_id, lit->value));

            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CONST_STR);
            inst.dest = temp;
            inst.arg1 = IRValue::make_str(str_id);
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::STRING;
            return IRValue::make_reg(temp);
        } else if (lit->lit_type == LiteralType::NULL_VAL) {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CONST_NULL);
            inst.dest = temp;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::NULL_VAL;
            return IRValue::make_reg(temp);
        }
    } else if (auto id_expr = dynamic_cast<IdentifierExprASTNode*>(expr)) {
        std::string temp = new_temp();
        IRInstruction load(IROpcode::LOAD);
        load.dest = temp;
        load.arg1 = IRValue::make_var(id_expr->name);
        m_current_func->instructions.push_back(load);
        // Propagate type from variable
        m_type_map[temp] = get_type(id_expr->name);
        return IRValue::make_reg(temp);

    } else if (auto arr_lit = dynamic_cast<ArrayLiteralExprASTNode*>(expr)) {
        // Array literal: [10, 20, 30]
        int64_t count = static_cast<int64_t>(arr_lit->elements.size());

        // Create the array
        std::string arr_temp = new_temp();
        IRInstruction create_inst(IROpcode::ARRAY_CREATE);
        create_inst.dest = arr_temp;
        create_inst.arg1 = IRValue::make_int(count);
        m_current_func->instructions.push_back(create_inst);
        m_type_map[arr_temp] = IRValueType::ARRAY;

        // Initialize each element
        for (int64_t i = 0; i < count; ++i) {
            IRValue elem_val = visit_expr(arr_lit->elements[i].get());
            IRInstruction set_inst(IROpcode::ARRAY_SET);
            set_inst.arg1 = IRValue::make_reg(arr_temp);

            std::string idx_temp = new_temp();
            IRInstruction idx_inst(IROpcode::CONST_INT);
            idx_inst.dest = idx_temp;
            idx_inst.arg1 = IRValue::make_int(i);
            m_current_func->instructions.push_back(idx_inst);
            m_type_map[idx_temp] = IRValueType::INT;

            set_inst.arg2 = IRValue::make_reg(idx_temp);
            set_inst.call_args.push_back(elem_val);
            m_current_func->instructions.push_back(set_inst);
        }

        return IRValue::make_reg(arr_temp);

    } else if (auto arr_idx = dynamic_cast<ArrayIndexExprASTNode*>(expr)) {
        // Array indexing: अंक[i]
        IRValue arr_val = visit_expr(arr_idx->array_expr.get());
        IRValue idx_val = visit_expr(arr_idx->index_expr.get());

        IRValueType arr_type = IRValueType::INT;
        if (arr_val.kind == IRValue::Kind::REGISTER) {
            arr_type = get_type(arr_val.str_val);
        }

        std::string temp = new_temp();
        if (arr_type == IRValueType::STRING) {
            IRInstruction get_inst(IROpcode::STRING_GET);
            get_inst.dest = temp;
            get_inst.arg1 = arr_val;
            get_inst.arg2 = idx_val;
            m_current_func->instructions.push_back(get_inst);
            m_type_map[temp] = IRValueType::STRING;
        } else {
            IRInstruction get_inst(IROpcode::ARRAY_GET);
            get_inst.dest = temp;
            get_inst.arg1 = arr_val;
            get_inst.arg2 = idx_val;
            m_current_func->instructions.push_back(get_inst);
            m_type_map[temp] = IRValueType::INT;
        }
        return IRValue::make_reg(temp);

    } else if (auto un_expr = dynamic_cast<UnaryExprASTNode*>(expr)) {
        IRValue operand_val = visit_expr(un_expr->operand.get());
        std::string temp = new_temp();
        if (un_expr->op == TokenType::LOGICAL_NOT || un_expr->op == TokenType::K_NA) {
            IRInstruction inst(IROpcode::NOT_OP);
            inst.dest = temp;
            inst.arg1 = operand_val;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::BOOL;
            return IRValue::make_reg(temp);
        } else if (un_expr->op == TokenType::MINUS) {
            IRInstruction inst(IROpcode::SUB);
            inst.dest = temp;
            inst.arg1 = IRValue::make_int(0);
            inst.arg2 = operand_val;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::INT;
            return IRValue::make_reg(temp);
        }

    } else if (auto bin_expr = dynamic_cast<BinaryExprASTNode*>(expr)) {
        IRValue left = visit_expr(bin_expr->left.get());
        IRValue right = visit_expr(bin_expr->right.get());

        // Determine types of operands
        IRValueType left_type = IRValueType::INT;
        IRValueType right_type = IRValueType::INT;
        if (left.kind == IRValue::Kind::REGISTER) left_type = get_type(left.str_val);
        if (right.kind == IRValue::Kind::REGISTER) right_type = get_type(right.str_val);

        // String concatenation: string + string
        if (bin_expr->op == TokenType::PLUS &&
            (left_type == IRValueType::STRING || right_type == IRValueType::STRING)) {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::STRING_CONCAT);
            inst.dest = temp;
            inst.arg1 = left;
            inst.arg2 = right;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::STRING;
            return IRValue::make_reg(temp);
        }

        // String equality: string == string
        if (bin_expr->op == TokenType::EQUAL &&
            (left_type == IRValueType::STRING || right_type == IRValueType::STRING)) {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::STRING_EQUAL);
            inst.dest = temp;
            inst.arg1 = left;
            inst.arg2 = right;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::BOOL;
            return IRValue::make_reg(temp);
        }

        // String inequality: string != string
        if (bin_expr->op == TokenType::NOT_EQUAL &&
            (left_type == IRValueType::STRING || right_type == IRValueType::STRING)) {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::STRING_NOT_EQUAL);
            inst.dest = temp;
            inst.arg1 = left;
            inst.arg2 = right;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::BOOL;
            return IRValue::make_reg(temp);
        }

        // String relational comparisons: lexicographical UTF-8 codepoint ordering
        if ((bin_expr->op == TokenType::LESS || bin_expr->op == TokenType::GREATER ||
             bin_expr->op == TokenType::LESS_EQUAL || bin_expr->op == TokenType::GREATER_EQUAL) &&
            (left_type == IRValueType::STRING || right_type == IRValueType::STRING)) {
            std::string temp = new_temp();
            IROpcode rel_op = IROpcode::STRING_LT;
            if (bin_expr->op == TokenType::GREATER) rel_op = IROpcode::STRING_GT;
            else if (bin_expr->op == TokenType::LESS_EQUAL) rel_op = IROpcode::STRING_LE;
            else if (bin_expr->op == TokenType::GREATER_EQUAL) rel_op = IROpcode::STRING_GE;
            IRInstruction inst(rel_op);
            inst.dest = temp;
            inst.arg1 = left;
            inst.arg2 = right;
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::BOOL;
            return IRValue::make_reg(temp);
        }

        // Integer/boolean operations
        IROpcode op = IROpcode::ADD;
        if (bin_expr->op == TokenType::PLUS) op = IROpcode::ADD;
        else if (bin_expr->op == TokenType::MINUS) op = IROpcode::SUB;
        else if (bin_expr->op == TokenType::STAR) op = IROpcode::MUL;
        else if (bin_expr->op == TokenType::SLASH) op = IROpcode::DIV;
        else if (bin_expr->op == TokenType::MOD) op = IROpcode::MOD;
        else if (bin_expr->op == TokenType::EQUAL) op = IROpcode::CMP_EQ;
        else if (bin_expr->op == TokenType::NOT_EQUAL) op = IROpcode::CMP_NE;
        else if (bin_expr->op == TokenType::LESS) op = IROpcode::CMP_LT;
        else if (bin_expr->op == TokenType::GREATER) op = IROpcode::CMP_GT;
        else if (bin_expr->op == TokenType::LESS_EQUAL) op = IROpcode::CMP_LE;
        else if (bin_expr->op == TokenType::GREATER_EQUAL) op = IROpcode::CMP_GE;
        else if (bin_expr->op == TokenType::LOGICAL_AND || bin_expr->op == TokenType::K_TATHA) op = IROpcode::AND_OP;
        else if (bin_expr->op == TokenType::LOGICAL_OR || bin_expr->op == TokenType::K_ATHAVA) op = IROpcode::OR_OP;

        std::string temp = new_temp();
        IRInstruction inst(op);
        inst.dest = temp;
        inst.arg1 = left;
        inst.arg2 = right;
        m_current_func->instructions.push_back(inst);
        bool is_bool_op = (op == IROpcode::CMP_EQ || op == IROpcode::CMP_NE ||
                           op == IROpcode::CMP_LT || op == IROpcode::CMP_GT ||
                           op == IROpcode::CMP_LE || op == IROpcode::CMP_GE ||
                           op == IROpcode::AND_OP || op == IROpcode::OR_OP);
        m_type_map[temp] = is_bool_op ? IRValueType::BOOL : IRValueType::INT;
        return IRValue::make_reg(temp);

    } else if (auto call_expr = dynamic_cast<CallExprASTNode*>(expr)) {
        std::string fname = call_expr->callee;

        // Handle लिखतु (print) as a special call
        if (fname == "लिखतु") {
            if (!call_expr->arguments.empty()) {
                IRValue val = visit_expr(call_expr->arguments[0].get());
                IRValueType val_type = IRValueType::INT;
                if (val.kind == IRValue::Kind::REGISTER) val_type = get_type(val.str_val);

                if (val_type == IRValueType::STRING) {
                    IRInstruction print_inst(IROpcode::PRINT_STR);
                    print_inst.arg1 = val;
                    m_current_func->instructions.push_back(print_inst);
                } else if (val_type == IRValueType::NULL_VAL) {
                    IRInstruction print_inst(IROpcode::PRINT_NULL);
                    m_current_func->instructions.push_back(print_inst);
                } else if (val_type == IRValueType::BOOL) {
                    IRInstruction print_inst(IROpcode::PRINT_BOOL);
                    print_inst.arg1 = val;
                    m_current_func->instructions.push_back(print_inst);
                } else {
                    IRInstruction print_inst(IROpcode::PRINT_INT);
                    print_inst.arg1 = val;
                    m_current_func->instructions.push_back(print_inst);
                }
            }
            return IRValue::make_int(0);
        }

        // Handle लंबाई (length)
        if (fname == "लंबाई") {
            if (!call_expr->arguments.empty()) {
                IRValue val = visit_expr(call_expr->arguments[0].get());
                IRValueType val_type = IRValueType::INT;
                if (val.kind == IRValue::Kind::REGISTER) val_type = get_type(val.str_val);

                std::string temp = new_temp();
                if (val_type == IRValueType::STRING) {
                    IRInstruction inst(IROpcode::STRING_LENGTH);
                    inst.dest = temp;
                    inst.arg1 = val;
                    m_current_func->instructions.push_back(inst);
                } else if (val_type == IRValueType::ARRAY) {
                    IRInstruction inst(IROpcode::ARRAY_LENGTH);
                    inst.dest = temp;
                    inst.arg1 = val;
                    m_current_func->instructions.push_back(inst);
                } else {
                    IRInstruction inst(IROpcode::CONST_INT);
                    inst.dest = temp;
                    inst.arg1 = IRValue::make_int(0);
                    m_current_func->instructions.push_back(inst);
                }
                m_type_map[temp] = IRValueType::INT;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        // Handle उच्च / निम्न (string case conversion)
        if (fname == "उच्च" || fname == "निम्न") {
            if (!call_expr->arguments.empty()) {
                IRValue val = visit_expr(call_expr->arguments[0].get());
                IRValueType val_type = IRValueType::INT;
                if (val.kind == IRValue::Kind::REGISTER) val_type = get_type(val.str_val);

                std::string temp = new_temp();
                if (val_type == IRValueType::STRING) {
                    IRInstruction inst(fname == "उच्च" ? IROpcode::STRING_UPPER : IROpcode::STRING_LOWER);
                    inst.dest = temp;
                    inst.arg1 = val;
                    m_current_func->instructions.push_back(inst);
                } else {
                    IRInstruction inst(IROpcode::CONST_STR);
                    inst.dest = temp;
                    inst.arg1 = IRValue::make_str("");
                    m_current_func->instructions.push_back(inst);
                }
                m_type_map[temp] = IRValueType::STRING;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_str("");
        }

        // Handle official stdlib functions already supported by the interpreter.
        if (fname == "वर्गमूल" || fname == "घात" || fname == "निरपेक्ष" || fname == "न्यूनतम" ||
            fname == "अधिकतम" || fname == "गोल") {
            std::vector<IRValue> args;
            for (const auto& arg : call_expr->arguments) {
                args.push_back(visit_expr(arg.get()));
            }

            std::string temp = new_temp();
            IRInstruction call(IROpcode::CALL);
            call.dest = temp;
            call.label = fname == "वर्गमूल" ? "sutra_math_sqrt" :
                         fname == "घात" ? "sutra_math_pow" :
                         fname == "निरपेक्ष" ? "sutra_math_abs" :
                         fname == "न्यूनतम" ? "sutra_math_min" :
                         fname == "अधिकतम" ? "sutra_math_max" : "sutra_math_round";
            call.call_args = args;
            m_current_func->instructions.push_back(call);
            m_type_map[temp] = IRValueType::INT;
            return IRValue::make_reg(temp);
        }

        if (fname == "प्रकार") {
            if (!call_expr->arguments.empty()) {
                IRValue val = visit_expr(call_expr->arguments[0].get());
                IRValueType val_type = IRValueType::INT;
                if (val.kind == IRValue::Kind::REGISTER) val_type = get_type(val.str_val);

                std::string temp = new_temp();
                std::string type_name = "संख्या";
                if (val_type == IRValueType::STRING) type_name = "पाठ";
                else if (val_type == IRValueType::ARRAY) type_name = "सूची";
                else if (val_type == IRValueType::BOOL) type_name = "बूल";
                else if (val_type == IRValueType::NULL_VAL) type_name = "शून्यम्";

                IRInstruction inst(IROpcode::CONST_STR);
                inst.dest = temp;
                inst.arg1 = IRValue::make_str(type_name);
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::STRING;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_str("शून्यम्");
        }

        if (fname == "जोड़ें") {
            if (!call_expr->arguments.empty()) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) {
                    args.push_back(visit_expr(arg.get()));
                }

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_list_append";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::ARRAY;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        // Generic function call
        std::vector<IRValue> args;
        for (const auto& arg : call_expr->arguments) {
            args.push_back(visit_expr(arg.get()));
        }

        std::string temp = new_temp();
        IRInstruction call(IROpcode::CALL);
        call.dest = temp;
        call.label = fname;
        call.call_args = args;
        m_current_func->instructions.push_back(call);
        
        IRValueType ret_type = IRValueType::INT;
        auto it = m_func_return_types.find(fname);
        if (it != m_func_return_types.end()) {
            ret_type = it->second;
        }
        m_type_map[temp] = ret_type;
        return IRValue::make_reg(temp);
    }

    return IRValue::make_int(0);
}

} // namespace compiler
} // namespace sutra
