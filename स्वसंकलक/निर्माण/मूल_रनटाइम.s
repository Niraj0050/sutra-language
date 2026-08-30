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
.LC_str_0:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\205\340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\256\340\244\276\340\244\250 (Index cannot be negative)\0"
.LC_str_0_len:
  .quad 103
.LC_str_1:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\252\340\244\276\340\244\240\340\244\270\340\245\215\340\244\257 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\205\340\244\244\340\244\277\340\244\225\340\245\215\340\244\260\340\244\276\340\244\250\340\245\215\340\244\244\340\244\276 (String index out of bounds)\0"
.LC_str_1_len:
  .quad 120
.LC_str_2:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\206\340\244\260\340\244\202\340\244\255\340\244\203 \340\244\205\340\244\250\340\245\215\340\244\244\340\245\215\340\244\257\340\244\244\340\244\203 \340\244\205\340\244\247\340\244\277\340\244\225\340\244\203 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277 (start > end)\0"
.LC_str_2_len:
  .quad 112

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

  .text
  .globl पाठ_आवंटित
  .def पाठ_आवंटित; .scl 2; .type 32; .endef
पाठ_आवंटित:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_90
  movq $4, %rax
  movq %rax, -16(%rbp)
.L_sutra_if_end_90:
  movq $16, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq $1, %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call सूत्र_आवंटन
  addq $48, %rsp
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  pushq %rax
  movq -8(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -8(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  jmp .L_epilogue_पाठ_आवंटित
.L_epilogue_पाठ_आवंटित:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl खंड_प्रतिलिपि
  .def खंड_प्रतिलिपि; .scl 2; .type 32; .endef
खंड_प्रतिलिपि:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq $0, -48(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  movq %r8, -24(%rbp)
  movq %r9, -32(%rbp)
  movq 48(%rbp), %rax
  movq %rax, -40(%rbp)
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

  movq $0, %rax
  movq %rax, -48(%rbp)
.L_sutra_while_cond_91:
  movq -48(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_92
  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_91
.L_sutra_while_end_92:
.L_sutra_while_cond_93:
  movq -48(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_94
  movq -8(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_93
.L_sutra_while_end_94:
  movq $0, %rax
  jmp .L_epilogue_खंड_प्रतिलिपि
.L_epilogue_खंड_प्रतिलिपि:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl पाठ_प्रति
  .def पाठ_प्रति; .scl 2; .type 32; .endef
पाठ_प्रति:
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

  movq -24(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -32(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 72(%rsp), %rcx
  movq 64(%rsp), %rdx
  movq 56(%rsp), %r8
  movq 48(%rsp), %r9
  movq 40(%rsp), %rax
  movq %rax, 32(%rsp)
  call खंड_प्रतिलिपि
  addq $80, %rsp
  movq -32(%rbp), %rax
  jmp .L_epilogue_पाठ_प्रति
.L_epilogue_पाठ_प्रति:
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
  .globl पाठ_जोड़
  .def पाठ_जोड़; .scl 2; .type 32; .endef
पाठ_जोड़:
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
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  andq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_96
  movq $0, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  jmp .L_epilogue_पाठ_जोड़
.L_sutra_if_end_96:
  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_98
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 56(%rsp), %rcx
  movq 48(%rsp), %rdx
  movq 40(%rsp), %r8
  call पाठ_प्रति
  addq $64, %rsp
  jmp .L_epilogue_पाठ_जोड़
.L_sutra_if_end_98:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_100
  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 56(%rsp), %rcx
  movq 48(%rsp), %rdx
  movq 40(%rsp), %r8
  call पाठ_प्रति
  addq $64, %rsp
  jmp .L_epilogue_पाठ_जोड़
.L_sutra_if_end_100:
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
  addq %rdx, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -40(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 72(%rsp), %rcx
  movq 64(%rsp), %rdx
  movq 56(%rsp), %r8
  movq 48(%rsp), %r9
  movq 40(%rsp), %rax
  movq %rax, 32(%rsp)
  call खंड_प्रतिलिपि
  addq $80, %rsp
  movq -40(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 72(%rsp), %rcx
  movq 64(%rsp), %rdx
  movq 56(%rsp), %r8
  movq 48(%rsp), %r9
  movq 40(%rsp), %rax
  movq %rax, 32(%rsp)
  call खंड_प्रतिलिपि
  addq $80, %rsp
  movq -40(%rbp), %rax
  jmp .L_epilogue_पाठ_जोड़
.L_epilogue_पाठ_जोड़:
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
  .globl अंक_गणना
  .def अंक_गणना; .scl 2; .type 32; .endef
अंक_गणना:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_102
  movq $1, %rax
  jmp .L_epilogue_अंक_गणना
.L_sutra_if_end_102:
  movq $0, %rax
  movq %rax, -16(%rbp)
  movq -8(%rbp), %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_104
  movq $1, %rax
  movq %rax, -16(%rbp)
  movq $0, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -24(%rbp)
.L_sutra_if_end_104:
.L_sutra_while_cond_105:
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_106
  movq -16(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -16(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $10, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_13
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_13
.L_div_zero_13:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_13:
  movq %rax, -24(%rbp)
  jmp .L_sutra_while_cond_105
.L_sutra_while_end_106:
  movq -16(%rbp), %rax
  jmp .L_epilogue_अंक_गणना
.L_epilogue_अंक_गणना:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl संख्या_से_पाठ
  .def संख्या_से_पाठ; .scl 2; .type 32; .endef
संख्या_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq $0, -48(%rbp)
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
  je .L_sutra_if_end_108
  movq -8(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_sutra_if_end_108:
  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अंक_गणना
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -24(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_110
  movq -24(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $48, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_sutra_if_end_110:
  movq -8(%rbp), %rax
  movq %rax, -32(%rbp)
  movq $0, %rax
  movq %rax, -40(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_112
  movq $1, %rax
  movq %rax, -40(%rbp)
  movq $0, %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -32(%rbp)
.L_sutra_if_end_112:
  movq -16(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -48(%rbp)
.L_sutra_while_cond_113:
  movq -32(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_114
  movq -24(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq $48, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $10, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_14
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_14
.L_div_zero_14:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_14:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $10, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_15
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_15
.L_div_zero_15:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_15:
  movq %rax, -32(%rbp)
  movq -48(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_113
.L_sutra_while_end_114:
  movq -40(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_116
  movq -24(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $45, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
.L_sutra_if_end_116:
  movq -24(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_epilogue_संख्या_से_पाठ:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl बूल_से_पाठ
  .def बूल_से_पाठ; .scl 2; .type 32; .endef
बूल_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_118
  movq $12, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $184, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $19, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $20, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $21, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $22, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $23, %rax
  pushq %rax
  movq $165, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $24, %rax
  pushq %rax
  movq $141, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $25, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $26, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $27, %rax
  pushq %rax
  movq $175, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_बूल_से_पाठ
.L_sutra_if_end_118:
  movq $15, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $133, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $19, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $20, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $21, %rax
  pushq %rax
  movq $184, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $22, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $23, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $24, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $25, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $26, %rax
  pushq %rax
  movq $165, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $27, %rax
  pushq %rax
  movq $141, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $28, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $29, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $30, %rax
  pushq %rax
  movq $175, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_बूल_से_पाठ
.L_epilogue_बूल_से_पाठ:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl शून्य_से_पाठ
  .def शून्य_से_पाठ; .scl 2; .type 32; .endef
शून्य_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq $21, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -8(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $182, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $19, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $20, %rax
  pushq %rax
  movq $165, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $21, %rax
  pushq %rax
  movq $130, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $22, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $23, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $24, %rax
  pushq %rax
  movq $168, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $25, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $26, %rax
  pushq %rax
  movq $165, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $27, %rax
  pushq %rax
  movq $141, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $28, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $29, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $30, %rax
  pushq %rax
  movq $175, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $31, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $32, %rax
  pushq %rax
  movq $164, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $33, %rax
  pushq %rax
  movq $174, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $34, %rax
  pushq %rax
  movq $224, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $35, %rax
  pushq %rax
  movq $165, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $36, %rax
  pushq %rax
  movq $141, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -8(%rbp), %rax
  jmp .L_epilogue_शून्य_से_पाठ
.L_epilogue_शून्य_से_पाठ:
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
  .globl अक्षर_बना
  .def अक्षर_बना; .scl 2; .type 32; .endef
अक्षर_बना:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq $0, -40(%rbp)
  movq $0, -48(%rbp)
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

  movq -8(%rbp), %rax
  pushq %rax
  movq $128, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_120
  movq $1, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -8(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_अक्षर_बना
.L_sutra_if_end_120:
  movq -8(%rbp), %rax
  pushq %rax
  movq $2048, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_122
  movq $2, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $192, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_16
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_16
.L_div_zero_16:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_16:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_17
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_17
.L_div_zero_17:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_17:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_अक्षर_बना
.L_sutra_if_end_122:
  movq -8(%rbp), %rax
  pushq %rax
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_124
  movq $3, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $224, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_18
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_18
.L_div_zero_18:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_18:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_19
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_19
.L_div_zero_19:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_19:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_20
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_20
.L_div_zero_20:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_20:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_21
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_21
.L_div_zero_21:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_21:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_अक्षर_बना
.L_sutra_if_end_124:
  movq -8(%rbp), %rax
  pushq %rax
  movq $1114111, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_126
  movq $4, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $240, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $262144, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_22
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_22
.L_div_zero_22:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_22:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_23
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_23
.L_div_zero_23:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_23:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_24
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_24
.L_div_zero_24:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_24:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_25
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_25
.L_div_zero_25:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_25:
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_26
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_26
.L_div_zero_26:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_26:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $19, %rax
  pushq %rax
  movq $128, %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_27
  movq %rdx, %r8
  cqto
  idivq %r8
  movq %rdx, %rax
  jmp .L_div_end_27
.L_div_zero_27:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_27:
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_अक्षर_बना
.L_sutra_if_end_126:
  movq $3, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq $239, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $17, %rax
  pushq %rax
  movq $191, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $18, %rax
  pushq %rax
  movq $189, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  jmp .L_epilogue_अक्षर_बना
.L_epilogue_अक्षर_बना:
  subq $48, %rsp
  movq %rax, 32(%rsp)
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
  .globl पाठ_उपखंड
  .def पाठ_उपखंड; .scl 2; .type 32; .endef
पाठ_उपखंड:
  pushq %rbp
  movq %rsp, %rbp
  subq $128, %rsp

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
  movq $0, -88(%rbp)
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
  leaq -88(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_128
  movq $0, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  jmp .L_epilogue_पाठ_उपखंड
.L_sutra_if_end_128:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
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
  je .L_sutra_if_end_130
  leaq .LC_str_0(%rip), %rcx
  movq .LC_str_0_len(%rip), %rdx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
  movq (%rsp), %rsp
.L_sutra_if_end_130:
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_कोडबिंदु_गणना
  addq $48, %rsp
  movq %rax, -40(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  movq %rax, %rdx
  popq %rax
  orq %rdx, %rax
  cmpq $0, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_132
  leaq .LC_str_1(%rip), %rcx
  movq .LC_str_1_len(%rip), %rdx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
  movq (%rsp), %rsp
.L_sutra_if_end_132:
  movq -16(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_134
  leaq .LC_str_2(%rip), %rcx
  movq .LC_str_2_len(%rip), %rdx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
  movq (%rsp), %rsp
.L_sutra_if_end_134:
  movq -16(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_136
  movq $0, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call पाठ_आवंटित
  addq $48, %rsp
  jmp .L_epilogue_पाठ_उपखंड
.L_sutra_if_end_136:
  movq $0, %rax
  movq %rax, -48(%rbp)
  movq -32(%rbp), %rax
  movq %rax, -56(%rbp)
  movq $0, %rax
  movq %rax, -64(%rbp)
  movq $0, %rax
  movq %rax, -72(%rbp)
.L_sutra_while_cond_137:
  movq -72(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_138
  movq -72(%rbp), %rax
  movq %rax, -80(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -72(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, -88(%rbp)
  movq -72(%rbp), %rax
  pushq %rax
  movq -88(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अक्षर_बाइट_चौड़ाई
  addq $48, %rsp
  movq %rax, %rdx
  popq %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_add_dynamic
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, -72(%rbp)
  movq -64(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_140
  movq -80(%rbp), %rax
  movq %rax, -48(%rbp)
.L_sutra_if_end_140:
  movq -64(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_142
  movq -80(%rbp), %rax
  movq %rax, -56(%rbp)
  jmp .L_sutra_while_end_138
.L_sutra_if_end_142:
  movq -64(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -64(%rbp)
  jmp .L_sutra_while_cond_137
.L_sutra_while_end_138:
  movq -24(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_144
  movq -32(%rbp), %rax
  movq %rax, -56(%rbp)
.L_sutra_if_end_144:
  movq -8(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq -56(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  pushq %rax
  subq $40, %rsp
  movq 56(%rsp), %rcx
  movq 48(%rsp), %rdx
  movq 40(%rsp), %r8
  call पाठ_प्रति
  addq $64, %rsp
  jmp .L_epilogue_पाठ_उपखंड
.L_epilogue_पाठ_उपखंड:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -88(%rbp), %rcx
  call sutra_gc_pop_root
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

