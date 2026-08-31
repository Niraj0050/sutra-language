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

  .data
  .globl sutra_glob_अखंड_प्रथम
sutra_glob_अखंड_प्रथम:
  .quad 0
  .globl sutra_glob_अखंड_वर्तमान
sutra_glob_अखंड_वर्तमान:
  .quad 0
  .globl sutra_glob_मुक्त_तालिका
sutra_glob_मुक्त_तालिका:
  .quad 0
  .globl sutra_glob_गण_चक्र
sutra_glob_गण_चक्र:
  .quad 0
  .globl sutra_glob_गण_सक्रिय
sutra_glob_गण_सक्रिय:
  .quad 0
  .globl sutra_glob_गण_संग्रहित
sutra_glob_गण_संग्रहित:
  .quad 0
  .globl sutra_glob_गण_पुनःप्राप्त
sutra_glob_गण_पुनःप्राप्त:
  .quad 0
  .globl sutra_glob_आवंटित_बाइट्स
sutra_glob_आवंटित_बाइट्स:
  .quad 0
  .globl sutra_glob_जीसी_सीमा
sutra_glob_जीसी_सीमा:
  .quad 0
  .globl sutra_glob_जीसी_चालू
sutra_glob_जीसी_चालू:
  .quad 0
  .globl sutra_glob_ऑटो_सक्षम
sutra_glob_ऑटो_सक्षम:
  .quad 0
  .globl sutra_glob_जीसी_दबाव
sutra_glob_जीसी_दबाव:
  .quad 0

  .section .rdata, "dr"

  .text
  .globl श्रेणी_का
  .def श्रेणी_का; .scl 2; .type 32; .endef
श्रेणी_का:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $4096, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_2
  movq $0, %rax
  jmp .L_epilogue_श्रेणी_का
.L_sutra_if_end_2:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_1
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_1
.L_div_zero_1:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_1:
  jmp .L_epilogue_श्रेणी_का
.L_epilogue_श्रेणी_का:
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
  .globl मुक्त_तालिका_तैयार
  .def मुक्त_तालिका_तैयार; .scl 2; .type 32; .endef
मुक्त_तालिका_तैयार:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_4
  movq $2056, %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, sutra_glob_मुक्त_तालिका(%rip)
.L_sutra_if_end_4:
  movq $0, %rax
  jmp .L_epilogue_मुक्त_तालिका_तैयार
.L_epilogue_मुक्त_तालिका_तैयार:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_स्वजीसी_आरंभ
  .def सूत्र_स्वजीसी_आरंभ; .scl 2; .type 32; .endef
सूत्र_स्वजीसी_आरंभ:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq $0, %rax
  movq %rax, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $0, %rax
  movq %rax, sutra_glob_जीसी_चालू(%rip)
  movq $0, %rax
  movq %rax, sutra_glob_जीसी_दबाव(%rip)
  movq $128, %rax
  pushq %rax
  movq $1048576, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, sutra_glob_जीसी_सीमा(%rip)
  movq $1, %rax
  movq %rax, sutra_glob_ऑटो_सक्षम(%rip)
  movq $0, %rax
  jmp .L_epilogue_सूत्र_स्वजीसी_आरंभ
.L_epilogue_सूत्र_स्वजीसी_आरंभ:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_जीसी_दबाओ
  .def सूत्र_जीसी_दबाओ; .scl 2; .type 32; .endef
सूत्र_जीसी_दबाओ:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_जीसी_दबाव(%rip), %rax
  pushq %rax
  movq $1, %rax
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
  movq %rax, sutra_glob_जीसी_दबाव(%rip)
  movq $0, %rax
  jmp .L_epilogue_सूत्र_जीसी_दबाओ
.L_epilogue_सूत्र_जीसी_दबाओ:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_जीसी_छोड़ो
  .def सूत्र_जीसी_छोड़ो; .scl 2; .type 32; .endef
