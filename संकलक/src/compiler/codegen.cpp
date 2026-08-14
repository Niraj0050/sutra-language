#include "sutra/compiler/codegen.hpp"

#include <sstream>
#include <fstream>
#include <cstdlib>
#include <algorithm>

namespace sutra {
namespace compiler {

// Helper: escape a UTF-8 string for GAS .ascii directive
// Outputs byte-by-byte, escaping non-printable ASCII and passing UTF-8 through
static std::string escape_for_gas(const std::string& s) {
    std::string result;
    for (unsigned char c : s) {
        if (c == '\\') result += "\\\\";
        else if (c == '"') result += "\\\"";
        else if (c == '\n') result += "\\n";
        else if (c == '\r') result += "\\r";
        else if (c == '\t') result += "\\t";
        else if (c >= 0x80 || (c >= 0x20 && c < 0x7f)) {
            // Printable ASCII or UTF-8 continuation/lead bytes — pass through
            result += (char)c;
        } else {
            // Non-printable ASCII — emit as octal
            char buf[8];
            snprintf(buf, sizeof(buf), "\\%03o", c);
            result += buf;
        }
    }
    return result;
}

std::string NativeCodeGenX86_64::generate_assembly(const IRModule& module) {
    std::ostringstream main_ss;

    main_ss << "  .ident \"Sutra Native Compiler 1.0\"\n";
    // Declare external C functions
    main_ss << "  .def printf; .scl 2; .type 32; .endef\n";
    main_ss << "  .def main; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_alloc; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_concat; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_equal; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_length; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_upper; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_lower; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_str_print; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_sqrt; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_pow; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_abs; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_min; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_max; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_math_round; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_list_append; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_arr_create; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_arr_get; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_arr_set; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_arr_length; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_print_null; .scl 2; .type 32; .endef\n";
    main_ss << "  .def sutra_print_bool; .scl 2; .type 32; .endef\n\n";

    // Read-only data section: format strings and string literals
    main_ss << "  .section .rdata,\"dr\"\n";
    main_ss << ".LC_fmt_int:\n";
    main_ss << "  .ascii \"%lld\\12\\0\"\n";

    for (const auto& kv : module.string_literals) {
        std::string escaped = escape_for_gas(kv.second);
        main_ss << ".LC_" << kv.first << ":\n";
        main_ss << "  .ascii \"" << escaped << "\\0\"\n";
        // Also store byte length as a separate label
        main_ss << ".LC_" << kv.first << "_len:\n";
        main_ss << "  .quad " << kv.second.size() << "\n";
    }

    main_ss << "\n  .text\n";

    for (const auto& func : module.functions) {
        m_stack_offsets.clear();
        m_current_stack_offset = 0;

        std::string fname = func->name;
        if (fname == "मुख्य") fname = "main";

        std::ostringstream ss;

        // Copy register parameters into stack positions (Windows x86-64 ABI: RCX, RDX, R8, R9)
        const char* reg_params[] = {"%rcx", "%rdx", "%r8", "%r9"};
        std::ostringstream param_ss;
        for (size_t i = 0; i < func->params.size() && i < 4; ++i) {
            int off = get_or_alloc_stack(func->params[i]);
            param_ss << "  movq " << reg_params[i] << ", " << off << "(%rbp)\n";
        }

        // Generate instructions
        for (const auto& inst : func->instructions) {
            switch (inst.opcode) {
                case IROpcode::CONST_INT: {
                    int off = get_or_alloc_stack(inst.dest);
                    ss << "  movq $" << inst.arg1.int_val << ", " << off << "(%rbp)\n";
                    break;
                }
                case IROpcode::CONST_NULL: {
                    int off = get_or_alloc_stack(inst.dest);
                    ss << "  movq $0, " << off << "(%rbp)\n";
                    break;
                }
                case IROpcode::CONST_STR: {
                    // Allocate string on heap via sutra_str_alloc(data_ptr, len)
                    int dest_off = get_or_alloc_stack(inst.dest);
                    std::string label = ".LC_" + inst.arg1.str_val;
                    std::string len_label = label + "_len";

                    // arg1 (RCX) = pointer to string data
                    ss << "  leaq " << label << "(%rip), %rcx\n";
                    // arg2 (RDX) = byte length
                    ss << "  movq " << len_label << "(%rip), %rdx\n";
                    ss << "  call sutra_str_alloc\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::ALLOCA: {
                    get_or_alloc_stack(inst.dest);
                    break;
                }
                case IROpcode::LOAD: {
                    int src_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << src_off << "(%rbp), %rax\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STORE: {
                    int dest_off = get_or_alloc_stack(inst.dest);
                    if (inst.arg1.kind == IRValue::Kind::INT_LITERAL) {
                        ss << "  movq $" << inst.arg1.int_val << ", " << dest_off << "(%rbp)\n";
                    } else {
                        int src_off = get_or_alloc_stack(inst.arg1.str_val);
                        ss << "  movq " << src_off << "(%rbp), %rax\n";
                        ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    }
                    break;
                }
                case IROpcode::ADD:
                case IROpcode::SUB:
                case IROpcode::MUL:
                case IROpcode::DIV:
                case IROpcode::MOD: {
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);

                    ss << "  movq " << left_off << "(%rbp), %rax\n";

                    if (inst.opcode == IROpcode::ADD) {
                        ss << "  addq " << right_off << "(%rbp), %rax\n";
                    } else if (inst.opcode == IROpcode::SUB) {
                        ss << "  subq " << right_off << "(%rbp), %rax\n";
                    } else if (inst.opcode == IROpcode::MUL) {
                        ss << "  imulq " << right_off << "(%rbp), %rax\n";
                    } else if (inst.opcode == IROpcode::DIV) {
                        ss << "  cqto\n";
                        ss << "  idivq " << right_off << "(%rbp)\n";
                    } else if (inst.opcode == IROpcode::MOD) {
                        ss << "  cqto\n";
                        ss << "  idivq " << right_off << "(%rbp)\n";
                        ss << "  movq %rdx, %rax\n";
                    }

                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::CMP_EQ:
                case IROpcode::CMP_NE:
                case IROpcode::CMP_LT:
                case IROpcode::CMP_GT:
                case IROpcode::CMP_LE:
                case IROpcode::CMP_GE: {
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);

                    ss << "  movq " << left_off << "(%rbp), %rax\n";
                    ss << "  cmpq " << right_off << "(%rbp), %rax\n";

                    if (inst.opcode == IROpcode::CMP_EQ) ss << "  sete %al\n";
                    else if (inst.opcode == IROpcode::CMP_NE) ss << "  setne %al\n";
                    else if (inst.opcode == IROpcode::CMP_LT) ss << "  setl %al\n";
                    else if (inst.opcode == IROpcode::CMP_GT) ss << "  setg %al\n";
                    else if (inst.opcode == IROpcode::CMP_LE) ss << "  setle %al\n";
                    else if (inst.opcode == IROpcode::CMP_GE) ss << "  setge %al\n";

                    ss << "  movzbl %al, %eax\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::AND_OP: {
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rax\n";
                    ss << "  andq " << right_off << "(%rbp), %rax\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::OR_OP: {
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rax\n";
                    ss << "  orq " << right_off << "(%rbp), %rax\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::NOT_OP: {
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << val_off << "(%rbp), %rax\n";
                    ss << "  cmpq $0, %rax\n";
                    ss << "  sete %al\n";
                    ss << "  movzbl %al, %eax\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::LABEL: {
                    ss << inst.label << ":\n";
                    break;
                }
                case IROpcode::JUMP: {
                    ss << "  jmp " << inst.label << "\n";
                    break;
                }
                case IROpcode::JUMP_IF_ZERO: {
                    if (inst.arg1.kind == IRValue::Kind::INT_LITERAL) {
                        if (inst.arg1.int_val == 0) {
                            ss << "  jmp " << inst.label << "\n";
                        }
                    } else {
                        int cond_off = get_or_alloc_stack(inst.arg1.str_val);
                        ss << "  movq " << cond_off << "(%rbp), %rax\n";
                        ss << "  cmpq $0, %rax\n";
                        ss << "  je " << inst.label << "\n";
                    }
                    break;
                }
                case IROpcode::PRINT_INT: {
                    if (inst.arg1.kind == IRValue::Kind::INT_LITERAL) {
                        ss << "  movq $" << inst.arg1.int_val << ", %rdx\n";
                    } else {
                        int val_off = get_or_alloc_stack(inst.arg1.str_val);
                        ss << "  movq " << val_off << "(%rbp), %rdx\n";
                    }
                    ss << "  leaq .LC_fmt_int(%rip), %rcx\n";
                    ss << "  call printf\n";
                    break;
                }
                case IROpcode::PRINT_STR: {
                    // Call sutra_str_print(str_ptr)
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    ss << "  call sutra_str_print\n";
                    break;
                }
                case IROpcode::PRINT_NULL: {
                    ss << "  call sutra_print_null\n";
                    break;
                }
                case IROpcode::PRINT_BOOL: {
                    if (inst.arg1.kind == IRValue::Kind::INT_LITERAL) {
                        ss << "  movq $" << inst.arg1.int_val << ", %rcx\n";
                    } else {
                        int val_off = get_or_alloc_stack(inst.arg1.str_val);
                        ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    }
                    ss << "  call sutra_print_bool\n";
                    break;
                }
                case IROpcode::STRING_CONCAT: {
                    // sutra_str_concat(a, b) -> result pointer
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rcx\n";
                    ss << "  movq " << right_off << "(%rbp), %rdx\n";
                    ss << "  call sutra_str_concat\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_EQUAL: {
                    // sutra_str_equal(a, b) -> 0 or 1
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rcx\n";
                    ss << "  movq " << right_off << "(%rbp), %rdx\n";
                    ss << "  call sutra_str_equal\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_NOT_EQUAL: {
                    // sutra_str_equal(a, b) then invert
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rcx\n";
                    ss << "  movq " << right_off << "(%rbp), %rdx\n";
                    ss << "  call sutra_str_equal\n";
                    ss << "  xorq $1, %rax\n"; // Invert: 0->1, 1->0
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_LENGTH: {
                    // sutra_str_length(s) -> int64
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    ss << "  call sutra_str_length\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_UPPER: {
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    ss << "  call sutra_str_upper\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_LOWER: {
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    ss << "  call sutra_str_lower\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_LT:
                case IROpcode::STRING_GT:
                case IROpcode::STRING_LE:
                case IROpcode::STRING_GE: {
                    int left_off = get_or_alloc_stack(inst.arg1.str_val);
                    int right_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << left_off << "(%rbp), %rcx\n";
                    ss << "  movq " << right_off << "(%rbp), %rdx\n";
                    if (inst.opcode == IROpcode::STRING_LT) ss << "  call sutra_str_less\n";
                    else if (inst.opcode == IROpcode::STRING_GT) ss << "  call sutra_str_greater\n";
                    else if (inst.opcode == IROpcode::STRING_LE) ss << "  call sutra_str_less_equal\n";
                    else ss << "  call sutra_str_greater_equal\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::STRING_GET: {
                    // sutra_str_get(s, idx) -> char string pointer
                    int val_off = get_or_alloc_stack(inst.arg1.str_val);
                    int idx_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << val_off << "(%rbp), %rcx\n";
                    ss << "  movq " << idx_off << "(%rbp), %rdx\n";
                    ss << "  call sutra_str_get\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::ARRAY_CREATE: {
                    // sutra_arr_create(n) -> array pointer
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq $" << inst.arg1.int_val << ", %rcx\n";
                    ss << "  call sutra_arr_create\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::ARRAY_GET: {
                    // sutra_arr_get(arr, idx) -> value
                    int arr_off = get_or_alloc_stack(inst.arg1.str_val);
                    int idx_off = get_or_alloc_stack(inst.arg2.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << arr_off << "(%rbp), %rcx\n";
                    ss << "  movq " << idx_off << "(%rbp), %rdx\n";
                    ss << "  call sutra_arr_get\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::ARRAY_SET: {
                    // sutra_arr_set(arr, idx, val)
                    int arr_off = get_or_alloc_stack(inst.arg1.str_val);
                    int idx_off = get_or_alloc_stack(inst.arg2.str_val);
                    ss << "  movq " << arr_off << "(%rbp), %rcx\n";
                    ss << "  movq " << idx_off << "(%rbp), %rdx\n";
                    if (!inst.call_args.empty()) {
                        if (inst.call_args[0].kind == IRValue::Kind::INT_LITERAL) {
                            ss << "  movq $" << inst.call_args[0].int_val << ", %r8\n";
                        } else {
                            int val_off = get_or_alloc_stack(inst.call_args[0].str_val);
                            ss << "  movq " << val_off << "(%rbp), %r8\n";
                        }
                    }
                    ss << "  call sutra_arr_set\n";
                    break;
                }
                case IROpcode::ARRAY_LENGTH: {
                    // sutra_arr_length(arr) -> int64
                    int arr_off = get_or_alloc_stack(inst.arg1.str_val);
                    int dest_off = get_or_alloc_stack(inst.dest);
                    ss << "  movq " << arr_off << "(%rbp), %rcx\n";
                    ss << "  call sutra_arr_length\n";
                    ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    break;
                }
                case IROpcode::CALL: {
                    const char* arg_regs[] = {"%rcx", "%rdx", "%r8", "%r9"};
                    for (size_t i = 0; i < inst.call_args.size() && i < 4; ++i) {
                        if (inst.call_args[i].kind == IRValue::Kind::INT_LITERAL) {
                            ss << "  movq $" << inst.call_args[i].int_val << ", " << arg_regs[i] << "\n";
                        } else {
                            int off = get_or_alloc_stack(inst.call_args[i].str_val);
                            ss << "  movq " << off << "(%rbp), " << arg_regs[i] << "\n";
                        }
                    }
                    ss << "  call " << inst.label << "\n";
                    if (!inst.dest.empty()) {
                        int dest_off = get_or_alloc_stack(inst.dest);
                        ss << "  movq %rax, " << dest_off << "(%rbp)\n";
                    }
                    break;
                }
                case IROpcode::RET: {
                    if (inst.arg1.kind == IRValue::Kind::INT_LITERAL) {
                        ss << "  movq $" << inst.arg1.int_val << ", %rax\n";
                    } else if (!inst.arg1.str_val.empty()) {
                        int off = get_or_alloc_stack(inst.arg1.str_val);
                        ss << "  movq " << off << "(%rbp), %rax\n";
                    } else {
                        ss << "  movq $0, %rax\n";
                    }
                    // Epilogue
                    ss << "  movq %rbp, %rsp\n";
                    ss << "  popq %rbp\n";
                    ss << "  ret\n";
                    break;
                }
                default: break;
            }
        }

        // Function Epilogue fallback
        ss << "  movq %rbp, %rsp\n";
        ss << "  popq %rbp\n";
        ss << "  ret\n\n";

        // Calculate actual frame size dynamically
        int frame_size = -m_current_stack_offset;
        frame_size = (frame_size + 15) & ~15; // 16-byte alignment
        if (frame_size < 32) frame_size = 32; // Shadow space

        // Output function header, prologue, parameter copy, and body to main_ss
        main_ss << "  .globl " << fname << "\n";
        main_ss << "  .def " << fname << "; .scl 2; .type 32; .endef\n";
        main_ss << fname << ":\n";
        main_ss << "  pushq %rbp\n";
        main_ss << "  movq %rsp, %rbp\n";
        main_ss << "  subq $" << frame_size << ", %rsp\n";

        main_ss << param_ss.str();
        main_ss << ss.str();
    }

    return main_ss.str();
}

bool NativeCodeGenX86_64::compile_to_binary(const IRModule& module, const std::string& output_exe_path) {
    std::string s_file = output_exe_path + ".s";
    std::string asm_code = generate_assembly(module);

    std::ofstream out(s_file);
    if (!out.is_open()) return false;
    out << asm_code;
    out.close();

    // Determine runtime .c file path (relative to the sutra.exe location)
    // The runtime source is at: संकलक/src/compiler/sutra_runtime.c
    // We compile it alongside the assembly
    std::string runtime_c = "";
    std::string runtime_o = output_exe_path + "_rt.o";

    // Try to find sutra_runtime.c relative to the executable
    // Check several possible locations
    const char* runtime_paths[] = {
        "sutra_runtime.c",
        "संकलक\\src\\compiler\\sutra_runtime.c",
        "..\\संकलक\\src\\compiler\\sutra_runtime.c"
    };

    for (const auto& rpath : runtime_paths) {
        std::ifstream test(rpath);
        if (test.good()) {
            runtime_c = rpath;
            test.close();
            break;
        }
    }

    if (runtime_c.empty()) {
        // Last resort: inline the runtime path
        runtime_c = "संकलक\\src\\compiler\\sutra_runtime.c";
    }

    // Step 1: Compile the C runtime to .o
    std::string cmd_rt = "C:\\msys64\\ucrt64\\bin\\gcc.exe -m64 -c \"" + runtime_c + "\" -o \"" + runtime_o + "\"";
    int res = system(cmd_rt.c_str());
    if (res != 0) {
        cmd_rt = "gcc -m64 -c \"" + runtime_c + "\" -o \"" + runtime_o + "\"";
        res = system(cmd_rt.c_str());
    }
    if (res != 0) return false;

    // Step 2: Link assembly + runtime .o -> executable
    std::string cmd = "C:\\msys64\\ucrt64\\bin\\gcc.exe -m64 \"" + s_file + "\" \"" + runtime_o + "\" -o \"" + output_exe_path + "\"";
    res = system(cmd.c_str());
    if (res != 0) {
        cmd = "gcc -m64 \"" + s_file + "\" \"" + runtime_o + "\" -o \"" + output_exe_path + "\"";
        res = system(cmd.c_str());
    }
    
    // Clean up temporary files
    remove(s_file.c_str());
    remove(runtime_o.c_str());
    
    return (res == 0);
}

} // namespace compiler
} // namespace sutra
