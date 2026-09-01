  .text
  .globl अक्षर_कोडबिंदु
  .def अक्षर_कोडबिंदु; .scl 2; .type 32; .endef
अक्षर_कोडबिंदु:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx

.L_अक्षर_कोडबिंदु__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_0
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_1
.L_किनारा_अक्षर_कोडबिंदु_0:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_2
.L_अक्षर_कोडबिंदु__if_अंत_2:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_1
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_3
.L_किनारा_अक्षर_कोडबिंदु_1:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_4
.L_अक्षर_कोडबिंदु__if_अंत_4:
  movq $16, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $128, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_2
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_5
.L_किनारा_अक्षर_कोडबिंदु_2:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_6
.L_अक्षर_कोडबिंदु__if_अंत_6:
  movq $192, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_3
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_7
.L_किनारा_अक्षर_कोडबिंदु_3:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_8
.L_अक्षर_कोडबिंदु__sc_लघु_8:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_9
.L_अक्षर_कोडबिंदु__sc_दायाँ_7:
  movq $224, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_9
.L_अक्षर_कोडबिंदु__sc_अंत_9:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_4
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_10
.L_किनारा_अक्षर_कोडबिंदु_4:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_11
.L_अक्षर_कोडबिंदु__sc_लघु_11:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_12
.L_अक्षर_कोडबिंदु__sc_दायाँ_10:
  movq $2, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_12
.L_अक्षर_कोडबिंदु__sc_अंत_12:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_5
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_13
.L_किनारा_अक्षर_कोडबिंदु_5:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_14
.L_अक्षर_कोडबिंदु__if_अंत_14:
  movq $224, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_6
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_15
.L_किनारा_अक्षर_कोडबिंदु_6:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_16
.L_अक्षर_कोडबिंदु__sc_लघु_16:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_17
.L_अक्षर_कोडबिंदु__sc_दायाँ_15:
  movq $240, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_17
.L_अक्षर_कोडबिंदु__sc_अंत_17:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_7
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_18
.L_किनारा_अक्षर_कोडबिंदु_7:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_19
.L_अक्षर_कोडबिंदु__sc_लघु_19:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_20
.L_अक्षर_कोडबिंदु__sc_दायाँ_18:
  movq $3, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_20
.L_अक्षर_कोडबिंदु__sc_अंत_20:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_8
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_21
.L_किनारा_अक्षर_कोडबिंदु_8:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_22
.L_अक्षर_कोडबिंदु__if_अंत_22:
  movq $240, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_9
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_23
.L_किनारा_अक्षर_कोडबिंदु_9:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_24
.L_अक्षर_कोडबिंदु__sc_लघु_24:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_25
.L_अक्षर_कोडबिंदु__sc_दायाँ_23:
  movq $248, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_25
.L_अक्षर_कोडबिंदु__sc_अंत_25:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_10
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_26
.L_किनारा_अक्षर_कोडबिंदु_10:
  jmp .L_अक्षर_कोडबिंदु__sc_लघु_27
.L_अक्षर_कोडबिंदु__sc_लघु_27:
  movq $0, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_28
.L_अक्षर_कोडबिंदु__sc_दायाँ_26:
  movq $4, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_अक्षर_कोडबिंदु__sc_अंत_28
.L_अक्षर_कोडबिंदु__sc_अंत_28:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_कोडबिंदु_11
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_29
.L_किनारा_अक्षर_कोडबिंदु_11:
  jmp .L_अक्षर_कोडबिंदु__if_अंत_30
.L_अक्षर_कोडबिंदु__if_अंत_30:
  movq $65533, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_29:
  movq $17, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $18, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq $19, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq $240, %rsi
  movq -72(%rbp), %r10
  subq %rsi, %r10
  movq %r10, %r15
  movq $262144, %rsi
  movq %r15, %r10
  imulq %rsi, %r10
  movq %r10, %r12
  movq $64, %rsi
  movq %rdi, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $4096, %rsi
  movq %r15, %r10
  imulq %rsi, %r10
  movq %r10, %rdi
  movq %r12, %r10
  addq %rdi, %r10
  movq %r10, %rsi
  movq $64, %rdi
  movq %r13, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %r12
  movq $64, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq $64, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_21:
  movq $17, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $18, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r12
  movq $224, %rsi
  movq -72(%rbp), %r10
  subq %rsi, %r10
  movq %r10, %r13
  movq $4096, %rsi
  movq %r13, %r10
  imulq %rsi, %r10
  movq %r10, %r14
  movq $64, %rsi
  movq %rdi, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r13
  movq $64, %rsi
  movq %r13, %r10
  imulq %rsi, %r10
  movq %r10, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %rsi
  movq $64, %rdi
  movq %r12, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_13:
  movq $17, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $192, %rbx
  movq -72(%rbp), %r10
  subq %rbx, %r10
  movq %r10, %rsi
  movq $64, %rbx
  movq %rsi, %r10
  imulq %rbx, %r10
  movq %r10, %r12
  movq $64, %rbx
  movq %rdi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_5:
  movq -72(%rbp), %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_3:
  movq $1, %rbx
  movq %rbx, %r10
  negq %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %r10
  negq %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_epilogue_अक्षर_कोडबिंदु:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_गणना
  .def पाठ_कोडबिंदु_गणना; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_गणना:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_कोडबिंदु_गणना__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_0
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_1
.L_किनारा_पाठ_कोडबिंदु_गणना_0:
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_2
.L_पाठ_कोडबिंदु_गणना__if_अंत_2:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq $0, %r12
  jmp .L_पाठ_कोडबिंदु_गणना__wh_शर्त_3
.L_पाठ_कोडबिंदु_गणना__wh_शर्त_3:
  movq %rsi, -80(%rbp)
  movq %r12, -88(%rbp)
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_1
  jmp .L_पाठ_कोडबिंदु_गणना__wh_देह_4
.L_किनारा_पाठ_कोडबिंदु_गणना_1:
  jmp .L_पाठ_कोडबिंदु_गणना__wh_अंत_5
.L_पाठ_कोडबिंदु_गणना__wh_अंत_5:
  movq %r12, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_गणना
.L_पाठ_कोडबिंदु_गणना__wh_देह_4:
  movq $16, %r13
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq $128, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_2
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_6
.L_किनारा_पाठ_कोडबिंदु_गणना_2:
  jmp .L_पाठ_कोडबिंदु_गणना__if_असत्य_8
.L_पाठ_कोडबिंदु_गणना__if_असत्य_8:
  movq $192, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_3
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_9
.L_किनारा_पाठ_कोडबिंदु_गणना_3:
  jmp .L_पाठ_कोडबिंदु_गणना__sc_लघु_10
.L_पाठ_कोडबिंदु_गणना__sc_लघु_10:
  movq $0, %r14
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_11
.L_पाठ_कोडबिंदु_गणना__sc_दायाँ_9:
  movq $224, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r14
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_11
.L_पाठ_कोडबिंदु_गणना__sc_अंत_11:
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_4
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_12
.L_किनारा_पाठ_कोडबिंदु_गणना_4:
  jmp .L_पाठ_कोडबिंदु_गणना__if_असत्य_14
.L_पाठ_कोडबिंदु_गणना__if_असत्य_14:
  movq $224, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_5
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_15
.L_किनारा_पाठ_कोडबिंदु_गणना_5:
  jmp .L_पाठ_कोडबिंदु_गणना__sc_लघु_16
.L_पाठ_कोडबिंदु_गणना__sc_लघु_16:
  movq $0, %r14
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_17
.L_पाठ_कोडबिंदु_गणना__sc_दायाँ_15:
  movq $240, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r14
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_17
.L_पाठ_कोडबिंदु_गणना__sc_अंत_17:
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_6
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_18
.L_किनारा_पाठ_कोडबिंदु_गणना_6:
  jmp .L_पाठ_कोडबिंदु_गणना__if_असत्य_20
.L_पाठ_कोडबिंदु_गणना__if_असत्य_20:
  movq $240, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_7
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_21
.L_किनारा_पाठ_कोडबिंदु_गणना_7:
  jmp .L_पाठ_कोडबिंदु_गणना__sc_लघु_22
.L_पाठ_कोडबिंदु_गणना__sc_लघु_22:
  movq $0, %r14
  movq %r14, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_23
.L_पाठ_कोडबिंदु_गणना__sc_दायाँ_21:
  movq $248, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__sc_अंत_23
.L_पाठ_कोडबिंदु_गणना__sc_अंत_23:
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_गणना_8
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_24
.L_किनारा_पाठ_कोडबिंदु_गणना_8:
  jmp .L_पाठ_कोडबिंदु_गणना__if_असत्य_26
.L_पाठ_कोडबिंदु_गणना__if_असत्य_26:
  movq $1, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_25
.L_पाठ_कोडबिंदु_गणना__if_सत्य_24:
  movq $4, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_25
.L_पाठ_कोडबिंदु_गणना__if_अंत_25:
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_19
.L_पाठ_कोडबिंदु_गणना__if_सत्य_18:
  movq $3, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_19
.L_पाठ_कोडबिंदु_गणना__if_अंत_19:
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_13
.L_पाठ_कोडबिंदु_गणना__if_सत्य_12:
  movq $2, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_13
.L_पाठ_कोडबिंदु_गणना__if_अंत_13:
  movq %r13, %rsi
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_7
.L_पाठ_कोडबिंदु_गणना__if_सत्य_6:
  movq $1, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $0, -80(%rbp)
  movq %r14, %rsi
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_7
.L_पाठ_कोडबिंदु_गणना__if_अंत_7:
  movq $1, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $0, -88(%rbp)
  movq %r14, %r12
  jmp .L_पाठ_कोडबिंदु_गणना__wh_शर्त_3
.L_पाठ_कोडबिंदु_गणना__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_गणना
.L_epilogue_पाठ_कोडबिंदु_गणना:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_तुल्य
  .def पाठ_तुल्य; .scl 2; .type 32; .endef
