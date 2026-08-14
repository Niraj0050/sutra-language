#include "sutra/compiler/ir.hpp"

namespace sutra {
namespace compiler {

void IRModule::dump(std::ostream& os) const {
    os << "; Sutra IR Module: " << module_name << "\n\n";

    if (!string_literals.empty()) {
        os << "; String Constants Table:\n";
        for (const auto& kv : string_literals) {
            os << kv.first << " = \"" << kv.second << "\"\n";
        }
        os << "\n";
    }

    for (const auto& func : functions) {
        os << "function @" << func->name << "(";
        for (size_t i = 0; i < func->params.size(); ++i) {
            os << "@" << func->params[i];
            if (i + 1 < func->params.size()) os << ", ";
        }
        os << ") {\n";

        for (const auto& inst : func->instructions) {
            os << "  ";
            switch (inst.opcode) {
                case IROpcode::CONST_INT:
                    os << "%" << inst.dest << " = " << inst.arg1.int_val << "\n";
                    break;
                case IROpcode::CONST_STR:
                    os << "%" << inst.dest << " = " << inst.arg1.str_val << "\n";
                    break;
                case IROpcode::ALLOCA:
                    os << "alloca @" << inst.dest << "\n";
                    break;
                case IROpcode::LOAD:
                    os << "%" << inst.dest << " = load " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::STORE:
                    os << "store " << inst.arg1.to_string() << ", @" << inst.dest << "\n";
                    break;
                case IROpcode::ADD:
                    os << "%" << inst.dest << " = add " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::SUB:
                    os << "%" << inst.dest << " = sub " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::MUL:
                    os << "%" << inst.dest << " = mul " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::DIV:
                    os << "%" << inst.dest << " = div " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::MOD:
                    os << "%" << inst.dest << " = mod " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_EQ:
                    os << "%" << inst.dest << " = eq " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_NE:
                    os << "%" << inst.dest << " = ne " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_LT:
                    os << "%" << inst.dest << " = lt " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_GT:
                    os << "%" << inst.dest << " = gt " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_LE:
                    os << "%" << inst.dest << " = le " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::CMP_GE:
                    os << "%" << inst.dest << " = ge " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::AND_OP:
                    os << "%" << inst.dest << " = and " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::OR_OP:
                    os << "%" << inst.dest << " = or " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::NOT_OP:
                    os << "%" << inst.dest << " = not " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::CALL:
                    if (!inst.dest.empty()) os << "%" << inst.dest << " = ";
                    os << "call @" << inst.label << "(";
                    for (size_t k = 0; k < inst.call_args.size(); ++k) {
                        os << inst.call_args[k].to_string();
                        if (k + 1 < inst.call_args.size()) os << ", ";
                    }
                    os << ")\n";
                    break;
                case IROpcode::RET:
                    os << "ret " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::PRINT_INT:
                    os << "print_int " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::PRINT_STR:
                    os << "print_str " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::LABEL:
                    os << inst.label << ":\n";
                    break;
                case IROpcode::JUMP:
                    os << "jump " << inst.label << "\n";
                    break;
                case IROpcode::JUMP_IF_ZERO:
                    os << "jump_if_zero " << inst.arg1.to_string() << ", " << inst.label << "\n";
                    break;
                case IROpcode::CONST_NULL:
                    os << "%" << inst.dest << " = null\n";
                    break;
                case IROpcode::PRINT_NULL:
                    os << "print_null\n";
                    break;
                case IROpcode::PRINT_BOOL:
                    os << "print_bool " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::STRING_CONCAT:
                    os << "%" << inst.dest << " = str_concat " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_EQUAL:
                    os << "%" << inst.dest << " = str_eq " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_NOT_EQUAL:
                    os << "%" << inst.dest << " = str_ne " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_LENGTH:
                    os << "%" << inst.dest << " = str_length " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::STRING_UPPER:
                    os << "%" << inst.dest << " = str_upper " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::STRING_LOWER:
                    os << "%" << inst.dest << " = str_lower " << inst.arg1.to_string() << "\n";
                    break;
                case IROpcode::STRING_LT:
                    os << "%" << inst.dest << " = str_lt " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_GT:
                    os << "%" << inst.dest << " = str_gt " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_LE:
                    os << "%" << inst.dest << " = str_le " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_GE:
                    os << "%" << inst.dest << " = str_ge " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::STRING_GET:
                    os << "%" << inst.dest << " = str_get " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::ARRAY_CREATE:
                    os << "%" << inst.dest << " = arr_create " << inst.arg1.int_val << "\n";
                    break;
                case IROpcode::ARRAY_GET:
                    os << "%" << inst.dest << " = arr_get " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << "\n";
                    break;
                case IROpcode::ARRAY_SET:
                    os << "arr_set " << inst.arg1.to_string() << ", " << inst.arg2.to_string() << ", " << (inst.call_args.empty() ? "?" : inst.call_args[0].to_string()) << "\n";
                    break;
                case IROpcode::ARRAY_LENGTH:
                    os << "%" << inst.dest << " = arr_length " << inst.arg1.to_string() << "\n";
                    break;
            }
        }
        os << "}\n\n";
    }
}

} // namespace compiler
} // namespace sutra
