  .ident "Sutra Native Backend 1.0"

  .def sutra_init_args; .scl 2; .type 32; .endef
  .def sutra_print_dynamic; .scl 2; .type 32; .endef
  .def sutra_gc_push_root; .scl 2; .type 32; .endef
  .def sutra_gc_pop_root; .scl 2; .type 32; .endef
  .def sutra_gc_collect; .scl 2; .type 32; .endef
  .def sutra_str_alloc; .scl 2; .type 32; .endef
  .def sutra_str_print; .scl 2; .type 32; .endef
  .def sutra_str_compare; .scl 2; .type 32; .endef
  .def sutra_str_equal; .scl 2; .type 32; .endef
  .def sutra_str_concat; .scl 2; .type 32; .endef
  .def sutra_str_less; .scl 2; .type 32; .endef
  .def sutra_str_greater; .scl 2; .type 32; .endef
  .def sutra_str_less_equal; .scl 2; .type 32; .endef
  .def sutra_str_greater_equal; .scl 2; .type 32; .endef
  .def sutra_print_bool; .scl 2; .type 32; .endef
  .def sutra_print_float; .scl 2; .type 32; .endef
  .def sutra_print_null; .scl 2; .type 32; .endef
  .def sutra_int_to_float; .scl 2; .type 32; .endef
  .def sutra_float_add; .scl 2; .type 32; .endef
  .def sutra_float_sub; .scl 2; .type 32; .endef
  .def sutra_float_mul; .scl 2; .type 32; .endef
  .def sutra_float_div; .scl 2; .type 32; .endef
  .def sutra_float_eq; .scl 2; .type 32; .endef
  .def sutra_float_ne; .scl 2; .type 32; .endef
  .def sutra_float_lt; .scl 2; .type 32; .endef
  .def sutra_float_gt; .scl 2; .type 32; .endef
  .def sutra_float_le; .scl 2; .type 32; .endef
  .def sutra_float_ge; .scl 2; .type 32; .endef
  .def sutra_throw_div_by_zero; .scl 2; .type 32; .endef
  .def sutra_exception_get_jmp_buf; .scl 2; .type 32; .endef
  .def sutra_exception_pop; .scl 2; .type 32; .endef
  .def sutra_get_exception_value; .scl 2; .type 32; .endef
  .def sutra_throw; .scl 2; .type 32; .endef
  .def _setjmp; .scl 2; .type 32; .endef
  .def sutra_int_to_str; .scl 2; .type 32; .endef
  .def sutra_bool_to_str; .scl 2; .type 32; .endef
  .def sutra_null_to_str; .scl 2; .type 32; .endef
  .def sutra_float_to_str; .scl 2; .type 32; .endef
  .def sutra_arr_get; .scl 2; .type 32; .endef
  .def sutra_arr_set; .scl 2; .type 32; .endef
  .def sutra_obj_alloc; .scl 2; .type 32; .endef

  .section .rdata, "dr"

  .text
  .globl अक्षर_कोडबिंदु
  .def अक्षर_कोडबिंदु; .scl 2; .type 32; .endef
