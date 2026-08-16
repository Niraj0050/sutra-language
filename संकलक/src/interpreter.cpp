#include "sutra/interpreter.hpp"
#include "sutra/runtime/runtime.hpp"
#include "sutra/स्मृतिसंग्राहक.hpp"
#include "sutra/unicode.hpp"
#include <cmath>
#include <algorithm>
#include <cctype>

namespace sutra {

Interpreter::Interpreter() {
    m_global_env = std::make_shared<Environment>();
}

void Interpreter::execute_program(const ProgramASTNode& program, std::ostream& out) {
    runtime::Runtime::get_instance().set_output_stream(&out);
    m_functions.clear();
    m_classes.clear();

    // Register user classes
    for (const auto& cls : program.classes) {
        m_classes[cls->name] = cls.get();
    }

    // Register user functions
    for (const auto& func : program.functions) {
        m_functions[func->name] = func.get();
    }

    // Execute global statements first
    for (const auto& stmt : program.global_statements) {
        execute_stmt(*stmt, m_global_env, out);
    }

    // Call 'मुख्य' function if present
    auto it = m_functions.find("मुख्य");
    if (it != m_functions.end()) {
        call_function("मुख्य", {}, it->second->line, it->second->column, out);
    }
}

void Interpreter::execute_repl_program(const ProgramASTNode& program, std::ostream& out) {
    runtime::Runtime::get_instance().set_output_stream(&out);
    for (const auto& cls : program.classes) {
        m_classes[cls->name] = cls.get();
    }

    for (const auto& func : program.functions) {
        m_functions[func->name] = func.get();
    }

    for (const auto& stmt : program.global_statements) {
        execute_stmt(*stmt, m_global_env, out);
    }
}

SutraValue Interpreter::execute_stmt(const StmtASTNode& stmt, std::shared_ptr<Environment> env, std::ostream& out) {
    runtime::Runtime::get_instance().set_output_stream(&out);
    GarbageCollector::get_instance().check_and_collect();
    if (auto print_stmt = dynamic_cast<const PrintStmtASTNode*>(&stmt)) {
        SutraValue val = evaluate_expr(*print_stmt->expression, env);
        runtime::Runtime::get_instance().write_line(val.to_string());
        return SutraValue::make_null();
    }

    if (auto var_decl = dynamic_cast<const VarDeclStmtASTNode*>(&stmt)) {
        SutraValue val = SutraValue::make_null();
        if (var_decl->initializer) {
            val = evaluate_expr(*var_decl->initializer, env);
        }
        env->define(var_decl->var_name, val);
        return SutraValue::make_null();
    }

    if (auto assign_stmt = dynamic_cast<const AssignStmtASTNode*>(&stmt)) {
        SutraValue val = evaluate_expr(*assign_stmt->value, env);
        env->assign(assign_stmt->var_name, val, assign_stmt->line, assign_stmt->column);
        return SutraValue::make_null();
    }

    if (auto arr_assign_stmt = dynamic_cast<const ArrayIndexAssignStmtASTNode*>(&stmt)) {
        if (arr_assign_stmt->index_exprs.empty()) {
            throw RuntimeError("सूचकांक-श्रेणिः रिक्ता (Empty index path)", arr_assign_stmt->line, arr_assign_stmt->column);
        }

        SutraValue current = env->get(arr_assign_stmt->array_name, arr_assign_stmt->line, arr_assign_stmt->column);
        std::vector<SutraValue> parents;
        std::vector<SutraValue> parent_indices;

        for (size_t i = 0; i < arr_assign_stmt->index_exprs.size(); ++i) {
            SutraValue idx_val = evaluate_expr(*arr_assign_stmt->index_exprs[i], env);
            
            if (current.type == ValueType::DICTIONARY) {
                if (idx_val.type != ValueType::STRING) {
                    throw RuntimeError("शब्दकोश की कुंजी पाठ होनी चाहिए (Dictionary key must be string)", arr_assign_stmt->line, arr_assign_stmt->column);
                }
                if (!current.dict_val) {
                    current.dict_val = std::make_shared<std::unordered_map<std::string, SutraValue>>();
                }
                
                if (i + 1 == arr_assign_stmt->index_exprs.size()) {
                    SutraValue val = evaluate_expr(*arr_assign_stmt->value_expr, env);
                    (*current.dict_val)[idx_val.string_val] = val;
                    for (int p = static_cast<int>(parents.size()) - 1; p >= 0; --p) {
                        if (parents[p].type == ValueType::LIST) {
                            parents[p].get_list()[static_cast<size_t>(parent_indices[p].int_val)] = current;
                        } else if (parents[p].type == ValueType::DICTIONARY) {
                            (*parents[p].dict_val)[parent_indices[p].string_val] = current;
                        }
                        current = parents[p];
                    }
                    env->assign(arr_assign_stmt->array_name, current, arr_assign_stmt->line, arr_assign_stmt->column);
                    return SutraValue::make_null();
                }

                parents.push_back(current);
                parent_indices.push_back(idx_val);
                current = (*current.dict_val)[idx_val.string_val];
            } else if (current.type == ValueType::LIST) {
                if (idx_val.type != ValueType::INT) {
                    throw RuntimeError("सूची की कुंजी पूर्णांक होनी चाहिए (List index must be int)", arr_assign_stmt->line, arr_assign_stmt->column);
                }
                if (idx_val.int_val < 0) {
                    throw RuntimeError("अमान्य सूचकांक मान (Index cannot be negative)", arr_assign_stmt->line, arr_assign_stmt->column);
                }
                size_t idx = static_cast<size_t>(idx_val.int_val);
                if (idx >= current.get_list().size()) {
                    throw RuntimeError("सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)", arr_assign_stmt->line, arr_assign_stmt->column);
                }

                if (i + 1 == arr_assign_stmt->index_exprs.size()) {
                    SutraValue val = evaluate_expr(*arr_assign_stmt->value_expr, env);
                    current.get_list()[idx] = val;
                    for (int p = static_cast<int>(parents.size()) - 1; p >= 0; --p) {
                        if (parents[p].type == ValueType::LIST) {
                            parents[p].get_list()[static_cast<size_t>(parent_indices[p].int_val)] = current;
                        } else if (parents[p].type == ValueType::DICTIONARY) {
                            (*parents[p].dict_val)[parent_indices[p].string_val] = current;
                        }
                        current = parents[p];
                    }
                    env->assign(arr_assign_stmt->array_name, current, arr_assign_stmt->line, arr_assign_stmt->column);
                    return SutraValue::make_null();
                }

                parents.push_back(current);
                parent_indices.push_back(idx_val);
                current = current.get_list()[idx];
            } else {
                throw RuntimeError("'" + arr_assign_stmt->array_name + "' सूची या शब्दकोश नहीं है।", arr_assign_stmt->line, arr_assign_stmt->column);
            }
        }

        throw RuntimeError("सूचकांक-श्रेणी त्रुटिः (Invalid index assignment)", arr_assign_stmt->line, arr_assign_stmt->column);
    }

    if (auto if_stmt = dynamic_cast<const IfStmtASTNode*>(&stmt)) {
        SutraValue cond_val = evaluate_expr(*if_stmt->condition, env);
        if (cond_val.is_truthy()) {
            return execute_stmt(*if_stmt->then_branch, env, out);
        } else if (if_stmt->else_branch) {
            return execute_stmt(*if_stmt->else_branch, env, out);
        }
        return SutraValue::make_null();
    }

    if (auto while_stmt = dynamic_cast<const WhileStmtASTNode*>(&stmt)) {
        while (evaluate_expr(*while_stmt->condition, env).is_truthy()) {
            SutraValue res = execute_stmt(*while_stmt->body, env, out);
            if (res.type == ValueType::BREAK_SIGNAL) {
                break;
            }
            if (res.type == ValueType::CONTINUE_SIGNAL) {
                continue;
            }
            if (res.type == ValueType::RETURN_SIGNAL) {
                return res;
            }
        }
        return SutraValue::make_null();
    }

    if (auto for_stmt = dynamic_cast<const ForStmtASTNode*>(&stmt)) {
        auto for_env = std::make_shared<Environment>(env);
        if (for_stmt->init) {
            execute_stmt(*for_stmt->init, for_env, out);
        }
        while (true) {
            if (for_stmt->condition) {
                if (!evaluate_expr(*for_stmt->condition, for_env).is_truthy()) {
                    break;
                }
            }
            if (for_stmt->body) {
                SutraValue res = execute_stmt(*for_stmt->body, for_env, out);
                if (res.type == ValueType::BREAK_SIGNAL) {
                    break;
                }
                if (res.type == ValueType::CONTINUE_SIGNAL) {
                    if (for_stmt->update) {
                        execute_stmt(*for_stmt->update, for_env, out);
                    }
                    continue;
                }
                if (res.type == ValueType::RETURN_SIGNAL) {
                    return res;
                }
            }
            if (for_stmt->update) {
                execute_stmt(*for_stmt->update, for_env, out);
            }
        }
        return SutraValue::make_null();
    }

    if (dynamic_cast<const BreakStmtASTNode*>(&stmt)) {
        return SutraValue::make_break();
    }

    if (dynamic_cast<const ContinueStmtASTNode*>(&stmt)) {
        return SutraValue::make_continue();
    }

    if (auto try_catch = dynamic_cast<const TryCatchStmtASTNode*>(&stmt)) {
        try {
            return execute_stmt(*try_catch->try_block, env, out);
        } catch (const SutraRuntimeException& ex) {
            GarbageCollector::get_instance().pop_exception();
            auto catch_env = std::make_shared<Environment>(env);
            catch_env->define(try_catch->catch_var_name, ex.error_val);
            return execute_stmt(*try_catch->catch_block, catch_env, out);
        } catch (const std::exception& ex) {
            auto catch_env = std::make_shared<Environment>(env);
            catch_env->define(try_catch->catch_var_name, SutraValue::make_string(ex.what()));
            return execute_stmt(*try_catch->catch_block, catch_env, out);
        }
    }

    if (auto throw_stmt = dynamic_cast<const ThrowStmtASTNode*>(&stmt)) {
        SutraValue val = evaluate_expr(*throw_stmt->expression, env);
        GarbageCollector::get_instance().push_exception(val);
        throw SutraRuntimeException(val, throw_stmt->line, throw_stmt->column);
    }

    if (auto ret_stmt = dynamic_cast<const ReturnStmtASTNode*>(&stmt)) {
        SutraValue val = SutraValue::make_null();
        if (ret_stmt->value) {
            val = evaluate_expr(*ret_stmt->value, env);
        }
        return SutraValue::make_return(val);
    }

    if (auto mem_assign = dynamic_cast<const MemberAssignStmtASTNode*>(&stmt)) {
        SutraValue obj_val = evaluate_expr(*mem_assign->object_expr, env);
        if (obj_val.type != ValueType::OBJECT || !obj_val.fields) {
            throw RuntimeError("वस्तु (Object) न अस्ति।", mem_assign->line, mem_assign->column);
        }
        SutraValue val = evaluate_expr(*mem_assign->value_expr, env);
        (*obj_val.fields)[mem_assign->member_name] = val;
        return SutraValue::make_null();
    }

    if (auto block_stmt = dynamic_cast<const BlockStmtASTNode*>(&stmt)) {
        auto block_env = std::make_shared<Environment>(env);
        for (const auto& s : block_stmt->statements) {
            SutraValue res = execute_stmt(*s, block_env, out);
            if (res.type == ValueType::RETURN_SIGNAL || res.type == ValueType::BREAK_SIGNAL || res.type == ValueType::CONTINUE_SIGNAL) {
                return res;
            }
        }
        return SutraValue::make_null();
    }

    if (auto expr_stmt = dynamic_cast<const ExprStmtASTNode*>(&stmt)) {
        evaluate_expr(*expr_stmt->expression, env);
        return SutraValue::make_null();
    }

    return SutraValue::make_null();
}

SutraValue Interpreter::evaluate_expr(const ExprASTNode& expr, std::shared_ptr<Environment> env) {
    if (auto lit_expr = dynamic_cast<const LiteralExprASTNode*>(&expr)) {
        switch (lit_expr->lit_type) {
            case LiteralType::INT:
                return SutraValue::make_int(std::stoll(lit_expr->value));
            case LiteralType::FLOAT:
                return SutraValue::make_float(std::stod(lit_expr->value));
            case LiteralType::STRING:
                return SutraValue::make_string(lit_expr->value);
            case LiteralType::BOOL:
                return SutraValue::make_bool(lit_expr->value == "सत्य");
            case LiteralType::NULL_VAL:
                return SutraValue::make_null();
            case LiteralType::CHAR:
                return SutraValue::make_char(lit_expr->value);
        }
    }

    if (dynamic_cast<const InputExprASTNode*>(&expr)) {
        std::string input_str = runtime::Runtime::get_instance().read();
        if (!input_str.empty()) {
            try {
                size_t pos = 0;
                int64_t i_val = std::stoll(input_str, &pos);
                if (pos == input_str.size()) return SutraValue::make_int(i_val);
            } catch (...) {}
            try {
                size_t pos = 0;
                double f_val = std::stod(input_str, &pos);
                if (pos == input_str.size()) return SutraValue::make_float(f_val);
            } catch (...) {}
            return SutraValue::make_string(input_str);
        }
        return SutraValue::make_null();
    }

    if (auto dict_lit = dynamic_cast<const DictionaryLiteralExprASTNode*>(&expr)) {
        auto dict_map = std::make_shared<std::unordered_map<std::string, SutraValue>>();
        for (const auto& elem : dict_lit->elements) {
            (*dict_map)[elem.first] = evaluate_expr(*elem.second, env);
        }
        return SutraValue::make_dict(dict_map);
    }

    if (auto arr_lit = dynamic_cast<const ArrayLiteralExprASTNode*>(&expr)) {
        std::vector<SutraValue> elems;
        for (const auto& elem : arr_lit->elements) {
            elems.push_back(evaluate_expr(*elem, env));
        }
        return SutraValue::make_list(elems);
    }

    if (auto arr_idx = dynamic_cast<const ArrayIndexExprASTNode*>(&expr)) {
        SutraValue arr_val = evaluate_expr(*arr_idx->array_expr, env);
        
        if (arr_val.type == ValueType::DICTIONARY) {
            SutraValue idx_val = evaluate_expr(*arr_idx->index_expr, env);
            if (idx_val.type != ValueType::STRING) {
                throw RuntimeError("शब्दकोश की कुंजी पाठ होनी चाहिए (Dictionary key must be string)", arr_idx->line, arr_idx->column);
            }
            if (!arr_val.dict_val) return SutraValue::make_null();
            auto it = arr_val.dict_val->find(idx_val.string_val);
            if (it != arr_val.dict_val->end()) {
                return it->second;
            }
            return SutraValue::make_null();
        }
        
        if (arr_val.type != ValueType::LIST && arr_val.type != ValueType::STRING) {
            throw RuntimeError("सूची, शब्दकोश वा पाठ न अस्ति। (Not a list, dict or string)", arr_idx->line, arr_idx->column);
        }
        SutraValue idx_val = evaluate_expr(*arr_idx->index_expr, env);
        if (idx_val.int_val < 0) {
            throw RuntimeError("अमान्य सूचकांक मान (Index cannot be negative)", arr_idx->line, arr_idx->column);
        }
        size_t idx = static_cast<size_t>(idx_val.int_val);
        
        if (arr_val.type == ValueType::LIST) {
            if (idx >= arr_val.get_list().size()) {
                throw RuntimeError("सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)", arr_idx->line, arr_idx->column);
            }
            return arr_val.get_list()[idx];
        } else {
            // String indexing
            size_t len = 0;
            size_t byte_idx = 0;
            while (byte_idx < arr_val.string_val.size()) {
                decode_utf8(arr_val.string_val, byte_idx);
                len++;
            }
            if (idx >= len) {
                throw RuntimeError("पाठस्य सीमा अतिक्रान्ता (String index out of bounds)", arr_idx->line, arr_idx->column);
            }
            byte_idx = 0;
            size_t char_count = 0;
            while (byte_idx < arr_val.string_val.size()) {
                size_t prev_byte = byte_idx;
                decode_utf8(arr_val.string_val, byte_idx);
                if (char_count == idx) {
                    return SutraValue::make_string(arr_val.string_val.substr(prev_byte, byte_idx - prev_byte));
                }
                char_count++;
            }
            return SutraValue::make_null();
        }
    }

    if (auto new_expr = dynamic_cast<const NewExprASTNode*>(&expr)) {
        auto it = m_classes.find(new_expr->class_name);
        if (it == m_classes.end()) {
            throw RuntimeError("'" + new_expr->class_name + "' नामकः वर्गः न प्राप्तः (Class not found)", new_expr->line, new_expr->column);
        }
        const ClassDeclASTNode* cls = it->second;
        auto fields = std::make_shared<std::unordered_map<std::string, SutraValue>>();

        for (const auto& field : cls->fields) {
            SutraValue init_val = SutraValue::make_null();
            if (field->initializer) {
                init_val = evaluate_expr(*field->initializer, env);
            }
            (*fields)[field->var_name] = init_val;
        }

        SutraValue obj_val = SutraValue::make_object(cls->name, fields);

        std::vector<SutraValue> args;
        for (const auto& arg : new_expr->arguments) {
            args.push_back(evaluate_expr(*arg, env));
        }

        for (const auto& method : cls->methods) {
            if (method->name == "रचना" || method->name == cls->name) {
                auto method_env = std::make_shared<Environment>(env);
                method_env->define("स्व", obj_val);
                for (size_t i = 0; i < args.size() && i < method->params.size(); ++i) {
                    method_env->define(method->params[i].name, args[i]);
                }
                execute_stmt(*method->body, method_env, std::cout);
                break;
            }
        }

        return obj_val;
    }

    if (dynamic_cast<const SelfExprASTNode*>(&expr)) {
        return env->get("स्व", expr.line, expr.column);
    }

    if (auto mem_acc = dynamic_cast<const MemberAccessExprASTNode*>(&expr)) {
        SutraValue obj_val = evaluate_expr(*mem_acc->object_expr, env);
        if (obj_val.type != ValueType::OBJECT || !obj_val.fields) {
            throw RuntimeError("वस्तु (Object) न अस्ति।", mem_acc->line, mem_acc->column);
        }
        auto it = obj_val.fields->find(mem_acc->member_name);
        if (it == obj_val.fields->end()) {
            return SutraValue::make_null();
        }
        return it->second;
    }

    if (auto meth_call = dynamic_cast<const MethodCallExprASTNode*>(&expr)) {
        SutraValue obj_val = evaluate_expr(*meth_call->object_expr, env);
        if (obj_val.type != ValueType::OBJECT || !obj_val.fields) {
            throw RuntimeError("वस्तु (Object) न अस्ति।", meth_call->line, meth_call->column);
        }

        auto cls_it = m_classes.find(obj_val.class_name);
        if (cls_it == m_classes.end()) {
            throw RuntimeError("'" + obj_val.class_name + "' नामकः वर्गः न प्राप्तः", meth_call->line, meth_call->column);
        }

        const ClassDeclASTNode* cls = cls_it->second;
        const FunctionDeclASTNode* target_method = nullptr;
        for (const auto& m : cls->methods) {
            if (m->name == meth_call->method_name) {
                target_method = m.get();
                break;
            }
        }

        if (!target_method) {
            throw RuntimeError("'" + meth_call->method_name + "' नामक विधिः न प्राप्ता (Method not found)", meth_call->line, meth_call->column);
        }

        std::vector<SutraValue> args;
        for (const auto& arg : meth_call->arguments) {
            args.push_back(evaluate_expr(*arg, env));
        }

        auto method_env = std::make_shared<Environment>(env);
        method_env->define("स्व", obj_val);
        for (size_t i = 0; i < args.size() && i < target_method->params.size(); ++i) {
            method_env->define(target_method->params[i].name, args[i]);
        }

        SutraValue result = execute_stmt(*target_method->body, method_env, std::cout);
        if (result.type == ValueType::RETURN_SIGNAL && result.return_payload) {
            return *result.return_payload;
        }
        return SutraValue::make_null();
    }

    if (auto id_expr = dynamic_cast<const IdentifierExprASTNode*>(&expr)) {
        return env->get(id_expr->name, id_expr->line, id_expr->column);
    }

    if (auto un_expr = dynamic_cast<const UnaryExprASTNode*>(&expr)) {
        SutraValue val = evaluate_expr(*un_expr->operand, env);
        if (un_expr->op == TokenType::LOGICAL_NOT || un_expr->op == TokenType::K_NA) {
            return SutraValue::make_bool(!val.is_truthy());
        }
        if (un_expr->op == TokenType::MINUS) {
            if (val.type == ValueType::FLOAT) return SutraValue::make_float(-val.float_val);
            return SutraValue::make_int(-val.int_val);
        }
    }

    if (auto call_expr = dynamic_cast<const CallExprASTNode*>(&expr)) {
        std::vector<SutraValue> args;
        for (const auto& arg : call_expr->arguments) {
            args.push_back(evaluate_expr(*arg, env));
        }

        // Builtin output functions as expression
        if (call_expr->callee == "लिखतु" || call_expr->callee == "दर्शयतु" || call_expr->callee == "पंक्तिं") {
            std::string out_str = "";
            for (size_t i = 0; i < args.size(); ++i) {
                if (i > 0) out_str += " ";
                out_str += args[i].to_string();
            }
            runtime::Runtime::get_instance().write_line(out_str);
            return SutraValue::make_null();
        }
        if (call_expr->callee == "संग्रह_करो") {
            GarbageCollector::get_instance().collect();
            return SutraValue::make_null();
        }
        if (call_expr->callee == "स्मृति_स्थिति") {
            GarbageCollector::get_instance().print_stats();
            return SutraValue::make_null();
        }

        // Standard Library Builtins
        // File I/O
        if (call_expr->callee == "सञ्चिका_पठतु") {
            if (args.size() != 1 || args[0].type != ValueType::STRING) {
                throw RuntimeError("'सञ्चिका_पठतु' के लिए एक पाठ (string) पथ अपेक्षित है।", call_expr->line, call_expr->column);
            }
            if (!runtime::Runtime::get_instance().platform().file_exists(args[0].string_val)) {
                throw RuntimeError("सञ्चिका न प्राप्ता (File not found): " + args[0].string_val, call_expr->line, call_expr->column);
            }
            return SutraValue::make_string(runtime::Runtime::get_instance().platform().file_read(args[0].string_val));
        }
        if (call_expr->callee == "सञ्चिका_लिखतु") {
            if (args.size() != 2 || args[0].type != ValueType::STRING || args[1].type != ValueType::STRING) {
                throw RuntimeError("'सञ्चिका_लिखतु' के लिए दो पाठ (string) अपेक्षित हैं।", call_expr->line, call_expr->column);
            }
            runtime::Runtime::get_instance().platform().file_write(args[0].string_val, args[1].string_val);
            return SutraValue::make_bool(true);
        }
        if (call_expr->callee == "सञ्चिका_अस्ति") {
            if (args.size() != 1 || args[0].type != ValueType::STRING) {
                throw RuntimeError("'सञ्चिका_अस्ति' के लिए एक पाठ (string) पथ अपेक्षित है।", call_expr->line, call_expr->column);
            }
            return SutraValue::make_bool(runtime::Runtime::get_instance().platform().file_exists(args[0].string_val));
        }

        if (call_expr->callee == "वर्गमूल") {
            double v = (args[0].type == ValueType::FLOAT) ? args[0].float_val : static_cast<double>(args[0].int_val);
            return SutraValue::make_float(std::sqrt(v));
        }
        if (call_expr->callee == "घात") {
            double b = (args[0].type == ValueType::FLOAT) ? args[0].float_val : static_cast<double>(args[0].int_val);
            double e = (args[1].type == ValueType::FLOAT) ? args[1].float_val : static_cast<double>(args[1].int_val);
            return SutraValue::make_float(std::pow(b, e));
        }
        if (call_expr->callee == "निरपेक्ष") {
            if (args[0].type == ValueType::FLOAT) return SutraValue::make_float(std::abs(args[0].float_val));
            return SutraValue::make_int(std::abs(args[0].int_val));
        }
        if (call_expr->callee == "न्यूनतम") {
            double a = (args[0].type == ValueType::FLOAT) ? args[0].float_val : static_cast<double>(args[0].int_val);
            double b = (args[1].type == ValueType::FLOAT) ? args[1].float_val : static_cast<double>(args[1].int_val);
            if (args[0].type == ValueType::FLOAT || args[1].type == ValueType::FLOAT) return SutraValue::make_float(std::min(a, b));
            return SutraValue::make_int(std::min(args[0].int_val, args[1].int_val));
        }
        if (call_expr->callee == "अधिकतम") {
            double a = (args[0].type == ValueType::FLOAT) ? args[0].float_val : static_cast<double>(args[0].int_val);
            double b = (args[1].type == ValueType::FLOAT) ? args[1].float_val : static_cast<double>(args[1].int_val);
            if (args[0].type == ValueType::FLOAT || args[1].type == ValueType::FLOAT) return SutraValue::make_float(std::max(a, b));
            return SutraValue::make_int(std::max(args[0].int_val, args[1].int_val));
        }
        if (call_expr->callee == "गोल") {
            double v = (args[0].type == ValueType::FLOAT) ? args[0].float_val : static_cast<double>(args[0].int_val);
            return SutraValue::make_int(static_cast<int64_t>(std::round(v)));
        }
        if (call_expr->callee == "लंबाई") {
            if (args[0].type == ValueType::STRING) {
                return SutraValue::make_int(static_cast<int64_t>(utf8_codepoint_count(args[0].string_val)));
            }
            if (args[0].type == ValueType::LIST) {
                return SutraValue::make_int(static_cast<int64_t>(args[0].get_list().size()));
            }
            if (args[0].type == ValueType::DICTIONARY) {
                if (args[0].dict_val) return SutraValue::make_int(static_cast<int64_t>(args[0].dict_val->size()));
                return SutraValue::make_int(0);
            }
            return SutraValue::make_int(0);
        }
        if (call_expr->callee == "उच्च") {
            std::string str = args[0].to_string();
            for (char &c : str) c = static_cast<char>(std::toupper(static_cast<unsigned char>(c)));
            return SutraValue::make_string(str);
        }
        if (call_expr->callee == "निम्न") {
            std::string str = args[0].to_string();
            for (char &c : str) c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
            return SutraValue::make_string(str);
        }
        if (call_expr->callee == "प्रकार") {
            switch (args[0].type) {
                case ValueType::INT: return SutraValue::make_string("संख्या");
                case ValueType::FLOAT: return SutraValue::make_string("दशमलव");
                case ValueType::STRING: return SutraValue::make_string("पाठ");
                case ValueType::BOOL: return SutraValue::make_string("बूल");
                case ValueType::LIST: return SutraValue::make_string("सूची");
                default: return SutraValue::make_string("शून्यम्");
            }
        }
        if (call_expr->callee == "जोड़ें") {
            if (args[0].type != ValueType::LIST) {
                throw RuntimeError("'जोड़ें' कार्य के लिए सूची अपेक्षित है।", call_expr->line, call_expr->column);
            }
            SutraValue new_list = args[0];
            new_list.get_list().push_back(args[1]);
            return new_list;
        }
        if (call_expr->callee == "निकालें") {
            if (args[0].type != ValueType::LIST) {
                throw RuntimeError("'निकालें' कार्य के लिए सूची अपेक्षित है।", call_expr->line, call_expr->column);
            }
            if (args[0].get_list().empty()) {
                throw RuntimeError("शून्य सूची से तत्व नहीं निकाला जा सकता।", call_expr->line, call_expr->column);
            }
            SutraValue new_list = args[0];
            new_list.get_list().pop_back();
            return new_list;
        }
        if (call_expr->callee == "डालें") {
            if (args[0].type != ValueType::LIST) {
                throw RuntimeError("'डालें' कार्य के लिए सूची अपेक्षित है।", call_expr->line, call_expr->column);
            }
            if (args[1].type != ValueType::INT) {
                throw RuntimeError("'डालें' कार्य के लिए सूचकांक पूर्णांक होना चाहिए।", call_expr->line, call_expr->column);
            }
            int64_t idx = args[1].int_val;
            if (idx < 0 || idx > (int64_t)args[0].get_list().size()) {
                throw RuntimeError("डालें: सूचकांक सीमा से बाहर अस्ति।", call_expr->line, call_expr->column);
            }
            SutraValue new_list = args[0];
            new_list.get_list().insert(new_list.get_list().begin() + idx, args[2]);
            return new_list;
        }
        if (call_expr->callee == "हटाएं") {
            if (args[0].type == ValueType::DICTIONARY) {
                if (args[1].type != ValueType::STRING) {
                    throw RuntimeError("'हटाएं' कार्य के लिए शब्दकोश कुंजी पाठ होनी चाहिए।", call_expr->line, call_expr->column);
                }
                SutraValue new_dict = args[0];
                if (new_dict.dict_val) {
                    new_dict.dict_val->erase(args[1].string_val);
                }
                return new_dict;
            }
            if (args[0].type != ValueType::LIST) {
                throw RuntimeError("'हटाएं' कार्य के लिए सूची या शब्दकोश अपेक्षित है।", call_expr->line, call_expr->column);
            }
            if (args[1].type != ValueType::INT) {
                throw RuntimeError("'हटाएं' कार्य के लिए सूचकांक पूर्णांक होना चाहिए।", call_expr->line, call_expr->column);
            }
            int64_t idx = args[1].int_val;
            if (idx < 0 || idx >= (int64_t)args[0].get_list().size()) {
                throw RuntimeError("हटाएं: सूचकांक सीमा से बाहर अस्ति।", call_expr->line, call_expr->column);
            }
            SutraValue new_list = args[0];
            new_list.get_list().erase(new_list.get_list().begin() + idx);
            return new_list;
        }
        if (call_expr->callee == "मिलाएं") {
            if (args[0].type != ValueType::LIST || args[1].type != ValueType::LIST) {
                throw RuntimeError("'मिलाएं' कार्य के लिए दोनों तर्क सूची होने चाहिए।", call_expr->line, call_expr->column);
            }
            SutraValue new_list = args[0];
            new_list.get_list().insert(new_list.get_list().end(), args[1].get_list().begin(), args[1].get_list().end());
            return new_list;
        }

        if (call_expr->callee == "कुंजी_है") {
            if (args.size() != 2) throw RuntimeError("'कुंजी_है' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            if (args[0].type != ValueType::DICTIONARY) throw RuntimeError("'कुंजी_है' कार्य के लिए शब्दकोश अपेक्षित है।", call_expr->line, call_expr->column);
            if (args[1].type != ValueType::STRING) throw RuntimeError("'कुंजी_है' कार्य के लिए कुंजी पाठ होनी चाहिए।", call_expr->line, call_expr->column);
            
            if (!args[0].dict_val) return SutraValue::make_bool(false);
            return SutraValue::make_bool(args[0].dict_val->find(args[1].string_val) != args[0].dict_val->end());
        }

        if (call_expr->callee == "कुंजियाँ") {
            if (args.size() != 1) throw RuntimeError("'कुंजियाँ' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            if (args[0].type != ValueType::DICTIONARY) throw RuntimeError("'कुंजियाँ' कार्य के लिए शब्दकोश अपेक्षित है।", call_expr->line, call_expr->column);
            
            std::vector<SutraValue> keys;
            if (args[0].dict_val) {
                for (const auto& pair : *args[0].dict_val) {
                    keys.push_back(SutraValue::make_string(pair.first));
                }
            }
            return SutraValue::make_list(keys);
        }

        // Sutra 1.1 approved string API
        if (call_expr->callee == "उपखंड") {
            if (args.size() != 3) {
                throw RuntimeError("'उपखंड' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::INT || args[2].type != ValueType::INT) {
                throw RuntimeError("'उपखंड' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            const std::string& s = args[0].string_val;
            int64_t start = args[1].int_val;
            int64_t end = args[2].int_val;
            if (start < 0 || end < 0) {
                throw RuntimeError("अमान्य सूचकांक मान (Index cannot be negative)", call_expr->line, call_expr->column);
            }
            size_t codepoint_count = utf8_codepoint_count(s);
            if (start > static_cast<int64_t>(codepoint_count) || end > static_cast<int64_t>(codepoint_count)) {
                throw RuntimeError("पाठस्य सीमा अतिक्रान्ता (String index out of bounds)", call_expr->line, call_expr->column);
            }
            if (start > end) {
                throw RuntimeError("आरंभः अन्त्यतः अधिकः अस्ति (start > end)", call_expr->line, call_expr->column);
            }
            if (start == end) {
                return SutraValue::make_string("");
            }

            size_t byte_start = 0;
            size_t byte_end = 0;
            size_t cp = 0;
            size_t idx = 0;
            while (idx < s.size()) {
                size_t prev = idx;
                decode_utf8(s, idx);
                if (cp == static_cast<size_t>(start)) {
                    byte_start = prev;
                }
                if (cp == static_cast<size_t>(end)) {
                    byte_end = prev;
                    break;
                }
                cp++;
            }
            if (byte_end == 0 && end == static_cast<int64_t>(codepoint_count)) {
                byte_end = s.size();
            }
            return SutraValue::make_string(s.substr(byte_start, byte_end - byte_start));
        }

        if (call_expr->callee == "खोजें") {
            if (args.size() != 2) {
                throw RuntimeError("'खोजें' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type == ValueType::LIST) {
                const auto& list = args[0].get_list();
                SutraValue target = args[1];
                int64_t found_idx = -1;
                for (size_t idx = 0; idx < list.size(); ++idx) {
                    bool match = false;
                    if (list[idx].type == target.type) {
                        if (list[idx].type == ValueType::INT && list[idx].int_val == target.int_val) match = true;
                        else if (list[idx].type == ValueType::FLOAT && list[idx].float_val == target.float_val) match = true;
                        else if (list[idx].type == ValueType::STRING && list[idx].string_val == target.string_val) match = true;
                        else if (list[idx].type == ValueType::BOOL && list[idx].bool_val == target.bool_val) match = true;
                        else if (list[idx].type == ValueType::NULL_VAL) match = true;
                    }
                    if (match) {
                        found_idx = (int64_t)idx;
                        break;
                    }
                }
                return SutraValue::make_int(found_idx);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::STRING) {
                throw RuntimeError("'खोजें' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            if (args[1].string_val.empty()) {
                throw RuntimeError("खोजें: रिक्त खोज पाठ मान्य न अस्ति।", call_expr->line, call_expr->column);
            }
            const std::string& haystack = args[0].string_val;
            const std::string& needle = args[1].string_val;
            size_t pos = haystack.find(needle);
            if (pos == std::string::npos) {
                return SutraValue::make_int(-1);
            }
            size_t count = 0;
            size_t i = 0;
            while (i < pos) {
                size_t prev = i;
                decode_utf8(haystack, i);
                count++;
                if (i <= prev) {
                    break;
                }
            }
            return SutraValue::make_int(static_cast<int64_t>(count));
        }

        if (call_expr->callee == "बदलें") {
            if (args.size() != 3) {
                throw RuntimeError("'बदलें' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::STRING || args[2].type != ValueType::STRING) {
                throw RuntimeError("'बदलें' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            if (args[1].string_val.empty()) {
                throw RuntimeError("बदलें: रिक्त खोज पाठ मान्य न अस्ति।", call_expr->line, call_expr->column);
            }
            const std::string& haystack = args[0].string_val;
            const std::string& needle = args[1].string_val;
            const std::string& replacement = args[2].string_val;
            size_t pos = haystack.find(needle);
            if (pos == std::string::npos) {
                return SutraValue::make_string(haystack);
            }
            return SutraValue::make_string(haystack.substr(0, pos) + replacement + haystack.substr(pos + needle.size()));
        }

        if (call_expr->callee == "विभाजित") {
            if (args.size() != 2) {
                throw RuntimeError("'विभाजित' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::STRING) {
                throw RuntimeError("'विभाजित' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            if (args[1].string_val.empty()) {
                throw RuntimeError("विभाजित: रिक्त विभाजक मान्य न अस्ति।", call_expr->line, call_expr->column);
            }
            std::vector<SutraValue> parts;
            std::string haystack = args[0].string_val;
            std::string delim = args[1].string_val;
            size_t start = 0;
            while (true) {
                size_t pos = haystack.find(delim, start);
                if (pos == std::string::npos) {
                    parts.push_back(SutraValue::make_string(haystack.substr(start)));
                    break;
                }
                parts.push_back(SutraValue::make_string(haystack.substr(start, pos - start)));
                start = pos + delim.size();
                if (start == haystack.size()) {
                    parts.push_back(SutraValue::make_string(""));
                    break;
                }
            }
            return SutraValue::make_list(parts);
        }

        if (call_expr->callee == "संयोजित") {
            if (args.size() != 2) {
                throw RuntimeError("'संयोजित' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::LIST || args[1].type != ValueType::STRING) {
                throw RuntimeError("'संयोजित' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            std::string sep = args[1].string_val;
            std::string out;
            const auto& join_list = args[0].get_list();
            for (size_t i = 0; i < join_list.size(); ++i) {
                if (join_list[i].type != ValueType::STRING) {
                    throw RuntimeError("'संयोजित' में सूची के सभी तत्व पाठ होने चाहिए।", call_expr->line, call_expr->column);
                }
                if (i > 0) out += sep;
                out += join_list[i].string_val;
            }
            return SutraValue::make_string(out);
        }

        if (call_expr->callee == "छाँटें") {
            if (args.size() != 1) {
                throw RuntimeError("'छाँटें' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING) {
                throw RuntimeError("'छाँटें' के तर्क का प्रकार पाठ नहीं है।", call_expr->line, call_expr->column);
            }

            const std::string& s = args[0].string_val;
            auto is_ws = [](uint32_t cp) {
                return cp == ' ' || cp == '\t' || cp == '\n' || cp == '\r' || cp == 0x00A0 || cp == 0x1680 ||
                       (cp >= 0x2000 && cp <= 0x200A) || cp == 0x2028 || cp == 0x2029 || cp == 0x202F ||
                       cp == 0x205F || cp == 0x3000;
            };

            std::vector<uint32_t> codepoints;
            size_t idx = 0;
            while (idx < s.size()) {
                size_t next = idx;
                codepoints.push_back(decode_utf8(s, next));
                idx = next;
            }

            size_t start = 0;
            while (start < codepoints.size() && is_ws(codepoints[start])) {
                ++start;
            }

            size_t end = codepoints.size();
            while (end > start && is_ws(codepoints[end - 1])) {
                --end;
            }

            std::string trimmed;
            for (size_t i = start; i < end; ++i) {
                trimmed += encode_utf8(codepoints[i]);
            }
            return SutraValue::make_string(trimmed);
        }

        if (call_expr->callee == "आरंभिक") {
            if (args.size() != 2) {
                throw RuntimeError("'आरंभिक' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::STRING) {
                throw RuntimeError("'आरंभिक' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            if (args[1].string_val.empty()) {
                return SutraValue::make_bool(true);
            }
            return SutraValue::make_bool(args[0].string_val.rfind(args[1].string_val, 0) == 0);
        }

        if (call_expr->callee == "अंतिम") {
            if (args.size() != 2) {
                throw RuntimeError("'अंतिम' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", call_expr->line, call_expr->column);
            }
            if (args[0].type != ValueType::STRING || args[1].type != ValueType::STRING) {
                throw RuntimeError("'अंतिम' के तर्क भिन्न प्रकार के हैं।", call_expr->line, call_expr->column);
            }
            if (args[1].string_val.empty()) {
                return SutraValue::make_bool(true);
            }
            const std::string& text = args[0].string_val;
            const std::string& suffix = args[1].string_val;
            return SutraValue::make_bool(text.size() >= suffix.size() && text.compare(text.size() - suffix.size(), suffix.size(), suffix) == 0);
        }

        return call_function(call_expr->callee, args, call_expr->line, call_expr->column, *runtime::Runtime::get_instance().get_output_stream());
    }

    if (auto bin_expr = dynamic_cast<const BinaryExprASTNode*>(&expr)) {
        // Short-circuit logical operators
        if (bin_expr->op == TokenType::LOGICAL_AND || bin_expr->op == TokenType::K_TATHA) {
            SutraValue left = evaluate_expr(*bin_expr->left, env);
            if (!left.is_truthy()) return SutraValue::make_bool(false);
            SutraValue right = evaluate_expr(*bin_expr->right, env);
            return SutraValue::make_bool(right.is_truthy());
        }

        if (bin_expr->op == TokenType::LOGICAL_OR || bin_expr->op == TokenType::K_ATHAVA) {
            SutraValue left = evaluate_expr(*bin_expr->left, env);
            if (left.is_truthy()) return SutraValue::make_bool(true);
            SutraValue right = evaluate_expr(*bin_expr->right, env);
            return SutraValue::make_bool(right.is_truthy());
        }

        SutraValue left = evaluate_expr(*bin_expr->left, env);
        SutraValue right = evaluate_expr(*bin_expr->right, env);

        // String concatenation
        if (left.type == ValueType::STRING || right.type == ValueType::STRING) {
            if (bin_expr->op == TokenType::PLUS) {
                return SutraValue::make_string(left.to_string() + right.to_string());
            }
        }

        // Equality check
        if (bin_expr->op == TokenType::EQUAL) {
            if (left.type == right.type) {
                if (left.type == ValueType::INT) return SutraValue::make_bool(left.int_val == right.int_val);
                if (left.type == ValueType::FLOAT) return SutraValue::make_bool(left.float_val == right.float_val);
                if (left.type == ValueType::STRING) return SutraValue::make_bool(left.string_val == right.string_val);
                if (left.type == ValueType::BOOL) return SutraValue::make_bool(left.bool_val == right.bool_val);
                if (left.type == ValueType::NULL_VAL) return SutraValue::make_bool(true);
            }
            return SutraValue::make_bool(false);
        }

        if (bin_expr->op == TokenType::NOT_EQUAL) {
            if (left.type == right.type) {
                if (left.type == ValueType::INT) return SutraValue::make_bool(left.int_val != right.int_val);
                if (left.type == ValueType::FLOAT) return SutraValue::make_bool(left.float_val != right.float_val);
                if (left.type == ValueType::STRING) return SutraValue::make_bool(left.string_val != right.string_val);
                if (left.type == ValueType::BOOL) return SutraValue::make_bool(left.bool_val != right.bool_val);
                if (left.type == ValueType::NULL_VAL) return SutraValue::make_bool(false);
            }
            return SutraValue::make_bool(true);
        }

        if (left.type == ValueType::STRING && right.type == ValueType::STRING) {
            auto compare_utf8 = [](const std::string& a, const std::string& b) -> int {
                size_t i = 0, j = 0;
                while (i < a.size() && j < b.size()) {
                    size_t ai = i, bj = j;
                    uint32_t ca = decode_utf8(a, ai);
                    uint32_t cb = decode_utf8(b, bj);
                    if (ca != cb) return (ca < cb) ? -1 : 1;
                    i = ai; j = bj;
                }
                if (i == a.size() && j == b.size()) return 0;
                return (i == a.size()) ? -1 : 1;
            };

            if (bin_expr->op == TokenType::LESS) return SutraValue::make_bool(compare_utf8(left.string_val, right.string_val) < 0);
            if (bin_expr->op == TokenType::GREATER) return SutraValue::make_bool(compare_utf8(left.string_val, right.string_val) > 0);
            if (bin_expr->op == TokenType::LESS_EQUAL) return SutraValue::make_bool(compare_utf8(left.string_val, right.string_val) <= 0);
            if (bin_expr->op == TokenType::GREATER_EQUAL) return SutraValue::make_bool(compare_utf8(left.string_val, right.string_val) >= 0);
        }

        // Numeric arithmetic & comparison
        double l_num = (left.type == ValueType::FLOAT) ? left.float_val : static_cast<double>(left.int_val);
        double r_num = (right.type == ValueType::FLOAT) ? right.float_val : static_cast<double>(right.int_val);
        bool use_float = (left.type == ValueType::FLOAT || right.type == ValueType::FLOAT);

        switch (bin_expr->op) {
            case TokenType::PLUS:
                if (use_float) return SutraValue::make_float(l_num + r_num);
                return SutraValue::make_int(left.int_val + right.int_val);
            case TokenType::MINUS:
                if (use_float) return SutraValue::make_float(l_num - r_num);
                return SutraValue::make_int(left.int_val - right.int_val);
            case TokenType::STAR:
                if (use_float) return SutraValue::make_float(l_num * r_num);
                return SutraValue::make_int(left.int_val * right.int_val);
            case TokenType::SLASH:
                if (r_num == 0.0) {
                    throw RuntimeError("शून्येन विभाजनम् न सम्भवति (Division by zero)", bin_expr->line, bin_expr->column);
                }
                if (use_float) return SutraValue::make_float(l_num / r_num);
                return SutraValue::make_int(left.int_val / right.int_val);
            case TokenType::MOD:
                if (right.int_val == 0) {
                    throw RuntimeError("शून्येन भागशेषः न सम्भवति (Modulo by zero)", bin_expr->line, bin_expr->column);
                }
                return SutraValue::make_int(left.int_val % right.int_val);
            case TokenType::GREATER:
                return SutraValue::make_bool(l_num > r_num);
            case TokenType::LESS:
                return SutraValue::make_bool(l_num < r_num);
            case TokenType::GREATER_EQUAL:
                return SutraValue::make_bool(l_num >= r_num);
            case TokenType::LESS_EQUAL:
                return SutraValue::make_bool(l_num <= r_num);
            default:
                break;
        }
    }

    return SutraValue::make_null();
}

SutraValue Interpreter::call_function(const std::string& name, const std::vector<SutraValue>& args, size_t line, size_t col, std::ostream& out) {
    auto it = m_functions.find(name);
    if (it == m_functions.end()) {
        throw RuntimeError("'" + name + "' नामकं कार्यं न प्राप्तम्।", line, col);
    }

    const FunctionDeclASTNode* func = it->second;
    if (func->params.size() != args.size()) {
        throw RuntimeError("'" + name + "' कार्यस्य तर्क-सङ्ख्या अमान्या अस्ति।", line, col);
    }

    auto func_env = std::make_shared<Environment>(m_global_env);
    for (size_t i = 0; i < args.size(); ++i) {
        if (func->params[i].type_name == "सूची" && args[i].type == ValueType::LIST) {
            // Shared/reference semantics for typed list parameters
            func_env->define(func->params[i].name, args[i].shallow_copy());
        } else {
            func_env->define(func->params[i].name, args[i]);
        }
    }

    SutraValue result = execute_stmt(*func->body, func_env, out);
    if (result.type == ValueType::RETURN_SIGNAL && result.return_payload) {
        return *result.return_payload;
    }

    return SutraValue::make_null();
}

} // namespace sutra
