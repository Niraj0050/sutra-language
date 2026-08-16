#ifndef SUTRA_IR_HPP
#define SUTRA_IR_HPP

#include <string>
#include <vector>
#include <memory>
#include <iostream>

namespace sutra {
namespace compiler {

enum class IRValueType {
    UNKNOWN,
    INT,
    FLOAT,
    BOOL,
    STRING,
    ARRAY,
    DICTIONARY,
    OBJECT,
    NULL_VAL
};

enum class IROpcode {
    CONST_INT,      // %dest = const int_val
    CONST_STR,      // %dest = const str_val (pointer to string)
    CONST_NULL,     // %dest = null (0)
    ALLOCA,         // %dest = alloca var_name
    LOAD,           // %dest = load var_name
    STORE,          // store %val, var_name
    ADD,            // %dest = add %arg1, %arg2
    SUB,            // %dest = sub %arg1, %arg2
    MUL,            // %dest = mul %arg1, %arg2
    DIV,            // %dest = div %arg1, %arg2
    MOD,            // %dest = mod %arg1, %arg2
    CMP_EQ,         // %dest = eq %arg1, %arg2
    CMP_NE,         // %dest = ne %arg1, %arg2
    CMP_LT,         // %dest = lt %arg1, %arg2
    CMP_GT,         // %dest = gt %arg1, %arg2
    CMP_LE,         // %dest = le %arg1, %arg2
    CMP_GE,         // %dest = ge %arg1, %arg2
    AND_OP,         // %dest = and %arg1, %arg2
    OR_OP,          // %dest = or %arg1, %arg2
    NOT_OP,         // %dest = not %arg1
    CALL,           // %dest = call func_name(%arg1, ...)
    RET,            // ret %val
    PRINT_INT,      // print_int %val
    PRINT_STR,      // print_str %val (string pointer)
    PRINT_NULL,     // print "शून्यम्"
    PRINT_BOOL,     // print "सत्य" or "असत्य"
    PRINT_FLOAT,    // print_float %val (float bits)
    LABEL,          // label_name:
    JUMP,           // jump label_name
    JUMP_IF_ZERO,   // jump_if_zero %cond, label_name
    // Milestone 3: String operations
    STRING_CONCAT,      // %dest = str_concat(%arg1, %arg2)
    STRING_EQUAL,       // %dest = str_equal(%arg1, %arg2)
    STRING_NOT_EQUAL,   // %dest = str_not_equal(%arg1, %arg2)
    STRING_LENGTH,      // %dest = str_length(%arg1)
    STRING_UPPER,       // %dest = str_upper(%arg1)
    STRING_LOWER,       // %dest = str_lower(%arg1)
    STRING_LT,          // %dest = str_lt(%arg1, %arg2)
    STRING_GT,          // %dest = str_gt(%arg1, %arg2)
    STRING_LE,          // %dest = str_le(%arg1, %arg2)
    STRING_GE,          // %dest = str_ge(%arg1, %arg2)
    STRING_GET,         // %dest = str_get(%arg1, %arg2)
    // Milestone 3: Array operations
    ARRAY_CREATE,       // %dest = arr_create(n) + init from call_args
    ARRAY_GET,          // %dest = arr_get(%arg1, %arg2)
    ARRAY_SET,          // arr_set(%arg1, %arg2, call_args[0])
    ARRAY_LENGTH,       // %dest = arr_length(%arg1)
    // Milestone 4: Dictionary operations
    DICT_CREATE,        // %dest = dict_create()
    DICT_GET,           // %dest = dict_get(%arg1, %arg2)
    DICT_SET,           // dict_set(%arg1, %arg2, call_args[0])
    // Milestone 5: File I/O
    FILE_READ,          // %dest = file_read(%arg1)
    FILE_WRITE,         // %dest = file_write(%arg1, %arg2)
    FILE_EXISTS,        // %dest = file_exists(%arg1)
    // Milestone 6: Exception Handling
    TRY_BEGIN,          // try_begin label_name
    TRY_END,            // try_end
    CATCH_BEGIN,        // catch_begin %dest
    THROW               // throw %arg1
};

struct IRValue {
    enum class Kind { INT_LITERAL, STR_LITERAL, REGISTER, VARIABLE } kind;
    long long int_val = 0;
    std::string str_val;

    static IRValue make_int(long long v) {
        IRValue val;
        val.kind = Kind::INT_LITERAL;
        val.int_val = v;
        return val;
    }

    static IRValue make_str(std::string s) {
        IRValue val;
        val.kind = Kind::STR_LITERAL;
        val.str_val = std::move(s);
        return val;
    }

    static IRValue make_reg(std::string r) {
        IRValue val;
        val.kind = Kind::REGISTER;
        val.str_val = std::move(r);
        return val;
    }

    static IRValue make_var(std::string v) {
        IRValue val;
        val.kind = Kind::VARIABLE;
        val.str_val = std::move(v);
        return val;
    }

    std::string to_string() const {
        switch (kind) {
            case Kind::INT_LITERAL: return std::to_string(int_val);
            case Kind::STR_LITERAL: return "\"" + str_val + "\"";
            case Kind::REGISTER: return "%" + str_val;
            case Kind::VARIABLE: return "@" + str_val;
        }
        return "";
    }
};

struct IRInstruction {
    IROpcode opcode;
    std::string dest;
    IRValue arg1;
    IRValue arg2;
    std::vector<IRValue> call_args;
    std::string label;

    IRInstruction(IROpcode op) : opcode(op) {}
};

class IRFunction {
public:
    std::string name;
    std::vector<std::string> params;
    std::vector<IRInstruction> instructions;

    IRFunction(std::string n, std::vector<std::string> p)
        : name(std::move(n)), params(std::move(p)) {}
};

class IRModule {
public:
    std::string module_name;
    std::vector<std::pair<std::string, std::string>> string_literals; // id -> value
    std::vector<std::unique_ptr<IRFunction>> functions;

    IRModule(std::string name) : module_name(std::move(name)) {}

    void dump(std::ostream& os) const;
};

} // namespace compiler
} // namespace sutra

#endif // SUTRA_IR_HPP