अक्षर_कोडबिंदु:
  pushq %rbp
  movq %rsp, %rbp
  subq $112, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq $0, -48(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root
  leaq -40(%rbp), %rcx
  call sutra_gc_push_root
  leaq -48(%rbp), %rcx
  call sutra_gc_push_root
  leaq -56(%rbp), %rcx
  call sutra_gc_push_root
  leaq -64(%rbp), %rcx
  call sutra_gc_push_root
  leaq -72(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_2
  movq $1, %rax
  negq %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_2:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_4
  movq $1, %rax
  negq %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_4:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $128, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_6
  movq -24(%rbp), %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_6:
  movq -24(%rbp), %rax
  pushq %rax
  movq $192, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_8
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $192, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_1
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_1
.L_div_zero_1:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_1:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_8:
  movq -24(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $3, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_10
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $18, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_2
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_2
.L_div_zero_2:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_2:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_3
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_3
.L_div_zero_3:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_3:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_10:
  movq -24(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $248, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $4, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_12
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $18, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $19, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -72(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $262144, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_4
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_4
.L_div_zero_4:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_4:
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_5
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_5
.L_div_zero_5:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_5:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -72(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_6
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_6
.L_div_zero_6:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_6:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_sutra_if_end_12:
  movq $65533, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_epilogue_अक्षर_कोडबिंदु:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -72(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -64(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -56(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -48(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -40(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -32(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -24(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_गणना
  .def पाठ_कोडबिंदु_गणना; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_गणना:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root
  leaq -40(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_14
  movq $0, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_गणना
.L_sutra_if_end_14:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -16(%rbp)
  movq $0, %rax
  movq %rax, -24(%rbp)
  movq $0, %rax
  movq %rax, -32(%rbp)
.L_sutra_while_cond_15:
  movq -24(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_16
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -40(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $128, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_17
  movq -24(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_if_end_18
.L_sutra_if_else_17:
  movq -40(%rbp), %rax
  pushq %rax
  movq $192, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_19
  movq -24(%rbp), %rax
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_if_end_20
.L_sutra_if_else_19:
  movq -40(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_21
  movq -24(%rbp), %rax
  pushq %rax
  movq $3, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_if_end_22
.L_sutra_if_else_21:
  movq -40(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $248, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_23
  movq -24(%rbp), %rax
  pushq %rax
  movq $4, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_if_end_24
.L_sutra_if_else_23:
  movq -24(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
.L_sutra_if_end_24:
.L_sutra_if_end_22:
.L_sutra_if_end_20:
.L_sutra_if_end_18:
  movq -32(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -32(%rbp)
  jmp .L_sutra_while_cond_15
.L_sutra_while_end_16:
  movq -32(%rbp), %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_गणना
.L_epilogue_पाठ_कोडबिंदु_गणना:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -40(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -32(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -24(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_तुल्य
  .def पाठ_तुल्य; .scl 2; .type 32; .endef
पाठ_तुल्य:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root
  leaq -40(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_26
  movq $1, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_26:
  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  orq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_28
  movq $0, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_28:
  movq -8(%rbp), %rax
  pushq %rax
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  orq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_30
  movq $0, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_30:
  movq -8(%rbp), %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq (%rsp), %rsp
  cmpq $0, %rax
  sete %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq (%rsp), %rsp
  cmpq $0, %rax
  sete %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  orq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_32
  movq $0, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_32:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_34
  movq $0, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_34:
  movq $0, %rax
  movq %rax, -40(%rbp)
.L_sutra_while_cond_35:
  movq -40(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_36
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_38
  movq $0, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_sutra_if_end_38:
  movq -40(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -40(%rbp)
  jmp .L_sutra_while_cond_35
.L_sutra_while_end_36:
  movq $1, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_epilogue_पाठ_तुल्य:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -40(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -32(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -24(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सञ्चय_गणना
  .def सञ्चय_गणना; .scl 2; .type 32; .endef
सञ्चय_गणना:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_40
  movq $0, %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_sutra_if_end_40:
  movq -8(%rbp), %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_is_dict
  addq $32, %rsp
  movq (%rsp), %rsp
  cmpq $0, %rax
  je .L_sutra_if_end_42
  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_sutra_if_end_42:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_epilogue_सञ्चय_गणना:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl दैशिक_लंबाई
  .def दैशिक_लंबाई; .scl 2; .type 32; .endef
दैशिक_लंबाई:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_44
  movq $0, %rax
  jmp .L_epilogue_दैशिक_लंबाई
.L_sutra_if_end_44:
  movq -8(%rbp), %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq (%rsp), %rsp
  cmpq $0, %rax
  je .L_sutra_if_end_46
  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_कोडबिंदु_गणना
  addq $48, %rsp
  jmp .L_epilogue_दैशिक_लंबाई
.L_sutra_if_end_46:
  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सञ्चय_गणना
  addq $48, %rsp
  jmp .L_epilogue_दैशिक_लंबाई
.L_epilogue_दैशिक_लंबाई:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl अक्षर_बाइट_चौड़ाई
  .def अक्षर_बाइट_चौड़ाई; .scl 2; .type 32; .endef
अक्षर_बाइट_चौड़ाई:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $128, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_48
  movq $1, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_sutra_if_end_48:
  movq -8(%rbp), %rax
  pushq %rax
  movq $192, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_50
  movq $2, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_sutra_if_end_50:
  movq -8(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_52
  movq $3, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_sutra_if_end_52:
  movq -8(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $248, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_54
  movq $4, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_sutra_if_end_54:
  movq $1, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_epilogue_अक्षर_बाइट_चौड़ाई:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोडबिंदु_मान
  .def कोडबिंदु_मान; .scl 2; .type 32; .endef
कोडबिंदु_मान:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  movq %r8, -24(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_56
  movq -32(%rbp), %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_sutra_if_end_56:
  movq -24(%rbp), %rax
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_58
  movq -32(%rbp), %rax
  pushq %rax
  movq $192, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_7
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_7
.L_div_zero_7:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_7:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_sutra_if_end_58:
  movq -24(%rbp), %rax
  pushq %rax
  movq $3, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_60
  movq -32(%rbp), %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_8
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_8
.L_div_zero_8:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_8:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_9
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_9
.L_div_zero_9:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_9:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_sutra_if_end_60:
  movq -32(%rbp), %rax
  pushq %rax
  movq $240, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  movq $262144, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_10
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_10
.L_div_zero_10:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_10:
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_11
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_11
.L_div_zero_11:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_11:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $19, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_12
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_12
.L_div_zero_12:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_12:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_epilogue_कोडबिंदु_मान:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -32(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -24(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_तुलना
  .def पाठ_कोडबिंदु_तुलना; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_तुलना:
  pushq %rbp
  movq %rsp, %rbp
  subq $112, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq $0, -48(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movq $0, -80(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root
  leaq -40(%rbp), %rcx
  call sutra_gc_push_root
  leaq -48(%rbp), %rcx
  call sutra_gc_push_root
  leaq -56(%rbp), %rcx
  call sutra_gc_push_root
  leaq -64(%rbp), %rcx
  call sutra_gc_push_root
  leaq -72(%rbp), %rcx
  call sutra_gc_push_root
  leaq -80(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_62
  movq $0, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_62:
  movq -8(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_64
  movq $1, %rax
  negq %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_64:
  movq -16(%rbp), %rax
  pushq %rax
  xorq %rax, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_66
  movq $1, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_66:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq $0, %rax
  movq %rax, -40(%rbp)
  movq $0, %rax
  movq %rax, -48(%rbp)
.L_sutra_while_cond_67:
  movq -40(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_68
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अक्षर_बाइट_चौड़ाई
  addq $48, %rsp
  movq %rax, -56(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq -56(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_70
  movq $1, %rax
  movq %rax, -56(%rbp)
.L_sutra_if_end_70:
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अक्षर_बाइट_चौड़ाई
  addq $48, %rsp
  movq %rax, -64(%rbp)
  movq -48(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_72
  movq $1, %rax
  movq %rax, -64(%rbp)
.L_sutra_if_end_72:
  movq -8(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq -56(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 56(%rsp), %rcx
  movq 48(%rsp), %rdx
  movq 40(%rsp), %r8
  call कोडबिंदु_मान
  addq $64, %rsp
  movq %rax, -72(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 56(%rsp), %rcx
  movq 48(%rsp), %rdx
  movq 40(%rsp), %r8
  call कोडबिंदु_मान
  addq $64, %rsp
  movq %rax, -80(%rbp)
  movq -72(%rbp), %rax
  pushq %rax
  movq -80(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_74
  movq -72(%rbp), %rax
  pushq %rax
  movq -80(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_76
  movq $1, %rax
  negq %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_76:
  movq $1, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_74:
  movq -40(%rbp), %rax
  pushq %rax
  movq -56(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -40(%rbp)
  movq -48(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_67
.L_sutra_while_end_68:
  movq -40(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_78
  movq $0, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_78:
  movq -40(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_80
  movq $1, %rax
  negq %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_sutra_if_end_80:
  movq $1, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_epilogue_पाठ_कोडबिंदु_तुलना:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -80(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -72(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -64(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -56(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -48(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -40(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -32(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -24(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_न्यून
  .def पाठ_न्यून; .scl 2; .type 32; .endef
पाठ_न्यून:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call पाठ_कोडबिंदु_तुलना
  addq $48, %rsp
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_82
  movq $1, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_sutra_if_end_82:
  movq $0, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_epilogue_पाठ_न्यून:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अधिक
  .def पाठ_अधिक; .scl 2; .type 32; .endef
पाठ_अधिक:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call पाठ_कोडबिंदु_तुलना
  addq $48, %rsp
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_84
  movq $1, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_sutra_if_end_84:
  movq $0, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_epilogue_पाठ_अधिक:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_न्यून_सम
  .def पाठ_न्यून_सम; .scl 2; .type 32; .endef
पाठ_न्यून_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call पाठ_कोडबिंदु_तुलना
  addq $48, %rsp
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_86
  movq $1, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_sutra_if_end_86:
  movq $0, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_epilogue_पाठ_न्यून_सम:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अधिक_सम
  .def पाठ_अधिक_सम; .scl 2; .type 32; .endef
पाठ_अधिक_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call पाठ_कोडबिंदु_तुलना
  addq $48, %rsp
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_88
  movq $1, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_sutra_if_end_88:
  movq $0, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_epilogue_पाठ_अधिक_सम:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -16(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -8(%rbp), %rcx
  call sutra_gc_pop_root
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