सूत्र_जीसी_छोड़ो:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_जीसी_दबाव(%rip), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, sutra_glob_जीसी_दबाव(%rip)
  movq $0, %rax
  jmp .L_epilogue_सूत्र_जीसी_छोड़ो
.L_epilogue_सूत्र_जीसी_छोड़ो:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl संरेखित16
  .def संरेखित16; .scl 2; .type 32; .endef
संरेखित16:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  movq $15, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_2
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_2
.L_div_zero_2:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_2:
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  jmp .L_epilogue_संरेखित16
.L_epilogue_संरेखित16:
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
  .globl नया_अखंड
  .def नया_अखंड; .scl 2; .type 32; .endef
नया_अखंड:
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

  movq $16777216, %rax
  movq %rax, -16(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_6
  movq -8(%rbp), %rax
  pushq %rax
  movq $64, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call संरेखित16
  addq $48, %rsp
  movq %rax, -16(%rbp)
.L_sutra_if_end_6:
  movq -16(%rbp), %rax
  pushq %rax
  movq $32, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_अखंड_प्रथम(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_7
  movq -24(%rbp), %rax
  movq %rax, sutra_glob_अखंड_प्रथम(%rip)
  jmp .L_sutra_if_end_8
.L_sutra_if_else_7:
  movq sutra_glob_अखंड_वर्तमान(%rip), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
.L_sutra_if_end_8:
  movq -24(%rbp), %rax
  movq %rax, sutra_glob_अखंड_वर्तमान(%rip)
  movq -24(%rbp), %rax
  jmp .L_epilogue_नया_अखंड
.L_epilogue_नया_अखंड:
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
  .globl शून्य_भरो
  .def शून्य_भरो; .scl 2; .type 32; .endef
शून्य_भरो:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq %rcx, -8(%rbp)
  movq %rdx, -16(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root

  movq $0, %rax
  movq %rax, -24(%rbp)
.L_sutra_while_cond_9:
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_10
  movq -8(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_while_cond_9
.L_sutra_while_end_10:
.L_sutra_while_cond_11:
  movq -24(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_12
  movq -8(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  jmp .L_sutra_while_cond_11
.L_sutra_while_end_12:
.L_epilogue_शून्य_भरो:
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
  .globl सूत्र_आवंटन
  .def सूत्र_आवंटन; .scl 2; .type 32; .endef
सूत्र_आवंटन:
  pushq %rbp
  movq %rsp, %rbp
  subq $144, %rsp

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
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
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
  leaq -88(%rbp), %rcx
  call sutra_gc_push_root
  leaq -96(%rbp), %rcx
  call sutra_gc_push_root
  leaq -104(%rbp), %rcx
  call sutra_gc_push_root
  leaq -112(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call संरेखित16
  addq $48, %rsp
  movq %rax, -24(%rbp)
  movq $16, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -32(%rbp)
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq sutra_glob_ऑटो_सक्षम(%rip), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_14
  movq sutra_glob_जीसी_चालू(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_16
  movq sutra_glob_जीसी_दबाव(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_18
  movq sutra_glob_आवंटित_बाइट्स(%rip), %rax
  pushq %rax
  movq sutra_glob_जीसी_सीमा(%rip), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_20
  movq $1, %rax
  movq %rax, sutra_glob_जीसी_चालू(%rip)
  subq $32, %rsp
  call सूत्र_संग्रह
  addq $32, %rsp
  movq $0, %rax
  movq %rax, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $0, %rax
  movq %rax, sutra_glob_जीसी_चालू(%rip)
.L_sutra_if_end_20:
.L_sutra_if_end_18:
.L_sutra_if_end_16:
.L_sutra_if_end_14:
  movq -24(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call श्रेणी_का
  addq $48, %rsp
  movq %rax, -40(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_21
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -48(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_24
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $16, %rax
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
  movq $0, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call शून्य_भरो
  addq $48, %rsp
  movq -48(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_sutra_if_end_24:
  jmp .L_sutra_if_end_22
.L_sutra_if_else_21:
  movq $0, %rax
  movq %rax, -56(%rbp)
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -64(%rbp)
.L_sutra_while_cond_25:
  movq -64(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_26
  movq -64(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -72(%rbp)
  movq -64(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -80(%rbp)
  movq -72(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_28
  movq -56(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_29
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -80(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  jmp .L_sutra_if_end_30
.L_sutra_if_else_29:
  movq -56(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -80(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
.L_sutra_if_end_30:
  movq -64(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -64(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -72(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call शून्य_भरो
  addq $48, %rsp
  movq -64(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_sutra_if_end_28:
  movq -64(%rbp), %rax
  movq %rax, -56(%rbp)
  movq -80(%rbp), %rax
  movq %rax, -64(%rbp)
  jmp .L_sutra_while_cond_25
.L_sutra_while_end_26:
.L_sutra_if_end_22:
  movq sutra_glob_अखंड_वर्तमान(%rip), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_32
  movq -32(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call नया_अखंड
  addq $48, %rsp
.L_sutra_if_end_32:
  movq sutra_glob_अखंड_वर्तमान(%rip), %rax
  movq %rax, -88(%rbp)
  movq -88(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -96(%rbp)
  movq -88(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -104(%rbp)
  movq -96(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -104(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setg %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_34
  movq -32(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call नया_अखंड
  addq $48, %rsp
  movq sutra_glob_अखंड_वर्तमान(%rip), %rax
  movq %rax, -88(%rbp)
  movq $0, %rax
  movq %rax, -96(%rbp)
.L_sutra_if_end_34:
  movq -88(%rbp), %rax
  pushq %rax
  movq $32, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -96(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -112(%rbp)
  movq -88(%rbp), %rax
  pushq %rax
  movq $8, %rax
  pushq %rax
  movq -96(%rbp), %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -112(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -112(%rbp), %rax
  pushq %rax
  movq $8, %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_आवंटित_बाइट्स(%rip), %rax
  pushq %rax
  movq -32(%rbp), %rax
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
  movq %rax, sutra_glob_आवंटित_बाइट्स(%rip)
  movq -112(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_epilogue_सूत्र_आवंटन:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -112(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -104(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -96(%rbp), %rcx
  call sutra_gc_pop_root
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

  .text
  .globl सूत्र_मुक्त
  .def सूत्र_मुक्त; .scl 2; .type 32; .endef
सूत्र_मुक्त:
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
  je .L_sutra_if_end_36
  movq $0, %rax
  jmp .L_epilogue_सूत्र_मुक्त
.L_sutra_if_end_36:
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call श्रेणी_का
  addq $48, %rsp
  movq %rax, -24(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -16(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq $0, %rax
  jmp .L_epilogue_सूत्र_मुक्त
.L_epilogue_सूत्र_मुक्त:
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
  .globl सूत्र_पुनः_आवंटन
  .def सूत्र_पुनः_आवंटन; .scl 2; .type 32; .endef
सूत्र_पुनः_आवंटन:
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

  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_38
  movq -16(%rbp), %rax
  pushq %rax
  movq $2, %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call सूत्र_आवंटन
  addq $48, %rsp
  jmp .L_epilogue_सूत्र_पुनः_आवंटन
.L_sutra_if_end_38:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -32(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, -40(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  pushq %rax
  subq $32, %rsp
  movq 40(%rsp), %rcx
  movq 32(%rsp), %rdx
  call सूत्र_आवंटन
  addq $48, %rsp
  movq %rax, -56(%rbp)
  movq -48(%rbp), %rax
  movq %rax, -64(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_40
  movq -16(%rbp), %rax
  movq %rax, -64(%rbp)
.L_sutra_if_end_40:
  movq $0, %rax
  movq %rax, -72(%rbp)
.L_sutra_while_cond_41:
  movq -72(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setle %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_42
  movq -56(%rbp), %rax
  pushq %rax
  movq -72(%rbp), %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq -72(%rbp), %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -72(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -72(%rbp)
  jmp .L_sutra_while_cond_41
.L_sutra_while_end_42:
.L_sutra_while_cond_43:
  movq -72(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_44
  movq -56(%rbp), %rax
  pushq %rax
  movq -72(%rbp), %rax
  pushq %rax
  movq -8(%rbp), %rax
  pushq %rax
  movq -72(%rbp), %rax
  movq %rax, %rcx
  popq %rax
  movzbq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movb %r8b, (%rax,%rcx)
  movq %r8, %rax
  movq -72(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -72(%rbp)
  jmp .L_sutra_while_cond_43
.L_sutra_while_end_44:
  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सूत्र_मुक्त
  addq $48, %rsp
  movq -56(%rbp), %rax
  jmp .L_epilogue_सूत्र_पुनः_आवंटन
.L_epilogue_सूत्र_पुनः_आवंटन:
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
  .globl अखंड_में_है
  .def अखंड_में_है; .scl 2; .type 32; .endef
अखंड_में_है:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root
  leaq -16(%rbp), %rcx
  call sutra_gc_push_root
  leaq -24(%rbp), %rcx
  call sutra_gc_push_root
  leaq -32(%rbp), %rcx
  call sutra_gc_push_root

  movq sutra_glob_अखंड_प्रथम(%rip), %rax
  movq %rax, -16(%rbp)
.L_sutra_while_cond_45:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_46
  movq -16(%rbp), %rax
  pushq %rax
  movq $32, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -32(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  pushq %rax
  movq -8(%rbp), %rax
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
  je .L_sutra_if_end_48
  movq $1, %rax
  jmp .L_epilogue_अखंड_में_है
.L_sutra_if_end_48:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -16(%rbp)
  jmp .L_sutra_while_cond_45
.L_sutra_while_end_46:
  movq $0, %rax
  jmp .L_epilogue_अखंड_में_है
.L_epilogue_अखंड_में_है:
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
  .globl सूत्र_ब्लॉक_प्रकार
  .def सूत्र_ब्लॉक_प्रकार; .scl 2; .type 32; .endef
सूत्र_ब्लॉक_प्रकार:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq %rcx, -8(%rbp)
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
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_50
  movq $0, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_sutra_if_end_50:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
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
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_52
  movq $0, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_sutra_if_end_52:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अखंड_में_है
  addq $48, %rsp
  cmpq $0, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_54
  movq $0, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_sutra_if_end_54:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, -32(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $4, %rax
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
  je .L_sutra_if_end_56
  movq $0, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_sutra_if_end_56:
  movq -32(%rbp), %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_epilogue_सूत्र_ब्लॉक_प्रकार:
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
  .globl सूत्र_क्या_पाठ
  .def सूत्र_क्या_पाठ; .scl 2; .type 32; .endef
सूत्र_क्या_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सूत्र_ब्लॉक_प्रकार
  addq $48, %rsp
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_58
  movq $1, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_sutra_if_end_58:
  movq $0, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_epilogue_सूत्र_क्या_पाठ:
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
  .globl सूत्र_क्या_सूची
  .def सूत्र_क्या_सूची; .scl 2; .type 32; .endef
सूत्र_क्या_सूची:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सूत्र_ब्लॉक_प्रकार
  addq $48, %rsp
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_60
  movq $1, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_sutra_if_end_60:
  movq $0, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_epilogue_सूत्र_क्या_सूची:
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
  .globl सूत्र_क्या_वस्तु
  .def सूत्र_क्या_वस्तु; .scl 2; .type 32; .endef
सूत्र_क्या_वस्तु:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सूत्र_ब्लॉक_प्रकार
  addq $48, %rsp
  pushq %rax
  movq $3, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_62
  movq $1, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_sutra_if_end_62:
  movq $0, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_epilogue_सूत्र_क्या_वस्तु:
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
  .globl सूत्र_क्या_शब्दकोश
  .def सूत्र_क्या_शब्दकोश; .scl 2; .type 32; .endef
सूत्र_क्या_शब्दकोश:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  movq $0, -8(%rbp)
  movq %rcx, -8(%rbp)
  leaq -8(%rbp), %rcx
  call sutra_gc_push_root

  movq -8(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call सूत्र_ब्लॉक_प्रकार
  addq $48, %rsp
  pushq %rax
  movq $4, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_64
  movq $1, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_sutra_if_end_64:
  movq $0, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_epilogue_सूत्र_क्या_शब्दकोश:
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
  .globl चिह्नित_कच्चा
  .def चिह्नित_कच्चा; .scl 2; .type 32; .endef
चिह्नित_कच्चा:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp

  movq $0, -8(%rbp)
  movq $0, -16(%rbp)
  movq $0, -24(%rbp)
  movq $0, -32(%rbp)
  movq %rcx, -8(%rbp)
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
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_66
  movq $0, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_sutra_if_end_66:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अखंड_में_है
  addq $48, %rsp
  cmpq $0, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_68
  movq $0, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_sutra_if_end_68:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, -32(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $4, %rax
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
  je .L_sutra_if_end_70
  movq $0, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_sutra_if_end_70:
  movq -24(%rbp), %rax
  pushq %rax
  movq $256, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_72
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $256, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
.L_sutra_if_end_72:
  movq $0, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_epilogue_चिह्नित_कच्चा:
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
  .globl चिह्नित
  .def चिह्नित; .scl 2; .type 32; .endef
चिह्नित:
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
  movq $65536, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_74
  movq $0, %rax
  jmp .L_epilogue_चिह्नित
.L_sutra_if_end_74:
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -16(%rbp)
  movq -16(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call अखंड_में_है
  addq $48, %rsp
  cmpq $0, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_76
  movq $0, %rax
  jmp .L_epilogue_चिह्नित
.L_sutra_if_end_76:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq -24(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, -32(%rbp)
  movq -32(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $4, %rax
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
  je .L_sutra_if_end_78
  movq $0, %rax
  jmp .L_epilogue_चिह्नित
.L_sutra_if_end_78:
  movq -24(%rbp), %rax
  pushq %rax
  movq $256, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_80
  movq $0, %rax
  jmp .L_epilogue_चिह्नित
.L_sutra_if_end_80:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $256, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  pushq %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $3, %rax
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
  je .L_sutra_if_else_81
  movq -8(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -40(%rbp)
  movq $0, %rax
  movq %rax, -48(%rbp)
.L_sutra_while_cond_83:
  movq -48(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_84
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित
  addq $48, %rsp
  movq -48(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_83
.L_sutra_while_end_84:
  jmp .L_sutra_if_end_82
.L_sutra_if_else_81:
  movq -32(%rbp), %rax
  pushq %rax
  movq $4, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  sete %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_86
  movq -8(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -40(%rbp)
  movq -8(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -64(%rbp)
  movq -64(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_88
  movq -64(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित_कच्चा
  addq $48, %rsp
  movq $0, %rax
  movq %rax, -48(%rbp)
.L_sutra_while_cond_89:
  movq -48(%rbp), %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_90
  movq -64(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित
  addq $48, %rsp
  movq -64(%rbp), %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित
  addq $48, %rsp
  movq -48(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -48(%rbp)
  jmp .L_sutra_while_cond_89
.L_sutra_while_end_90:
.L_sutra_if_end_88:
.L_sutra_if_end_86:
.L_sutra_if_end_82:
  movq $0, %rax
  jmp .L_epilogue_चिह्नित
.L_epilogue_चिह्नित:
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
  .globl सूत्र_संग्रह
  .def सूत्र_संग्रह; .scl 2; .type 32; .endef
सूत्र_संग्रह:
  pushq %rbp
  movq %rsp, %rbp
  subq $176, %rsp

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
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
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
  leaq -96(%rbp), %rcx
  call sutra_gc_push_root
  leaq -104(%rbp), %rcx
  call sutra_gc_push_root
  leaq -112(%rbp), %rcx
  call sutra_gc_push_root
  leaq -120(%rbp), %rcx
  call sutra_gc_push_root
  leaq -128(%rbp), %rcx
  call sutra_gc_push_root
  leaq -136(%rbp), %rcx
  call sutra_gc_push_root

  movq sutra_glob_गण_चक्र(%rip), %rax
  pushq %rax
  movq $1, %rax
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
  movq %rax, sutra_glob_गण_चक्र(%rip)
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %rax
  movq %rax, -8(%rbp)
  movq sutra_glob_अखंड_प्रथम(%rip), %rax
  movq %rax, -16(%rbp)
.L_sutra_while_cond_91:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_92
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq $0, %rax
  movq %rax, -32(%rbp)
.L_sutra_while_cond_93:
  movq -32(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_94
  movq -16(%rbp), %rax
  pushq %rax
  movq $32, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -40(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -56(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -48(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -32(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -56(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -32(%rbp)
  jmp .L_sutra_while_cond_93
.L_sutra_while_end_94:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -16(%rbp)
  jmp .L_sutra_while_cond_91
.L_sutra_while_end_92:
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_gc_root_count
  addq $32, %rsp
  movq (%rsp), %rsp
  movq %rax, -64(%rbp)
  movq $0, %rax
  movq %rax, -72(%rbp)
.L_sutra_while_cond_95:
  movq -72(%rbp), %rax
  pushq %rax
  movq -64(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_96
  movq -72(%rbp), %rax
  movq %rax, %rcx
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_gc_root_deref
  addq $32, %rsp
  movq (%rsp), %rsp
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित
  addq $48, %rsp
  movq -72(%rbp), %rax
  pushq %rax
  movq $1, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -72(%rbp)
  jmp .L_sutra_while_cond_95
.L_sutra_while_end_96:
  movq %rsp, %rax
  subq $8, %rsp
  andq $-16, %rsp
  movq %rax, (%rsp)
  subq $32, %rsp
  call sutra_gc_active_exc
  addq $32, %rsp
  movq (%rsp), %rsp
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call चिह्नित
  addq $48, %rsp
  movq $0, %rax
  movq %rax, sutra_glob_गण_सक्रिय(%rip)
  movq sutra_glob_अखंड_प्रथम(%rip), %rax
  movq %rax, -16(%rbp)
.L_sutra_while_cond_97:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_98
  movq -16(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -24(%rbp)
  movq $0, %rax
  movq %rax, -32(%rbp)
.L_sutra_while_cond_99:
  movq -32(%rbp), %rax
  pushq %rax
  movq -24(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_while_end_100
  movq -16(%rbp), %rax
  pushq %rax
  movq $32, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -32(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -40(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -48(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -56(%rbp)
  movq -48(%rbp), %rax
  pushq %rax
  movq $256, %rax
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
  movq %rax, -120(%rbp)
  movq -120(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setne %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_102
  movq -48(%rbp), %rax
  pushq %rax
  movq $256, %rax
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setge %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_else_103
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq -120(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_गण_सक्रिय(%rip), %rax
  pushq %rax
  movq $1, %rax
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
  movq %rax, sutra_glob_गण_सक्रिय(%rip)
  jmp .L_sutra_if_end_104
.L_sutra_if_else_103:
  movq -56(%rbp), %rax
  pushq %rax
  subq $40, %rsp
  movq 40(%rsp), %rcx
  call श्रेणी_का
  addq $48, %rsp
  movq %rax, -128(%rbp)
  movq -40(%rbp), %rax
  pushq %rax
  movq $0, %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq -40(%rbp), %rax
  pushq %rax
  movq $16, %rax
  pushq %rax
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -128(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_मुक्त_तालिका(%rip), %rax
  pushq %rax
  movq -128(%rbp), %rax
  pushq %rax
  movq $8, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  pushq %rax
  movq -40(%rbp), %rax
  movq %rax, %r8
  popq %rcx
  popq %rax
  movq %r8, (%rax,%rcx)
  movq %r8, %rax
  movq sutra_glob_गण_संग्रहित(%rip), %rax
  pushq %rax
  movq $1, %rax
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
  movq %rax, sutra_glob_गण_संग्रहित(%rip)
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %rax
  pushq %rax
  movq -56(%rbp), %rax
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
  movq %rax, sutra_glob_गण_पुनःप्राप्त(%rip)
.L_sutra_if_end_104:
.L_sutra_if_end_102:
  movq -32(%rbp), %rax
  pushq %rax
  movq $16, %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  pushq %rax
  movq -56(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  addq %rdx, %rax
  movq %rax, -32(%rbp)
  jmp .L_sutra_while_cond_99
.L_sutra_while_end_100:
  movq -16(%rbp), %rax
  pushq %rax
  movq $0, %rax
  movq %rax, %rcx
  popq %rax
  movq (%rax,%rcx), %rax
  movq %rax, -16(%rbp)
  jmp .L_sutra_while_cond_97
.L_sutra_while_end_98:
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %rax
  pushq %rax
  movq -8(%rbp), %rax
  movq %rax, %rdx
  popq %rax
  subq %rdx, %rax
  movq %rax, -136(%rbp)
  movq -136(%rbp), %rax
  pushq %rax
  movq sutra_glob_जीसी_सीमा(%rip), %rax
  pushq %rax
  movq $4, %rax
  movq %rax, %rdx
  popq %rax
  cmpq $0, %rdx
  je .L_div_zero_10
  movq %rdx, %r8
  cqto
  idivq %r8
  jmp .L_div_end_10
.L_div_zero_10:
  subq $32, %rsp
  call sutra_throw_div_by_zero
  addq $32, %rsp
.L_div_end_10:
  movq %rax, %rdx
  popq %rax
  cmpq %rdx, %rax
  setl %al
  movzbl %al, %eax
  cmpq $0, %rax
  je .L_sutra_if_end_106
  movq sutra_glob_जीसी_सीमा(%rip), %rax
  pushq %rax
  movq $2, %rax
  movq %rax, %rdx
  popq %rax
  imulq %rdx, %rax
  movq %rax, sutra_glob_जीसी_सीमा(%rip)
.L_sutra_if_end_106:
  movq $0, %rax
  jmp .L_epilogue_सूत्र_संग्रह
.L_epilogue_सूत्र_संग्रह:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  leaq -136(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -128(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -120(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -112(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -104(%rbp), %rcx
  call sutra_gc_pop_root
  leaq -96(%rbp), %rcx
  call sutra_gc_pop_root
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

  .text
  .globl सूत्र_गण_चक्र
  .def सूत्र_गण_चक्र; .scl 2; .type 32; .endef
सूत्र_गण_चक्र:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_गण_चक्र(%rip), %rax
  jmp .L_epilogue_सूत्र_गण_चक्र
.L_epilogue_सूत्र_गण_चक्र:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_गण_सक्रिय
  .def सूत्र_गण_सक्रिय; .scl 2; .type 32; .endef
सूत्र_गण_सक्रिय:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_गण_सक्रिय(%rip), %rax
  jmp .L_epilogue_सूत्र_गण_सक्रिय
.L_epilogue_सूत्र_गण_सक्रिय:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_गण_संग्रहित
  .def सूत्र_गण_संग्रहित; .scl 2; .type 32; .endef
सूत्र_गण_संग्रहित:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_गण_संग्रहित(%rip), %rax
  jmp .L_epilogue_सूत्र_गण_संग्रहित
.L_epilogue_सूत्र_गण_संग्रहित:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_गण_पुनःप्राप्त
  .def सूत्र_गण_पुनःप्राप्त; .scl 2; .type 32; .endef
सूत्र_गण_पुनःप्राप्त:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp


  movq sutra_glob_गण_पुनःप्राप्त(%rip), %rax
  jmp .L_epilogue_सूत्र_गण_पुनःप्राप्त
.L_epilogue_सूत्र_गण_पुनःप्राप्त:
  subq $48, %rsp
  movq %rax, 32(%rsp)
  movq 32(%rsp), %rax
  addq $48, %rsp
  movq %rbp, %rsp
  popq %rbp
  ret

