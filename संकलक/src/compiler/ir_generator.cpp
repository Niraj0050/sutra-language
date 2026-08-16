#include "sutra/compiler/ir_generator.hpp"
#include "sutra/error.hpp"
#include <cstdint>
#include <cstring>
#include <iostream>

namespace sutra {
namespace compiler {

static IRValueType infer_expr_type_static(ExprASTNode* expr, FunctionDeclASTNode* func,
                                          const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_funcs,
                                          const std::vector<std::unique_ptr<ClassDeclASTNode>>& all_classes,
                                          const std::unordered_map<std::string, IRValueType>& current_func_types,
                                          const std::string& current_class_name = "") {
    if (!expr) return IRValueType::INT;
    
    if (auto lit = dynamic_cast<LiteralExprASTNode*>(expr)) {
        if (lit->lit_type == LiteralType::STRING) return IRValueType::STRING;
        if (lit->lit_type == LiteralType::BOOL) return IRValueType::BOOL;
        if (lit->lit_type == LiteralType::NULL_VAL) return IRValueType::NULL_VAL;
        if (lit->lit_type == LiteralType::FLOAT) return IRValueType::FLOAT;
        return IRValueType::INT;
    }
    
    if (auto id = dynamic_cast<IdentifierExprASTNode*>(expr)) {
        if (id->name == "स्व") return IRValueType::OBJECT;
        if (func) {
            for (const auto& p : func->params) {
                if (p.name == id->name) {
                    if (p.type_name == "पाठ") return IRValueType::STRING;
                    if (p.type_name == "बूल" || p.type_name == "तर्क") return IRValueType::BOOL;
                    if (p.type_name == "सूची") return IRValueType::ARRAY;
                    if (p.type_name == "दशमलव") return IRValueType::FLOAT;
                    return IRValueType::INT;
                }
            }
            
            struct VarDeclScanner {
                std::string target;
                FunctionDeclASTNode* f;
                const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_f;
                const std::vector<std::unique_ptr<ClassDeclASTNode>>& all_c;
                const std::unordered_map<std::string, IRValueType>& ft;
                std::string cur_class;
                IRValueType found = IRValueType::UNKNOWN;
                
                void scan(StmtASTNode* s) {
                    if (!s || found != IRValueType::UNKNOWN) return;
                    if (auto decl = dynamic_cast<VarDeclStmtASTNode*>(s)) {
                        if (decl->var_name == target) {
                            if (decl->type_name == "पाठ") found = IRValueType::STRING;
                            else if (decl->type_name == "बूल" || decl->type_name == "तर्क") found = IRValueType::BOOL;
                            else if (decl->type_name == "सूची") found = IRValueType::ARRAY;
                            else if (decl->type_name == "दशमलव") found = IRValueType::FLOAT;
                            else if (decl->type_name == "मान" && decl->initializer) {
                                found = infer_expr_type_static(decl->initializer.get(), f, all_f, all_c, ft, cur_class);
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
            VarDeclScanner scanner{id->name, func, all_funcs, all_classes, current_func_types, current_class_name, IRValueType::UNKNOWN};
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
            if (infer_expr_type_static(bin->left.get(), func, all_funcs, all_classes, current_func_types, current_class_name) == IRValueType::STRING ||
                infer_expr_type_static(bin->right.get(), func, all_funcs, all_classes, current_func_types, current_class_name) == IRValueType::STRING) {
                return IRValueType::STRING;
            }
        }
        if (bin->op == TokenType::PLUS || bin->op == TokenType::MINUS || bin->op == TokenType::STAR || bin->op == TokenType::SLASH) {
            if (infer_expr_type_static(bin->left.get(), func, all_funcs, all_classes, current_func_types, current_class_name) == IRValueType::FLOAT ||
                infer_expr_type_static(bin->right.get(), func, all_funcs, all_classes, current_func_types, current_class_name) == IRValueType::FLOAT) {
                return IRValueType::FLOAT;
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
        if (call->callee == "वर्गमूल" || call->callee == "घात") return IRValueType::FLOAT;
        if (call->callee == "निरपेक्ष" || call->callee == "न्यूनतम" || call->callee == "अधिकतम") {
            for (const auto& arg : call->arguments) {
                if (infer_expr_type_static(arg.get(), func, all_funcs, all_classes, current_func_types, current_class_name) == IRValueType::FLOAT) {
                    return IRValueType::FLOAT;
                }
            }
            return IRValueType::INT;
        }
        if (call->callee == "गोल") return IRValueType::INT;
        if (call->callee == "लंबाई") return IRValueType::INT;
        if (call->callee == "उच्च" || call->callee == "निम्न") return IRValueType::STRING;
        if (call->callee == "उपखंड" || call->callee == "बदलें" || call->callee == "संयोजित" || call->callee == "छाँटें") return IRValueType::STRING;
        if (call->callee == "खोजें") return IRValueType::INT;
        if (call->callee == "विभाजित") return IRValueType::ARRAY;
        if (call->callee == "आरंभिक" || call->callee == "अंतिम") return IRValueType::BOOL;
        if (call->callee == "सञ्चिका_पठतु") return IRValueType::STRING;
        if (call->callee == "सञ्चिका_लिखतु" || call->callee == "सञ्चिका_अस्ति") return IRValueType::BOOL;
        auto it = current_func_types.find(call->callee);
        if (it != current_func_types.end()) {
            return it->second;
        }
    }

    if (dynamic_cast<NewExprASTNode*>(expr)) {
        return IRValueType::OBJECT;
    }

    if (dynamic_cast<SelfExprASTNode*>(expr)) {
        return IRValueType::OBJECT;
    }

    if (auto mem = dynamic_cast<MemberAccessExprASTNode*>(expr)) {
        std::string cls_name = "";
        if (dynamic_cast<SelfExprASTNode*>(mem->object_expr.get())) {
            cls_name = current_class_name;
        } else if (auto obj_id = dynamic_cast<IdentifierExprASTNode*>(mem->object_expr.get())) {
            if (func && func->body) {
                struct ClassFinder {
                    std::string target;
                    FunctionDeclASTNode* f;
                    const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_f;
                    const std::vector<std::unique_ptr<ClassDeclASTNode>>& all_c;
                    const std::unordered_map<std::string, IRValueType>& ft;
                    std::string cur_class;
                    std::string found_class = "";
                    void scan(StmtASTNode* s) {
                        if (!s || !found_class.empty()) return;
                        if (auto decl = dynamic_cast<VarDeclStmtASTNode*>(s)) {
                            if (decl->var_name == target && decl->initializer) {
                                if (auto new_expr = dynamic_cast<NewExprASTNode*>(decl->initializer.get())) {
                                    found_class = new_expr->class_name;
                                }
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
                        }
                    }
                };
                ClassFinder finder{obj_id->name, func, all_funcs, all_classes, current_func_types, current_class_name};
                finder.scan(func->body.get());
                cls_name = finder.found_class;
            }
        }
        if (!cls_name.empty()) {
            for (const auto& cls : all_classes) {
                if (cls->name == cls_name) {
                    for (const auto& field : cls->fields) {
                        if (field->var_name == mem->member_name) {
                            if (field->type_name == "पाठ") return IRValueType::STRING;
                            if (field->type_name == "बूल") return IRValueType::BOOL;
                            if (field->type_name == "सूची") return IRValueType::ARRAY;
                            if (field->initializer) {
                                if (auto lit = dynamic_cast<LiteralExprASTNode*>(field->initializer.get())) {
                                    if (lit->lit_type == LiteralType::STRING) return IRValueType::STRING;
                                    if (lit->lit_type == LiteralType::BOOL) return IRValueType::BOOL;
                                }
                            }
                            return IRValueType::INT;
                        }
                    }
                }
            }
        }
    }

    if (auto mcall = dynamic_cast<MethodCallExprASTNode*>(expr)) {
        std::string cls_name = "";
        if (dynamic_cast<SelfExprASTNode*>(mcall->object_expr.get())) {
            cls_name = current_class_name;
        } else if (auto obj_id = dynamic_cast<IdentifierExprASTNode*>(mcall->object_expr.get())) {
            if (func && func->body) {
                struct ClassFinder {
                    std::string target;
                    FunctionDeclASTNode* f;
                    const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_f;
                    const std::vector<std::unique_ptr<ClassDeclASTNode>>& all_c;
                    const std::unordered_map<std::string, IRValueType>& ft;
                    std::string cur_class;
                    std::string found_class = "";
                    void scan(StmtASTNode* s) {
                        if (!s || !found_class.empty()) return;
                        if (auto decl = dynamic_cast<VarDeclStmtASTNode*>(s)) {
                            if (decl->var_name == target && decl->initializer) {
                                if (auto new_expr = dynamic_cast<NewExprASTNode*>(decl->initializer.get())) {
                                    found_class = new_expr->class_name;
                                }
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
                        }
                    }
                };
                ClassFinder finder{obj_id->name, func, all_funcs, all_classes, current_func_types, current_class_name};
                finder.scan(func->body.get());
                cls_name = finder.found_class;
            }
        }
        if (!cls_name.empty()) {
            std::string full_method_name = cls_name + "_" + mcall->method_name;
            auto it = current_func_types.find(full_method_name);
            if (it != current_func_types.end()) {
                return it->second;
            }
        }
    }
    
    if (auto dict_lit = dynamic_cast<DictionaryLiteralExprASTNode*>(expr)) {
        return IRValueType::DICTIONARY;
    }

    if (auto un = dynamic_cast<UnaryExprASTNode*>(expr)) {
        if (un->op == TokenType::LOGICAL_NOT || un->op == TokenType::K_NA) {
            return IRValueType::BOOL;
        }
        if (un->op == TokenType::MINUS) {
            return infer_expr_type_static(un->operand.get(), func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    }

    return IRValueType::INT;
}

static void find_return_types_static(StmtASTNode* stmt, std::vector<IRValueType>& types, FunctionDeclASTNode* func,
                                     const std::vector<std::unique_ptr<FunctionDeclASTNode>>& all_funcs,
                                     const std::vector<std::unique_ptr<ClassDeclASTNode>>& all_classes,
                                     const std::unordered_map<std::string, IRValueType>& current_func_types,
                                     const std::string& current_class_name = "") {
    if (!stmt) return;
    if (auto block = dynamic_cast<BlockStmtASTNode*>(stmt)) {
        for (const auto& child : block->statements) {
            find_return_types_static(child.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    } else if (auto if_stmt = dynamic_cast<IfStmtASTNode*>(stmt)) {
        if (if_stmt->then_branch) {
            find_return_types_static(if_stmt->then_branch.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
        if (if_stmt->else_branch) {
            find_return_types_static(if_stmt->else_branch.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    } else if (auto while_stmt = dynamic_cast<WhileStmtASTNode*>(stmt)) {
        if (while_stmt->body) {
            find_return_types_static(while_stmt->body.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    } else if (auto for_stmt = dynamic_cast<ForStmtASTNode*>(stmt)) {
        if (for_stmt->body) {
            find_return_types_static(for_stmt->body.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    } else if (auto try_catch = dynamic_cast<TryCatchStmtASTNode*>(stmt)) {
        if (try_catch->try_block) {
            find_return_types_static(try_catch->try_block.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
        if (try_catch->catch_block) {
            find_return_types_static(try_catch->catch_block.get(), types, func, all_funcs, all_classes, current_func_types, current_class_name);
        }
    } else if (auto ret = dynamic_cast<ReturnStmtASTNode*>(stmt)) {
        if (ret->value) {
            types.push_back(infer_expr_type_static(ret->value.get(), func, all_funcs, all_classes, current_func_types, current_class_name));
        } else {
            types.push_back(IRValueType::INT);
        }
    }
}

std::unique_ptr<IRModule> IRGenerator::generate(ProgramASTNode& program, const std::string& module_name) {
    m_module = std::make_unique<IRModule>(module_name);
    m_type_map.clear();
    m_func_return_types.clear();
    m_class_map.clear();
    m_class_instances.clear();

    // Populate class metadata
    for (const auto& cls : program.classes) {
        ClassMetadata meta;
        meta.name = cls->name;
        for (size_t i = 0; i < cls->fields.size(); ++i) {
            meta.field_names.push_back(cls->fields[i]->var_name);
            meta.field_to_index[cls->fields[i]->var_name] = static_cast<int>(i);

            // Infer type
            IRValueType ft = IRValueType::INT;
            if (cls->fields[i]->type_name == "पाठ") ft = IRValueType::STRING;
            else if (cls->fields[i]->type_name == "सूची") ft = IRValueType::ARRAY;
            else if (cls->fields[i]->type_name == "बूल") ft = IRValueType::BOOL;
            else if (cls->fields[i]->initializer) {
                if (auto lit = dynamic_cast<LiteralExprASTNode*>(cls->fields[i]->initializer.get())) {
                    if (lit->lit_type == LiteralType::STRING) ft = IRValueType::STRING;
                    else if (lit->lit_type == LiteralType::BOOL) ft = IRValueType::BOOL;
                }
            }
            meta.field_types[cls->fields[i]->var_name] = ft;
        }
        m_class_map[cls->name] = meta;
    }

    // Initialize function/method return types
    for (const auto& func : program.functions) {
        m_func_return_types[func->name] = IRValueType::INT;
    }
    for (const auto& cls : program.classes) {
        for (const auto& method : cls->methods) {
            m_func_return_types[cls->name + "_" + method->name] = IRValueType::INT;
        }
    }

    // Run passes to resolve function return types
    for (int pass = 0; pass < 3; ++pass) {
        for (const auto& func : program.functions) {
            std::vector<IRValueType> ret_types;
            if (func->body) {
                find_return_types_static(func->body.get(), ret_types, func.get(), program.functions, program.classes, m_func_return_types);
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
                if (t == IRValueType::DICTIONARY) {
                    inferred = IRValueType::DICTIONARY;
                }
                if (t == IRValueType::OBJECT) {
                    inferred = IRValueType::OBJECT;
                }
            }
            m_func_return_types[func->name] = inferred;
        }
        for (const auto& cls : program.classes) {
            for (const auto& method : cls->methods) {
                std::vector<IRValueType> ret_types;
                if (method->body) {
                    find_return_types_static(method->body.get(), ret_types, method.get(), program.functions, program.classes, m_func_return_types, cls->name);
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
                    if (t == IRValueType::DICTIONARY) {
                        inferred = IRValueType::DICTIONARY;
                    }
                    if (t == IRValueType::OBJECT) {
                        inferred = IRValueType::OBJECT;
                    }
                }
                m_func_return_types[cls->name + "_" + method->name] = inferred;
            }
        }
    }

    // 1. Process Functions
    for (const auto& func : program.functions) {
        visit_function_decl(func.get());
    }

    // 1.5 Process Class Methods
    for (const auto& cls : program.classes) {
        for (const auto& method : cls->methods) {
            visit_method_decl(method.get(), cls->name);
        }
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

void IRGenerator::visit_method_decl(FunctionDeclASTNode* func, const std::string& class_name) {
    std::vector<std::string> param_names;
    param_names.push_back("स्व");
    for (const auto& p : func->params) {
        param_names.push_back(p.name);
    }

    std::string fname = class_name + "_" + func->name;
    auto ir_func = std::make_unique<IRFunction>(fname, param_names);
    m_current_func = ir_func.get();

    m_type_map["स्व"] = IRValueType::OBJECT;
    m_class_instances["स्व"] = class_name;

    // Allocate stack space and store for parameter "स्व"
    {
        IRInstruction alloc(IROpcode::ALLOCA);
        alloc.dest = "स्व";
        m_current_func->instructions.push_back(alloc);

        IRInstruction store(IROpcode::STORE);
        store.arg1 = IRValue::make_var("स्व");
        store.dest = "स्व";
        m_current_func->instructions.push_back(store);
    }

    // Allocate stack space for other parameters
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
    if (!stmt) return;
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
        } else if (var_decl->type_name == "दशमलव") {
            m_type_map[var_decl->var_name] = IRValueType::FLOAT;
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

            // Propagate class type mapping
            if (val.kind == IRValue::Kind::REGISTER) {
                auto inst_it = m_class_instances.find(val.str_val);
                if (inst_it != m_class_instances.end()) {
                    m_class_instances[var_decl->var_name] = inst_it->second;
                }
            }
        }
    } else if (auto assign = dynamic_cast<AssignStmtASTNode*>(stmt)) {
        IRValue val = visit_expr(assign->value.get());
        IRInstruction store(IROpcode::STORE);
        store.arg1 = val;
        store.dest = assign->var_name;
        m_current_func->instructions.push_back(store);

        // Propagate class type mapping
        if (val.kind == IRValue::Kind::REGISTER) {
            auto inst_it = m_class_instances.find(val.str_val);
            if (inst_it != m_class_instances.end()) {
                m_class_instances[assign->var_name] = inst_it->second;
            }
        }

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
        
        IRValueType base_type = get_type(arr_assign->array_name);
        m_type_map[temp_arr] = base_type;

        for (size_t i = 0; i < arr_assign->index_exprs.size(); ++i) {
            IRValue idx_val = visit_expr(arr_assign->index_exprs[i].get());
            if (i + 1 == arr_assign->index_exprs.size()) {
                IRValue val = visit_expr(arr_assign->value_expr.get());
                IRInstruction set_inst(base_type == IRValueType::DICTIONARY ? IROpcode::DICT_SET : IROpcode::ARRAY_SET);
                set_inst.arg1 = IRValue::make_reg(temp_arr);
                set_inst.arg2 = idx_val;
                set_inst.call_args.push_back(val);
                m_current_func->instructions.push_back(set_inst);
                break;
            }

            std::string next_temp = new_temp();
            IRInstruction get_inst(base_type == IRValueType::DICTIONARY ? IROpcode::DICT_GET : IROpcode::ARRAY_GET);
            get_inst.dest = next_temp;
            get_inst.arg1 = IRValue::make_reg(temp_arr);
            get_inst.arg2 = idx_val;
            m_current_func->instructions.push_back(get_inst);
            
            // Note: nested types aren't fully tracked statically, we assume it continues as same type for simplicity 
            // unless we had deeper type annotations. We'll default to the base type.
            m_type_map[next_temp] = base_type;
            temp_arr = next_temp;
        }

    } else if (auto mem_assign = dynamic_cast<MemberAssignStmtASTNode*>(stmt)) {
        IRValue obj_val = visit_expr(mem_assign->object_expr.get());
        std::string obj_reg = obj_val.str_val;

        std::string cls_name = "";
        auto it = m_class_instances.find(obj_reg);
        if (it != m_class_instances.end()) {
            cls_name = it->second;
        } else {
            if (auto id_obj = dynamic_cast<IdentifierExprASTNode*>(mem_assign->object_expr.get())) {
                auto id_it = m_class_instances.find(id_obj->name);
                if (id_it != m_class_instances.end()) {
                    cls_name = id_it->second;
                }
            }
        }

        if (cls_name.empty()) {
            throw RuntimeError("ऑब्जेक्ट प्रकार अज्ञात है", mem_assign->line, mem_assign->column);
        }

        auto class_it = m_class_map.find(cls_name);
        if (class_it == m_class_map.end()) {
            throw RuntimeError("वर्ग '" + cls_name + "' न प्राप्तः", mem_assign->line, mem_assign->column);
        }

        auto field_it = class_it->second.field_to_index.find(mem_assign->member_name);
        if (field_it == class_it->second.field_to_index.end()) {
            throw RuntimeError("वर्ग '" + cls_name + "' में सदस्य '" + mem_assign->member_name + "' नहीं मिला", mem_assign->line, mem_assign->column);
        }
        int field_idx = field_it->second;

        IRValue val = visit_expr(mem_assign->value_expr.get());

        std::string idx_temp = new_temp();
        IRInstruction const_idx(IROpcode::CONST_INT);
        const_idx.dest = idx_temp;
        const_idx.arg1 = IRValue::make_int(field_idx);
        m_current_func->instructions.push_back(const_idx);
        m_type_map[idx_temp] = IRValueType::INT;

        IRInstruction set_inst(IROpcode::ARRAY_SET);
        set_inst.arg1 = IRValue::make_reg(obj_reg);
        set_inst.arg2 = IRValue::make_reg(idx_temp);
        set_inst.call_args.push_back(val);
        m_current_func->instructions.push_back(set_inst);

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
        } else if (val_type == IRValueType::FLOAT) {
            IRInstruction print_inst(IROpcode::PRINT_FLOAT);
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
    } else if (auto try_catch = dynamic_cast<TryCatchStmtASTNode*>(stmt)) {
        std::string catch_lbl = new_label("catch");
        std::string end_try_lbl = new_label("end_try");

        IRInstruction try_beg(IROpcode::TRY_BEGIN);
        try_beg.arg1 = IRValue::make_str(catch_lbl);
        m_current_func->instructions.push_back(try_beg);

        if (try_catch->try_block) {
            visit_stmt(try_catch->try_block.get());
        }

        IRInstruction try_end(IROpcode::TRY_END);
        m_current_func->instructions.push_back(try_end);

        IRInstruction jmp_end(IROpcode::JUMP);
        jmp_end.label = end_try_lbl;
        m_current_func->instructions.push_back(jmp_end);

        IRInstruction lbl_catch(IROpcode::LABEL);
        lbl_catch.label = catch_lbl;
        m_current_func->instructions.push_back(lbl_catch);

        IRInstruction catch_beg(IROpcode::CATCH_BEGIN);
        catch_beg.arg1 = IRValue::make_var(try_catch->catch_var_name);
        m_current_func->instructions.push_back(catch_beg);
        m_type_map[try_catch->catch_var_name] = IRValueType::STRING;

        if (try_catch->catch_block) {
            visit_stmt(try_catch->catch_block.get());
        }

        IRInstruction lbl_end(IROpcode::LABEL);
        lbl_end.label = end_try_lbl;
        m_current_func->instructions.push_back(lbl_end);

    } else if (auto throw_stmt = dynamic_cast<ThrowStmtASTNode*>(stmt)) {
        IRValue val = visit_expr(throw_stmt->expression.get());
        IRInstruction throw_inst(IROpcode::THROW);
        throw_inst.arg1 = val;
        m_current_func->instructions.push_back(throw_inst);

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
    if (!expr) return IRValue::make_int(0);
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
            std::string str_id = add_string_literal(lit->value);

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
        } else if (lit->lit_type == LiteralType::FLOAT) {
            double d = 0.0;
            try { d = std::stod(lit->value); } catch (...) {}
            long long bits;
            std::memcpy(&bits, &d, sizeof(d));
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CONST_INT);
            inst.dest = temp;
            inst.arg1 = IRValue::make_int(bits);
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::FLOAT;
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

    } else if (auto dict_lit = dynamic_cast<DictionaryLiteralExprASTNode*>(expr)) {
        std::string dict_temp = new_temp();
        IRInstruction create_inst(IROpcode::DICT_CREATE);
        create_inst.dest = dict_temp;
        m_current_func->instructions.push_back(create_inst);
        m_type_map[dict_temp] = IRValueType::DICTIONARY;

        for (const auto& pair : dict_lit->elements) {
            IRValue key_val = visit_expr(new LiteralExprASTNode(LiteralType::STRING, pair.first, 0, 0));
            IRValue val_val = visit_expr(pair.second.get());
            
            IRInstruction set_inst(IROpcode::DICT_SET);
            set_inst.arg1 = IRValue::make_reg(dict_temp);
            set_inst.arg2 = key_val;
            set_inst.call_args.push_back(val_val);
            m_current_func->instructions.push_back(set_inst);
        }

        return IRValue::make_reg(dict_temp);

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
        } else if (arr_type == IRValueType::DICTIONARY) {
            IRInstruction get_inst(IROpcode::DICT_GET);
            get_inst.dest = temp;
            get_inst.arg1 = arr_val;
            get_inst.arg2 = idx_val;
            m_current_func->instructions.push_back(get_inst);
            m_type_map[temp] = IRValueType::INT;
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
            IRValueType op_type = IRValueType::INT;
            if (operand_val.kind == IRValue::Kind::REGISTER) op_type = get_type(operand_val.str_val);

            if (op_type == IRValueType::FLOAT) {
                double zero_val = 0.0;
                long long zero_bits;
                std::memcpy(&zero_bits, &zero_val, sizeof(zero_val));
                
                std::string zero_temp = new_temp();
                IRInstruction zero_inst(IROpcode::CONST_INT);
                zero_inst.dest = zero_temp;
                zero_inst.arg1 = IRValue::make_int(zero_bits);
                m_current_func->instructions.push_back(zero_inst);
                m_type_map[zero_temp] = IRValueType::FLOAT;

                IRInstruction inst(IROpcode::CALL);
                inst.dest = temp;
                inst.label = "sutra_float_sub";
                inst.call_args.push_back(IRValue::make_reg(zero_temp));
                inst.call_args.push_back(operand_val);
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::FLOAT;
                return IRValue::make_reg(temp);
            } else {
                std::string zero_temp = new_temp();
                IRInstruction zero_inst(IROpcode::CONST_INT);
                zero_inst.dest = zero_temp;
                zero_inst.arg1 = IRValue::make_int(0);
                m_current_func->instructions.push_back(zero_inst);
                m_type_map[zero_temp] = IRValueType::INT;

                IRInstruction inst(IROpcode::SUB);
                inst.dest = temp;
                inst.arg1 = IRValue::make_reg(zero_temp);
                inst.arg2 = operand_val;
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::INT;
                return IRValue::make_reg(temp);
            }
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
            
            IRValue final_left = left;
            if (left_type != IRValueType::STRING) {
                std::string temp_left = new_temp();
                IRInstruction conv(IROpcode::CALL);
                conv.dest = temp_left;
                if (left_type == IRValueType::BOOL) {
                    conv.label = "sutra_bool_to_str";
                } else if (left_type == IRValueType::NULL_VAL) {
                    conv.label = "sutra_null_to_str";
                } else if (left_type == IRValueType::FLOAT) {
                    conv.label = "sutra_float_to_str";
                } else {
                    conv.label = "sutra_int_to_str";
                }
                conv.call_args.push_back(left);
                m_current_func->instructions.push_back(conv);
                m_type_map[temp_left] = IRValueType::STRING;
                final_left = IRValue::make_reg(temp_left);
            }

            IRValue final_right = right;
            if (right_type != IRValueType::STRING) {
                std::string temp_right = new_temp();
                IRInstruction conv(IROpcode::CALL);
                conv.dest = temp_right;
                if (right_type == IRValueType::BOOL) {
                    conv.label = "sutra_bool_to_str";
                } else if (right_type == IRValueType::NULL_VAL) {
                    conv.label = "sutra_null_to_str";
                } else if (right_type == IRValueType::FLOAT) {
                    conv.label = "sutra_float_to_str";
                } else {
                    conv.label = "sutra_int_to_str";
                }
                conv.call_args.push_back(right);
                m_current_func->instructions.push_back(conv);
                m_type_map[temp_right] = IRValueType::STRING;
                final_right = IRValue::make_reg(temp_right);
            }

            std::string temp = new_temp();
            IRInstruction inst(IROpcode::STRING_CONCAT);
            inst.dest = temp;
            inst.arg1 = final_left;
            inst.arg2 = final_right;
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
        // Floating point operations
        if (left_type == IRValueType::FLOAT || right_type == IRValueType::FLOAT) {
            if (left_type == IRValueType::INT) {
                std::string temp_left = new_temp();
                IRInstruction conv(IROpcode::CALL);
                conv.dest = temp_left;
                conv.label = "sutra_int_to_float";
                conv.call_args.push_back(left);
                m_current_func->instructions.push_back(conv);
                m_type_map[temp_left] = IRValueType::FLOAT;
                left = IRValue::make_reg(temp_left);
                left_type = IRValueType::FLOAT;
            }
            if (right_type == IRValueType::INT) {
                std::string temp_right = new_temp();
                IRInstruction conv(IROpcode::CALL);
                conv.dest = temp_right;
                conv.label = "sutra_int_to_float";
                conv.call_args.push_back(right);
                m_current_func->instructions.push_back(conv);
                m_type_map[temp_right] = IRValueType::FLOAT;
                right = IRValue::make_reg(temp_right);
                right_type = IRValueType::FLOAT;
            }

            std::string temp = new_temp();
            IRInstruction call(IROpcode::CALL);
            call.dest = temp;
            call.call_args.push_back(left);
            call.call_args.push_back(right);
            
            bool is_bool_op = false;
            if (bin_expr->op == TokenType::PLUS) {
                call.label = "sutra_float_add";
            } else if (bin_expr->op == TokenType::MINUS) {
                call.label = "sutra_float_sub";
            } else if (bin_expr->op == TokenType::STAR) {
                call.label = "sutra_float_mul";
            } else if (bin_expr->op == TokenType::SLASH) {
                call.label = "sutra_float_div";
            } else if (bin_expr->op == TokenType::EQUAL) {
                call.label = "sutra_float_eq";
                is_bool_op = true;
            } else if (bin_expr->op == TokenType::NOT_EQUAL) {
                call.label = "sutra_float_ne";
                is_bool_op = true;
            } else if (bin_expr->op == TokenType::LESS) {
                call.label = "sutra_float_lt";
                is_bool_op = true;
            } else if (bin_expr->op == TokenType::GREATER) {
                call.label = "sutra_float_gt";
                is_bool_op = true;
            } else if (bin_expr->op == TokenType::LESS_EQUAL) {
                call.label = "sutra_float_le";
                is_bool_op = true;
            } else if (bin_expr->op == TokenType::GREATER_EQUAL) {
                call.label = "sutra_float_ge";
                is_bool_op = true;
            } else {
                call.label = "sutra_float_add";
            }
            m_current_func->instructions.push_back(call);
            m_type_map[temp] = is_bool_op ? IRValueType::BOOL : IRValueType::FLOAT;
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
                } else if (val_type == IRValueType::FLOAT) {
                    IRInstruction print_inst(IROpcode::PRINT_FLOAT);
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
                } else if (val_type == IRValueType::ARRAY || val_type == IRValueType::DICTIONARY) {
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
                    inst.arg1 = IRValue::make_str(add_string_literal(""));
                    m_current_func->instructions.push_back(inst);
                }
                m_type_map[temp] = IRValueType::STRING;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_str(add_string_literal(""));
        }

        // Handle official stdlib functions already supported by the interpreter.
        if (fname == "वर्गमूल" || fname == "घात" || fname == "निरपेक्ष" || fname == "न्यूनतम" ||
            fname == "अधिकतम" || fname == "गोल") {
            std::vector<IRValue> args;
            std::vector<IRValueType> arg_types;
            for (const auto& arg : call_expr->arguments) {
                IRValue val = visit_expr(arg.get());
                IRValueType val_type = IRValueType::INT;
                if (val.kind == IRValue::Kind::REGISTER) val_type = get_type(val.str_val);
                args.push_back(val);
                arg_types.push_back(val_type);
            }

            bool has_float = false;
            if (fname == "वर्गमूल" || fname == "घात") {
                has_float = true;
            } else {
                for (auto t : arg_types) {
                    if (t == IRValueType::FLOAT) has_float = true;
                }
            }

            // If we need float mode, promote any INT arguments to FLOAT
            if (has_float) {
                for (size_t i = 0; i < args.size(); ++i) {
                    if (arg_types[i] == IRValueType::INT) {
                        std::string temp_conv = new_temp();
                        IRInstruction conv(IROpcode::CALL);
                        conv.dest = temp_conv;
                        conv.label = "sutra_int_to_float";
                        conv.call_args.push_back(args[i]);
                        m_current_func->instructions.push_back(conv);
                        m_type_map[temp_conv] = IRValueType::FLOAT;
                        args[i] = IRValue::make_reg(temp_conv);
                        arg_types[i] = IRValueType::FLOAT;
                    }
                }
            }

            std::string temp = new_temp();
            IRInstruction call(IROpcode::CALL);
            call.dest = temp;
            call.call_args = args;

            IRValueType ret_type = IRValueType::INT;
            if (fname == "वर्गमूल") {
                call.label = "sutra_math_sqrt_f";
                ret_type = IRValueType::FLOAT;
            } else if (fname == "घात") {
                call.label = "sutra_math_pow_f";
                ret_type = IRValueType::FLOAT;
            } else if (fname == "निरपेक्ष") {
                call.label = has_float ? "sutra_math_abs_f" : "sutra_math_abs";
                ret_type = has_float ? IRValueType::FLOAT : IRValueType::INT;
            } else if (fname == "न्यूनतम") {
                call.label = has_float ? "sutra_math_min_f" : "sutra_math_min";
                ret_type = has_float ? IRValueType::FLOAT : IRValueType::INT;
            } else if (fname == "अधिकतम") {
                call.label = has_float ? "sutra_math_max_f" : "sutra_math_max";
                ret_type = has_float ? IRValueType::FLOAT : IRValueType::INT;
            } else if (fname == "गोल") {
                call.label = has_float ? "sutra_math_round_f" : "sutra_math_round";
                ret_type = IRValueType::INT;
            }

            m_current_func->instructions.push_back(call);
            m_type_map[temp] = ret_type;
            return IRValue::make_reg(temp);
        }

        if (fname == "उपखंड" || fname == "खोजें" || fname == "बदलें" || fname == "विभाजित" ||
            fname == "संयोजित" || fname == "छाँटें" || fname == "आरंभिक" || fname == "अंतिम") {
            std::vector<IRValue> args;
            for (const auto& arg : call_expr->arguments) {
                args.push_back(visit_expr(arg.get()));
            }

            std::string temp = new_temp();
            IRInstruction call(IROpcode::CALL);
            call.dest = temp;
            std::string label = "";
            if (fname == "उपखंड") label = "sutra_substr";
            else if (fname == "खोजें") {
                IRValueType first_type = IRValueType::STRING;
                 if (!args.empty() && (args[0].kind == IRValue::Kind::REGISTER || args[0].kind == IRValue::Kind::VARIABLE)) {
                    IRValueType resolved = get_type(args[0].str_val);
                    if (resolved != IRValueType::UNKNOWN) first_type = resolved;
                }
                label = (first_type == IRValueType::ARRAY) ? "sutra_list_find" : "sutra_find";
            }
            else if (fname == "बदलें") label = "sutra_replace";
            else if (fname == "विभाजित") label = "sutra_split";
            else if (fname == "संयोजित") label = "sutra_join";
            else if (fname == "छाँटें") label = "sutra_trim";
            else if (fname == "आरंभिक") label = "sutra_starts_with";
            else label = "sutra_ends_with";
            call.label = label;
            call.call_args = args;
            m_current_func->instructions.push_back(call);

            IRValueType ret_type = IRValueType::INT;
            if (fname == "उपखंड" || fname == "बदलें" || fname == "संयोजित" || fname == "छाँटें") ret_type = IRValueType::STRING;
            else if (fname == "विभाजित") ret_type = IRValueType::ARRAY;
            else if (fname == "आरंभिक" || fname == "अंतिम") ret_type = IRValueType::BOOL;
            m_type_map[temp] = ret_type;
            return IRValue::make_reg(temp);
        }

        if (fname == "सञ्चिका_पठतु") {
            if (call_expr->arguments.size() >= 1) {
                IRValue arg = visit_expr(call_expr->arguments[0].get());
                std::string temp = new_temp();
                IRInstruction inst(IROpcode::FILE_READ);
                inst.dest = temp;
                inst.arg1 = arg;
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::STRING;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_str(add_string_literal(""));
        }

        if (fname == "सञ्चिका_लिखतु") {
            if (call_expr->arguments.size() >= 2) {
                IRValue arg1 = visit_expr(call_expr->arguments[0].get());
                IRValue arg2 = visit_expr(call_expr->arguments[1].get());
                std::string temp = new_temp();
                IRInstruction inst(IROpcode::FILE_WRITE);
                inst.dest = temp;
                inst.arg1 = arg1;
                inst.arg2 = arg2;
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::BOOL;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "सञ्चिका_अस्ति") {
            if (call_expr->arguments.size() >= 1) {
                IRValue arg = visit_expr(call_expr->arguments[0].get());
                std::string temp = new_temp();
                IRInstruction inst(IROpcode::FILE_EXISTS);
                inst.dest = temp;
                inst.arg1 = arg;
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::BOOL;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
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
                else if (val_type == IRValueType::DICTIONARY) type_name = "शब्दकोश";
                else if (val_type == IRValueType::BOOL) type_name = "बूल";
                else if (val_type == IRValueType::NULL_VAL) type_name = "शून्यम्";

                IRInstruction inst(IROpcode::CONST_STR);
                inst.dest = temp;
                inst.arg1 = IRValue::make_str(add_string_literal(type_name));
                m_current_func->instructions.push_back(inst);
                m_type_map[temp] = IRValueType::STRING;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_str(add_string_literal("शून्यम्"));
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

        if (fname == "निकालें") {
            if (!call_expr->arguments.empty()) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) {
                    args.push_back(visit_expr(arg.get()));
                }

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_list_pop";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::ARRAY;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "डालें") {
            if (call_expr->arguments.size() >= 3) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) {
                    args.push_back(visit_expr(arg.get()));
                }

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_list_insert";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::ARRAY;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "हटाएं") {
            if (call_expr->arguments.size() >= 2) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) {
                    args.push_back(visit_expr(arg.get()));
                }

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                
                IRValueType base_type = IRValueType::INT;
                if (args[0].kind == IRValue::Kind::REGISTER) base_type = get_type(args[0].str_val);
                else if (args[0].kind == IRValue::Kind::VARIABLE) base_type = get_type(args[0].str_val);

                if (base_type == IRValueType::DICTIONARY) {
                    call.label = "sutra_dict_remove";
                    m_type_map[temp] = IRValueType::DICTIONARY;
                } else {
                    call.label = "sutra_list_remove";
                    m_type_map[temp] = IRValueType::ARRAY;
                }
                
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "कुंजी_है") {
            if (call_expr->arguments.size() >= 2) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) args.push_back(visit_expr(arg.get()));

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_dict_has_key";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::BOOL;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "कुंजियाँ") {
            if (call_expr->arguments.size() >= 1) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) args.push_back(visit_expr(arg.get()));

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_dict_keys";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::ARRAY;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "मिलाएं") {
            if (call_expr->arguments.size() >= 2) {
                std::vector<IRValue> args;
                for (const auto& arg : call_expr->arguments) {
                    args.push_back(visit_expr(arg.get()));
                }

                std::string temp = new_temp();
                IRInstruction call(IROpcode::CALL);
                call.dest = temp;
                call.label = "sutra_list_concat";
                call.call_args = args;
                m_current_func->instructions.push_back(call);
                m_type_map[temp] = IRValueType::ARRAY;
                return IRValue::make_reg(temp);
            }
            return IRValue::make_int(0);
        }

        if (fname == "समय") {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CALL);
            inst.dest = temp;
            inst.label = "sutra_time";
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::INT;
            return IRValue::make_reg(temp);
        }

        if (fname == "स्मृति_स्थिति") {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CALL);
            inst.dest = temp;
            inst.label = "sutra_gc_status";
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::NULL_VAL;
            return IRValue::make_reg(temp);
        }

        if (fname == "संग्रह_करो") {
            std::string temp = new_temp();
            IRInstruction inst(IROpcode::CALL);
            inst.dest = temp;
            inst.label = "sutra_gc_collect";
            m_current_func->instructions.push_back(inst);
            m_type_map[temp] = IRValueType::NULL_VAL;
            return IRValue::make_reg(temp);
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
    } else if (auto new_expr = dynamic_cast<NewExprASTNode*>(expr)) {
        auto it = m_class_map.find(new_expr->class_name);
        if (it == m_class_map.end()) {
            throw RuntimeError("वर्ग '" + new_expr->class_name + "' न प्राप्तः", new_expr->line, new_expr->column);
        }
        int64_t field_count = it->second.field_names.size();

        std::string temp = new_temp();
        IRInstruction call_alloc(IROpcode::CALL);
        call_alloc.dest = temp;
        call_alloc.label = "sutra_obj_alloc";
        call_alloc.call_args.push_back(IRValue::make_int(field_count));
        m_current_func->instructions.push_back(call_alloc);

        m_type_map[temp] = IRValueType::OBJECT;
        m_class_instances[temp] = new_expr->class_name;

        // Call constructor if it exists
        std::string ctor_name = new_expr->class_name + "_रचना";
        bool has_ctor = false;
        if (m_func_return_types.find(ctor_name) != m_func_return_types.end()) {
            has_ctor = true;
        }

        if (has_ctor) {
            std::vector<IRValue> ctor_args;
            ctor_args.push_back(IRValue::make_reg(temp)); // self argument
            for (const auto& arg : new_expr->arguments) {
                ctor_args.push_back(visit_expr(arg.get()));
            }

            std::string dummy = new_temp();
            IRInstruction call_ctor(IROpcode::CALL);
            call_ctor.dest = dummy;
            call_ctor.label = ctor_name;
            call_ctor.call_args = ctor_args;
            m_current_func->instructions.push_back(call_ctor);
        }

        return IRValue::make_reg(temp);

    } else if (dynamic_cast<SelfExprASTNode*>(expr)) {
        std::string temp = new_temp();
        IRInstruction load(IROpcode::LOAD);
        load.dest = temp;
        load.arg1 = IRValue::make_var("स्व");
        m_current_func->instructions.push_back(load);
        m_type_map[temp] = IRValueType::OBJECT;
        
        auto self_it = m_class_instances.find("स्व");
        if (self_it != m_class_instances.end()) {
            m_class_instances[temp] = self_it->second;
        }
        return IRValue::make_reg(temp);

    } else if (auto mem_expr = dynamic_cast<MemberAccessExprASTNode*>(expr)) {
        IRValue obj_val = visit_expr(mem_expr->object_expr.get());
        std::string obj_reg = obj_val.str_val;

        std::string cls_name = "";
        auto it = m_class_instances.find(obj_reg);
        if (it != m_class_instances.end()) {
            cls_name = it->second;
        } else {
            if (auto id_obj = dynamic_cast<IdentifierExprASTNode*>(mem_expr->object_expr.get())) {
                auto id_it = m_class_instances.find(id_obj->name);
                if (id_it != m_class_instances.end()) {
                    cls_name = id_it->second;
                }
            }
        }

        if (cls_name.empty()) {
            throw RuntimeError("ऑब्जेक्ट प्रकार अज्ञात है", mem_expr->line, mem_expr->column);
        }

        auto class_it = m_class_map.find(cls_name);
        if (class_it == m_class_map.end()) {
            throw RuntimeError("वर्ग '" + cls_name + "' न प्राप्तः", mem_expr->line, mem_expr->column);
        }

        auto field_it = class_it->second.field_to_index.find(mem_expr->member_name);
        if (field_it == class_it->second.field_to_index.end()) {
            throw RuntimeError("वर्ग '" + cls_name + "' में सदस्य '" + mem_expr->member_name + "' नहीं मिला", mem_expr->line, mem_expr->column);
        }
        int field_idx = field_it->second;

        std::string idx_temp = new_temp();
        IRInstruction const_idx(IROpcode::CONST_INT);
        const_idx.dest = idx_temp;
        const_idx.arg1 = IRValue::make_int(field_idx);
        m_current_func->instructions.push_back(const_idx);
        m_type_map[idx_temp] = IRValueType::INT;

        std::string dest_temp = new_temp();
        IRInstruction get_inst(IROpcode::ARRAY_GET);
        get_inst.dest = dest_temp;
        get_inst.arg1 = IRValue::make_reg(obj_reg);
        get_inst.arg2 = IRValue::make_reg(idx_temp);
        m_current_func->instructions.push_back(get_inst);

        IRValueType field_type = IRValueType::INT;
        auto field_type_it = class_it->second.field_types.find(mem_expr->member_name);
        if (field_type_it != class_it->second.field_types.end()) {
            field_type = field_type_it->second;
        }
        m_type_map[dest_temp] = field_type;

        return IRValue::make_reg(dest_temp);

    } else if (auto mcall = dynamic_cast<MethodCallExprASTNode*>(expr)) {
        IRValue obj_val = visit_expr(mcall->object_expr.get());
        std::string obj_reg = obj_val.str_val;

        std::string cls_name = "";
        auto it = m_class_instances.find(obj_reg);
        if (it != m_class_instances.end()) {
            cls_name = it->second;
        } else {
            if (auto id_obj = dynamic_cast<IdentifierExprASTNode*>(mcall->object_expr.get())) {
                auto id_it = m_class_instances.find(id_obj->name);
                if (id_it != m_class_instances.end()) {
                    cls_name = id_it->second;
                }
            }
        }

        if (cls_name.empty()) {
            throw RuntimeError("ऑब्जेक्ट प्रकार अज्ञात है", mcall->line, mcall->column);
        }

        std::string method_func_name = cls_name + "_" + mcall->method_name;

        std::vector<IRValue> call_args;
        call_args.push_back(IRValue::make_reg(obj_reg)); // self
        for (const auto& arg : mcall->arguments) {
            call_args.push_back(visit_expr(arg.get()));
        }

        std::string dest_temp = new_temp();
        IRInstruction call_inst(IROpcode::CALL);
        call_inst.dest = dest_temp;
        call_inst.label = method_func_name;
        call_inst.call_args = call_args;
        m_current_func->instructions.push_back(call_inst);

        IRValueType ret_type = IRValueType::INT;
        auto ret_it = m_func_return_types.find(method_func_name);
        if (ret_it != m_func_return_types.end()) {
            ret_type = ret_it->second;
        }
        m_type_map[dest_temp] = ret_type;

        return IRValue::make_reg(dest_temp);
    }

    return IRValue::make_int(0);
}

} // namespace compiler
} // namespace sutra
