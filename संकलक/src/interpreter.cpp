#include "sutra/interpreter.hpp"
#include <cmath>
#include <algorithm>
#include <cctype>

namespace sutra {

Interpreter::Interpreter() {
    m_global_env = std::make_shared<Environment>();
}

void Interpreter::execute_program(const ProgramASTNode& program, std::ostream& out) {
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
    if (auto print_stmt = dynamic_cast<const PrintStmtASTNode*>(&stmt)) {
        SutraValue val = evaluate_expr(*print_stmt->expression, env);
        out << val.to_string() << "\n";
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
        SutraValue arr_val = env->get(arr_assign_stmt->array_name, arr_assign_stmt->line, arr_assign_stmt->column);
        if (arr_val.type != ValueType::LIST) {
            throw RuntimeError("'" + arr_assign_stmt->array_name + "' सूची न अस्ति।", arr_assign_stmt->line, arr_assign_stmt->column);
        }
        SutraValue idx_val = evaluate_expr(*arr_assign_stmt->index_expr, env);
        size_t idx = static_cast<size_t>(idx_val.int_val);
        if (idx >= arr_val.list_val.size()) {
            throw RuntimeError("सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)", arr_assign_stmt->line, arr_assign_stmt->column);
        }
        SutraValue val = evaluate_expr(*arr_assign_stmt->value_expr, env);
        arr_val.list_val[idx] = val;
        env->assign(arr_assign_stmt->array_name, arr_val, arr_assign_stmt->line, arr_assign_stmt->column);
        return SutraValue::make_null();
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
        }
    }

    if (dynamic_cast<const InputExprASTNode*>(&expr)) {
        std::string input_str;
        if (std::cin >> input_str) {
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

    if (auto arr_lit = dynamic_cast<const ArrayLiteralExprASTNode*>(&expr)) {
        std::vector<SutraValue> elems;
        for (const auto& elem : arr_lit->elements) {
            elems.push_back(evaluate_expr(*elem, env));
        }
        return SutraValue::make_list(elems);
    }

    if (auto arr_idx = dynamic_cast<const ArrayIndexExprASTNode*>(&expr)) {
        SutraValue arr_val = evaluate_expr(*arr_idx->array_expr, env);
        if (arr_val.type != ValueType::LIST) {
            throw RuntimeError("सूची न अस्ति।", arr_idx->line, arr_idx->column);
        }
        SutraValue idx_val = evaluate_expr(*arr_idx->index_expr, env);
        size_t idx = static_cast<size_t>(idx_val.int_val);
        if (idx >= arr_val.list_val.size()) {
            throw RuntimeError("सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)", arr_idx->line, arr_idx->column);
        }
        return arr_val.list_val[idx];
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
            for (size_t i = 0; i < args.size(); ++i) {
                if (i > 0) std::cout << " ";
                std::cout << args[i].to_string();
            }
            std::cout << "\n";
            return SutraValue::make_null();
        }

        // Standard Library Builtins
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
                return SutraValue::make_int(static_cast<int64_t>(args[0].string_val.length()));
            }
            if (args[0].type == ValueType::LIST) {
                return SutraValue::make_int(static_cast<int64_t>(args[0].list_val.size()));
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
            if (args[0].type == ValueType::LIST) {
                SutraValue new_list = args[0];
                new_list.list_val.push_back(args[1]);
                return new_list;
            }
            return args[0];
        }

        return call_function(call_expr->callee, args, call_expr->line, call_expr->column, std::cout);
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
        func_env->define(func->params[i].name, args[i]);
    }

    SutraValue result = execute_stmt(*func->body, func_env, out);
    if (result.type == ValueType::RETURN_SIGNAL && result.return_payload) {
        return *result.return_payload;
    }

    return SutraValue::make_null();
}

} // namespace sutra