पाठ_तुल्य:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -80(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_तुल्य__प्रवेश_0:
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_0
  jmp .L_पाठ_तुल्य__if_सत्य_1
.L_किनारा_पाठ_तुल्य_0:
  jmp .L_पाठ_तुल्य__if_अंत_2
.L_पाठ_तुल्य__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_1
  jmp .L_पाठ_तुल्य__sc_लघु_4
.L_किनारा_पाठ_तुल्य_1:
  jmp .L_पाठ_तुल्य__sc_दायाँ_3
.L_पाठ_तुल्य__sc_दायाँ_3:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_5
.L_पाठ_तुल्य__sc_लघु_4:
  movq $1, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_5
.L_पाठ_तुल्य__sc_अंत_5:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_2
  jmp .L_पाठ_तुल्य__if_सत्य_6
.L_किनारा_पाठ_तुल्य_2:
  jmp .L_पाठ_तुल्य__if_अंत_7
.L_पाठ_तुल्य__if_अंत_7:
  movq $65536, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_3
  jmp .L_पाठ_तुल्य__sc_लघु_9
.L_किनारा_पाठ_तुल्य_3:
  jmp .L_पाठ_तुल्य__sc_दायाँ_8
.L_पाठ_तुल्य__sc_दायाँ_8:
  movq $65536, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_10
.L_पाठ_तुल्य__sc_लघु_9:
  movq $1, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_10
.L_पाठ_तुल्य__sc_अंत_10:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_4
  jmp .L_पाठ_तुल्य__if_सत्य_11
.L_किनारा_पाठ_तुल्य_4:
  jmp .L_पाठ_तुल्य__if_अंत_12
.L_पाठ_तुल्य__if_अंत_12:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_5
  jmp .L_पाठ_तुल्य__sc_लघु_14
.L_किनारा_पाठ_तुल्य_5:
  jmp .L_पाठ_तुल्य__sc_दायाँ_13
.L_पाठ_तुल्य__sc_दायाँ_13:
  movq %rsi, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_15
.L_पाठ_तुल्य__sc_लघु_14:
  movq $1, %rdi
  jmp .L_पाठ_तुल्य__sc_अंत_15
.L_पाठ_तुल्य__sc_अंत_15:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_6
  jmp .L_पाठ_तुल्य__if_सत्य_16
.L_किनारा_पाठ_तुल्य_6:
  jmp .L_पाठ_तुल्य__if_अंत_17
.L_पाठ_तुल्य__if_अंत_17:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r12, %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_7
  jmp .L_पाठ_तुल्य__if_सत्य_18
.L_किनारा_पाठ_तुल्य_7:
  jmp .L_पाठ_तुल्य__if_अंत_19
.L_पाठ_तुल्य__if_अंत_19:
  movq $0, %rdi
  jmp .L_पाठ_तुल्य__wh_शर्त_20
.L_पाठ_तुल्य__wh_शर्त_20:
  movq %rdi, -80(%rbp)
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_8
  jmp .L_पाठ_तुल्य__wh_देह_21
.L_किनारा_पाठ_तुल्य_8:
  jmp .L_पाठ_तुल्य__wh_अंत_22
.L_पाठ_तुल्य__wh_अंत_22:
  movq $1, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__wh_देह_21:
  movq $16, %r13
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq $16, %r14
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %r15
  movq %rsi, %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_तुल्य_9
  jmp .L_पाठ_तुल्य__if_सत्य_23
.L_किनारा_पाठ_तुल्य_9:
  jmp .L_पाठ_तुल्य__if_अंत_24
.L_पाठ_तुल्य__if_अंत_24:
  movq $1, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $0, -80(%rbp)
  movq %r14, %rdi
  jmp .L_पाठ_तुल्य__wh_शर्त_20
.L_पाठ_तुल्य__if_सत्य_23:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__if_सत्य_18:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__if_सत्य_16:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__if_सत्य_11:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__if_सत्य_6:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_पाठ_तुल्य__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य
.L_epilogue_पाठ_तुल्य:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सञ्चय_गणना__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सञ्चय_गणना_0
  jmp .L_सञ्चय_गणना__if_सत्य_1
.L_किनारा_सञ्चय_गणना_0:
  jmp .L_सञ्चय_गणना__if_अंत_2
.L_सञ्चय_गणना__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_is_dict
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_सञ्चय_गणना_1
  jmp .L_सञ्चय_गणना__if_सत्य_3
.L_किनारा_सञ्चय_गणना_1:
  jmp .L_सञ्चय_गणना__if_अंत_4
.L_सञ्चय_गणना__if_अंत_4:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_सञ्चय_गणना__if_सत्य_3:
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_सञ्चय_गणना__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चय_गणना
.L_epilogue_सञ्चय_गणना:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_दैशिक_लंबाई__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_दैशिक_लंबाई_0
  jmp .L_दैशिक_लंबाई__if_सत्य_1
.L_किनारा_दैशिक_लंबाई_0:
  jmp .L_दैशिक_लंबाई__if_अंत_2
.L_दैशिक_लंबाई__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_दैशिक_लंबाई_1
  jmp .L_दैशिक_लंबाई__if_सत्य_3
.L_किनारा_दैशिक_लंबाई_1:
  jmp .L_दैशिक_लंबाई__if_अंत_4
.L_दैशिक_लंबाई__if_अंत_4:
  movq %rbx, %rcx
  subq $32, %rsp
  call सञ्चय_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_दैशिक_लंबाई
.L_दैशिक_लंबाई__if_सत्य_3:
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_कोडबिंदु_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_दैशिक_लंबाई
.L_दैशिक_लंबाई__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_दैशिक_लंबाई
.L_epilogue_दैशिक_लंबाई:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_अक्षर_बाइट_चौड़ाई__प्रवेश_0:
  movq $128, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_0
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_1
.L_किनारा_अक्षर_बाइट_चौड़ाई_0:
  jmp .L_अक्षर_बाइट_चौड़ाई__if_अंत_2
.L_अक्षर_बाइट_चौड़ाई__if_अंत_2:
  movq $192, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_1
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_3
.L_किनारा_अक्षर_बाइट_चौड़ाई_1:
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_लघु_4
.L_अक्षर_बाइट_चौड़ाई__sc_लघु_4:
  movq $0, %rsi
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_5
.L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_3:
  movq $224, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_5
.L_अक्षर_बाइट_चौड़ाई__sc_अंत_5:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_2
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_6
.L_किनारा_अक्षर_बाइट_चौड़ाई_2:
  jmp .L_अक्षर_बाइट_चौड़ाई__if_अंत_7
.L_अक्षर_बाइट_चौड़ाई__if_अंत_7:
  movq $224, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_3
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_8
.L_किनारा_अक्षर_बाइट_चौड़ाई_3:
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_लघु_9
.L_अक्षर_बाइट_चौड़ाई__sc_लघु_9:
  movq $0, %rsi
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_10
.L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_8:
  movq $240, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_10
.L_अक्षर_बाइट_चौड़ाई__sc_अंत_10:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_4
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_11
.L_किनारा_अक्षर_बाइट_चौड़ाई_4:
  jmp .L_अक्षर_बाइट_चौड़ाई__if_अंत_12
.L_अक्षर_बाइट_चौड़ाई__if_अंत_12:
  movq $240, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_5
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_13
.L_किनारा_अक्षर_बाइट_चौड़ाई_5:
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_लघु_14
.L_अक्षर_बाइट_चौड़ाई__sc_लघु_14:
  movq $0, %rsi
  movq %rsi, %rbx
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_15
.L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_13:
  movq $248, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rbx
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_अंत_15
.L_अक्षर_बाइट_चौड़ाई__sc_अंत_15:
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बाइट_चौड़ाई_6
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_16
.L_किनारा_अक्षर_बाइट_चौड़ाई_6:
  jmp .L_अक्षर_बाइट_चौड़ाई__if_अंत_17
.L_अक्षर_बाइट_चौड़ाई__if_अंत_17:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_अक्षर_बाइट_चौड़ाई__if_सत्य_16:
  movq $4, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_अक्षर_बाइट_चौड़ाई__if_सत्य_11:
  movq $3, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_अक्षर_बाइट_चौड़ाई__if_सत्य_6:
  movq $2, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_अक्षर_बाइट_चौड़ाई__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_बाइट_चौड़ाई
.L_epilogue_अक्षर_बाइट_चौड़ाई:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोडबिंदु_मान
  .def कोडबिंदु_मान; .scl 2; .type 32; .endef
कोडबिंदु_मान:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, %rdi

.L_कोडबिंदु_मान__प्रवेश_0:
  movq $16, %r12
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r12
  movq $1, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_मान_0
  jmp .L_कोडबिंदु_मान__if_सत्य_1
.L_किनारा_कोडबिंदु_मान_0:
  jmp .L_कोडबिंदु_मान__if_अंत_2
.L_कोडबिंदु_मान__if_अंत_2:
  movq $2, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_मान_1
  jmp .L_कोडबिंदु_मान__if_सत्य_3
.L_किनारा_कोडबिंदु_मान_1:
  jmp .L_कोडबिंदु_मान__if_अंत_4
.L_कोडबिंदु_मान__if_अंत_4:
  movq $3, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_मान_2
  jmp .L_कोडबिंदु_मान__if_सत्य_5
.L_किनारा_कोडबिंदु_मान_2:
  jmp .L_कोडबिंदु_मान__if_अंत_6
.L_कोडबिंदु_मान__if_अंत_6:
  movq $240, %rdi
  movq %r12, %r10
  subq %rdi, %r10
  movq %r10, %r13
  movq $262144, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq $17, %rdi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $64, %r13
  movq %rdi, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $4096, %rdi
  movq %r15, %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq $18, %r13
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq $64, %r14
  movq %r13, %rax
  movq %r14, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $64, %r13
  movq %r15, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq $19, %rdi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $64, %r14
  movq %rdi, %rax
  movq %r14, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_कोडबिंदु_मान__if_सत्य_5:
  movq $224, %rdi
  movq %r12, %r10
  subq %rdi, %r10
  movq %r10, %r13
  movq $4096, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq $17, %rdi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $64, %r13
  movq %rdi, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $64, %rdi
  movq %r15, %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq $18, %r13
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq $64, %r14
  movq %r13, %rax
  movq %r14, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq %rdi, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %r13, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_कोडबिंदु_मान__if_सत्य_3:
  movq $192, %rdi
  movq %r12, %r10
  subq %rdi, %r10
  movq %r10, %r13
  movq $64, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq $17, %rdi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $64, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_कोडबिंदु_मान__if_सत्य_1:
  movq %r12, %rax
  jmp .L_epilogue_कोडबिंदु_मान
.L_epilogue_कोडबिंदु_मान:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_तुलना
  .def पाठ_कोडबिंदु_तुलना; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_तुलना:
  pushq %rbp
  movq %rsp, %rbp
  subq $176, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -104(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
  movq $0, -160(%rbp)
  movq $0, -168(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -144(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -152(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -160(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -168(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_कोडबिंदु_तुलना__प्रवेश_0:
  movq %rbx, %r10
  cmpq -104(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_0
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_1
.L_किनारा_पाठ_कोडबिंदु_तुलना_0:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_2
.L_पाठ_कोडबिंदु_तुलना__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_1
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_3
.L_किनारा_पाठ_कोडबिंदु_तुलना_1:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_4
.L_पाठ_कोडबिंदु_तुलना__if_अंत_4:
  movq $0, %rdi
  movq -104(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_2
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_5
.L_किनारा_पाठ_कोडबिंदु_तुलना_2:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_6
.L_पाठ_कोडबिंदु_तुलना__if_अंत_6:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $8, %rdi
  movq -104(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %rdi
  movq $0, %r14
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_शर्त_7
.L_पाठ_कोडबिंदु_तुलना__wh_शर्त_7:
  movq %rdi, -144(%rbp)
  movq %r14, -152(%rbp)
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_3
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_10
.L_किनारा_पाठ_कोडबिंदु_तुलना_3:
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_लघु_11
.L_पाठ_कोडबिंदु_तुलना__sc_लघु_11:
  movq $0, %r15
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_अंत_12
.L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_10:
  movq %r14, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_अंत_12
.L_पाठ_कोडबिंदु_तुलना__sc_अंत_12:
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_4
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_देह_8
.L_किनारा_पाठ_कोडबिंदु_तुलना_4:
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_अंत_9
.L_पाठ_कोडबिंदु_तुलना__wh_अंत_9:
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_5
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_21
.L_किनारा_पाठ_कोडबिंदु_तुलना_5:
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_लघु_22
.L_पाठ_कोडबिंदु_तुलना__sc_लघु_22:
  movq $0, %r15
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_अंत_23
.L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_21:
  movq %r14, %r10
  cmpq -72(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_अंत_23
.L_पाठ_कोडबिंदु_तुलना__sc_अंत_23:
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_6
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_24
.L_किनारा_पाठ_कोडबिंदु_तुलना_6:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_25
.L_पाठ_कोडबिंदु_तुलना__if_अंत_25:
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_7
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_26
.L_किनारा_पाठ_कोडबिंदु_तुलना_7:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_27
.L_पाठ_कोडबिंदु_तुलना__if_अंत_27:
  movq $1, %r15
  movq %r15, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_26:
  movq $1, %r15
  movq %r15, %r10
  negq %r10
  movq %r10, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_24:
  movq $0, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__wh_देह_8:
  movq $16, %r13
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r15
  movq %rbx, %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r15
  movq %rdi, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq -88(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_8
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_13
.L_किनारा_पाठ_कोडबिंदु_तुलना_8:
  movq %r15, %r12
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_14
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_13:
  movq $1, %r12
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_14
.L_पाठ_कोडबिंदु_तुलना__if_अंत_14:
  movq %r12, -160(%rbp)
  movq $16, %r13
  movq %r13, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq -104(%rbp), %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r15
  movq %r14, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_9
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_15
.L_किनारा_पाठ_कोडबिंदु_तुलना_9:
  movq %r15, %rsi
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_16
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_15:
  movq $1, %rsi
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_16
.L_पाठ_कोडबिंदु_तुलना__if_अंत_16:
  movq %rsi, -168(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq %r12, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -136(%rbp)
  movq -104(%rbp), %rcx
  movq %r14, %rdx
  movq %rsi, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, -120(%rbp)
  movq %r13, %r10
  cmpq -120(%rbp), %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_10
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_17
.L_किनारा_पाठ_कोडबिंदु_तुलना_10:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_18
.L_पाठ_कोडबिंदु_तुलना__if_अंत_18:
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r15
  movq $0, -144(%rbp)
  movq $0, -160(%rbp)
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, -152(%rbp)
  movq $0, -168(%rbp)
  movq %rdi, %r14
  movq %r15, %rdi
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_शर्त_7
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_17:
  movq %r13, %r10
  cmpq -120(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq $0, -136(%rbp)
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_11
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_19
.L_किनारा_पाठ_कोडबिंदु_तुलना_11:
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_20
.L_पाठ_कोडबिंदु_तुलना__if_अंत_20:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_19:
  movq $1, %rbx
  movq %rbx, %r10
  negq %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_5:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_3:
  movq $1, %rbx
  movq %rbx, %r10
  negq %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_epilogue_पाठ_कोडबिंदु_तुलना:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सामान्य_न्यून
  .def सामान्य_न्यून; .scl 2; .type 32; .endef
सामान्य_न्यून:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सामान्य_न्यून__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_न्यून_0
  jmp .L_सामान्य_न्यून__if_सत्य_1
.L_किनारा_सामान्य_न्यून_0:
  jmp .L_सामान्य_न्यून__if_अंत_2
.L_सामान्य_न्यून__if_सत्य_1:
  movq %rsi, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_न्यून_1
  jmp .L_सामान्य_न्यून__if_सत्य_3
.L_किनारा_सामान्य_न्यून_1:
  jmp .L_सामान्य_न्यून__if_अंत_4
.L_सामान्य_न्यून__if_अंत_4:
  jmp .L_सामान्य_न्यून__if_अंत_2
.L_सामान्य_न्यून__if_अंत_2:
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_न्यून_2
  jmp .L_सामान्य_न्यून__if_सत्य_5
.L_किनारा_सामान्य_न्यून_2:
  jmp .L_सामान्य_न्यून__if_अंत_6
.L_सामान्य_न्यून__if_अंत_6:
  movq $0, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_न्यून
.L_सामान्य_न्यून__if_सत्य_5:
  movq $1, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_न्यून
.L_सामान्य_न्यून__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_न्यून
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_न्यून
.L_epilogue_सामान्य_न्यून:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सामान्य_अधिक
  .def सामान्य_अधिक; .scl 2; .type 32; .endef
सामान्य_अधिक:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सामान्य_अधिक__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_अधिक_0
  jmp .L_सामान्य_अधिक__if_सत्य_1
.L_किनारा_सामान्य_अधिक_0:
  jmp .L_सामान्य_अधिक__if_अंत_2
.L_सामान्य_अधिक__if_सत्य_1:
  movq %rsi, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_अधिक_1
  jmp .L_सामान्य_अधिक__if_सत्य_3
.L_किनारा_सामान्य_अधिक_1:
  jmp .L_सामान्य_अधिक__if_अंत_4
.L_सामान्य_अधिक__if_अंत_4:
  jmp .L_सामान्य_अधिक__if_अंत_2
.L_सामान्य_अधिक__if_अंत_2:
  movq %rbx, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_अधिक_2
  jmp .L_सामान्य_अधिक__if_सत्य_5
.L_किनारा_सामान्य_अधिक_2:
  jmp .L_सामान्य_अधिक__if_अंत_6
.L_सामान्य_अधिक__if_अंत_6:
  movq $0, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_अधिक
.L_सामान्य_अधिक__if_सत्य_5:
  movq $1, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_अधिक
.L_सामान्य_अधिक__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_अधिक
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सामान्य_अधिक
.L_epilogue_सामान्य_अधिक:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सामान्य_न्यून_सम
  .def सामान्य_न्यून_सम; .scl 2; .type 32; .endef
सामान्य_न्यून_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सामान्य_न्यून_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सामान्य_अधिक
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_न्यून_सम_0
  jmp .L_सामान्य_न्यून_सम__if_सत्य_1
.L_किनारा_सामान्य_न्यून_सम_0:
  jmp .L_सामान्य_न्यून_सम__if_अंत_2
.L_सामान्य_न्यून_सम__if_अंत_2:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सामान्य_न्यून_सम
.L_सामान्य_न्यून_सम__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सामान्य_न्यून_सम
.L_epilogue_सामान्य_न्यून_सम:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सामान्य_अधिक_सम
  .def सामान्य_अधिक_सम; .scl 2; .type 32; .endef
सामान्य_अधिक_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सामान्य_अधिक_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सामान्य_न्यून
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सामान्य_अधिक_सम_0
  jmp .L_सामान्य_अधिक_सम__if_सत्य_1
.L_किनारा_सामान्य_अधिक_सम_0:
  jmp .L_सामान्य_अधिक_सम__if_अंत_2
.L_सामान्य_अधिक_सम__if_अंत_2:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सामान्य_अधिक_सम
.L_सामान्य_अधिक_सम__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सामान्य_अधिक_सम
.L_epilogue_सामान्य_अधिक_सम:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_न्यून
  .def पाठ_न्यून; .scl 2; .type 32; .endef
पाठ_न्यून:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_न्यून__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -48(%rbp)
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_न्यून
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -48(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_न्यून_0
  jmp .L_पाठ_न्यून__if_सत्य_1
.L_किनारा_पाठ_न्यून_0:
  jmp .L_पाठ_न्यून__if_अंत_2
.L_पाठ_न्यून__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_पाठ_न्यून__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_epilogue_पाठ_न्यून:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अधिक
  .def पाठ_अधिक; .scl 2; .type 32; .endef
पाठ_अधिक:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_अधिक__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -48(%rbp)
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_अधिक
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -48(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अधिक_0
  jmp .L_पाठ_अधिक__if_सत्य_1
.L_किनारा_पाठ_अधिक_0:
  jmp .L_पाठ_अधिक__if_अंत_2
.L_पाठ_अधिक__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_पाठ_अधिक__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_epilogue_पाठ_अधिक:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_न्यून_सम
  .def पाठ_न्यून_सम; .scl 2; .type 32; .endef
पाठ_न्यून_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_न्यून_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -48(%rbp)
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_न्यून_सम
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -48(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_न्यून_सम_0
  jmp .L_पाठ_न्यून_सम__if_सत्य_1
.L_किनारा_पाठ_न्यून_सम_0:
  jmp .L_पाठ_न्यून_सम__if_अंत_2
.L_पाठ_न्यून_सम__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_पाठ_न्यून_सम__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_epilogue_पाठ_न्यून_सम:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अधिक_सम
  .def पाठ_अधिक_सम; .scl 2; .type 32; .endef
पाठ_अधिक_सम:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_अधिक_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -48(%rbp)
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_अधिक_सम
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -48(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अधिक_सम_0
  jmp .L_पाठ_अधिक_सम__if_सत्य_1
.L_किनारा_पाठ_अधिक_सम_0:
  jmp .L_पाठ_अधिक_सम__if_अंत_2
.L_पाठ_अधिक_सम__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_पाठ_अधिक_सम__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_epilogue_पाठ_अधिक_सम:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_आवंटित
  .def पाठ_आवंटित; .scl 2; .type 32; .endef
पाठ_आवंटित:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_आवंटित__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_आवंटित_0
  jmp .L_पाठ_आवंटित__if_सत्य_1
.L_किनारा_पाठ_आवंटित_0:
  movq %rbx, %rsi
  jmp .L_पाठ_आवंटित__if_अंत_2
.L_पाठ_आवंटित__if_सत्य_1:
  movq $4, %rsi
  jmp .L_पाठ_आवंटित__if_अंत_2
.L_पाठ_आवंटित__if_अंत_2:
  movq %rsi, -72(%rbp)
  movq $16, %rdi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq $1, %rdi
  movq %r12, %r10
  addq %rdi, %r10
  movq %r10, %r13
  movq $1, %rdi
  movq %r13, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -64(%rbp)
  movq $0, %rdi
  movq %r12, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r13
  movq $0, -72(%rbp)
  movq $8, %rsi
  movq %r12, %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $16, %rsi
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $0, %rbx
  movq %r12, %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rsi
  movq %r12, %rax
  jmp .L_epilogue_पाठ_आवंटित
.L_epilogue_पाठ_आवंटित:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl खंड_प्रतिलिपि
  .def खंड_प्रतिलिपि; .scl 2; .type 32; .endef
खंड_प्रतिलिपि:
  pushq %rbp
  movq %rsp, %rbp
  subq $144, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, -104(%rbp)
  movq %r9, -88(%rbp)
  movq 48(%rbp), %r10
  movq %r10, -72(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_खंड_प्रतिलिपि__प्रवेश_0:
  movq $0, %r14
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_1
.L_खंड_प्रतिलिपि__wh_शर्त_1:
  movq %r14, -120(%rbp)
  movq $8, %r15
  movq %r14, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_खंड_प्रतिलिपि_0
  jmp .L_खंड_प्रतिलिपि__wh_देह_2
.L_किनारा_खंड_प्रतिलिपि_0:
  jmp .L_खंड_प्रतिलिपि__wh_अंत_3
.L_खंड_प्रतिलिपि__wh_अंत_3:
  movq %r14, %r13
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_4
.L_खंड_प्रतिलिपि__wh_शर्त_4:
  movq %r13, -128(%rbp)
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_खंड_प्रतिलिपि_1
  jmp .L_खंड_प्रतिलिपि__wh_देह_5
.L_किनारा_खंड_प्रतिलिपि_1:
  jmp .L_खंड_प्रतिलिपि__wh_अंत_6
.L_खंड_प्रतिलिपि__wh_अंत_6:
  movq $0, %r15
  movq %r15, %rax
  jmp .L_epilogue_खंड_प्रतिलिपि
.L_खंड_प्रतिलिपि__wh_देह_5:
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq -88(%rbp), %r10
  addq %r13, %r10
  movq %r10, %r12
  movq -104(%rbp), %r10
  movq %r12, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rbx, %r10
  movq %r15, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $1, %rdi
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $0, -128(%rbp)
  movq %r12, %r13
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_4
.L_खंड_प्रतिलिपि__wh_देह_2:
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %rdi
  movq -88(%rbp), %r10
  addq %r14, %r10
  movq %r10, %r12
  movq -104(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %rdi, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r12
  movq $8, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $0, -120(%rbp)
  movq %r12, %r14
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_1
.L_epilogue_खंड_प्रतिलिपि:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_प्रति
  .def पाठ_प्रति; .scl 2; .type 32; .endef
पाठ_प्रति:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, %rdi
  movq $0, -80(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_प्रति__प्रवेश_0:
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -80(%rbp)
  movq $16, %r13
  movq $16, %r14
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %r15
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %r12, %rcx
  movq %r13, %rdx
  movq %rbx, %r8
  movq %r15, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rsi
  movq %r12, %rax
  jmp .L_epilogue_पाठ_प्रति
.L_epilogue_पाठ_प्रति:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_जोड़
  .def पाठ_जोड़; .scl 2; .type 32; .endef
पाठ_जोड़:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -72(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_जोड़__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_जोड़_0
  jmp .L_पाठ_जोड़__sc_दायाँ_1
.L_किनारा_पाठ_जोड़_0:
  jmp .L_पाठ_जोड़__sc_लघु_2
.L_पाठ_जोड़__sc_लघु_2:
  movq $0, %rdi
  jmp .L_पाठ_जोड़__sc_अंत_3
.L_पाठ_जोड़__sc_दायाँ_1:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_जोड़__sc_अंत_3
.L_पाठ_जोड़__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_जोड़_1
  jmp .L_पाठ_जोड़__if_सत्य_4
.L_किनारा_पाठ_जोड़_1:
  jmp .L_पाठ_जोड़__if_अंत_5
.L_पाठ_जोड़__if_अंत_5:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_जोड़_2
  jmp .L_पाठ_जोड़__if_सत्य_6
.L_किनारा_पाठ_जोड़_2:
  jmp .L_पाठ_जोड़__if_अंत_7
.L_पाठ_जोड़__if_अंत_7:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_जोड़_3
  jmp .L_पाठ_जोड़__if_सत्य_8
.L_किनारा_पाठ_जोड़_3:
  jmp .L_पाठ_जोड़__if_अंत_9
.L_पाठ_जोड़__if_अंत_9:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -88(%rbp)
  movq $16, %rdi
  movq $16, %r15
  subq $8, %rsp
  movq %r12, %r11
  pushq %r11
  movq %r14, %rcx
  movq %rdi, %rdx
  movq %rbx, %r8
  movq %r15, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq $16, %rsi
  subq $8, %rsp
  movq %r13, %r11
  pushq %r11
  movq %r14, %rcx
  movq %rdi, %rdx
  movq -72(%rbp), %r8
  movq %rsi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r12
  movq %r14, %rax
  jmp .L_epilogue_पाठ_जोड़
.L_पाठ_जोड़__if_सत्य_8:
  movq $0, %rsi
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rbx, %rcx
  movq %rsi, %rdx
  movq %r12, %r8
  subq $32, %rsp
  call पाठ_प्रति
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_जोड़
.L_पाठ_जोड़__if_सत्य_6:
  movq $0, %rbx
  movq $8, %rsi
  movq -72(%rbp), %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq -72(%rbp), %rcx
  movq %rbx, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call पाठ_प्रति
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_जोड़
.L_पाठ_जोड़__if_सत्य_4:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_जोड़
.L_epilogue_पाठ_जोड़:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl अंक_गणना
  .def अंक_गणना; .scl 2; .type 32; .endef
अंक_गणना:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx

.L_अंक_गणना__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अंक_गणना_0
  jmp .L_अंक_गणना__if_सत्य_1
.L_किनारा_अंक_गणना_0:
  jmp .L_अंक_गणना__if_अंत_2
.L_अंक_गणना__if_अंत_2:
  movq $0, %rsi
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_अंक_गणना_1
  jmp .L_अंक_गणना__if_सत्य_3
.L_किनारा_अंक_गणना_1:
  movq %rbx, %r11
  movq %rsi, %rbx
  movq %r11, %rsi
  jmp .L_अंक_गणना__if_अंत_4
.L_अंक_गणना__if_सत्य_3:
  movq $1, %rsi
  movq $0, %rdi
  movq %rdi, %r10
  subq %rbx, %r10
  movq %r10, %r12
  movq %rsi, %rbx
  movq %r12, %rsi
  jmp .L_अंक_गणना__if_अंत_4
.L_अंक_गणना__if_अंत_4:
  jmp .L_अंक_गणना__wh_शर्त_5
.L_अंक_गणना__wh_शर्त_5:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_अंक_गणना_2
  jmp .L_अंक_गणना__wh_देह_6
.L_किनारा_अंक_गणना_2:
  jmp .L_अंक_गणना__wh_अंत_7
.L_अंक_गणना__wh_अंत_7:
  movq %rbx, %rax
  jmp .L_epilogue_अंक_गणना
.L_अंक_गणना__wh_देह_6:
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $10, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq %rdi, %rsi
  movq %r12, %rbx
  jmp .L_अंक_गणना__wh_शर्त_5
.L_अंक_गणना__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अंक_गणना
.L_epilogue_अंक_गणना:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl संख्या_से_पाठ
  .def संख्या_से_पाठ; .scl 2; .type 32; .endef
संख्या_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $144, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -72(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_संख्या_से_पाठ__प्रवेश_0:
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_संख्या_से_पाठ_0
  jmp .L_संख्या_से_पाठ__if_सत्य_1
.L_किनारा_संख्या_से_पाठ_0:
  jmp .L_संख्या_से_पाठ__if_अंत_2
.L_संख्या_से_पाठ__if_अंत_2:
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call अंक_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -104(%rbp)
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, -88(%rbp)
  movq -88(%rbp), %r11
  movq %r11, -112(%rbp)
  movq $0, %r12
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_संख्या_से_पाठ_1
  jmp .L_संख्या_से_पाठ__if_सत्य_3
.L_किनारा_संख्या_से_पाठ_1:
  jmp .L_संख्या_से_पाठ__if_अंत_4
.L_संख्या_से_पाठ__if_अंत_4:
  movq $0, %r12
  movq $0, %r13
  movq -72(%rbp), %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_संख्या_से_पाठ_2
  jmp .L_संख्या_से_पाठ__if_सत्य_5
.L_किनारा_संख्या_से_पाठ_2:
  movq %r12, %r13
  movq -72(%rbp), %r12
  jmp .L_संख्या_से_पाठ__if_अंत_6
.L_संख्या_से_पाठ__if_सत्य_5:
  movq $1, %r12
  movq $0, %r13
  movq %r13, %r10
  subq -72(%rbp), %r10
  movq %r10, %r14
  movq %r12, %r13
  movq %r14, %r12
  jmp .L_संख्या_से_पाठ__if_अंत_6
.L_संख्या_से_पाठ__if_अंत_6:
  movq %r13, -120(%rbp)
  movq $1, %r14
  movq %rsi, %r10
  subq %r14, %r10
  movq %r10, %r15
  movq $0, -104(%rbp)
  movq %r12, %rsi
  movq %r15, %r12
  jmp .L_संख्या_से_पाठ__wh_शर्त_7
.L_संख्या_से_पाठ__wh_शर्त_7:
  movq %rsi, -128(%rbp)
  movq %r12, -136(%rbp)
  movq $0, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_संख्या_से_पाठ_3
  jmp .L_संख्या_से_पाठ__wh_देह_8
.L_किनारा_संख्या_से_पाठ_3:
  jmp .L_संख्या_से_पाठ__wh_अंत_9
.L_संख्या_से_पाठ__wh_अंत_9:
  movq $1, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_संख्या_से_पाठ_4
  jmp .L_संख्या_से_पाठ__if_सत्य_10
.L_किनारा_संख्या_से_पाठ_4:
  jmp .L_संख्या_से_पाठ__if_अंत_11
.L_संख्या_से_पाठ__if_सत्य_10:
  movq $16, %r14
  movq $45, %r15
  movq -88(%rbp), %r10
  movq %r14, %r11
  movq %r15, %r8
  movb %r8b, (%r10,%r11)
  movq %r15, %rbx
  jmp .L_संख्या_से_पाठ__if_अंत_11
.L_संख्या_से_पाठ__if_अंत_11:
  movq -88(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_संख्या_से_पाठ__wh_देह_8:
  movq $16, %rbx
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq $48, %rbx
  movq $10, %r15
  movq %rsi, %rax
  movq %r15, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r15
  movq -88(%rbp), %r10
  movq %r14, %r11
  movq %r15, %r8
  movb %r8b, (%r10,%r11)
  movq %r15, %rbx
  movq $10, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $0, -128(%rbp)
  movq $1, %rbx
  movq %r12, %r10
  subq %rbx, %r10
  movq %r10, %rsi
  movq $0, -136(%rbp)
  movq %rsi, %r12
  movq %rdi, %rsi
  jmp .L_संख्या_से_पाठ__wh_शर्त_7
.L_संख्या_से_पाठ__if_सत्य_3:
  movq $16, %rbx
  movq $48, %rsi
  movq -88(%rbp), %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %rdi
  movq -88(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_संख्या_से_पाठ__if_सत्य_1:
  movq -72(%rbp), %rax
  jmp .L_epilogue_संख्या_से_पाठ
.L_epilogue_संख्या_से_पाठ:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl बूल_से_पाठ
  .def बूल_से_पाठ; .scl 2; .type 32; .endef
बूल_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_बूल_से_पाठ__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_बूल_से_पाठ_0
  jmp .L_बूल_से_पाठ__if_सत्य_1
.L_किनारा_बूल_से_पाठ_0:
  jmp .L_बूल_से_पाठ__if_अंत_2
.L_बूल_से_पाठ__if_अंत_2:
  movq $15, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -64(%rbp)
  movq $16, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $17, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $18, %rbx
  movq $133, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $19, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $20, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $21, %rbx
  movq $184, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $22, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $23, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $24, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $25, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $26, %rbx
  movq $165, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $27, %rbx
  movq $141, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $28, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $29, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $30, %rbx
  movq $175, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq %rsi, %rax
  jmp .L_epilogue_बूल_से_पाठ
.L_बूल_से_पाठ__if_सत्य_1:
  movq $12, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -56(%rbp)
  movq $16, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $17, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $18, %rbx
  movq $184, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $19, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $20, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $21, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $22, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $23, %rbx
  movq $165, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $24, %rbx
  movq $141, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $25, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $26, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $27, %rbx
  movq $175, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq %rsi, %rax
  jmp .L_epilogue_बूल_से_पाठ
.L_epilogue_बूल_से_पाठ:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शून्य_से_पाठ
  .def शून्य_से_पाठ; .scl 2; .type 32; .endef
शून्य_से_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq $0, -56(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शून्य_से_पाठ__प्रवेश_0:
  movq $21, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -56(%rbp)
  movq $16, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $17, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $18, %rbx
  movq $182, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $19, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $20, %rbx
  movq $165, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $21, %rbx
  movq $130, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $22, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $23, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $24, %rbx
  movq $168, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $25, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $26, %rbx
  movq $165, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $27, %rbx
  movq $141, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $28, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $29, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $30, %rbx
  movq $175, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $31, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $32, %rbx
  movq $164, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $33, %rbx
  movq $174, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $34, %rbx
  movq $224, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $35, %rbx
  movq $165, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $36, %rbx
  movq $141, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq %rsi, %rax
  jmp .L_epilogue_शून्य_से_पाठ
.L_epilogue_शून्य_से_पाठ:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl अक्षर_बना
  .def अक्षर_बना; .scl 2; .type 32; .endef
अक्षर_बना:
  pushq %rbp
  movq %rsp, %rbp
  subq $128, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -96(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_अक्षर_बना__प्रवेश_0:
  movq $128, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बना_0
  jmp .L_अक्षर_बना__if_सत्य_1
.L_किनारा_अक्षर_बना_0:
  jmp .L_अक्षर_बना__if_अंत_2
.L_अक्षर_बना__if_अंत_2:
  movq $2048, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बना_1
  jmp .L_अक्षर_बना__if_सत्य_3
.L_किनारा_अक्षर_बना_1:
  jmp .L_अक्षर_बना__if_अंत_4
.L_अक्षर_बना__if_अंत_4:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बना_2
  jmp .L_अक्षर_बना__if_सत्य_5
.L_किनारा_अक्षर_बना_2:
  jmp .L_अक्षर_बना__if_अंत_6
.L_अक्षर_बना__if_अंत_6:
  movq $1114111, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_अक्षर_बना_3
  jmp .L_अक्षर_बना__if_सत्य_7
.L_किनारा_अक्षर_बना_3:
  jmp .L_अक्षर_बना__if_अंत_8
.L_अक्षर_बना__if_अंत_8:
  movq $3, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -112(%rbp)
  movq $16, %rsi
  movq $239, %r12
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %r13
  movq $17, %rsi
  movq $191, %r12
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %r13
  movq $18, %rsi
  movq $189, %r12
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %r13
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_बना
.L_अक्षर_बना__if_सत्य_7:
  movq $4, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -104(%rbp)
  movq $16, %rsi
  movq $240, %r12
  movq $262144, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $17, %rsi
  movq $128, %r12
  movq $4096, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq $64, %r13
  movq %r14, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq %r12, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $18, %rsi
  movq $128, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq $64, %r13
  movq %r14, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq %r12, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $19, %rsi
  movq $128, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_बना
.L_अक्षर_बना__if_सत्य_5:
  movq $3, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -96(%rbp)
  movq $16, %rsi
  movq $224, %r12
  movq $4096, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $17, %rsi
  movq $128, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq $64, %r13
  movq %r14, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq %r12, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $18, %rsi
  movq $128, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_बना
.L_अक्षर_बना__if_सत्य_3:
  movq $2, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -88(%rbp)
  movq $16, %rsi
  movq $192, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq $17, %rsi
  movq $128, %r12
  movq $64, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r12
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_बना
.L_अक्षर_बना__if_सत्य_1:
  movq $1, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq $16, %rsi
  movq %rdi, %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %r12
  movq %rdi, %rax
  jmp .L_epilogue_अक्षर_बना
.L_epilogue_अक्षर_बना:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_उपखंड
  .def पाठ_उपखंड; .scl 2; .type 32; .endef
पाठ_उपखंड:
  pushq %rbp
  movq %rsp, %rbp
  subq $192, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi
  movq %r8, -120(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
  movq $0, -160(%rbp)
  movq $0, -168(%rbp)
  movq $0, -176(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -144(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -152(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -160(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -168(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -176(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_उपखंड__प्रवेश_0:
  movq $0, %r12
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_0
  jmp .L_पाठ_उपखंड__if_सत्य_1
.L_किनारा_पाठ_उपखंड_0:
  jmp .L_पाठ_उपखंड__if_अंत_2
.L_पाठ_उपखंड__if_अंत_2:
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_1
  jmp .L_पाठ_उपखंड__sc_लघु_4
.L_किनारा_पाठ_उपखंड_1:
  jmp .L_पाठ_उपखंड__sc_दायाँ_3
.L_पाठ_उपखंड__sc_दायाँ_3:
  movq $0, %r12
  movq -120(%rbp), %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r12
  jmp .L_पाठ_उपखंड__sc_अंत_5
.L_पाठ_उपखंड__sc_लघु_4:
  movq $1, %r12
  jmp .L_पाठ_उपखंड__sc_अंत_5
.L_पाठ_उपखंड__sc_अंत_5:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_2
  jmp .L_पाठ_उपखंड__if_सत्य_6
.L_किनारा_पाठ_उपखंड_2:
  jmp .L_पाठ_उपखंड__if_अंत_7
.L_पाठ_उपखंड__if_अंत_7:
  movq $8, %r12
  movq -72(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call पाठ_कोडबिंदु_गणना
  addq $32, %rsp
  movq %rax, -104(%rbp)
  movq -104(%rbp), %r11
  movq %r11, -136(%rbp)
  movq %rsi, %r10
  cmpq -104(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_3
  jmp .L_पाठ_उपखंड__sc_लघु_9
.L_किनारा_पाठ_उपखंड_3:
  jmp .L_पाठ_उपखंड__sc_दायाँ_8
.L_पाठ_उपखंड__sc_दायाँ_8:
  movq -120(%rbp), %r10
  cmpq -104(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  jmp .L_पाठ_उपखंड__sc_अंत_10
.L_पाठ_उपखंड__sc_लघु_9:
  movq $1, %r14
  jmp .L_पाठ_उपखंड__sc_अंत_10
.L_पाठ_उपखंड__sc_अंत_10:
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_4
  jmp .L_पाठ_उपखंड__if_सत्य_11
.L_किनारा_पाठ_उपखंड_4:
  jmp .L_पाठ_उपखंड__if_अंत_12
.L_पाठ_उपखंड__if_अंत_12:
  movq %rsi, %r10
  cmpq -120(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_5
  jmp .L_पाठ_उपखंड__if_सत्य_13
.L_किनारा_पाठ_उपखंड_5:
  jmp .L_पाठ_उपखंड__if_अंत_14
.L_पाठ_उपखंड__if_अंत_14:
  movq %rsi, %r10
  cmpq -120(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_6
  jmp .L_पाठ_उपखंड__if_सत्य_15
.L_किनारा_पाठ_उपखंड_6:
  jmp .L_पाठ_उपखंड__if_अंत_16
.L_पाठ_उपखंड__if_अंत_16:
  movq $0, %r14
  movq $0, %r15
  movq $0, %rbx
  movq %rbx, %r11
  movq %r14, %rbx
  movq %r15, %r14
  movq %r11, %r15
  jmp .L_पाठ_उपखंड__wh_शर्त_17
.L_पाठ_उपखंड__wh_शर्त_17:
  movq %rbx, -152(%rbp)
  movq %r14, -160(%rbp)
  movq %r15, -168(%rbp)
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_7
  jmp .L_पाठ_उपखंड__wh_देह_18
.L_किनारा_पाठ_उपखंड_7:
  movq -88(%rbp), %rsi
  jmp .L_पाठ_उपखंड__wh_अंत_19
.L_पाठ_उपखंड__wh_देह_18:
  movq $16, %r13
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r12
  movq -72(%rbp), %r10
  movq %r12, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -144(%rbp)
  movq %r15, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_add_dynamic
  addq $32, %rsp
  movq %rax, %r13
  movq $0, -144(%rbp)
  movq %r14, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_8
  jmp .L_पाठ_उपखंड__if_सत्य_20
.L_किनारा_पाठ_उपखंड_8:
  jmp .L_पाठ_उपखंड__if_अंत_21
.L_पाठ_उपखंड__if_सत्य_20:
  movq %r15, %rbx
  jmp .L_पाठ_उपखंड__if_अंत_21
.L_पाठ_उपखंड__if_अंत_21:
  movq %r14, %r10
  cmpq -120(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_9
  jmp .L_पाठ_उपखंड__if_सत्य_22
.L_किनारा_पाठ_उपखंड_9:
  jmp .L_पाठ_उपखंड__if_अंत_23
.L_पाठ_उपखंड__if_अंत_23:
  movq $1, %r12
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq $0, -160(%rbp)
  movq %r13, %r15
  movq %rdi, %r14
  jmp .L_पाठ_उपखंड__wh_शर्त_17
.L_पाठ_उपखंड__if_सत्य_22:
  movq %r15, %rsi
  jmp .L_पाठ_उपखंड__wh_अंत_19
.L_पाठ_उपखंड__wh_अंत_19:
  movq %rbx, -176(%rbp)
  movq -120(%rbp), %r10
  cmpq -104(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq $0, -136(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_10
  jmp .L_पाठ_उपखंड__if_सत्य_24
.L_किनारा_पाठ_उपखंड_10:
  jmp .L_पाठ_उपखंड__if_अंत_25
.L_पाठ_उपखंड__if_सत्य_24:
  movq -88(%rbp), %rsi
  jmp .L_पाठ_उपखंड__if_अंत_25
.L_पाठ_उपखंड__if_अंत_25:
  movq %rsi, %r10
  subq %rbx, %r10
  movq %r10, %rdi
  movq -72(%rbp), %rcx
  movq %rbx, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call पाठ_प्रति
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -176(%rbp)
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_उपखंड
.L_पाठ_उपखंड__if_सत्य_15:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_उपखंड
.L_पाठ_उपखंड__if_सत्य_13:
  leaq .LC_str_2(%rip), %rcx
  movq .LC_str_2_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_उपखंड__if_सत्य_11:
  leaq .LC_str_1(%rip), %rcx
  movq .LC_str_1_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_उपखंड__if_सत्य_6:
  leaq .LC_str_0(%rip), %rcx
  movq .LC_str_0_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_उपखंड__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_उपखंड
.L_epilogue_पाठ_उपखंड:
  subl $6, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष_हैश
  .def कोष_हैश; .scl 2; .type 32; .endef
कोष_हैश:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_कोष_हैश__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_हैश_0
  jmp .L_कोष_हैश__if_सत्य_1
.L_किनारा_कोष_हैश_0:
  jmp .L_कोष_हैश__if_अंत_2
.L_कोष_हैश__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_native_is_string
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_हैश_1
  jmp .L_कोष_हैश__if_सत्य_3
.L_किनारा_कोष_हैश_1:
  jmp .L_कोष_हैश__if_अंत_4
.L_कोष_हैश__if_अंत_4:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq $0, %r12
  jmp .L_कोष_हैश__wh_शर्त_5
.L_कोष_हैश__wh_शर्त_5:
  movq %r12, -72(%rbp)
  movq %r12, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_हैश_2
  jmp .L_कोष_हैश__wh_देह_6
.L_किनारा_कोष_हैश_2:
  jmp .L_कोष_हैश__wh_अंत_7
.L_कोष_हैश__wh_अंत_7:
  movq %rsi, %rax
  jmp .L_epilogue_कोष_हैश
.L_कोष_हैश__wh_देह_6:
  movq $31, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq $16, %rsi
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq $1000000007, %rsi
  movq %r13, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq $1, %rsi
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq $0, -72(%rbp)
  movq %r13, %r12
  movq %r14, %rsi
  jmp .L_कोष_हैश__wh_शर्त_5
.L_कोष_हैश__if_सत्य_3:
  movq $16, %rsi
  movq %rbx, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_कोष_हैश
.L_कोष_हैश__if_सत्य_1:
  movq %rbx, %rax
  jmp .L_epilogue_कोष_हैश
.L_epilogue_कोष_हैश:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष_स्लॉट
  .def कोष_स्लॉट; .scl 2; .type 32; .endef
कोष_स्लॉट:
  pushq %rbp
  movq %rsp, %rbp
  subq $112, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -88(%rbp)
  movq $0, -96(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -96(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_कोष_स्लॉट__प्रवेश_0:
  movq $32, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $24, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $16, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %rsi, %rcx
  subq $32, %rsp
  call कोष_हैश
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -88(%rbp)
  movq %rbx, %rax
  movq %r12, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq $0, -88(%rbp)
  movq $0, %rbx
  movq %rdi, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_स्लॉट_0
  jmp .L_कोष_स्लॉट__if_सत्य_1
.L_किनारा_कोष_स्लॉट_0:
  movq %rdi, %rbx
  jmp .L_कोष_स्लॉट__if_अंत_2
.L_कोष_स्लॉट__if_सत्य_1:
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %rbx
  jmp .L_कोष_स्लॉट__if_अंत_2
.L_कोष_स्लॉट__if_अंत_2:
  movq %rbx, -72(%rbp)
  jmp .L_कोष_स्लॉट__wh_शर्त_3
.L_कोष_स्लॉट__wh_शर्त_3:
  movq -72(%rbp), %r11
  movq %r11, -96(%rbp)
  movq $1, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_स्लॉट_1
  jmp .L_कोष_स्लॉट__wh_देह_4
.L_किनारा_कोष_स्लॉट_1:
  jmp .L_कोष_स्लॉट__wh_अंत_5
.L_कोष_स्लॉट__wh_अंत_5:
  movq $0, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_कोष_स्लॉट__wh_देह_4:
  movq $8, %rdi
  movq -72(%rbp), %r10
  imulq %rdi, %r10
  movq %r10, %r15
  movq %r13, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %r15
  movq %rdi, %r10
  cmpq %r15, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_स्लॉट_2
  jmp .L_कोष_स्लॉट__if_सत्य_6
.L_किनारा_कोष_स्लॉट_2:
  jmp .L_कोष_स्लॉट__if_अंत_7
.L_कोष_स्लॉट__if_अंत_7:
  movq $1, %rbx
  movq %rdi, %r10
  subq %rbx, %r10
  movq %r10, %r15
  movq $16, %rbx
  movq %r15, %r10
  imulq %rbx, %r10
  movq %r10, %rdi
  movq %r14, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_स्लॉट_3
  jmp .L_कोष_स्लॉट__if_सत्य_8
.L_किनारा_कोष_स्लॉट_3:
  jmp .L_कोष_स्लॉट__if_अंत_9
.L_कोष_स्लॉट__if_अंत_9:
  movq $1, %rbx
  movq -72(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq %r12, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_स्लॉट_4
  jmp .L_कोष_स्लॉट__if_सत्य_10
.L_किनारा_कोष_स्लॉट_4:
  movq %rdi, %rbx
  jmp .L_कोष_स्लॉट__if_अंत_11
.L_कोष_स्लॉट__if_सत्य_10:
  movq $0, %rbx
  jmp .L_कोष_स्लॉट__if_अंत_11
.L_कोष_स्लॉट__if_अंत_11:
  movq %rbx, -72(%rbp)
  jmp .L_कोष_स्लॉट__wh_शर्त_3
.L_कोष_स्लॉट__if_सत्य_8:
  movq -72(%rbp), %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_कोष_स्लॉट__if_सत्य_6:
  movq -72(%rbp), %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_epilogue_कोष_स्लॉट:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष_सूचकांक_भरो
  .def कोष_सूचकांक_भरो; .scl 2; .type 32; .endef
कोष_सूचकांक_भरो:
  pushq %rbp
  movq %rsp, %rbp
  subq $128, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movq $0, -120(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_कोष_सूचकांक_भरो__प्रवेश_0:
  movq $32, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $16, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $0, %rbx
  movq %rbx, -72(%rbp)
  jmp .L_कोष_सूचकांक_भरो__wh_शर्त_1
.L_कोष_सूचकांक_भरो__wh_शर्त_1:
  movq -72(%rbp), %r11
  movq %r11, -112(%rbp)
  movq -72(%rbp), %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_0
  jmp .L_कोष_सूचकांक_भरो__wh_देह_2
.L_किनारा_कोष_सूचकांक_भरो_0:
  jmp .L_कोष_सूचकांक_भरो__wh_अंत_3
.L_कोष_सूचकांक_भरो__wh_अंत_3:
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_कोष_सूचकांक_भरो
.L_कोष_सूचकांक_भरो__wh_देह_2:
  movq $16, %rsi
  movq -72(%rbp), %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq %r13, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call कोष_हैश
  addq $32, %rsp
  movq %rax, %r15
  movq %r15, -104(%rbp)
  movq %r15, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq $0, -104(%rbp)
  movq $0, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_1
  jmp .L_कोष_सूचकांक_भरो__if_सत्य_4
.L_किनारा_कोष_सूचकांक_भरो_1:
  movq %rsi, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_5
.L_कोष_सूचकांक_भरो__if_सत्य_4:
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_5
.L_कोष_सूचकांक_भरो__if_अंत_5:
  jmp .L_कोष_सूचकांक_भरो__wh_शर्त_6
.L_कोष_सूचकांक_भरो__wh_शर्त_6:
  movq %rbx, -120(%rbp)
  movq $8, %rsi
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $0, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_2
  jmp .L_कोष_सूचकांक_भरो__wh_देह_7
.L_किनारा_कोष_सूचकांक_भरो_2:
  jmp .L_कोष_सूचकांक_भरो__wh_अंत_8
.L_कोष_सूचकांक_भरो__wh_अंत_8:
  movq $8, %rsi
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r14
  movq $1, %rsi
  movq -72(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %r14, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %rsi
  movq $1, %rsi
  movq -72(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %r14, -72(%rbp)
  jmp .L_कोष_सूचकांक_भरो__wh_शर्त_1
.L_कोष_सूचकांक_भरो__wh_देह_7:
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq $0, -120(%rbp)
  movq %r14, %r10
  cmpq %rdi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_3
  jmp .L_कोष_सूचकांक_भरो__if_सत्य_9
.L_किनारा_कोष_सूचकांक_भरो_3:
  movq %r14, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_10
.L_कोष_सूचकांक_भरो__if_सत्य_9:
  movq $0, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_10
.L_कोष_सूचकांक_भरो__if_अंत_10:
  jmp .L_कोष_सूचकांक_भरो__wh_शर्त_6
.L_epilogue_कोष_सूचकांक_भरो:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_रचना
  .def शब्दकोश_रचना; .scl 2; .type 32; .endef
शब्दकोश_रचना:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq $0, -72(%rbp)
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शब्दकोश_रचना__प्रवेश_0:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rbx
  movq $40, %rbx
  movq $4, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -72(%rbp)
  movq $64, %rbx
  movq $2, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -80(%rbp)
  movq $64, %rbx
  movq $2, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -88(%rbp)
  movq $0, %rbx
  movq $0, %rsi
  movq %rdi, %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r14
  movq $8, %rbx
  movq $4, %rsi
  movq %rdi, %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r14
  movq $16, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %rsi
  movq $0, -80(%rbp)
  movq $24, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %rsi
  movq $0, -88(%rbp)
  movq $32, %rbx
  movq $8, %rsi
  movq %rdi, %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r12
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rdi, %rax
  jmp .L_epilogue_शब्दकोश_रचना
.L_epilogue_शब्दकोश_रचना:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_पाओ
  .def शब्दकोश_पाओ; .scl 2; .type 32; .endef
शब्दकोश_पाओ:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -64(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शब्दकोश_पाओ__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_पाओ_0
  jmp .L_शब्दकोश_पाओ__if_सत्य_1
.L_किनारा_शब्दकोश_पाओ_0:
  jmp .L_शब्दकोश_पाओ__if_अंत_2
.L_शब्दकोश_पाओ__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %r12, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_पाओ_1
  jmp .L_शब्दकोश_पाओ__if_सत्य_3
.L_किनारा_शब्दकोश_पाओ_1:
  jmp .L_शब्दकोश_पाओ__if_अंत_4
.L_शब्दकोश_पाओ__if_अंत_4:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r13
  movq $0, -64(%rbp)
  movq %r12, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_पाओ_2
  jmp .L_शब्दकोश_पाओ__if_सत्य_5
.L_किनारा_शब्दकोश_पाओ_2:
  jmp .L_शब्दकोश_पाओ__if_अंत_6
.L_शब्दकोश_पाओ__if_अंत_6:
  movq $16, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $1, %rbx
  movq %rsi, %r10
  subq %rbx, %r10
  movq %r10, %rdi
  movq $16, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %rsi
  movq $8, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %r12, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_पाओ
.L_शब्दकोश_पाओ__if_सत्य_5:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_पाओ
.L_शब्दकोश_पाओ__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_पाओ
.L_शब्दकोश_पाओ__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_पाओ
.L_epilogue_शब्दकोश_पाओ:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_कुंजी_है
  .def शब्दकोश_कुंजी_है; .scl 2; .type 32; .endef
शब्दकोश_कुंजी_है:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -64(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शब्दकोश_कुंजी_है__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_कुंजी_है_0
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_1
.L_किनारा_शब्दकोश_कुंजी_है_0:
  jmp .L_शब्दकोश_कुंजी_है__if_अंत_2
.L_शब्दकोश_कुंजी_है__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %r12, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_कुंजी_है_1
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_3
.L_किनारा_शब्दकोश_कुंजी_है_1:
  jmp .L_शब्दकोश_कुंजी_है__if_अंत_4
.L_शब्दकोश_कुंजी_है__if_अंत_4:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %rsi
  movq $0, -64(%rbp)
  movq %r12, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_कुंजी_है_2
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_5
.L_किनारा_शब्दकोश_कुंजी_है_2:
  jmp .L_शब्दकोश_कुंजी_है__if_अंत_6
.L_शब्दकोश_कुंजी_है__if_अंत_6:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_कुंजी_है
.L_शब्दकोश_कुंजी_है__if_सत्य_5:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_कुंजी_है
.L_शब्दकोश_कुंजी_है__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_कुंजी_है
.L_शब्दकोश_कुंजी_है__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_कुंजी_है
.L_epilogue_शब्दकोश_कुंजी_है:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_सेट
  .def शब्दकोश_सेट; .scl 2; .type 32; .endef
शब्दकोश_सेट:
  pushq %rbp
  movq %rsp, %rbp
  subq $144, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, -72(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शब्दकोश_सेट__प्रवेश_0:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_सेट_0
  jmp .L_शब्दकोश_सेट__if_सत्य_1
.L_किनारा_शब्दकोश_सेट_0:
  jmp .L_शब्दकोश_सेट__if_अंत_2
.L_शब्दकोश_सेट__if_अंत_2:
  movq $0, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %r12
  movq %r13, %r10
  cmpq %r12, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_सेट_1
  jmp .L_शब्दकोश_सेट__if_सत्य_3
.L_किनारा_शब्दकोश_सेट_1:
  jmp .L_शब्दकोश_सेट__if_अंत_4
.L_शब्दकोश_सेट__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -104(%rbp)
  movq $24, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq $8, %r14
  movq %r12, %r10
  imulq %r14, %r10
  movq %r10, %rdi
  movq $0, -104(%rbp)
  movq %r15, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $0, %rdi
  movq -88(%rbp), %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_सेट_2
  jmp .L_शब्दकोश_सेट__if_सत्य_5
.L_किनारा_शब्दकोश_सेट_2:
  jmp .L_शब्दकोश_सेट__if_अंत_6
.L_शब्दकोश_सेट__if_अंत_6:
  jmp .L_शब्दकोश_सेट__if_अंत_4
.L_शब्दकोश_सेट__if_अंत_4:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_सेट_3
  jmp .L_शब्दकोश_सेट__if_सत्य_7
.L_किनारा_शब्दकोश_सेट_3:
  jmp .L_शब्दकोश_सेट__if_अंत_8
.L_शब्दकोश_सेट__if_सत्य_7:
  movq $2, %rdi
  movq %r14, %r10
  imulq %rdi, %r10
  movq %r10, %r15
  movq $16, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq $16, %rdi
  movq %r15, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %r14, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -112(%rbp)
  movq $8, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r14
  movq $16, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r14
  movq $0, -112(%rbp)
  jmp .L_शब्दकोश_सेट__if_अंत_8
.L_शब्दकोश_सेट__if_अंत_8:
  movq $16, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $16, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq %r12, %r10
  movq %r14, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  movq $16, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq $8, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %r15, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rdi
  movq $0, %rdi
  movq $1, %r12
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %rdi, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %r12
  movq $32, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $1, %rdi
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq $4, %rdi
  movq %r14, %r10
  imulq %rdi, %r10
  movq %r10, %r15
  movq $3, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq %r15, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_सेट_4
  jmp .L_शब्दकोश_सेट__if_सत्य_9
.L_किनारा_शब्दकोश_सेट_4:
  jmp .L_शब्दकोश_सेट__if_असत्य_11
.L_शब्दकोश_सेट__if_असत्य_11:
  movq $24, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -128(%rbp)
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq %r15, -136(%rbp)
  movq $0, -128(%rbp)
  movq $1, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %r14, %r10
  movq %r15, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rsi
  movq $0, -136(%rbp)
  jmp .L_शब्दकोश_सेट__if_अंत_10
.L_शब्दकोश_सेट__if_सत्य_9:
  movq $2, %rsi
  movq %r12, %r10
  imulq %rsi, %r10
  movq %r10, %rdi
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r13
  movq $2, %rsi
  movq %r13, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -120(%rbp)
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r13
  movq $0, -120(%rbp)
  movq $32, %rsi
  movq $2, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %rdi
  movq %rbx, %rcx
  subq $32, %rsp
  call कोष_सूचकांक_भरो
  addq $32, %rsp
  movq %rax, %rsi
  jmp .L_शब्दकोश_सेट__if_अंत_10
.L_शब्दकोश_सेट__if_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_शब्दकोश_सेट
.L_शब्दकोश_सेट__if_सत्य_5:
  movq $16, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $1, %rbx
  movq -88(%rbp), %r10
  subq %rbx, %r10
  movq %r10, %rsi
  movq $16, %rbx
  movq %rsi, %r10
  imulq %rbx, %r10
  movq %r10, %r12
  movq $8, %rbx
  movq %r12, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rdi, %r10
  movq %rsi, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rbx
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शब्दकोश_सेट
.L_शब्दकोश_सेट__if_सत्य_1:
  leaq .LC_str_3(%rip), %rcx
  movq .LC_str_3_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_शब्दकोश_सेट:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_हटाओ
  .def शब्दकोश_हटाओ; .scl 2; .type 32; .endef
शब्दकोश_हटाओ:
  pushq %rbp
  movq %rsp, %rbp
  subq $192, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi
  movq $0, -152(%rbp)
  movq $0, -160(%rbp)
  movq $0, -168(%rbp)
  movq $0, -176(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -152(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -160(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -168(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -176(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शब्दकोश_हटाओ__प्रवेश_0:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_हटाओ_0
  jmp .L_शब्दकोश_हटाओ__if_सत्य_1
.L_किनारा_शब्दकोश_हटाओ_0:
  jmp .L_शब्दकोश_हटाओ__if_अंत_2
.L_शब्दकोश_हटाओ__if_अंत_2:
  movq $0, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %r12, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_हटाओ_1
  jmp .L_शब्दकोश_हटाओ__if_सत्य_3
.L_किनारा_शब्दकोश_हटाओ_1:
  jmp .L_शब्दकोश_हटाओ__if_अंत_4
.L_शब्दकोश_हटाओ__if_अंत_4:
  movq $24, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -136(%rbp)
  movq $16, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -120(%rbp)
  movq -72(%rbp), %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq -136(%rbp), %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_हटाओ_2
  jmp .L_शब्दकोश_हटाओ__if_सत्य_5
.L_किनारा_शब्दकोश_हटाओ_2:
  jmp .L_शब्दकोश_हटाओ__if_अंत_6
.L_शब्दकोश_हटाओ__if_अंत_6:
  movq $1, %rdi
  movq %rsi, %r10
  subq %rdi, %r10
  movq %r10, %r15
  movq %r15, %rsi
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_7
.L_शब्दकोश_हटाओ__wh_शर्त_7:
  movq %rsi, -152(%rbp)
  movq -104(%rbp), %r11
  movq %r11, -160(%rbp)
  movq -88(%rbp), %r11
  movq %r11, -168(%rbp)
  movq $1, %rbx
  movq %r12, %r10
  subq %rbx, %r10
  movq %r10, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_हटाओ_3
  jmp .L_शब्दकोश_हटाओ__wh_देह_8
.L_किनारा_शब्दकोश_हटाओ_3:
  jmp .L_शब्दकोश_हटाओ__wh_अंत_9
.L_शब्दकोश_हटाओ__wh_अंत_9:
  movq $0, %rbx
  movq $1, %r15
  movq %r12, %r10
  subq %r15, %r10
  movq %r10, %rdi
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r15
  movq $32, %rbx
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rbx
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_10
.L_शब्दकोश_हटाओ__wh_शर्त_10:
  movq %rbx, -176(%rbp)
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_शब्दकोश_हटाओ_4
  jmp .L_शब्दकोश_हटाओ__wh_देह_11
.L_किनारा_शब्दकोश_हटाओ_4:
  jmp .L_शब्दकोश_हटाओ__wh_अंत_12
.L_शब्दकोश_हटाओ__wh_अंत_12:
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call कोष_सूचकांक_भरो
  addq $32, %rsp
  movq %rax, %r15
  movq -72(%rbp), %rax
  jmp .L_epilogue_शब्दकोश_हटाओ
.L_शब्दकोश_हटाओ__wh_देह_11:
  movq $8, %r15
  movq %rbx, %r10
  imulq %r15, %r10
  movq %r10, %r14
  movq $0, %r15
  movq -136(%rbp), %r10
  movq %r14, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r13
  movq $1, %r13
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $0, -176(%rbp)
  movq %r14, %rbx
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_10
.L_शब्दकोश_हटाओ__wh_देह_8:
  movq $16, %rbx
  movq %rsi, %r10
  imulq %rbx, %r10
  movq %r10, %rdi
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %r13
  movq $16, %rbx
  movq %r13, %r10
  imulq %rbx, %r10
  movq %r10, %r14
  movq -120(%rbp), %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq -120(%rbp), %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r13
  movq $16, %rbx
  movq %rsi, %r10
  imulq %rbx, %r10
  movq %r10, %rdi
  movq $8, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %r13
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $16, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %r14
  movq $8, %rbx
  movq %r14, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq -120(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq -120(%rbp), %r10
  movq %r13, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $0, -152(%rbp)
  movq %rdi, %rsi
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_7
.L_शब्दकोश_हटाओ__if_सत्य_5:
  movq -72(%rbp), %rax
  jmp .L_epilogue_शब्दकोश_हटाओ
.L_शब्दकोश_हटाओ__if_सत्य_3:
  movq -72(%rbp), %rax
  jmp .L_epilogue_शब्दकोश_हटाओ
.L_शब्दकोश_हटाओ__if_सत्य_1:
  movq -72(%rbp), %rax
  jmp .L_epilogue_शब्दकोश_हटाओ
.L_epilogue_शब्दकोश_हटाओ:
  subl $4, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_रचना
  .def सूची_रचना; .scl 2; .type 32; .endef
सूची_रचना:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movq $0, -56(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_रचना__प्रवेश_0:
  movq $16, %rsi
  movq $8, %rdi
  movq %rbx, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq $2, %rsi
  movq %rdi, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -56(%rbp)
  movq $0, %rsi
  movq %r12, %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $8, %rsi
  movq %r12, %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq %r12, %rax
  jmp .L_epilogue_सूची_रचना
.L_epilogue_सूची_रचना:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_जोड़
  .def सूची_जोड़; .scl 2; .type 32; .endef
सूची_जोड़:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_जोड़__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़_0
  jmp .L_सूची_जोड़__if_सत्य_1
.L_किनारा_सूची_जोड़_0:
  jmp .L_सूची_जोड़__if_अंत_2
.L_सूची_जोड़__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़_1
  jmp .L_सूची_जोड़__if_सत्य_3
.L_किनारा_सूची_जोड़_1:
  jmp .L_सूची_जोड़__if_अंत_4
.L_सूची_जोड़__if_अंत_4:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $4, %rdi
  movq $0, %r14
  movq %r12, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़_2
  jmp .L_सूची_जोड़__if_सत्य_5
.L_किनारा_सूची_जोड़_2:
  jmp .L_सूची_जोड़__if_अंत_6
.L_सूची_जोड़__if_सत्य_5:
  movq $2, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq %r14, %rdi
  jmp .L_सूची_जोड़__if_अंत_6
.L_सूची_जोड़__if_अंत_6:
  movq %rdi, -88(%rbp)
  movq $16, %r12
  movq $8, %r14
  movq %rdi, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r12, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %rbx, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -80(%rbp)
  movq $0, %r14
  movq %r12, %r10
  movq %r14, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r15
  movq $0, -88(%rbp)
  movq $8, %rdi
  movq $1, %r14
  movq %r13, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %rdi, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r14
  movq $16, %rdi
  movq $8, %r14
  movq %r13, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %rdi, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %r12, %r10
  movq %r14, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rdi
  movq %r12, %rax
  jmp .L_epilogue_सूची_जोड़
.L_सूची_जोड़__if_सत्य_3:
  movq $16, %rdi
  movq $8, %r12
  movq %r13, %r10
  imulq %r12, %r10
  movq %r10, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  movq $8, %rsi
  movq $1, %rdi
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %rdi
  movq %rbx, %rax
  jmp .L_epilogue_सूची_जोड़
.L_सूची_जोड़__if_सत्य_1:
  leaq .LC_str_4(%rip), %rcx
  movq .LC_str_4_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_सूची_जोड़:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_निकाल
  .def सूची_निकाल; .scl 2; .type 32; .endef
सूची_निकाल:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_निकाल__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_निकाल_0
  jmp .L_सूची_निकाल__if_सत्य_1
.L_किनारा_सूची_निकाल_0:
  jmp .L_सूची_निकाल__if_अंत_2
.L_सूची_निकाल__if_अंत_2:
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_निकाल_1
  jmp .L_सूची_निकाल__if_सत्य_3
.L_किनारा_सूची_निकाल_1:
  jmp .L_सूची_निकाल__if_अंत_4
.L_सूची_निकाल__if_अंत_4:
  movq $16, %rsi
  movq $1, %r13
  movq %r12, %r10
  subq %r13, %r10
  movq %r10, %r14
  movq $8, %r13
  movq %r14, %r10
  imulq %r13, %r10
  movq %r10, %r15
  movq %rsi, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq $0, %rsi
  movq %rbx, %r10
  movq %r13, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r14
  movq $1, %rsi
  movq %r12, %r10
  subq %rsi, %r10
  movq %r10, %r13
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r12
  movq $4, %rsi
  movq %rdi, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %r12
  movq %r13, %r10
  cmpq %r12, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_निकाल_2
  jmp .L_सूची_निकाल__if_सत्य_5
.L_किनारा_सूची_निकाल_2:
  jmp .L_सूची_निकाल__if_अंत_6
.L_सूची_निकाल__if_सत्य_5:
  movq $4, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_निकाल_3
  jmp .L_सूची_निकाल__if_सत्य_7
.L_किनारा_सूची_निकाल_3:
  jmp .L_सूची_निकाल__if_अंत_8
.L_सूची_निकाल__if_अंत_8:
  jmp .L_सूची_निकाल__if_अंत_6
.L_सूची_निकाल__if_अंत_6:
  movq %rbx, %rax
  jmp .L_epilogue_सूची_निकाल
.L_सूची_निकाल__if_सत्य_7:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $2, %rsi
  movq %rdi, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %r12
  movq $4, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_निकाल_4
  jmp .L_सूची_निकाल__if_सत्य_9
.L_किनारा_सूची_निकाल_4:
  movq %r12, %rsi
  jmp .L_सूची_निकाल__if_अंत_10
.L_सूची_निकाल__if_सत्य_9:
  movq $4, %rsi
  jmp .L_सूची_निकाल__if_अंत_10
.L_सूची_निकाल__if_अंत_10:
  movq %rsi, -88(%rbp)
  movq $16, %rdi
  movq $8, %r12
  movq %rsi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r12
  movq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq $0, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r12
  movq $0, -88(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rdi, %rax
  jmp .L_epilogue_सूची_निकाल
.L_सूची_निकाल__if_सत्य_3:
  leaq .LC_str_5(%rip), %rcx
  movq .LC_str_5_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_सूची_निकाल__if_सत्य_1:
  leaq .LC_str_5(%rip), %rcx
  movq .LC_str_5_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_सूची_निकाल:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_डाल
  .def सूची_डाल; .scl 2; .type 32; .endef
सूची_डाल:
  pushq %rbp
  movq %rsp, %rbp
  subq $160, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, -104(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -144(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_डाल__प्रवेश_0:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_0
  jmp .L_सूची_डाल__if_सत्य_1
.L_किनारा_सूची_डाल_0:
  jmp .L_सूची_डाल__if_अंत_2
.L_सूची_डाल__if_अंत_2:
  movq $0, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $8, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_1
  jmp .L_सूची_डाल__sc_लघु_4
.L_किनारा_सूची_डाल_1:
  jmp .L_सूची_डाल__sc_दायाँ_3
.L_सूची_डाल__sc_दायाँ_3:
  movq %rsi, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  jmp .L_सूची_डाल__sc_अंत_5
.L_सूची_डाल__sc_लघु_4:
  movq $1, %r12
  jmp .L_सूची_डाल__sc_अंत_5
.L_सूची_डाल__sc_अंत_5:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_2
  jmp .L_सूची_डाल__if_सत्य_6
.L_किनारा_सूची_डाल_2:
  jmp .L_सूची_डाल__if_अंत_7
.L_सूची_डाल__if_अंत_7:
  movq -72(%rbp), %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_3
  jmp .L_सूची_डाल__if_सत्य_8
.L_किनारा_सूची_डाल_3:
  movq %rbx, -88(%rbp)
  jmp .L_सूची_डाल__if_अंत_9
.L_सूची_डाल__if_सत्य_8:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r12
  movq $4, %r12
  movq $0, %r15
  movq %r13, %r10
  cmpq %r15, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_4
  jmp .L_सूची_डाल__if_सत्य_10
.L_किनारा_सूची_डाल_4:
  jmp .L_सूची_डाल__if_अंत_11
.L_सूची_डाल__if_सत्य_10:
  movq $2, %r12
  movq %r13, %r10
  imulq %r12, %r10
  movq %r10, %r14
  movq %r14, %r12
  jmp .L_सूची_डाल__if_अंत_11
.L_सूची_डाल__if_अंत_11:
  movq %r12, -128(%rbp)
  movq $16, %r13
  movq $8, %r14
  movq %r12, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %rbx, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -120(%rbp)
  movq $0, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r14
  movq $0, -128(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %r13, -88(%rbp)
  jmp .L_सूची_डाल__if_अंत_9
.L_सूची_डाल__if_अंत_9:
  movq -88(%rbp), %r11
  movq %r11, -136(%rbp)
  movq -72(%rbp), %r12
  jmp .L_सूची_डाल__wh_शर्त_12
.L_सूची_डाल__wh_शर्त_12:
  movq %r12, -144(%rbp)
  movq %r12, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_5
  jmp .L_सूची_डाल__wh_देह_13
.L_किनारा_सूची_डाल_5:
  jmp .L_सूची_डाल__wh_अंत_14
.L_सूची_डाल__wh_अंत_14:
  movq $16, %r13
  movq $8, %r14
  movq %rsi, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq -88(%rbp), %r10
  movq %r14, %r11
  movq -104(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -104(%rbp), %r13
  movq $8, %r13
  movq $1, %r14
  movq -72(%rbp), %r10
  addq %r14, %r10
  movq %r10, %r15
  movq -88(%rbp), %r10
  movq %r13, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r14
  movq -88(%rbp), %rax
  jmp .L_epilogue_सूची_डाल
.L_सूची_डाल__wh_देह_13:
  movq $16, %r13
  movq $8, %r14
  movq %r12, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq $16, %r13
  movq $1, %r15
  movq %r12, %r10
  subq %r15, %r10
  movq %r10, %rbx
  movq $8, %r15
  movq %rbx, %r10
  imulq %r15, %r10
  movq %r10, %rdi
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %rbx
  movq -88(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq -88(%rbp), %r10
  movq %r14, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rbx
  movq $1, %rbx
  movq %r12, %r10
  subq %rbx, %r10
  movq %r10, %rdi
  movq $0, -144(%rbp)
  movq %rdi, %r12
  jmp .L_सूची_डाल__wh_शर्त_12
.L_सूची_डाल__if_सत्य_6:
  leaq .LC_str_7(%rip), %rcx
  movq .LC_str_7_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_सूची_डाल__if_सत्य_1:
  leaq .LC_str_6(%rip), %rcx
  movq .LC_str_6_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_सूची_डाल:
  subl $4, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_हटा
  .def सूची_हटा; .scl 2; .type 32; .endef
सूची_हटा:
  pushq %rbp
  movq %rsp, %rbp
  subq $128, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movq $0, -120(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_हटा__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_0
  jmp .L_सूची_हटा__if_सत्य_1
.L_किनारा_सूची_हटा_0:
  jmp .L_सूची_हटा__if_अंत_2
.L_सूची_हटा__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_1
  jmp .L_सूची_हटा__sc_लघु_4
.L_किनारा_सूची_हटा_1:
  jmp .L_सूची_हटा__sc_दायाँ_3
.L_सूची_हटा__sc_दायाँ_3:
  movq %rsi, %r10
  cmpq -72(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  jmp .L_सूची_हटा__sc_अंत_5
.L_सूची_हटा__sc_लघु_4:
  movq $1, %rdi
  jmp .L_सूची_हटा__sc_अंत_5
.L_सूची_हटा__sc_अंत_5:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_2
  jmp .L_सूची_हटा__if_सत्य_6
.L_किनारा_सूची_हटा_2:
  jmp .L_सूची_हटा__if_अंत_7
.L_सूची_हटा__if_अंत_7:
  jmp .L_सूची_हटा__wh_शर्त_8
.L_सूची_हटा__wh_शर्त_8:
  movq %rsi, -112(%rbp)
  movq $1, %rdi
  movq -72(%rbp), %r10
  subq %rdi, %r10
  movq %r10, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_3
  jmp .L_सूची_हटा__wh_देह_9
.L_किनारा_सूची_हटा_3:
  jmp .L_सूची_हटा__wh_अंत_10
.L_सूची_हटा__wh_अंत_10:
  movq $16, %rdi
  movq $1, %r14
  movq -72(%rbp), %r10
  subq %r14, %r10
  movq %r10, %r15
  movq $8, %r14
  movq %r15, %r10
  imulq %r14, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $0, %rdi
  movq %rbx, %r10
  movq %r14, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r13
  movq $1, %rdi
  movq -72(%rbp), %r10
  subq %rdi, %r10
  movq %r10, %r13
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r14
  movq $4, %rdi
  movq -88(%rbp), %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_4
  jmp .L_सूची_हटा__if_सत्य_11
.L_किनारा_सूची_हटा_4:
  jmp .L_सूची_हटा__if_अंत_12
.L_सूची_हटा__if_सत्य_11:
  movq $4, %rdi
  movq -88(%rbp), %r10
  cmpq %rdi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_5
  jmp .L_सूची_हटा__if_सत्य_13
.L_किनारा_सूची_हटा_5:
  jmp .L_सूची_हटा__if_अंत_14
.L_सूची_हटा__if_अंत_14:
  jmp .L_सूची_हटा__if_अंत_12
.L_सूची_हटा__if_अंत_12:
  movq %rbx, %rax
  jmp .L_epilogue_सूची_हटा
.L_सूची_हटा__if_सत्य_13:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $2, %rdi
  movq -88(%rbp), %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rax, %r13
  movq $4, %rdi
  movq %r13, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_हटा_6
  jmp .L_सूची_हटा__if_सत्य_15
.L_किनारा_सूची_हटा_6:
  movq %r13, %rdi
  jmp .L_सूची_हटा__if_अंत_16
.L_सूची_हटा__if_सत्य_15:
  movq $4, %rdi
  jmp .L_सूची_हटा__if_अंत_16
.L_सूची_हटा__if_अंत_16:
  movq %rdi, -120(%rbp)
  movq $16, %r13
  movq $8, %r14
  movq %rdi, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %rbx, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -104(%rbp)
  movq $0, %r14
  movq %r13, %r10
  movq %r14, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r15
  movq $0, -120(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rdi
  movq %r13, %rax
  jmp .L_epilogue_सूची_हटा
.L_सूची_हटा__wh_देह_9:
  movq $16, %rdi
  movq $8, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq $16, %rdi
  movq $1, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq $8, %r14
  movq %r15, %r10
  imulq %r14, %r10
  movq %r10, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rbx, %r10
  movq %r13, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $1, %rdi
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $0, -112(%rbp)
  movq %r12, %rsi
  jmp .L_सूची_हटा__wh_शर्त_8
.L_सूची_हटा__if_सत्य_6:
  leaq .LC_str_9(%rip), %rcx
  movq .LC_str_9_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_सूची_हटा__if_सत्य_1:
  leaq .LC_str_8(%rip), %rcx
  movq .LC_str_8_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_सूची_हटा:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_जोड़ो_दो
  .def सूची_जोड़ो_दो; .scl 2; .type 32; .endef
सूची_जोड़ो_दो:
  pushq %rbp
  movq %rsp, %rbp
  subq $176, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -120(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
  movq $0, -160(%rbp)
  movq $0, -168(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -144(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -152(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -160(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -168(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_जोड़ो_दो__प्रवेश_0:
  movq $0, %rdi
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़ो_दो_0
  jmp .L_सूची_जोड़ो_दो__if_सत्य_1
.L_किनारा_सूची_जोड़ो_दो_0:
  movq %rdi, -104(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_2
.L_सूची_जोड़ो_दो__if_सत्य_1:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %r12, -104(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_2
.L_सूची_जोड़ो_दो__if_अंत_2:
  movq -104(%rbp), %r11
  movq %r11, -144(%rbp)
  movq $0, %r12
  movq $0, %r13
  movq -120(%rbp), %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़ो_दो_1
  jmp .L_सूची_जोड़ो_दो__if_सत्य_3
.L_किनारा_सूची_जोड़ो_दो_1:
  movq %r12, -88(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_4
.L_सूची_जोड़ो_दो__if_सत्य_3:
  movq $8, %r12
  movq -120(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, -88(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_4
.L_सूची_जोड़ो_दो__if_अंत_4:
  movq -88(%rbp), %r11
  movq %r11, -152(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r13
  movq -104(%rbp), %r10
  addq -88(%rbp), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call सूची_रचना
  addq $32, %rsp
  movq %rax, -72(%rbp)
  movq -72(%rbp), %r11
  movq %r11, -136(%rbp)
  movq $0, %r13
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_5
.L_सूची_जोड़ो_दो__wh_शर्त_5:
  movq %r13, -160(%rbp)
  movq %r13, %r10
  cmpq -104(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़ो_दो_2
  jmp .L_सूची_जोड़ो_दो__wh_देह_6
.L_किनारा_सूची_जोड़ो_दो_2:
  jmp .L_सूची_जोड़ो_दो__wh_अंत_7
.L_सूची_जोड़ो_दो__wh_अंत_7:
  movq $0, %r15
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_8
.L_सूची_जोड़ो_दो__wh_शर्त_8:
  movq %r15, -168(%rbp)
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_जोड़ो_दो_3
  jmp .L_सूची_जोड़ो_दो__wh_देह_9
.L_किनारा_सूची_जोड़ो_दो_3:
  jmp .L_सूची_जोड़ो_दो__wh_अंत_10
.L_सूची_जोड़ो_दो__wh_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %r14
  movq -72(%rbp), %rax
  jmp .L_epilogue_सूची_जोड़ो_दो
.L_सूची_जोड़ो_दो__wh_देह_9:
  movq $16, %r14
  movq -104(%rbp), %r10
  addq %r15, %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %rsi
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq $8, %r12
  movq %r15, %r10
  imulq %r12, %r10
  movq %r10, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %r12
  movq -120(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r12
  movq $1, %rsi
  movq %r15, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, -168(%rbp)
  movq %rdi, %r15
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_8
.L_सूची_जोड़ो_दो__wh_देह_6:
  movq $16, %rsi
  movq $8, %rdi
  movq %r13, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq $8, %r12
  movq %r13, %r10
  imulq %r12, %r10
  movq %r10, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r12
  movq $1, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, -160(%rbp)
  movq %rdi, %r13
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_5
.L_epilogue_सूची_जोड़ो_दो:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_खोज
  .def सूची_खोज; .scl 2; .type 32; .endef
सूची_खोज:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -80(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूची_खोज__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_खोज_0
  jmp .L_सूची_खोज__if_सत्य_1
.L_किनारा_सूची_खोज_0:
  jmp .L_सूची_खोज__if_अंत_2
.L_सूची_खोज__if_अंत_2:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  jmp .L_सूची_खोज__wh_शर्त_3
.L_सूची_खोज__wh_शर्त_3:
  movq %rdi, -80(%rbp)
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_खोज_1
  jmp .L_सूची_खोज__wh_देह_4
.L_किनारा_सूची_खोज_1:
  jmp .L_सूची_खोज__wh_अंत_5
.L_सूची_खोज__wh_अंत_5:
  movq $1, %r13
  movq %r13, %r10
  negq %r10
  movq %r10, %r14
  movq %r14, %rax
  jmp .L_epilogue_सूची_खोज
.L_सूची_खोज__wh_देह_4:
  movq $16, %r13
  movq $8, %r14
  movq %rdi, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_खोज_2
  jmp .L_सूची_खोज__if_सत्य_6
.L_किनारा_सूची_खोज_2:
  jmp .L_सूची_खोज__if_अंत_7
.L_सूची_खोज__if_अंत_7:
  movq $1, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %rdi
  jmp .L_सूची_खोज__wh_शर्त_3
.L_सूची_खोज__if_सत्य_6:
  movq %rdi, %rax
  jmp .L_epilogue_सूची_खोज
.L_सूची_खोज__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %r10
  negq %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सूची_खोज
.L_epilogue_सूची_खोज:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_बाइट_मिलान
  .def पाठ_बाइट_मिलान; .scl 2; .type 32; .endef
पाठ_बाइट_मिलान:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq %r8, %rdi
  movq %r9, -72(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_बाइट_मिलान__प्रवेश_0:
  movq $0, %r13
  jmp .L_पाठ_बाइट_मिलान__wh_शर्त_1
.L_पाठ_बाइट_मिलान__wh_शर्त_1:
  movq %r13, -88(%rbp)
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बाइट_मिलान_0
  jmp .L_पाठ_बाइट_मिलान__wh_देह_2
.L_किनारा_पाठ_बाइट_मिलान_0:
  jmp .L_पाठ_बाइट_मिलान__wh_अंत_3
.L_पाठ_बाइट_मिलान__wh_अंत_3:
  movq $1, %r14
  movq %r14, %rax
  jmp .L_epilogue_पाठ_बाइट_मिलान
.L_पाठ_बाइट_मिलान__wh_देह_2:
  movq $16, %r14
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %r15
  movq %r15, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r15
  movq $16, %r14
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r15, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बाइट_मिलान_1
  jmp .L_पाठ_बाइट_मिलान__if_सत्य_4
.L_किनारा_पाठ_बाइट_मिलान_1:
  jmp .L_पाठ_बाइट_मिलान__if_अंत_5
.L_पाठ_बाइट_मिलान__if_अंत_5:
  movq $1, %r12
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq $0, -88(%rbp)
  movq %r14, %r13
  jmp .L_पाठ_बाइट_मिलान__wh_शर्त_1
.L_पाठ_बाइट_मिलान__if_सत्य_4:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_बाइट_मिलान
.L_epilogue_पाठ_बाइट_मिलान:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_पूर्व
  .def पाठ_कोडबिंदु_पूर्व; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_पूर्व:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -72(%rbp)
  movq $0, -80(%rbp)
  movq $0, -88(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_कोडबिंदु_पूर्व__प्रवेश_0:
  movq $0, %rdi
  movq $0, %r12
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1
.L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1:
  movq %rdi, -80(%rbp)
  movq %r12, -88(%rbp)
  movq %r12, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_पूर्व_0
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_देह_2
.L_किनारा_पाठ_कोडबिंदु_पूर्व_0:
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_अंत_3
.L_पाठ_कोडबिंदु_पूर्व__wh_अंत_3:
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_पूर्व
.L_पाठ_कोडबिंदु_पूर्व__wh_देह_2:
  movq $16, %r13
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -72(%rbp)
  movq %r12, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call sutra_add_dynamic
  addq $32, %rsp
  movq %rax, %r13
  movq $0, -72(%rbp)
  movq $0, -88(%rbp)
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq $0, -80(%rbp)
  movq %r13, %r12
  movq %r14, %rdi
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1
.L_epilogue_पाठ_कोडबिंदु_पूर्व:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कोडबिंदु_खोज
  .def पाठ_कोडबिंदु_खोज; .scl 2; .type 32; .endef
पाठ_कोडबिंदु_खोज:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi
  movq $0, -80(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_कोडबिंदु_खोज__प्रवेश_0:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %rdi
  movq %r13, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_खोज_0
  jmp .L_पाठ_कोडबिंदु_खोज__if_सत्य_1
.L_किनारा_पाठ_कोडबिंदु_खोज_0:
  jmp .L_पाठ_कोडबिंदु_खोज__if_अंत_2
.L_पाठ_कोडबिंदु_खोज__if_अंत_2:
  movq $0, %rdi
  jmp .L_पाठ_कोडबिंदु_खोज__wh_शर्त_3
.L_पाठ_कोडबिंदु_खोज__wh_शर्त_3:
  movq %rdi, -80(%rbp)
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq %r12, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_खोज_1
  jmp .L_पाठ_कोडबिंदु_खोज__wh_देह_4
.L_किनारा_पाठ_कोडबिंदु_खोज_1:
  jmp .L_पाठ_कोडबिंदु_खोज__wh_अंत_5
.L_पाठ_कोडबिंदु_खोज__wh_अंत_5:
  movq $1, %r14
  movq %r14, %r10
  negq %r10
  movq %r10, %r15
  movq %r15, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_खोज
.L_पाठ_कोडबिंदु_खोज__wh_देह_4:
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq %rsi, %r8
  movq %r13, %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_खोज_2
  jmp .L_पाठ_कोडबिंदु_खोज__if_सत्य_6
.L_किनारा_पाठ_कोडबिंदु_खोज_2:
  jmp .L_पाठ_कोडबिंदु_खोज__if_अंत_7
.L_पाठ_कोडबिंदु_खोज__if_अंत_7:
  movq $1, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r15, %rdi
  jmp .L_पाठ_कोडबिंदु_खोज__wh_शर्त_3
.L_पाठ_कोडबिंदु_खोज__if_सत्य_6:
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_पूर्व
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -80(%rbp)
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_खोज
.L_पाठ_कोडबिंदु_खोज__if_सत्य_1:
  leaq .LC_str_10(%rip), %rcx
  movq .LC_str_10_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_पाठ_कोडबिंदु_खोज:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_बदल
  .def पाठ_बदल; .scl 2; .type 32; .endef
पाठ_बदल:
  pushq %rbp
  movq %rsp, %rbp
  subq $144, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi
  movq %r8, %rdi
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_बदल__प्रवेश_0:
  movq $0, %r12
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_0
  jmp .L_पाठ_बदल__sc_लघु_2
.L_किनारा_पाठ_बदल_0:
  jmp .L_पाठ_बदल__sc_दायाँ_1
.L_पाठ_बदल__sc_दायाँ_1:
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r12
  jmp .L_पाठ_बदल__sc_अंत_3
.L_पाठ_बदल__sc_लघु_2:
  movq $1, %r12
  jmp .L_पाठ_बदल__sc_अंत_3
.L_पाठ_बदल__sc_अंत_3:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_1
  jmp .L_पाठ_बदल__sc_लघु_5
.L_किनारा_पाठ_बदल_1:
  jmp .L_पाठ_बदल__sc_दायाँ_4
.L_पाठ_बदल__sc_दायाँ_4:
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r12
  jmp .L_पाठ_बदल__sc_अंत_6
.L_पाठ_बदल__sc_लघु_5:
  movq $1, %r12
  jmp .L_पाठ_बदल__sc_अंत_6
.L_पाठ_बदल__sc_अंत_6:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_2
  jmp .L_पाठ_बदल__if_सत्य_7
.L_किनारा_पाठ_बदल_2:
  jmp .L_पाठ_बदल__if_अंत_8
.L_पाठ_बदल__if_अंत_8:
  movq $8, %r12
  movq -72(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $8, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq $0, %r12
  movq -88(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_3
  jmp .L_पाठ_बदल__if_सत्य_9
.L_किनारा_पाठ_बदल_3:
  jmp .L_पाठ_बदल__if_अंत_10
.L_पाठ_बदल__if_अंत_10:
  movq $0, %rbx
  jmp .L_पाठ_बदल__wh_शर्त_11
.L_पाठ_बदल__wh_शर्त_11:
  movq %rbx, -128(%rbp)
  movq %rbx, %r10
  addq -88(%rbp), %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq %r13, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_4
  jmp .L_पाठ_बदल__wh_देह_12
.L_किनारा_पाठ_बदल_4:
  jmp .L_पाठ_बदल__wh_अंत_13
.L_पाठ_बदल__wh_अंत_13:
  movq -72(%rbp), %rax
  jmp .L_epilogue_पाठ_बदल
.L_पाठ_बदल__wh_देह_12:
  movq -72(%rbp), %rcx
  movq %rbx, %rdx
  movq %rsi, %r8
  movq -88(%rbp), %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_बदल_5
  jmp .L_पाठ_बदल__if_सत्य_14
.L_किनारा_पाठ_बदल_5:
  jmp .L_पाठ_बदल__if_अंत_15
.L_पाठ_बदल__if_अंत_15:
  movq $1, %r12
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %r14, %rbx
  jmp .L_पाठ_बदल__wh_शर्त_11
.L_पाठ_बदल__if_सत्य_14:
  movq %r13, %r10
  subq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  subq -88(%rbp), %r10
  movq %r10, %r12
  movq %rbx, %r10
  addq %r15, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, -104(%rbp)
  movq -104(%rbp), %r11
  movq %r11, -120(%rbp)
  movq $16, %r13
  movq $16, %r14
  subq $8, %rsp
  movq %rbx, %r11
  pushq %r11
  movq -104(%rbp), %rcx
  movq %r13, %rdx
  movq -72(%rbp), %r8
  movq %r14, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %r13
  movq $16, %rsi
  subq $8, %rsp
  movq %r15, %r11
  pushq %r11
  movq -104(%rbp), %rcx
  movq %r13, %rdx
  movq %rdi, %r8
  movq %rsi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  movq $16, %rsi
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  addq %r15, %r10
  movq %r10, %rsi
  movq $16, %rdi
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %r13
  movq $0, -128(%rbp)
  movq %r13, %r10
  addq -88(%rbp), %r10
  movq %r10, %rbx
  subq $8, %rsp
  movq %r12, %r11
  pushq %r11
  movq -104(%rbp), %rcx
  movq %rsi, %rdx
  movq -72(%rbp), %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rdi
  movq -104(%rbp), %rax
  jmp .L_epilogue_पाठ_बदल
.L_पाठ_बदल__if_सत्य_9:
  leaq .LC_str_12(%rip), %rcx
  movq .LC_str_12_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_बदल__if_सत्य_7:
  leaq .LC_str_11(%rip), %rcx
  movq .LC_str_11_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_पाठ_बदल:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_विभाजन
  .def पाठ_विभाजन; .scl 2; .type 32; .endef
पाठ_विभाजन:
  pushq %rbp
  movq %rsp, %rbp
  subq $256, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -120(%rbp)
  movq %rdx, -104(%rbp)
  movq $0, -184(%rbp)
  movq $0, -192(%rbp)
  movq $0, -200(%rbp)
  movq $0, -208(%rbp)
  movq $0, -216(%rbp)
  movq $0, -224(%rbp)
  movq $0, -232(%rbp)
  movq $0, -240(%rbp)
  movq $0, -248(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -184(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -192(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -200(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -208(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -216(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -224(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -232(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -240(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -248(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_विभाजन__प्रवेश_0:
  movq $0, %rdi
  movq -120(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_0
  jmp .L_पाठ_विभाजन__sc_लघु_2
.L_किनारा_पाठ_विभाजन_0:
  jmp .L_पाठ_विभाजन__sc_दायाँ_1
.L_पाठ_विभाजन__sc_दायाँ_1:
  movq $0, %rdi
  movq -104(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_विभाजन__sc_अंत_3
.L_पाठ_विभाजन__sc_लघु_2:
  movq $1, %rdi
  jmp .L_पाठ_विभाजन__sc_अंत_3
.L_पाठ_विभाजन__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_1
  jmp .L_पाठ_विभाजन__if_सत्य_4
.L_किनारा_पाठ_विभाजन_1:
  jmp .L_पाठ_विभाजन__if_अंत_5
.L_पाठ_विभाजन__if_अंत_5:
  movq $8, %rdi
  movq -120(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $8, %rdi
  movq -104(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_2
  jmp .L_पाठ_विभाजन__if_सत्य_6
.L_किनारा_पाठ_विभाजन_2:
  jmp .L_पाठ_विभाजन__if_अंत_7
.L_पाठ_विभाजन__if_अंत_7:
  movq $1, %rdi
  movq $0, %r14
  movq %r14, -136(%rbp)
  movq %rdi, -152(%rbp)
  jmp .L_पाठ_विभाजन__wh_शर्त_8
.L_पाठ_विभाजन__wh_शर्त_8:
  movq -152(%rbp), %r11
  movq %r11, -200(%rbp)
  movq -136(%rbp), %r11
  movq %r11, -208(%rbp)
  movq -136(%rbp), %r10
  addq -72(%rbp), %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_3
  jmp .L_पाठ_विभाजन__wh_देह_9
.L_किनारा_पाठ_विभाजन_3:
  jmp .L_पाठ_विभाजन__wh_अंत_10
.L_पाठ_विभाजन__wh_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r13
  movq -152(%rbp), %rcx
  subq $32, %rsp
  call सूची_रचना
  addq $32, %rsp
  movq %rax, -168(%rbp)
  movq -168(%rbp), %r11
  movq %r11, -184(%rbp)
  movq $0, %r15
  movq $0, %r12
  movq %r12, %r11
  movq %r15, %r12
  movq %r11, %r15
  jmp .L_पाठ_विभाजन__wh_शर्त_14
.L_पाठ_विभाजन__wh_शर्त_14:
  movq %r12, -216(%rbp)
  movq %r15, -224(%rbp)
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_4
  jmp .L_पाठ_विभाजन__wh_देह_15
.L_किनारा_पाठ_विभाजन_4:
  jmp .L_पाठ_विभाजन__wh_अंत_16
.L_पाठ_विभाजन__wh_देह_15:
  movq $0, %rsi
  movq %r15, %rbx
  jmp .L_पाठ_विभाजन__wh_शर्त_17
.L_पाठ_विभाजन__wh_शर्त_17:
  movq %rbx, -232(%rbp)
  movq %rbx, %r10
  addq -72(%rbp), %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq -88(%rbp), %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_5
  jmp .L_पाठ_विभाजन__wh_देह_18
.L_किनारा_पाठ_विभाजन_5:
  jmp .L_पाठ_विभाजन__wh_अंत_19
.L_पाठ_विभाजन__wh_देह_18:
  movq -120(%rbp), %rcx
  movq %rbx, %rdx
  movq -104(%rbp), %r8
  movq -72(%rbp), %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_6
  jmp .L_पाठ_विभाजन__if_सत्य_20
.L_किनारा_पाठ_विभाजन_6:
  jmp .L_पाठ_विभाजन__if_अंत_21
.L_पाठ_विभाजन__if_अंत_21:
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq %r14, %rbx
  jmp .L_पाठ_विभाजन__wh_शर्त_17
.L_पाठ_विभाजन__if_सत्य_20:
  movq $1, %rsi
  jmp .L_पाठ_विभाजन__wh_अंत_19
.L_पाठ_विभाजन__wh_अंत_19:
  movq %rsi, -240(%rbp)
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_7
  jmp .L_पाठ_विभाजन__if_सत्य_22
.L_किनारा_पाठ_विभाजन_7:
  jmp .L_पाठ_विभाजन__if_अंत_23
.L_पाठ_विभाजन__if_सत्य_22:
  movq -88(%rbp), %rbx
  jmp .L_पाठ_विभाजन__if_अंत_23
.L_पाठ_विभाजन__if_अंत_23:
  movq %rbx, -248(%rbp)
  movq %rbx, %r10
  subq %r15, %r10
  movq %r10, %rdi
  movq -120(%rbp), %rcx
  movq %r15, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call पाठ_प्रति
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -192(%rbp)
  movq $0, -224(%rbp)
  movq $16, %rdi
  movq $8, %r15
  movq %r12, %r10
  imulq %r15, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq -168(%rbp), %r10
  movq %r15, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %rdi
  movq $0, -192(%rbp)
  movq $1, %rdi
  movq %r12, %r10
  addq %rdi, %r10
  movq %r10, %r13
  movq $0, -216(%rbp)
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq $0, -240(%rbp)
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_8
  jmp .L_पाठ_विभाजन__if_सत्य_24
.L_किनारा_पाठ_विभाजन_8:
  jmp .L_पाठ_विभाजन__if_अंत_25
.L_पाठ_विभाजन__if_अंत_25:
  movq %rbx, %r10
  addq -72(%rbp), %r10
  movq %r10, %rsi
  movq $0, -248(%rbp)
  movq %rsi, %r15
  movq %r13, %r12
  jmp .L_पाठ_विभाजन__wh_शर्त_14
.L_पाठ_विभाजन__if_सत्य_24:
  jmp .L_पाठ_विभाजन__wh_अंत_16
.L_पाठ_विभाजन__wh_अंत_16:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq -168(%rbp), %rax
  jmp .L_epilogue_पाठ_विभाजन
.L_पाठ_विभाजन__wh_देह_9:
  movq -120(%rbp), %rcx
  movq -136(%rbp), %rdx
  movq -104(%rbp), %r8
  movq -72(%rbp), %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_9
  jmp .L_पाठ_विभाजन__if_सत्य_11
.L_किनारा_पाठ_विभाजन_9:
  jmp .L_पाठ_विभाजन__if_असत्य_13
.L_पाठ_विभाजन__if_असत्य_13:
  movq $1, %rbx
  movq -136(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq -152(%rbp), %rbx
  jmp .L_पाठ_विभाजन__if_अंत_12
.L_पाठ_विभाजन__if_सत्य_11:
  movq $1, %rbx
  movq -152(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $0, -200(%rbp)
  movq -136(%rbp), %r10
  addq -72(%rbp), %r10
  movq %r10, %rbx
  movq $0, -208(%rbp)
  movq %rbx, %r11
  movq %rsi, %rbx
  movq %r11, %rsi
  jmp .L_पाठ_विभाजन__if_अंत_12
.L_पाठ_विभाजन__if_अंत_12:
  movq %rsi, -136(%rbp)
  movq %rbx, -152(%rbp)
  jmp .L_पाठ_विभाजन__wh_शर्त_8
.L_पाठ_विभाजन__if_सत्य_6:
  leaq .LC_str_14(%rip), %rcx
  movq .LC_str_14_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_विभाजन__if_सत्य_4:
  leaq .LC_str_13(%rip), %rcx
  movq .LC_str_13_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_epilogue_पाठ_विभाजन:
  subl $9, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_संयोग
  .def पाठ_संयोग; .scl 2; .type 32; .endef
पाठ_संयोग:
  pushq %rbp
  movq %rsp, %rbp
  subq $240, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -120(%rbp)
  movq %rdx, -104(%rbp)
  movq $0, -184(%rbp)
  movq $0, -192(%rbp)
  movq $0, -200(%rbp)
  movq $0, -208(%rbp)
  movq $0, -216(%rbp)
  movq $0, -224(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -184(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -192(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -200(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -208(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -216(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -224(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_संयोग__प्रवेश_0:
  movq $0, %rdi
  movq -120(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_0
  jmp .L_पाठ_संयोग__if_सत्य_1
.L_किनारा_पाठ_संयोग_0:
  jmp .L_पाठ_संयोग__if_अंत_2
.L_पाठ_संयोग__if_अंत_2:
  movq $8, %rdi
  movq -120(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $0, %rdi
  movq $0, %r13
  movq -104(%rbp), %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_1
  jmp .L_पाठ_संयोग__if_सत्य_3
.L_किनारा_पाठ_संयोग_1:
  movq %rdi, -72(%rbp)
  jmp .L_पाठ_संयोग__if_अंत_4
.L_पाठ_संयोग__if_सत्य_3:
  movq $8, %rdi
  movq -104(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, -72(%rbp)
  jmp .L_पाठ_संयोग__if_अंत_4
.L_पाठ_संयोग__if_अंत_4:
  movq -72(%rbp), %r11
  movq %r11, -192(%rbp)
  movq $0, %r13
  movq $0, %r14
  movq %r14, -136(%rbp)
  movq %r13, -152(%rbp)
  jmp .L_पाठ_संयोग__wh_शर्त_5
.L_पाठ_संयोग__wh_शर्त_5:
  movq -152(%rbp), %r11
  movq %r11, -200(%rbp)
  movq -136(%rbp), %r11
  movq %r11, -208(%rbp)
  movq -136(%rbp), %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_2
  jmp .L_पाठ_संयोग__wh_देह_6
.L_किनारा_पाठ_संयोग_2:
  jmp .L_पाठ_संयोग__wh_अंत_7
.L_पाठ_संयोग__wh_अंत_7:
  movq -152(%rbp), %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, -168(%rbp)
  movq -168(%rbp), %r11
  movq %r11, -184(%rbp)
  movq $0, %rdi
  movq $0, %r12
  movq %rdi, %r11
  movq %r12, %rdi
  movq %r11, %r12
  jmp .L_पाठ_संयोग__wh_शर्त_12
.L_पाठ_संयोग__wh_शर्त_12:
  movq %rdi, -216(%rbp)
  movq %r12, -224(%rbp)
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_3
  jmp .L_पाठ_संयोग__wh_देह_13
.L_किनारा_पाठ_संयोग_3:
  jmp .L_पाठ_संयोग__wh_अंत_14
.L_पाठ_संयोग__wh_अंत_14:
  movq -168(%rbp), %rax
  jmp .L_epilogue_पाठ_संयोग
.L_पाठ_संयोग__wh_देह_13:
  movq $16, %rsi
  movq $8, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %rbx
  movq -120(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $8, %rbx
  movq %rsi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq $16, %rbx
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq $16, %rbx
  subq $8, %rsp
  movq %r14, %r11
  pushq %r11
  movq -168(%rbp), %rcx
  movq %r13, %rdx
  movq %rsi, %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r15
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %rbx
  movq $0, -224(%rbp)
  movq $1, %rsi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_4
  jmp .L_पाठ_संयोग__if_सत्य_15
.L_किनारा_पाठ_संयोग_4:
  jmp .L_पाठ_संयोग__if_अंत_16
.L_पाठ_संयोग__if_सत्य_15:
  movq $0, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_5
  jmp .L_पाठ_संयोग__if_सत्य_17
.L_किनारा_पाठ_संयोग_5:
  jmp .L_पाठ_संयोग__if_अंत_18
.L_पाठ_संयोग__if_सत्य_17:
  movq $16, %rsi
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %r12
  movq $16, %rsi
  subq $8, %rsp
  movq -72(%rbp), %r11
  pushq %r11
  movq -168(%rbp), %rcx
  movq %r12, %rdx
  movq -104(%rbp), %r8
  movq %rsi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  movq %rbx, %r10
  addq -72(%rbp), %r10
  movq %r10, %rsi
  movq %rsi, %rbx
  jmp .L_पाठ_संयोग__if_अंत_18
.L_पाठ_संयोग__if_अंत_18:
  jmp .L_पाठ_संयोग__if_अंत_16
.L_पाठ_संयोग__if_अंत_16:
  movq $1, %rsi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq $0, -216(%rbp)
  movq %r12, %rdi
  movq %rbx, %r12
  jmp .L_पाठ_संयोग__wh_शर्त_12
.L_पाठ_संयोग__wh_देह_6:
  movq $16, %rbx
  movq $8, %rsi
  movq -136(%rbp), %r10
  imulq %rsi, %r10
  movq %r10, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %rsi
  movq -120(%rbp), %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_6
  jmp .L_पाठ_संयोग__if_सत्य_8
.L_किनारा_पाठ_संयोग_6:
  jmp .L_पाठ_संयोग__if_अंत_9
.L_पाठ_संयोग__if_अंत_9:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq -152(%rbp), %r10
  addq %rdi, %r10
  movq %r10, %rbx
  movq $0, -200(%rbp)
  movq $1, %rsi
  movq -136(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_संयोग_7
  jmp .L_पाठ_संयोग__if_सत्य_10
.L_किनारा_पाठ_संयोग_7:
  jmp .L_पाठ_संयोग__if_अंत_11
.L_पाठ_संयोग__if_सत्य_10:
  movq %rbx, %r10
  addq -72(%rbp), %r10
  movq %r10, %rsi
  movq %rsi, %rbx
  jmp .L_पाठ_संयोग__if_अंत_11
.L_पाठ_संयोग__if_अंत_11:
  movq $1, %rsi
  movq -136(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, -208(%rbp)
  movq %rdi, -136(%rbp)
  movq %rbx, -152(%rbp)
  jmp .L_पाठ_संयोग__wh_शर्त_5
.L_पाठ_संयोग__if_सत्य_8:
  leaq .LC_str_15(%rip), %rcx
  movq .LC_str_15_len(%rip), %rdx
  subq $32, %rsp
  call sutra_str_alloc
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call sutra_throw
  addq $32, %rsp
.L_पाठ_संयोग__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_संयोग
.L_epilogue_पाठ_संयोग:
  subl $6, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोडबिंदु_श्वेत_है
  .def कोडबिंदु_श्वेत_है; .scl 2; .type 32; .endef
कोडबिंदु_श्वेत_है:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_कोडबिंदु_श्वेत_है__प्रवेश_0:
  movq $32, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_0
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_2
.L_किनारा_कोडबिंदु_श्वेत_है_0:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_1
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_1:
  movq $9, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_3
.L_कोडबिंदु_श्वेत_है__sc_लघु_2:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_3
.L_कोडबिंदु_श्वेत_है__sc_अंत_3:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_1
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_5
.L_किनारा_कोडबिंदु_श्वेत_है_1:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_4
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_4:
  movq $10, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_6
.L_कोडबिंदु_श्वेत_है__sc_लघु_5:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_6
.L_कोडबिंदु_श्वेत_है__sc_अंत_6:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_2
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_8
.L_किनारा_कोडबिंदु_श्वेत_है_2:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_7
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_7:
  movq $13, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_9
.L_कोडबिंदु_श्वेत_है__sc_लघु_8:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_9
.L_कोडबिंदु_श्वेत_है__sc_अंत_9:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_3
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_10
.L_किनारा_कोडबिंदु_श्वेत_है_3:
  jmp .L_कोडबिंदु_श्वेत_है__if_अंत_11
.L_कोडबिंदु_श्वेत_है__if_अंत_11:
  movq $160, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_4
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_13
.L_किनारा_कोडबिंदु_श्वेत_है_4:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_12
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_12:
  movq $5760, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_14
.L_कोडबिंदु_श्वेत_है__sc_लघु_13:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_14
.L_कोडबिंदु_श्वेत_है__sc_अंत_14:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_5
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_15
.L_किनारा_कोडबिंदु_श्वेत_है_5:
  jmp .L_कोडबिंदु_श्वेत_है__if_अंत_16
.L_कोडबिंदु_श्वेत_है__if_अंत_16:
  movq $8192, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_6
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_17
.L_किनारा_कोडबिंदु_श्वेत_है_6:
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_18
.L_कोडबिंदु_श्वेत_है__sc_लघु_18:
  movq $0, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_19
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_17:
  movq $8202, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_19
.L_कोडबिंदु_श्वेत_है__sc_अंत_19:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_7
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_20
.L_किनारा_कोडबिंदु_श्वेत_है_7:
  jmp .L_कोडबिंदु_श्वेत_है__if_अंत_21
.L_कोडबिंदु_श्वेत_है__if_अंत_21:
  movq $8232, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_8
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_23
.L_किनारा_कोडबिंदु_श्वेत_है_8:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_22
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_22:
  movq $8233, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_24
.L_कोडबिंदु_श्वेत_है__sc_लघु_23:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_24
.L_कोडबिंदु_श्वेत_है__sc_अंत_24:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_9
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_26
.L_किनारा_कोडबिंदु_श्वेत_है_9:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_25
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_25:
  movq $8239, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_27
.L_कोडबिंदु_श्वेत_है__sc_लघु_26:
  movq $1, %rsi
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_27
.L_कोडबिंदु_श्वेत_है__sc_अंत_27:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_10
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_28
.L_किनारा_कोडबिंदु_श्वेत_है_10:
  jmp .L_कोडबिंदु_श्वेत_है__if_अंत_29
.L_कोडबिंदु_श्वेत_है__if_अंत_29:
  movq $8287, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_11
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_31
.L_किनारा_कोडबिंदु_श्वेत_है_11:
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_30
.L_कोडबिंदु_श्वेत_है__sc_दायाँ_30:
  movq $12288, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rbx
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_32
.L_कोडबिंदु_श्वेत_है__sc_लघु_31:
  movq $1, %rbx
  jmp .L_कोडबिंदु_श्वेत_है__sc_अंत_32
.L_कोडबिंदु_श्वेत_है__sc_अंत_32:
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोडबिंदु_श्वेत_है_12
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_33
.L_किनारा_कोडबिंदु_श्वेत_है_12:
  jmp .L_कोडबिंदु_श्वेत_है__if_अंत_34
.L_कोडबिंदु_श्वेत_है__if_अंत_34:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_कोडबिंदु_श्वेत_है__if_सत्य_33:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_कोडबिंदु_श्वेत_है__if_सत्य_28:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_कोडबिंदु_श्वेत_है__if_सत्य_20:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_कोडबिंदु_श्वेत_है__if_सत्य_15:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_कोडबिंदु_श्वेत_है__if_सत्य_10:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोडबिंदु_श्वेत_है
.L_epilogue_कोडबिंदु_श्वेत_है:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_छाँट
  .def पाठ_छाँट; .scl 2; .type 32; .endef
पाठ_छाँट:
  pushq %rbp
  movq %rsp, %rbp
  subq $208, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -88(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
  movq $0, -160(%rbp)
  movq $0, -168(%rbp)
  movq $0, -176(%rbp)
  movq $0, -184(%rbp)
  movq $0, -192(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -128(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -136(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -144(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -152(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -160(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -168(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -176(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -184(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -192(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_छाँट__प्रवेश_0:
  movq $0, %rsi
  movq -88(%rbp), %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_0
  jmp .L_पाठ_छाँट__if_सत्य_1
.L_किनारा_पाठ_छाँट_0:
  jmp .L_पाठ_छाँट__if_अंत_2
.L_पाठ_छाँट__if_अंत_2:
  movq $8, %rsi
  movq -88(%rbp), %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %rsi
  movq $0, %r12
  movq $0, %r13
  movq %r13, -104(%rbp)
  jmp .L_पाठ_छाँट__wh_शर्त_3
.L_पाठ_छाँट__wh_शर्त_3:
  movq -104(%rbp), %r11
  movq %r11, -136(%rbp)
  movq -104(%rbp), %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_1
  jmp .L_पाठ_छाँट__wh_देह_4
.L_किनारा_पाठ_छाँट_1:
  movq %rsi, %rbx
  movq %r12, %rsi
  jmp .L_पाठ_छाँट__wh_अंत_5
.L_पाठ_छाँट__wh_देह_4:
  movq $16, %r14
  movq %r14, %r10
  addq -104(%rbp), %r10
  movq %r10, %r15
  movq -88(%rbp), %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r14, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r15
  movq -104(%rbp), %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_2
  jmp .L_पाठ_छाँट__if_सत्य_6
.L_किनारा_पाठ_छाँट_2:
  movq %r15, %rdi
  jmp .L_पाठ_छाँट__if_अंत_7
.L_पाठ_छाँट__if_सत्य_6:
  movq $1, %rdi
  jmp .L_पाठ_छाँट__if_अंत_7
.L_पाठ_छाँट__if_अंत_7:
  movq %rdi, -144(%rbp)
  movq %r14, -152(%rbp)
  movq %r15, -160(%rbp)
  movq -88(%rbp), %rcx
  movq -104(%rbp), %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -120(%rbp)
  movq %rbx, %rcx
  subq $32, %rsp
  call कोडबिंदु_श्वेत_है
  addq $32, %rsp
  movq %rax, %r13
  movq $0, -120(%rbp)
  movq %r13, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_3
  jmp .L_पाठ_छाँट__if_सत्य_8
.L_किनारा_पाठ_छाँट_3:
  jmp .L_पाठ_छाँट__if_अंत_9
.L_पाठ_छाँट__if_अंत_9:
  movq -104(%rbp), %r10
  addq %rdi, %r10
  movq %r10, %rbx
  movq $0, -144(%rbp)
  movq %rbx, -104(%rbp)
  jmp .L_पाठ_छाँट__wh_शर्त_3
.L_पाठ_छाँट__if_सत्य_8:
  movq $1, %rbx
  movq %rbx, %rsi
  movq -104(%rbp), %rbx
  jmp .L_पाठ_छाँट__wh_अंत_5
.L_पाठ_छाँट__wh_अंत_5:
  movq %rbx, -168(%rbp)
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_4
  jmp .L_पाठ_छाँट__if_सत्य_10
.L_किनारा_पाठ_छाँट_4:
  jmp .L_पाठ_छाँट__if_अंत_11
.L_पाठ_छाँट__if_अंत_11:
  movq %rbx, %rdi
  movq %rbx, %rsi
  jmp .L_पाठ_छाँट__wh_शर्त_12
.L_पाठ_छाँट__wh_शर्त_12:
  movq %rsi, -176(%rbp)
  movq %rdi, -184(%rbp)
  movq %rsi, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_5
  jmp .L_पाठ_छाँट__wh_देह_13
.L_किनारा_पाठ_छाँट_5:
  jmp .L_पाठ_छाँट__wh_अंत_14
.L_पाठ_छाँट__wh_अंत_14:
  movq %rdi, %r10
  subq %rbx, %r10
  movq %r10, %r12
  movq -88(%rbp), %rcx
  movq %rbx, %rdx
  movq %r12, %r8
  subq $32, %rsp
  call पाठ_प्रति
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_छाँट
.L_पाठ_छाँट__wh_देह_13:
  movq $16, %r12
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq -88(%rbp), %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r12
  movq %r12, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_6
  jmp .L_पाठ_छाँट__if_सत्य_15
.L_किनारा_पाठ_छाँट_6:
  movq %r13, %r12
  jmp .L_पाठ_छाँट__if_अंत_16
.L_पाठ_छाँट__if_सत्य_15:
  movq $1, %r12
  jmp .L_पाठ_छाँट__if_अंत_16
.L_पाठ_छाँट__if_अंत_16:
  movq %r12, -192(%rbp)
  movq -88(%rbp), %rcx
  movq %rsi, %rdx
  movq %r12, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -128(%rbp)
  movq %r13, %rcx
  subq $32, %rsp
  call कोडबिंदु_श्वेत_है
  addq $32, %rsp
  movq %rax, %r14
  movq $0, -128(%rbp)
  movq %r14, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_7
  jmp .L_पाठ_छाँट__if_सत्य_17
.L_किनारा_पाठ_छाँट_7:
  jmp .L_पाठ_छाँट__if_अंत_18
.L_पाठ_छाँट__if_सत्य_17:
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %rdi
  jmp .L_पाठ_छाँट__if_अंत_18
.L_पाठ_छाँट__if_अंत_18:
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq $0, -176(%rbp)
  movq $0, -192(%rbp)
  movq %r13, %rsi
  jmp .L_पाठ_छाँट__wh_शर्त_12
.L_पाठ_छाँट__if_सत्य_10:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_छाँट
.L_पाठ_छाँट__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_छाँट
.L_epilogue_पाठ_छाँट:
  subl $10, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq -56(%rbp), %r15
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_आरंभ_में
  .def पाठ_आरंभ_में; .scl 2; .type 32; .endef
पाठ_आरंभ_में:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_आरंभ_में__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_आरंभ_में_0
  jmp .L_पाठ_आरंभ_में__sc_लघु_2
.L_किनारा_पाठ_आरंभ_में_0:
  jmp .L_पाठ_आरंभ_में__sc_दायाँ_1
.L_पाठ_आरंभ_में__sc_दायाँ_1:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_आरंभ_में__sc_अंत_3
.L_पाठ_आरंभ_में__sc_लघु_2:
  movq $1, %rdi
  jmp .L_पाठ_आरंभ_में__sc_अंत_3
.L_पाठ_आरंभ_में__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_आरंभ_में_1
  jmp .L_पाठ_आरंभ_में__if_सत्य_4
.L_किनारा_पाठ_आरंभ_में_1:
  jmp .L_पाठ_आरंभ_में__if_अंत_5
.L_पाठ_आरंभ_में__if_अंत_5:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %rdi
  movq %r13, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_आरंभ_में_2
  jmp .L_पाठ_आरंभ_में__if_सत्य_6
.L_किनारा_पाठ_आरंभ_में_2:
  jmp .L_पाठ_आरंभ_में__if_अंत_7
.L_पाठ_आरंभ_में__if_अंत_7:
  movq %r12, %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_आरंभ_में_3
  jmp .L_पाठ_आरंभ_में__if_सत्य_8
.L_किनारा_पाठ_आरंभ_में_3:
  jmp .L_पाठ_आरंभ_में__if_अंत_9
.L_पाठ_आरंभ_में__if_अंत_9:
  movq $0, %rdi
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq %rsi, %r8
  movq %r13, %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %rax
  jmp .L_epilogue_पाठ_आरंभ_में
.L_पाठ_आरंभ_में__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_आरंभ_में
.L_पाठ_आरंभ_में__if_सत्य_6:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_आरंभ_में
.L_पाठ_आरंभ_में__if_सत्य_4:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_आरंभ_में
.L_epilogue_पाठ_आरंभ_में:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अंत_में
  .def पाठ_अंत_में; .scl 2; .type 32; .endef
पाठ_अंत_में:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_अंत_में__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अंत_में_0
  jmp .L_पाठ_अंत_में__sc_लघु_2
.L_किनारा_पाठ_अंत_में_0:
  jmp .L_पाठ_अंत_में__sc_दायाँ_1
.L_पाठ_अंत_में__sc_दायाँ_1:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_अंत_में__sc_अंत_3
.L_पाठ_अंत_में__sc_लघु_2:
  movq $1, %rdi
  jmp .L_पाठ_अंत_में__sc_अंत_3
.L_पाठ_अंत_में__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अंत_में_1
  jmp .L_पाठ_अंत_में__if_सत्य_4
.L_किनारा_पाठ_अंत_में_1:
  jmp .L_पाठ_अंत_में__if_अंत_5
.L_पाठ_अंत_में__if_अंत_5:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %rdi
  movq %r13, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अंत_में_2
  jmp .L_पाठ_अंत_में__if_सत्य_6
.L_किनारा_पाठ_अंत_में_2:
  jmp .L_पाठ_अंत_में__if_अंत_7
.L_पाठ_अंत_में__if_अंत_7:
  movq %r12, %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अंत_में_3
  jmp .L_पाठ_अंत_में__if_सत्य_8
.L_किनारा_पाठ_अंत_में_3:
  jmp .L_पाठ_अंत_में__if_अंत_9
.L_पाठ_अंत_में__if_अंत_9:
  movq %r12, %r10
  subq %r13, %r10
  movq %r10, %rdi
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq %rsi, %r8
  movq %r13, %r9
  subq $32, %rsp
  call पाठ_बाइट_मिलान
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %rax
  jmp .L_epilogue_पाठ_अंत_में
.L_पाठ_अंत_में__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अंत_में
.L_पाठ_अंत_में__if_सत्य_6:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अंत_में
.L_पाठ_अंत_में__if_सत्य_4:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अंत_में
.L_epilogue_पाठ_अंत_में:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq -48(%rbp), %r14
  movq %rbp, %rsp
  popq %rbp
  ret

  .section .rdata,"dr"
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
.LC_str_3:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\266\340\244\254\340\245\215\340\244\246\340\244\225\340\245\213\340\244\266 \340\244\252\340\244\260 \340\244\270\340\245\207\340\244\237 \340\244\252\340\245\215\340\244\260\340\244\257\340\244\276\340\244\270\0"
.LC_str_3_len:
  .quad 99
.LC_str_4:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\252\340\244\260 \340\244\234\340\245\213\340\244\241\340\244\274\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_4_len:
  .quad 90
.LC_str_5:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\270\340\245\207 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\250\340\244\277\340\244\225\340\244\276\340\244\262\340\244\276 \340\244\234\340\244\276 \340\244\270\340\244\225\340\244\244\340\244\276\340\245\244\0"
.LC_str_5_len:
  .quad 123
.LC_str_6:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\252\340\244\260 \340\244\241\340\244\276\340\244\262\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_6_len:
  .quad 87
.LC_str_7:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\241\340\244\276\340\244\262\340\245\207\340\244\202: \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\270\340\245\207 \340\244\254\340\244\276\340\244\271\340\244\260\0"
.LC_str_7_len:
  .quad 97
.LC_str_8:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\270\340\245\207 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\271\340\244\237\340\244\276\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_8_len:
  .quad 100
.LC_str_9:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\271\340\244\237\340\244\276\340\244\217\340\244\202: \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\270\340\245\207 \340\244\254\340\244\276\340\244\271\340\244\260\0"
.LC_str_9_len:
  .quad 97
.LC_str_10:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\226\340\245\213\340\244\234\340\245\207\340\244\202: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\226\340\245\213\340\244\234 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_10_len:
  .quad 117
.LC_str_11:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\254\340\244\246\340\244\262\340\245\207\340\244\202 \340\244\256\340\245\207\340\244\202 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\271\340\245\210\0"
.LC_str_11_len:
  .quad 113
.LC_str_12:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\254\340\244\246\340\244\262\340\245\207\340\244\202: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\226\340\245\213\340\244\234 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_12_len:
  .quad 117
.LC_str_13:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\277\340\244\244 \340\244\225\340\245\207 \340\244\244\340\244\260\340\245\215\340\244\225 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\271\340\245\213 \340\244\270\340\244\225\340\244\244\340\245\207\0"
.LC_str_13_len:
  .quad 116
.LC_str_14:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\277\340\244\244: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\225 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_14_len:
  .quad 122
.LC_str_15:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\270\340\244\202\340\244\257\340\245\213\340\244\234\340\244\277\340\244\244 \340\244\256\340\245\207\340\244\202 \340\244\270\340\245\202\340\244\232\340\245\200 \340\244\225\340\245\207 \340\244\270\340\244\255\340\245\200 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\252\340\244\276\340\244\240 \340\244\271\340\245\213\340\244\250\340\245\207 \340\244\232\340\244\276\340\244\271\340\244\277\340\244\217\340\245\244\0"
.LC_str_15_len:
  .quad 142

