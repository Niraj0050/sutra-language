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
  je .L_अक्षर_कोडबिंदु__if_अंत_2
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_1
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
  je .L_अक्षर_कोडबिंदु__if_अंत_4
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_3
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
  je .L_अक्षर_कोडबिंदु__if_अंत_6
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_5
.L_अक्षर_कोडबिंदु__if_अंत_6:
  movq $192, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_अक्षर_कोडबिंदु__sc_लघु_8
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_7
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
  je .L_अक्षर_कोडबिंदु__sc_लघु_11
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_10
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
  je .L_अक्षर_कोडबिंदु__if_अंत_14
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_13
.L_अक्षर_कोडबिंदु__if_अंत_14:
  movq $224, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_अक्षर_कोडबिंदु__sc_लघु_16
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_15
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
  je .L_अक्षर_कोडबिंदु__sc_लघु_19
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_18
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
  je .L_अक्षर_कोडबिंदु__if_अंत_22
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_21
.L_अक्षर_कोडबिंदु__if_अंत_22:
  movq $240, %rsi
  movq -72(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_अक्षर_कोडबिंदु__sc_लघु_24
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_23
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
  je .L_अक्षर_कोडबिंदु__sc_लघु_27
  jmp .L_अक्षर_कोडबिंदु__sc_दायाँ_26
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
  je .L_अक्षर_कोडबिंदु__if_अंत_30
  jmp .L_अक्षर_कोडबिंदु__if_सत्य_29
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
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अक्षर_कोडबिंदु
.L_अक्षर_कोडबिंदु__if_सत्य_1:
  movq $-1, %rbx
  movq %rbx, %rax
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
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx

.L_पाठ_कोडबिंदु_गणना__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_गणना__if_अंत_2
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_1
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
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_गणना__wh_अंत_5
  jmp .L_पाठ_कोडबिंदु_गणना__wh_देह_4
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
  je .L_पाठ_कोडबिंदु_गणना__if_असत्य_8
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_6
.L_पाठ_कोडबिंदु_गणना__if_असत्य_8:
  movq $192, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_गणना__sc_लघु_10
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_9
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
  je .L_पाठ_कोडबिंदु_गणना__if_असत्य_14
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_12
.L_पाठ_कोडबिंदु_गणना__if_असत्य_14:
  movq $224, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_गणना__sc_लघु_16
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_15
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
  je .L_पाठ_कोडबिंदु_गणना__if_असत्य_20
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_18
.L_पाठ_कोडबिंदु_गणना__if_असत्य_20:
  movq $240, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_गणना__sc_लघु_22
  jmp .L_पाठ_कोडबिंदु_गणना__sc_दायाँ_21
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
  je .L_पाठ_कोडबिंदु_गणना__if_असत्य_26
  jmp .L_पाठ_कोडबिंदु_गणना__if_सत्य_24
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
  movq %r14, %rsi
  jmp .L_पाठ_कोडबिंदु_गणना__if_अंत_7
.L_पाठ_कोडबिंदु_गणना__if_अंत_7:
  movq $1, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r12
  jmp .L_पाठ_कोडबिंदु_गणना__wh_शर्त_3
.L_पाठ_कोडबिंदु_गणना__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_गणना
.L_epilogue_पाठ_कोडबिंदु_गणना:
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

.L_पाठ_तुल्य__प्रवेश_0:
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य__if_अंत_2
  jmp .L_पाठ_तुल्य__if_सत्य_1
.L_पाठ_तुल्य__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य__sc_दायाँ_3
  jmp .L_पाठ_तुल्य__sc_लघु_4
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
  je .L_पाठ_तुल्य__if_अंत_7
  jmp .L_पाठ_तुल्य__if_सत्य_6
.L_पाठ_तुल्य__if_अंत_7:
  movq $65536, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य__sc_दायाँ_8
  jmp .L_पाठ_तुल्य__sc_लघु_9
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
  je .L_पाठ_तुल्य__if_अंत_12
  jmp .L_पाठ_तुल्य__if_सत्य_11
.L_पाठ_तुल्य__if_अंत_12:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य__sc_दायाँ_13
  jmp .L_पाठ_तुल्य__sc_लघु_14
.L_पाठ_तुल्य__sc_दायाँ_13:
  movq %rsi, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
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
  je .L_पाठ_तुल्य__if_अंत_17
  jmp .L_पाठ_तुल्य__if_सत्य_16
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
  je .L_पाठ_तुल्य__if_अंत_19
  jmp .L_पाठ_तुल्य__if_सत्य_18
.L_पाठ_तुल्य__if_अंत_19:
  movq $0, %rdi
  jmp .L_पाठ_तुल्य__wh_शर्त_20
.L_पाठ_तुल्य__wh_शर्त_20:
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य__wh_अंत_22
  jmp .L_पाठ_तुल्य__wh_देह_21
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
  je .L_पाठ_तुल्य__if_अंत_24
  jmp .L_पाठ_तुल्य__if_सत्य_23
.L_पाठ_तुल्य__if_अंत_24:
  movq $1, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
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
  je .L_सञ्चय_गणना__if_अंत_2
  jmp .L_सञ्चय_गणना__if_सत्य_1
.L_सञ्चय_गणना__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_शब्दकोश
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सञ्चय_गणना__if_अंत_4
  jmp .L_सञ्चय_गणना__if_सत्य_3
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
  je .L_दैशिक_लंबाई__if_अंत_2
  jmp .L_दैशिक_लंबाई__if_सत्य_1
.L_दैशिक_लंबाई__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_दैशिक_लंबाई__if_अंत_4
  jmp .L_दैशिक_लंबाई__if_सत्य_3
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
  je .L_अक्षर_बाइट_चौड़ाई__if_अंत_2
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_1
.L_अक्षर_बाइट_चौड़ाई__if_अंत_2:
  movq $192, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बाइट_चौड़ाई__sc_लघु_4
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_3
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
  je .L_अक्षर_बाइट_चौड़ाई__if_अंत_7
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_6
.L_अक्षर_बाइट_चौड़ाई__if_अंत_7:
  movq $224, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बाइट_चौड़ाई__sc_लघु_9
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_8
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
  je .L_अक्षर_बाइट_चौड़ाई__if_अंत_12
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_11
.L_अक्षर_बाइट_चौड़ाई__if_अंत_12:
  movq $240, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बाइट_चौड़ाई__sc_लघु_14
  jmp .L_अक्षर_बाइट_चौड़ाई__sc_दायाँ_13
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
  je .L_अक्षर_बाइट_चौड़ाई__if_अंत_17
  jmp .L_अक्षर_बाइट_चौड़ाई__if_सत्य_16
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
  je .L_कोडबिंदु_मान__if_अंत_2
  jmp .L_कोडबिंदु_मान__if_सत्य_1
.L_कोडबिंदु_मान__if_अंत_2:
  movq $2, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_मान__if_अंत_4
  jmp .L_कोडबिंदु_मान__if_सत्य_3
.L_कोडबिंदु_मान__if_अंत_4:
  movq $3, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_मान__if_अंत_6
  jmp .L_कोडबिंदु_मान__if_सत्य_5
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
  subq $144, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -104(%rbp)

.L_पाठ_कोडबिंदु_तुलना__प्रवेश_0:
  movq %rbx, %r10
  cmpq -104(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_2
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_1
.L_पाठ_कोडबिंदु_तुलना__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_4
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_3
.L_पाठ_कोडबिंदु_तुलना__if_अंत_4:
  movq $0, %rdi
  movq -104(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_6
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_5
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
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__sc_लघु_11
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_10
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
  je .L_पाठ_कोडबिंदु_तुलना__wh_अंत_9
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_देह_8
.L_पाठ_कोडबिंदु_तुलना__wh_अंत_9:
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__sc_लघु_22
  jmp .L_पाठ_कोडबिंदु_तुलना__sc_दायाँ_21
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
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_25
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_24
.L_पाठ_कोडबिंदु_तुलना__if_अंत_25:
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_27
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_26
.L_पाठ_कोडबिंदु_तुलना__if_अंत_27:
  movq $1, %r15
  movq %r15, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_26:
  movq $-1, %r15
  movq %r15, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_24:
  movq $0, %r15
  movq %r15, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__wh_देह_8:
  movq $16, %r15
  movq %r15, %r10
  addq %rdi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r15
  movq %r15, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_0
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_13
.L_किनारा_पाठ_कोडबिंदु_तुलना_0:
  movq %r13, %r12
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_14
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_13:
  movq $1, %r12
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_14
.L_पाठ_कोडबिंदु_तुलना__if_अंत_14:
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
  je .L_किनारा_पाठ_कोडबिंदु_तुलना_1
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_15
.L_किनारा_पाठ_कोडबिंदु_तुलना_1:
  movq %r15, %rsi
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_16
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_15:
  movq $1, %rsi
  jmp .L_पाठ_कोडबिंदु_तुलना__if_अंत_16
.L_पाठ_कोडबिंदु_तुलना__if_अंत_16:
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq %r12, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %r13
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
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_18
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_17
.L_पाठ_कोडबिंदु_तुलना__if_अंत_18:
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r15
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r14
  movq %r15, %rdi
  jmp .L_पाठ_कोडबिंदु_तुलना__wh_शर्त_7
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_17:
  movq %r13, %r10
  cmpq -120(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_तुलना__if_अंत_20
  jmp .L_पाठ_कोडबिंदु_तुलना__if_सत्य_19
.L_पाठ_कोडबिंदु_तुलना__if_अंत_20:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_19:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_5:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_3:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_पाठ_कोडबिंदु_तुलना__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_तुलना
.L_epilogue_पाठ_कोडबिंदु_तुलना:
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
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_न्यून__if_अंत_2
  jmp .L_सामान्य_न्यून__if_सत्य_1
.L_सामान्य_न्यून__if_सत्य_1:
  movq %rsi, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_न्यून__if_अंत_2
  jmp .L_सामान्य_न्यून__if_सत्य_3
.L_सामान्य_न्यून__if_अंत_2:
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_न्यून__if_अंत_6
  jmp .L_सामान्य_न्यून__if_सत्य_5
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
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_अधिक__if_अंत_2
  jmp .L_सामान्य_अधिक__if_सत्य_1
.L_सामान्य_अधिक__if_सत्य_1:
  movq %rsi, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_अधिक__if_अंत_2
  jmp .L_सामान्य_अधिक__if_सत्य_3
.L_सामान्य_अधिक__if_अंत_2:
  movq %rbx, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सामान्य_अधिक__if_अंत_6
  jmp .L_सामान्य_अधिक__if_सत्य_5
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
  je .L_सामान्य_न्यून_सम__if_अंत_2
  jmp .L_सामान्य_न्यून_सम__if_सत्य_1
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
  je .L_सामान्य_अधिक_सम__if_अंत_2
  jmp .L_सामान्य_अधिक_सम__if_सत्य_1
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
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_न्यून__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_न्यून
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_न्यून__if_अंत_2
  jmp .L_पाठ_न्यून__if_सत्य_1
.L_पाठ_न्यून__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_पाठ_न्यून__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून
.L_epilogue_पाठ_न्यून:
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
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_अधिक__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_अधिक
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_अधिक__if_अंत_2
  jmp .L_पाठ_अधिक__if_सत्य_1
.L_पाठ_अधिक__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_पाठ_अधिक__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक
.L_epilogue_पाठ_अधिक:
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
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_न्यून_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_न्यून_सम
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_न्यून_सम__if_अंत_2
  jmp .L_पाठ_न्यून_सम__if_सत्य_1
.L_पाठ_न्यून_सम__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_पाठ_न्यून_सम__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_न्यून_सम
.L_epilogue_पाठ_न्यून_सम:
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
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_अधिक_सम__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_तुलना
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rbx
  movq %rdi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सामान्य_अधिक_सम
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_अधिक_सम__if_अंत_2
  jmp .L_पाठ_अधिक_सम__if_सत्य_1
.L_पाठ_अधिक_सम__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_पाठ_अधिक_सम__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_अधिक_सम
.L_epilogue_पाठ_अधिक_सम:
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
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
  .globl खंड_प्रतिलिपि
  .def खंड_प्रतिलिपि; .scl 2; .type 32; .endef
खंड_प्रतिलिपि:
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
  movq %r8, -104(%rbp)
  movq %r9, -88(%rbp)
  movq 48(%rbp), %r10
  movq %r10, -72(%rbp)

.L_खंड_प्रतिलिपि__प्रवेश_0:
  movq $0, %r14
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_1
.L_खंड_प्रतिलिपि__wh_शर्त_1:
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
  je .L_खंड_प्रतिलिपि__wh_अंत_3
  jmp .L_खंड_प्रतिलिपि__wh_देह_2
.L_खंड_प्रतिलिपि__wh_अंत_3:
  movq %r14, %r13
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_4
.L_खंड_प्रतिलिपि__wh_शर्त_4:
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_खंड_प्रतिलिपि__wh_अंत_6
  jmp .L_खंड_प्रतिलिपि__wh_देह_5
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
  movq %r12, %r14
  jmp .L_खंड_प्रतिलिपि__wh_शर्त_1
.L_epilogue_खंड_प्रतिलिपि:
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
  .globl पाठ_उपखंड_बाइट
  .def पाठ_उपखंड_बाइट; .scl 2; .type 32; .endef
पाठ_उपखंड_बाइट:
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

.L_पाठ_उपखंड_बाइट__प्रवेश_0:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड_बाइट__if_अंत_2
  jmp .L_पाठ_उपखंड_बाइट__if_सत्य_1
.L_पाठ_उपखंड_बाइट__if_अंत_2:
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड_बाइट__sc_दायाँ_3
  jmp .L_पाठ_उपखंड_बाइट__sc_लघु_4
.L_पाठ_उपखंड_बाइट__sc_दायाँ_3:
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r12
  jmp .L_पाठ_उपखंड_बाइट__sc_अंत_5
.L_पाठ_उपखंड_बाइट__sc_लघु_4:
  movq $1, %r12
  jmp .L_पाठ_उपखंड_बाइट__sc_अंत_5
.L_पाठ_उपखंड_बाइट__sc_अंत_5:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड_बाइट__if_अंत_7
  jmp .L_पाठ_उपखंड_बाइट__if_सत्य_6
.L_पाठ_उपखंड_बाइट__if_अंत_7:
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $8, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r12, %r10
  cmpq %r14, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड_बाइट__if_अंत_9
  jmp .L_पाठ_उपखंड_बाइट__if_सत्य_8
.L_पाठ_उपखंड_बाइट__if_अंत_9:
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड_बाइट__if_अंत_11
  jmp .L_पाठ_उपखंड_बाइट__if_सत्य_10
.L_पाठ_उपखंड_बाइट__if_अंत_11:
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
  jmp .L_epilogue_पाठ_उपखंड_बाइट
.L_पाठ_उपखंड_बाइट__if_सत्य_10:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_उपखंड_बाइट
.L_पाठ_उपखंड_बाइट__if_सत्य_8:
  leaq .LC_str_1(%rip), %rcx
  movq .LC_str_1_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_उपखंड_बाइट__if_सत्य_6:
  leaq .LC_str_0(%rip), %rcx
  movq .LC_str_0_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_उपखंड_बाइट__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_उपखंड_बाइट
.L_epilogue_पाठ_उपखंड_बाइट:
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
  subq $112, %rsp
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
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -96(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -104(%rbp), %r11
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
  je .L_पाठ_जोड़__sc_लघु_2
  jmp .L_पाठ_जोड़__sc_दायाँ_1
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
  je .L_पाठ_जोड़__if_अंत_5
  jmp .L_पाठ_जोड़__if_सत्य_4
.L_पाठ_जोड़__if_अंत_5:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_जोड़__if_अंत_7
  jmp .L_पाठ_जोड़__if_सत्य_6
.L_पाठ_जोड़__if_अंत_7:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_जोड़__if_अंत_9
  jmp .L_पाठ_जोड़__if_सत्य_8
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
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -104(%rbp)
  movq $16, %r12
  movq $16, %r13
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %rsi, %rcx
  movq %r12, %rdx
  movq %rbx, %r8
  movq %r13, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_जोड़
.L_पाठ_जोड़__if_सत्य_6:
  movq $8, %rbx
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -96(%rbp)
  movq $16, %rdi
  movq $16, %r12
  subq $8, %rsp
  movq %rsi, %r11
  pushq %r11
  movq %rbx, %rcx
  movq %rdi, %rdx
  movq -72(%rbp), %r8
  movq %r12, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  movq %rbx, %rax
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
  .globl निर्माता_नया
  .def निर्माता_नया; .scl 2; .type 32; .endef
निर्माता_नया:
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

.L_निर्माता_नया__प्रवेश_0:
  movq $16, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -56(%rbp)
  movq $8, %rbx
  movq $0, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $16, %rbx
  movq $0, %rdi
  movq %rsi, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq %rsi, %rax
  jmp .L_epilogue_निर्माता_नया
.L_epilogue_निर्माता_नया:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निर्माता_जोड़
  .def निर्माता_जोड़; .scl 2; .type 32; .endef
निर्माता_जोड़:
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
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_निर्माता_जोड़__प्रवेश_0:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_निर्माता_जोड़__if_अंत_2
  jmp .L_निर्माता_जोड़__if_सत्य_1
.L_निर्माता_जोड़__if_अंत_2:
  movq %rsi, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_निर्माता_जोड़__if_अंत_4
  jmp .L_निर्माता_जोड़__if_सत्य_3
.L_निर्माता_जोड़__if_अंत_4:
  movq $8, %rdi
  movq %rsi, %r10
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
  je .L_निर्माता_जोड़__if_अंत_6
  jmp .L_निर्माता_जोड़__if_सत्य_5
.L_निर्माता_जोड़__if_अंत_6:
  movq $8, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, -88(%rbp)
  movq $0, %r14
  movq -72(%rbp), %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq -88(%rbp), %r10
  cmpq %r15, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_निर्माता_जोड़_0
  jmp .L_निर्माता_जोड़__if_सत्य_7
.L_किनारा_निर्माता_जोड़_0:
  movq -72(%rbp), %rbx
  jmp .L_निर्माता_जोड़__if_अंत_8
.L_निर्माता_जोड़__if_सत्य_7:
  movq $2, %r14
  movq %r15, %r10
  imulq %r14, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_निर्माता_जोड़_1
  jmp .L_निर्माता_जोड़__if_सत्य_9
.L_किनारा_निर्माता_जोड़_1:
  jmp .L_निर्माता_जोड़__if_अंत_10
.L_निर्माता_जोड़__if_सत्य_9:
  movq -88(%rbp), %rbx
  jmp .L_निर्माता_जोड़__if_अंत_10
.L_निर्माता_जोड़__if_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r14
  movq $16, %r14
  movq %r14, %r10
  addq %rbx, %r10
  movq %r10, %r15
  movq $1, %r14
  movq %r15, %r10
  addq %r14, %r10
  movq %r10, %rdi
  movq -72(%rbp), %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call सूत्र_पुनः_आवंटन
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -104(%rbp)
  movq $0, %rdi
  movq %r14, %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r15
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %r14, %rbx
  jmp .L_निर्माता_जोड़__if_अंत_8
.L_निर्माता_जोड़__if_अंत_8:
  movq %rbx, -112(%rbp)
  movq $16, %rdi
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $16, %rdi
  subq $8, %rsp
  movq %r12, %r11
  pushq %r11
  movq %rbx, %rcx
  movq %r14, %rdx
  movq %rsi, %r8
  movq %rdi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq -88(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -88(%rbp), %rdi
  movq $16, %rsi
  movq %rsi, %r10
  addq -88(%rbp), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %r12
  movq %rbx, %rax
  jmp .L_epilogue_निर्माता_जोड़
.L_निर्माता_जोड़__if_सत्य_5:
  movq -72(%rbp), %rax
  jmp .L_epilogue_निर्माता_जोड़
.L_निर्माता_जोड़__if_सत्य_3:
  movq -72(%rbp), %rax
  jmp .L_epilogue_निर्माता_जोड़
.L_निर्माता_जोड़__if_सत्य_1:
  movq -72(%rbp), %rax
  jmp .L_epilogue_निर्माता_जोड़
.L_epilogue_निर्माता_जोड़:
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
  .globl निर्माता_अक्षर
  .def निर्माता_अक्षर; .scl 2; .type 32; .endef
निर्माता_अक्षर:
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

.L_निर्माता_अक्षर__प्रवेश_0:
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -48(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call निर्माता_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -48(%rbp)
  movq %rsi, %rax
  jmp .L_epilogue_निर्माता_अक्षर
.L_epilogue_निर्माता_अक्षर:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निर्माता_लंबाई
  .def निर्माता_लंबाई; .scl 2; .type 32; .endef
निर्माता_लंबाई:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_निर्माता_लंबाई__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_निर्माता_लंबाई__if_अंत_2
  jmp .L_निर्माता_लंबाई__if_सत्य_1
.L_निर्माता_लंबाई__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_कोडबिंदु_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_निर्माता_लंबाई
.L_निर्माता_लंबाई__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_निर्माता_लंबाई
.L_epilogue_निर्माता_लंबाई:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निर्माता_पाठ
  .def निर्माता_पाठ; .scl 2; .type 32; .endef
निर्माता_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_निर्माता_पाठ__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_निर्माता_पाठ__if_अंत_2
  jmp .L_निर्माता_पाठ__if_सत्य_1
.L_निर्माता_पाठ__if_अंत_2:
  movq %rbx, %rax
  jmp .L_epilogue_निर्माता_पाठ
.L_निर्माता_पाठ__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_निर्माता_पाठ
.L_epilogue_निर्माता_पाठ:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  je .L_अंक_गणना__if_अंत_2
  jmp .L_अंक_गणना__if_सत्य_1
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
  je .L_किनारा_अंक_गणना_0
  jmp .L_अंक_गणना__if_सत्य_3
.L_किनारा_अंक_गणना_0:
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
  je .L_अंक_गणना__wh_अंत_7
  jmp .L_अंक_गणना__wh_देह_6
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
  subq $112, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -72(%rbp)
  movq $0, -104(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_संख्या_से_पाठ__प्रवेश_0:
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_संख्या_से_पाठ__if_अंत_2
  jmp .L_संख्या_से_पाठ__if_सत्य_1
.L_संख्या_से_पाठ__if_अंत_2:
  movq -72(%rbp), %rcx
  subq $32, %rsp
  call अंक_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, -88(%rbp)
  movq -88(%rbp), %r11
  movq %r11, -104(%rbp)
  movq $0, %r12
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_संख्या_से_पाठ__if_अंत_4
  jmp .L_संख्या_से_पाठ__if_सत्य_3
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
  je .L_किनारा_संख्या_से_पाठ_0
  jmp .L_संख्या_से_पाठ__if_सत्य_5
.L_किनारा_संख्या_से_पाठ_0:
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
  movq $1, %r14
  movq %rsi, %r10
  subq %r14, %r10
  movq %r10, %r15
  movq %r12, %rsi
  movq %r15, %r12
  jmp .L_संख्या_से_पाठ__wh_शर्त_7
.L_संख्या_से_पाठ__wh_शर्त_7:
  movq $0, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_संख्या_से_पाठ__wh_अंत_9
  jmp .L_संख्या_से_पाठ__wh_देह_8
.L_संख्या_से_पाठ__wh_अंत_9:
  movq $1, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_संख्या_से_पाठ__if_अंत_11
  jmp .L_संख्या_से_पाठ__if_सत्य_10
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
  movq $1, %rbx
  movq %r12, %r10
  subq %rbx, %r10
  movq %r10, %rsi
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
  je .L_बूल_से_पाठ__if_अंत_2
  jmp .L_बूल_से_पाठ__if_सत्य_1
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movl $5, %ecx
.Lजड़_अक्षर_बना:
  movq $0, (%r11)
  movq %r11, (%r10,%rax,8)
  incl %eax
  subq $8, %r11
  decl %ecx
  jnz .Lजड़_अक्षर_बना
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
  je .L_अक्षर_बना__if_अंत_2
  jmp .L_अक्षर_बना__if_सत्य_1
.L_अक्षर_बना__if_अंत_2:
  movq $2048, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बना__if_अंत_4
  jmp .L_अक्षर_बना__if_सत्य_3
.L_अक्षर_बना__if_अंत_4:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बना__if_अंत_6
  jmp .L_अक्षर_बना__if_सत्य_5
.L_अक्षर_बना__if_अंत_6:
  movq $1114111, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अक्षर_बना__if_अंत_8
  jmp .L_अक्षर_बना__if_सत्य_7
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
  movq %r8, -120(%rbp)
  movq $0, -136(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -136(%rbp), %r11
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
  je .L_पाठ_उपखंड__if_अंत_2
  jmp .L_पाठ_उपखंड__if_सत्य_1
.L_पाठ_उपखंड__if_अंत_2:
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड__sc_दायाँ_3
  jmp .L_पाठ_उपखंड__sc_लघु_4
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
  je .L_पाठ_उपखंड__if_अंत_7
  jmp .L_पाठ_उपखंड__if_सत्य_6
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
  movq %rsi, %r10
  cmpq -104(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड__sc_दायाँ_8
  jmp .L_पाठ_उपखंड__sc_लघु_9
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
  je .L_पाठ_उपखंड__if_अंत_12
  jmp .L_पाठ_उपखंड__if_सत्य_11
.L_पाठ_उपखंड__if_अंत_12:
  movq %rsi, %r10
  cmpq -120(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड__if_अंत_14
  jmp .L_पाठ_उपखंड__if_सत्य_13
.L_पाठ_उपखंड__if_अंत_14:
  movq %rsi, %r10
  cmpq -120(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_उपखंड__if_अंत_16
  jmp .L_पाठ_उपखंड__if_सत्य_15
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
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_0
  jmp .L_पाठ_उपखंड__wh_देह_18
.L_किनारा_पाठ_उपखंड_0:
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
  movq %r15, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r14, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_1
  jmp .L_पाठ_उपखंड__if_सत्य_20
.L_किनारा_पाठ_उपखंड_1:
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
  je .L_पाठ_उपखंड__if_अंत_23
  jmp .L_पाठ_उपखंड__if_सत्य_22
.L_पाठ_उपखंड__if_अंत_23:
  movq $1, %r12
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq %r13, %r15
  movq %rdi, %r14
  jmp .L_पाठ_उपखंड__wh_शर्त_17
.L_पाठ_उपखंड__if_सत्य_22:
  movq %r15, %rsi
  jmp .L_पाठ_उपखंड__wh_अंत_19
.L_पाठ_उपखंड__wh_अंत_19:
  movq -120(%rbp), %r10
  cmpq -104(%rbp), %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_उपखंड_2
  jmp .L_पाठ_उपखंड__if_सत्य_24
.L_किनारा_पाठ_उपखंड_2:
  jmp .L_पाठ_उपखंड__if_अंत_25
.L_पाठ_उपखंड__if_सत्य_24:
  movq -88(%rbp), %rsi
  jmp .L_पाठ_उपखंड__if_अंत_25
.L_पाठ_उपखंड__if_अंत_25:
  movq %rsi, %r10
  subq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -136(%rbp)
  movq $16, %r12
  movq $16, %r13
  movq %r13, %r10
  addq %rbx, %r10
  movq %r10, %r14
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %rsi, %rcx
  movq %r12, %rdx
  movq -72(%rbp), %r8
  movq %r14, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rbx
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
  leaq .LC_str_4(%rip), %rcx
  movq .LC_str_4_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_उपखंड__if_सत्य_11:
  leaq .LC_str_3(%rip), %rcx
  movq .LC_str_3_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_उपखंड__if_सत्य_6:
  leaq .LC_str_2(%rip), %rcx
  movq .LC_str_2_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
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
  .globl पंक्ति_लिखो
  .def पंक्ति_लिखो; .scl 2; .type 32; .endef
पंक्ति_लिखो:
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

.L_पंक्ति_लिखो__प्रवेश_0:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -56(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -64(%rbp)
  movq $0, -56(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  addq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -64(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पंक्ति_लिखो
.L_epilogue_पंक्ति_लिखो:
  subl $2, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_छापो
  .def पाठ_छापो; .scl 2; .type 32; .endef
पाठ_छापो:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movl $5, %ecx
.Lजड़_पाठ_छापो:
  movq $0, (%r11)
  movq %r11, (%r10,%rax,8)
  incl %eax
  subq $8, %r11
  decl %ecx
  jnz .Lजड़_पाठ_छापो
  movl %eax, gc_roots_count(%rip)

.L_पाठ_छापो__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_छापो__if_अंत_2
  jmp .L_पाठ_छापो__if_सत्य_1
.L_पाठ_छापो__if_अंत_2:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -88(%rbp)
  movq $0, -80(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  addq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -88(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_छापो
.L_पाठ_छापो__if_सत्य_1:
  subq $32, %rsp
  call शून्य_से_पाठ
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -56(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  addq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -72(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_छापो
.L_epilogue_पाठ_छापो:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शून्य_छापो
  .def शून्य_छापो; .scl 2; .type 32; .endef
शून्य_छापो:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शून्य_छापो__प्रवेश_0:
  subq $32, %rsp
  call शून्य_से_पाठ
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -56(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  addq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -72(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_शून्य_छापो
.L_epilogue_शून्य_छापो:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl बूल_छापो
  .def बूल_छापो; .scl 2; .type 32; .endef
बूल_छापो:
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
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_बूल_छापो__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call बूल_से_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -56(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rbx
  movq $10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -72(%rbp)
  movq $0, -56(%rbp)
  movq $0, -64(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -72(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_बूल_छापो
.L_epilogue_बूल_छापो:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष्ठ_शब्दकोश
  .def कोष्ठ_शब्दकोश; .scl 2; .type 32; .endef
कोष्ठ_शब्दकोश:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_कोष्ठ_शब्दकोश__प्रवेश_0:
  leaq .LC_str_5(%rip), %rcx
  movq .LC_str_5_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोष्ठ_शब्दकोश
.L_epilogue_कोष्ठ_शब्दकोश:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष्ठ_सूची
  .def कोष्ठ_सूची; .scl 2; .type 32; .endef
कोष्ठ_सूची:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_कोष्ठ_सूची__प्रवेश_0:
  leaq .LC_str_6(%rip), %rcx
  movq .LC_str_6_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोष्ठ_सूची
.L_epilogue_कोष्ठ_सूची:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl गतिशील_छापो
  .def गतिशील_छापो; .scl 2; .type 32; .endef
गतिशील_छापो:
  pushq %rbp
  movq %rsp, %rbp
  subq $192, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movl $15, %ecx
.Lजड़_गतिशील_छापो:
  movq $0, (%r11)
  movq %r11, (%r10,%rax,8)
  incl %eax
  subq $8, %r11
  decl %ecx
  jnz .Lजड़_गतिशील_छापो
  movl %eax, gc_roots_count(%rip)

.L_गतिशील_छापो__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_गतिशील_छापो__if_अंत_2
  jmp .L_गतिशील_छापो__if_सत्य_1
.L_गतिशील_छापो__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $1, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_गतिशील_छापो__if_अंत_4
  jmp .L_गतिशील_छापो__if_सत्य_3
.L_गतिशील_छापो__if_अंत_4:
  movq $4, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_गतिशील_छापो__if_अंत_6
  jmp .L_गतिशील_छापो__if_सत्य_5
.L_गतिशील_छापो__if_अंत_6:
  movq $2, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_गतिशील_छापो__if_अंत_8
  jmp .L_गतिशील_छापो__if_सत्य_7
.L_गतिशील_छापो__if_अंत_8:
  movq $3, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_गतिशील_छापो__if_अंत_10
  jmp .L_गतिशील_छापो__if_सत्य_9
.L_गतिशील_छापो__if_अंत_10:
  movq %rbx, %rcx
  subq $32, %rsp
  call संख्या_से_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -168(%rbp)
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -176(%rbp)
  movq $0, -168(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rdi, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -176(%rbp)
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_गतिशील_छापो__if_सत्य_9:
  leaq .LC_str_6(%rip), %rcx
  movq .LC_str_6_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -144(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -152(%rbp)
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -160(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rdi, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -160(%rbp)
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_गतिशील_छापो__if_सत्य_7:
  leaq .LC_str_6(%rip), %rcx
  movq .LC_str_6_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -120(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -128(%rbp)
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -136(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rdi, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -136(%rbp)
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_गतिशील_छापो__if_सत्य_5:
  leaq .LC_str_5(%rip), %rcx
  movq .LC_str_5_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -96(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq $10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -104(%rbp)
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -112(%rbp)
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rdi, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -112(%rbp)
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_गतिशील_छापो__if_सत्य_3:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -88(%rbp)
  movq $0, -80(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  addq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -88(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_गतिशील_छापो__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call संख्या_से_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rbx
  movq $10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call अक्षर_बना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -64(%rbp)
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -72(%rbp)
  movq $0, -64(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, -72(%rbp)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_छापो
.L_epilogue_गतिशील_छापो:
  subl $15, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl गतिशील_प्रकार
  .def गतिशील_प्रकार; .scl 2; .type 32; .endef
गतिशील_प्रकार:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_गतिशील_प्रकार__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_गतिशील_प्रकार__if_अंत_2
  jmp .L_गतिशील_प्रकार__if_सत्य_1
.L_गतिशील_प्रकार__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $1, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_गतिशील_प्रकार__if_अंत_4
  jmp .L_गतिशील_प्रकार__if_सत्य_3
.L_गतिशील_प्रकार__if_अंत_4:
  movq $4, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_गतिशील_प्रकार__if_अंत_6
  jmp .L_गतिशील_प्रकार__if_सत्य_5
.L_गतिशील_प्रकार__if_अंत_6:
  movq $2, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_गतिशील_प्रकार__if_अंत_8
  jmp .L_गतिशील_प्रकार__if_सत्य_7
.L_गतिशील_प्रकार__if_अंत_8:
  leaq .LC_str_11(%rip), %rcx
  movq .LC_str_11_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_प्रकार
.L_गतिशील_प्रकार__if_सत्य_7:
  leaq .LC_str_10(%rip), %rcx
  movq .LC_str_10_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_प्रकार
.L_गतिशील_प्रकार__if_सत्य_5:
  leaq .LC_str_9(%rip), %rcx
  movq .LC_str_9_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_प्रकार
.L_गतिशील_प्रकार__if_सत्य_3:
  leaq .LC_str_8(%rip), %rcx
  movq .LC_str_8_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_प्रकार
.L_गतिशील_प्रकार__if_सत्य_1:
  leaq .LC_str_7(%rip), %rcx
  movq .LC_str_7_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_गतिशील_प्रकार
.L_epilogue_गतिशील_प्रकार:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_अक्षर_रूप
  .def पाठ_अक्षर_रूप; .scl 2; .type 32; .endef
पाठ_अक्षर_रूप:
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
  movq $0, -104(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_अक्षर_रूप__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__if_अंत_2
  jmp .L_पाठ_अक्षर_रूप__if_सत्य_1
.L_पाठ_अक्षर_रूप__if_अंत_2:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq -88(%rbp), %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, -72(%rbp)
  movq -72(%rbp), %r11
  movq %r11, -104(%rbp)
  movq $0, %r13
  jmp .L_पाठ_अक्षर_रूप__wh_शर्त_3
.L_पाठ_अक्षर_रूप__wh_शर्त_3:
  movq %r13, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__wh_अंत_5
  jmp .L_पाठ_अक्षर_रूप__wh_देह_4
.L_पाठ_अक्षर_रूप__wh_अंत_5:
  movq -72(%rbp), %rax
  jmp .L_epilogue_पाठ_अक्षर_रूप
.L_पाठ_अक्षर_रूप__wh_देह_4:
  movq $16, %r14
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq %rbx, %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq $97, %r15
  movq %r14, %r10
  cmpq %r15, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__sc_लघु_7
  jmp .L_पाठ_अक्षर_रूप__sc_दायाँ_6
.L_पाठ_अक्षर_रूप__sc_लघु_7:
  movq $0, %rdi
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_8
.L_पाठ_अक्षर_रूप__sc_दायाँ_6:
  movq $122, %rdi
  movq %r14, %r10
  cmpq %rdi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %rdi
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_8
.L_पाठ_अक्षर_रूप__sc_अंत_8:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__sc_लघु_10
  jmp .L_पाठ_अक्षर_रूप__sc_दायाँ_9
.L_पाठ_अक्षर_रूप__sc_लघु_10:
  movq $0, %rdi
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_11
.L_पाठ_अक्षर_रूप__sc_दायाँ_9:
  movq $1, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %rdi
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_11
.L_पाठ_अक्षर_रूप__sc_अंत_11:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अक्षर_रूप_0
  jmp .L_पाठ_अक्षर_रूप__if_सत्य_12
.L_किनारा_पाठ_अक्षर_रूप_0:
  movq %r14, %rdi
  jmp .L_पाठ_अक्षर_रूप__if_अंत_13
.L_पाठ_अक्षर_रूप__if_सत्य_12:
  movq $32, %rdi
  movq %r14, %r10
  subq %rdi, %r10
  movq %r10, %r15
  movq %r15, %rdi
  jmp .L_पाठ_अक्षर_रूप__if_अंत_13
.L_पाठ_अक्षर_रूप__if_अंत_13:
  movq $65, %r15
  movq %r14, %r10
  cmpq %r15, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__sc_लघु_15
  jmp .L_पाठ_अक्षर_रूप__sc_दायाँ_14
.L_पाठ_अक्षर_रूप__sc_लघु_15:
  movq $0, %r12
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_16
.L_पाठ_अक्षर_रूप__sc_दायाँ_14:
  movq $90, %r12
  movq %r14, %r10
  cmpq %r12, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r12
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_16
.L_पाठ_अक्षर_रूप__sc_अंत_16:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_अक्षर_रूप__sc_लघु_18
  jmp .L_पाठ_अक्षर_रूप__sc_दायाँ_17
.L_पाठ_अक्षर_रूप__sc_लघु_18:
  movq $0, %r12
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_19
.L_पाठ_अक्षर_रूप__sc_दायाँ_17:
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r12
  jmp .L_पाठ_अक्षर_रूप__sc_अंत_19
.L_पाठ_अक्षर_रूप__sc_अंत_19:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_अक्षर_रूप_1
  jmp .L_पाठ_अक्षर_रूप__if_सत्य_20
.L_किनारा_पाठ_अक्षर_रूप_1:
  jmp .L_पाठ_अक्षर_रूप__if_अंत_21
.L_पाठ_अक्षर_रूप__if_सत्य_20:
  movq $32, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_अक्षर_रूप__if_अंत_21
.L_पाठ_अक्षर_रूप__if_अंत_21:
  movq $16, %r12
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq -72(%rbp), %r10
  movq %r14, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $1, %rdi
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r13
  jmp .L_पाठ_अक्षर_रूप__wh_शर्त_3
.L_पाठ_अक्षर_रूप__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_अक्षर_रूप
.L_epilogue_पाठ_अक्षर_रूप:
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
  .globl प्रयत्न_ढेर_तैयार
  .def प्रयत्न_ढेर_तैयार; .scl 2; .type 32; .endef
प्रयत्न_ढेर_तैयार:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_प्रयत्न_ढेर_तैयार__प्रवेश_0:
  movq sutra_glob_प्रयत्न_ढेर(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_प्रयत्न_ढेर_तैयार__if_अंत_2
  jmp .L_प्रयत्न_ढेर_तैयार__if_सत्य_1
.L_प्रयत्न_ढेर_तैयार__if_सत्य_1:
  movq $65536, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_प्रयत्न_ढेर(%rip)
  movq $2048, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_प्रयत्न_जड़_गण(%rip)
  jmp .L_प्रयत्न_ढेर_तैयार__if_अंत_2
.L_प्रयत्न_ढेर_तैयार__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_प्रयत्न_ढेर_तैयार
.L_epilogue_प्रयत्न_ढेर_तैयार:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl अपवाद_बफ_लो
  .def अपवाद_बफ_लो; .scl 2; .type 32; .endef
अपवाद_बफ_लो:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)

.L_अपवाद_बफ_लो__प्रवेश_0:
  subq $32, %rsp
  call प्रयत्न_ढेर_तैयार
  addq $32, %rsp
  movq %rax, %rbx
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rbx
  movq $256, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अपवाद_बफ_लो__if_अंत_2
  jmp .L_अपवाद_बफ_लो__if_सत्य_1
.L_अपवाद_बफ_लो__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_अपवाद_निकास
  addq $32, %rsp
  movq %rax, %rsi
  jmp .L_अपवाद_बफ_लो__if_अंत_2
.L_अपवाद_बफ_लो__if_अंत_2:
  movq sutra_glob_प्रयत्न_जड़_गण(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rsi
  movq $8, %rdi
  movq %rsi, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  subq $32, %rsp
  call sutra_gc_root_count
  addq $32, %rsp
  movq %rax, %rsi
  movq %rbx, %r10
  movq %r12, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  movq sutra_glob_प्रयत्न_ढेर(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rsi
  movq $256, %rdi
  movq %rsi, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %rsi
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rbx
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_प्रयत्न_गहराई(%rip)
  movq %rsi, %rax
  jmp .L_epilogue_अपवाद_बफ_लो
.L_epilogue_अपवाद_बफ_लो:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl अपवाद_पॉप
  .def अपवाद_पॉप; .scl 2; .type 32; .endef
अपवाद_पॉप:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_अपवाद_पॉप__प्रवेश_0:
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अपवाद_पॉप__if_अंत_2
  jmp .L_अपवाद_पॉप__if_सत्य_1
.L_अपवाद_पॉप__if_सत्य_1:
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_प्रयत्न_गहराई(%rip)
  jmp .L_अपवाद_पॉप__if_अंत_2
.L_अपवाद_पॉप__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अपवाद_पॉप
.L_epilogue_अपवाद_पॉप:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सक्रिय_अपवाद_लो
  .def सक्रिय_अपवाद_लो; .scl 2; .type 32; .endef
सक्रिय_अपवाद_लो:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_सक्रिय_अपवाद_लो__प्रवेश_0:
  movq sutra_glob_सक्रिय_अपवाद(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सक्रिय_अपवाद_लो
.L_epilogue_सक्रिय_अपवाद_लो:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl फेंको
  .def फेंको; .scl 2; .type 32; .endef
फेंको:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx

.L_फेंको__प्रवेश_0:
  movq %rbx, %r10
  movq %r10, sutra_glob_सक्रिय_अपवाद(%rip)
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rsi
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_फेंको__if_अंत_2
  jmp .L_फेंको__if_सत्य_1
.L_फेंको__if_सत्य_1:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_अपवाद_निकास
  addq $32, %rsp
  movq %rax, %rsi
  jmp .L_फेंको__if_अंत_2
.L_फेंको__if_अंत_2:
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_प्रयत्न_गहराई(%rip)
  movq sutra_glob_प्रयत्न_जड़_गण(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rsi
  movq $8, %rdi
  movq %rsi, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq sutra_glob_प्रयत्न_ढेर(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_प्रयत्न_गहराई(%rip), %r10
  movq %r10, %rdi
  movq $256, %r12
  movq %rdi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूत्र_दीर्घकूद
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_फेंको
.L_epilogue_फेंको:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl कोष_हैश
  .def कोष_हैश; .scl 2; .type 32; .endef
कोष_हैश:
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

.L_कोष_हैश__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोष_हैश__if_अंत_2
  jmp .L_कोष_हैश__if_सत्य_1
.L_कोष_हैश__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोष_हैश__if_अंत_4
  jmp .L_कोष_हैश__if_सत्य_3
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
  movq %r12, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_कोष_हैश__wh_अंत_7
  jmp .L_कोष_हैश__wh_देह_6
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
  .globl कोष_प्रोब1
  .def कोष_प्रोब1; .scl 2; .type 32; .endef
कोष_प्रोब1:
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
  movq %r8, %rdi
  movq %r9, %r12

.L_कोष_प्रोब1__प्रवेश_0:
  movq $8, %r13
  movq %r12, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %rbx
  movq %r13, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_कोष_प्रोब1__if_अंत_2
  jmp .L_कोष_प्रोब1__if_सत्य_1
.L_कोष_प्रोब1__if_अंत_2:
  movq $1, %rbx
  movq %r13, %r10
  subq %rbx, %r10
  movq %r10, %r14
  movq $16, %rbx
  movq %r14, %r10
  imulq %rbx, %r10
  movq %r10, %r13
  movq %rsi, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_कोष_प्रोब1__if_अंत_4
  jmp .L_कोष_प्रोब1__if_सत्य_3
.L_कोष_प्रोब1__if_अंत_4:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_कोष_प्रोब1
.L_कोष_प्रोब1__if_सत्य_3:
  movq %r12, %rax
  jmp .L_epilogue_कोष_प्रोब1
.L_कोष_प्रोब1__if_सत्य_1:
  movq %r12, %rax
  jmp .L_epilogue_कोष_प्रोब1
.L_epilogue_कोष_प्रोब1:
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
  subq $160, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -136(%rbp)

.L_कोष_स्लॉट__प्रवेश_0:
  movq $32, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -120(%rbp)
  movq $24, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -104(%rbp)
  movq $16, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
  movq $1, %rbx
  movq -120(%rbp), %r10
  subq %rbx, %r10
  movq %r10, -72(%rbp)
  movq -136(%rbp), %rcx
  subq $32, %rsp
  call कोष_हैश
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %r10
  movq -72(%rbp), %r11
  andq %r11, %r10
  movq %r10, %r15
  movq $0, %rbx
  movq %rbx, %r11
  movq %r15, %rbx
  movq %r11, %r15
  jmp .L_कोष_स्लॉट__wh_शर्त_1
.L_कोष_स्लॉट__wh_शर्त_1:
  movq $8, %rdi
  movq %r15, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_कोष_स्लॉट__wh_अंत_3
  jmp .L_कोष_स्लॉट__wh_देह_2
.L_कोष_स्लॉट__wh_अंत_3:
  movq $8, %rdi
  movq %rdi, %r14
  movq %rbx, %rdi
  jmp .L_कोष_स्लॉट__wh_शर्त_6
.L_कोष_स्लॉट__wh_शर्त_6:
  movq %r14, %r10
  cmpq -120(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_कोष_स्लॉट__wh_अंत_8
  jmp .L_कोष_स्लॉट__wh_देह_7
.L_कोष_स्लॉट__wh_अंत_8:
  movq %rdi, %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_कोष_स्लॉट__wh_देह_7:
  movq -104(%rbp), %rcx
  movq -88(%rbp), %rdx
  movq -136(%rbp), %r8
  movq %rdi, %r9
  subq $32, %rsp
  call कोष_प्रोब1
  addq $32, %rsp
  movq %rax, %r13
  movq $-1, %r12
  movq %r13, %r10
  cmpq %r12, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_कोष_स्लॉट__if_अंत_10
  jmp .L_कोष_स्लॉट__if_सत्य_9
.L_कोष_स्लॉट__if_अंत_10:
  movq $1, %rsi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq -72(%rbp), %r11
  andq %r11, %r10
  movq %r10, %rsi
  movq $1, %rdi
  movq %r14, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r14
  movq %rsi, %rdi
  jmp .L_कोष_स्लॉट__wh_शर्त_6
.L_कोष_स्लॉट__if_सत्य_9:
  movq %r13, %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_कोष_स्लॉट__wh_देह_2:
  movq -104(%rbp), %rcx
  movq -88(%rbp), %rdx
  movq -136(%rbp), %r8
  movq %rbx, %r9
  subq $32, %rsp
  call कोष_प्रोब1
  addq $32, %rsp
  movq %rax, %rsi
  movq $-1, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_कोष_स्लॉट__if_अंत_5
  jmp .L_कोष_स्लॉट__if_सत्य_4
.L_कोष_स्लॉट__if_अंत_5:
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq -72(%rbp), %r11
  andq %r11, %r10
  movq %r10, %rbx
  movq $1, %rdi
  movq %r15, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r15
  jmp .L_कोष_स्लॉट__wh_शर्त_1
.L_कोष_स्लॉट__if_सत्य_4:
  movq %rsi, %rax
  jmp .L_epilogue_कोष_स्लॉट
.L_epilogue_कोष_स्लॉट:
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
  subq $112, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx

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
  movq -72(%rbp), %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_कोष_सूचकांक_भरो__wh_अंत_3
  jmp .L_कोष_सूचकांक_भरो__wh_देह_2
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
  movq %r15, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq $0, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_0
  jmp .L_कोष_सूचकांक_भरो__if_सत्य_4
.L_किनारा_कोष_सूचकांक_भरो_0:
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
  je .L_कोष_सूचकांक_भरो__wh_अंत_8
  jmp .L_कोष_सूचकांक_भरो__wh_देह_7
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
  movq %r14, %r10
  cmpq %rdi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_कोष_सूचकांक_भरो_1
  jmp .L_कोष_सूचकांक_भरो__if_सत्य_9
.L_किनारा_कोष_सूचकांक_भरो_1:
  movq %r14, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_10
.L_कोष_सूचकांक_भरो__if_सत्य_9:
  movq $0, %rbx
  jmp .L_कोष_सूचकांक_भरो__if_अंत_10
.L_कोष_सूचकांक_भरो__if_अंत_10:
  jmp .L_कोष_सूचकांक_भरो__wh_शर्त_6
.L_epilogue_कोष_सूचकांक_भरो:
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
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_शब्दकोश_पाओ__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_पाओ__if_अंत_2
  jmp .L_शब्दकोश_पाओ__if_सत्य_1
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
  je .L_शब्दकोश_पाओ__if_अंत_4
  jmp .L_शब्दकोश_पाओ__if_सत्य_3
.L_शब्दकोश_पाओ__if_अंत_4:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r13
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
  je .L_शब्दकोश_पाओ__if_अंत_6
  jmp .L_शब्दकोश_पाओ__if_सत्य_5
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
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_शब्दकोश_कुंजी_है__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_कुंजी_है__if_अंत_2
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_1
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
  je .L_शब्दकोश_कुंजी_है__if_अंत_4
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_3
.L_शब्दकोश_कुंजी_है__if_अंत_4:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %rdi
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $8, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %rsi
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
  je .L_शब्दकोश_कुंजी_है__if_अंत_6
  jmp .L_शब्दकोश_कुंजी_है__if_सत्य_5
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
  movq %r8, -72(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
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
  je .L_शब्दकोश_सेट__if_अंत_2
  jmp .L_शब्दकोश_सेट__if_सत्य_1
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
  je .L_शब्दकोश_सेट__if_अंत_4
  jmp .L_शब्दकोश_सेट__if_सत्य_3
.L_शब्दकोश_सेट__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call कोष_स्लॉट
  addq $32, %rsp
  movq %rax, %r12
  movq $24, %r14
  movq %rbx, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq $8, %r14
  movq %r12, %r10
  imulq %r14, %r10
  movq %r10, %rdi
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
  je .L_शब्दकोश_सेट__if_अंत_4
  jmp .L_शब्दकोश_सेट__if_सत्य_5
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
  je .L_शब्दकोश_सेट__if_अंत_8
  jmp .L_शब्दकोश_सेट__if_सत्य_7
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
  movq %rdi, -104(%rbp)
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
  movq $0, -104(%rbp)
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
  je .L_शब्दकोश_सेट__if_असत्य_11
  jmp .L_शब्दकोश_सेट__if_सत्य_9
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
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq $1, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %r14, %r10
  movq %r15, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rsi
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
  movq %rdi, -112(%rbp)
  movq $24, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r13
  movq $0, -112(%rbp)
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
  leaq .LC_str_12(%rip), %rcx
  movq .LC_str_12_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_शब्दकोश_सेट:
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
  .globl शब्दकोश_हटाओ
  .def शब्दकोश_हटाओ; .scl 2; .type 32; .endef
शब्दकोश_हटाओ:
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
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi

.L_शब्दकोश_हटाओ__प्रवेश_0:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_हटाओ__if_अंत_2
  jmp .L_शब्दकोश_हटाओ__if_सत्य_1
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
  je .L_शब्दकोश_हटाओ__if_अंत_4
  jmp .L_शब्दकोश_हटाओ__if_सत्य_3
.L_शब्दकोश_हटाओ__if_अंत_4:
  movq $24, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -104(%rbp)
  movq $16, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -88(%rbp)
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
  movq -104(%rbp), %r10
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
  je .L_शब्दकोश_हटाओ__if_अंत_6
  jmp .L_शब्दकोश_हटाओ__if_सत्य_5
.L_शब्दकोश_हटाओ__if_अंत_6:
  movq $1, %rdi
  movq %rsi, %r10
  subq %rdi, %r10
  movq %r10, %r15
  movq %r15, %rsi
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_7
.L_शब्दकोश_हटाओ__wh_शर्त_7:
  movq $1, %rdi
  movq %r12, %r10
  subq %rdi, %r10
  movq %r10, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_हटाओ__wh_अंत_9
  jmp .L_शब्दकोश_हटाओ__wh_देह_8
.L_शब्दकोश_हटाओ__wh_अंत_9:
  movq $0, %rdi
  movq $1, %r15
  movq %r12, %r10
  subq %r15, %r10
  movq %r10, %rbx
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r15
  movq $32, %rbx
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rbx
  jmp .L_शब्दकोश_हटाओ__wh_शर्त_10
.L_शब्दकोश_हटाओ__wh_शर्त_10:
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_हटाओ__wh_अंत_12
  jmp .L_शब्दकोश_हटाओ__wh_देह_11
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
  movq -104(%rbp), %r10
  movq %r14, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r13
  movq $1, %r13
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %r14
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
  movq -88(%rbp), %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq -88(%rbp), %r10
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
  movq -88(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq -88(%rbp), %r10
  movq %r13, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
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
  je .L_सूची_जोड़__if_अंत_2
  jmp .L_सूची_जोड़__if_सत्य_1
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
  je .L_सूची_जोड़__if_अंत_4
  jmp .L_सूची_जोड़__if_सत्य_3
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
  je .L_किनारा_सूची_जोड़_0
  jmp .L_सूची_जोड़__if_सत्य_5
.L_किनारा_सूची_जोड़_0:
  jmp .L_सूची_जोड़__if_अंत_6
.L_सूची_जोड़__if_सत्य_5:
  movq $2, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r14
  movq %r14, %rdi
  jmp .L_सूची_जोड़__if_अंत_6
.L_सूची_जोड़__if_अंत_6:
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
  leaq .LC_str_13(%rip), %rcx
  movq .LC_str_13_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_जोड़:
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
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
  je .L_सूची_निकाल__if_अंत_2
  jmp .L_सूची_निकाल__if_सत्य_1
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
  je .L_सूची_निकाल__if_अंत_4
  jmp .L_सूची_निकाल__if_सत्य_3
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
  je .L_सूची_निकाल__if_अंत_6
  jmp .L_सूची_निकाल__if_सत्य_5
.L_सूची_निकाल__if_सत्य_5:
  movq $4, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_निकाल__if_अंत_6
  jmp .L_सूची_निकाल__if_सत्य_7
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
  je .L_किनारा_सूची_निकाल_0
  jmp .L_सूची_निकाल__if_सत्य_9
.L_किनारा_सूची_निकाल_0:
  movq %r12, %rsi
  jmp .L_सूची_निकाल__if_अंत_10
.L_सूची_निकाल__if_सत्य_9:
  movq $4, %rsi
  jmp .L_सूची_निकाल__if_अंत_10
.L_सूची_निकाल__if_अंत_10:
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
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rdi, %rax
  jmp .L_epilogue_सूची_निकाल
.L_सूची_निकाल__if_सत्य_3:
  leaq .LC_str_14(%rip), %rcx
  movq .LC_str_14_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सूची_निकाल__if_सत्य_1:
  leaq .LC_str_14(%rip), %rcx
  movq .LC_str_14_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_निकाल:
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
  .globl सूची_डाल
  .def सूची_डाल; .scl 2; .type 32; .endef
सूची_डाल:
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

.L_सूची_डाल__प्रवेश_0:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_डाल__if_अंत_2
  jmp .L_सूची_डाल__if_सत्य_1
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
  je .L_सूची_डाल__sc_दायाँ_3
  jmp .L_सूची_डाल__sc_लघु_4
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
  je .L_सूची_डाल__if_अंत_7
  jmp .L_सूची_डाल__if_सत्य_6
.L_सूची_डाल__if_अंत_7:
  movq -72(%rbp), %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूची_डाल_0
  jmp .L_सूची_डाल__if_सत्य_8
.L_किनारा_सूची_डाल_0:
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
  je .L_किनारा_सूची_डाल_1
  jmp .L_सूची_डाल__if_सत्य_10
.L_किनारा_सूची_डाल_1:
  jmp .L_सूची_डाल__if_अंत_11
.L_सूची_डाल__if_सत्य_10:
  movq $2, %r12
  movq %r13, %r10
  imulq %r12, %r10
  movq %r10, %r14
  movq %r14, %r12
  jmp .L_सूची_डाल__if_अंत_11
.L_सूची_डाल__if_अंत_11:
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
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %r13, -88(%rbp)
  jmp .L_सूची_डाल__if_अंत_9
.L_सूची_डाल__if_अंत_9:
  movq -88(%rbp), %r11
  movq %r11, -128(%rbp)
  movq -72(%rbp), %r12
  jmp .L_सूची_डाल__wh_शर्त_12
.L_सूची_डाल__wh_शर्त_12:
  movq %r12, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_डाल__wh_अंत_14
  jmp .L_सूची_डाल__wh_देह_13
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
  movq %rdi, %r12
  jmp .L_सूची_डाल__wh_शर्त_12
.L_सूची_डाल__if_सत्य_6:
  leaq .LC_str_16(%rip), %rcx
  movq .LC_str_16_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सूची_डाल__if_सत्य_1:
  leaq .LC_str_15(%rip), %rcx
  movq .LC_str_15_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_डाल:
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
  .globl सूची_हटा
  .def सूची_हटा; .scl 2; .type 32; .endef
सूची_हटा:
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
  movq $0, -104(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
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
  je .L_सूची_हटा__if_अंत_2
  jmp .L_सूची_हटा__if_सत्य_1
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
  je .L_सूची_हटा__sc_दायाँ_3
  jmp .L_सूची_हटा__sc_लघु_4
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
  je .L_सूची_हटा__if_अंत_7
  jmp .L_सूची_हटा__if_सत्य_6
.L_सूची_हटा__if_अंत_7:
  jmp .L_सूची_हटा__wh_शर्त_8
.L_सूची_हटा__wh_शर्त_8:
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
  je .L_सूची_हटा__wh_अंत_10
  jmp .L_सूची_हटा__wh_देह_9
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
  je .L_सूची_हटा__if_अंत_12
  jmp .L_सूची_हटा__if_सत्य_11
.L_सूची_हटा__if_सत्य_11:
  movq $4, %rdi
  movq -88(%rbp), %r10
  cmpq %rdi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_हटा__if_अंत_12
  jmp .L_सूची_हटा__if_सत्य_13
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
  je .L_किनारा_सूची_हटा_0
  jmp .L_सूची_हटा__if_सत्य_15
.L_किनारा_सूची_हटा_0:
  movq %r13, %rdi
  jmp .L_सूची_हटा__if_अंत_16
.L_सूची_हटा__if_सत्य_15:
  movq $4, %rdi
  jmp .L_सूची_हटा__if_अंत_16
.L_सूची_हटा__if_अंत_16:
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
  movq %r12, %rsi
  jmp .L_सूची_हटा__wh_शर्त_8
.L_सूची_हटा__if_सत्य_6:
  leaq .LC_str_18(%rip), %rcx
  movq .LC_str_18_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सूची_हटा__if_सत्य_1:
  leaq .LC_str_17(%rip), %rcx
  movq .LC_str_17_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_हटा:
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
  .globl सूची_जोड़ो_दो
  .def सूची_जोड़ो_दो; .scl 2; .type 32; .endef
सूची_जोड़ो_दो:
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
  movq %rdx, -120(%rbp)
  movq $0, -136(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -136(%rbp), %r11
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
  movq %r12, -72(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_4
.L_सूची_जोड़ो_दो__if_सत्य_3:
  movq $8, %r12
  movq -120(%rbp), %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, -72(%rbp)
  jmp .L_सूची_जोड़ो_दो__if_अंत_4
.L_सूची_जोड़ो_दो__if_अंत_4:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r13
  movq -104(%rbp), %r10
  addq -72(%rbp), %r10
  movq %r10, %r13
  movq $16, %r14
  movq $8, %r15
  movq %r13, %r10
  imulq %r15, %r10
  movq %r10, %r12
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %r15
  movq $2, %r12
  movq %r15, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, -88(%rbp)
  movq -88(%rbp), %r11
  movq %r11, -136(%rbp)
  movq $0, %r12
  movq -88(%rbp), %r10
  movq %r12, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r15
  movq $8, %r12
  movq -88(%rbp), %r10
  movq %r12, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r15
  movq $0, %r12
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_5
.L_सूची_जोड़ो_दो__wh_शर्त_5:
  movq %r12, %r10
  cmpq -104(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_जोड़ो_दो__wh_अंत_7
  jmp .L_सूची_जोड़ो_दो__wh_देह_6
.L_सूची_जोड़ो_दो__wh_अंत_7:
  movq $0, %r13
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_8
.L_सूची_जोड़ो_दो__wh_शर्त_8:
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सूची_जोड़ो_दो__wh_अंत_10
  jmp .L_सूची_जोड़ो_दो__wh_देह_9
.L_सूची_जोड़ो_दो__wh_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %r15
  movq -88(%rbp), %rax
  jmp .L_epilogue_सूची_जोड़ो_दो
.L_सूची_जोड़ो_दो__wh_देह_9:
  movq $16, %r15
  movq -104(%rbp), %r10
  addq %r13, %r10
  movq %r10, %r14
  movq $8, %rdi
  movq %r14, %r10
  imulq %rdi, %r10
  movq %r10, %rsi
  movq %r15, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq $8, %r14
  movq %r13, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %rsi, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq -120(%rbp), %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq -88(%rbp), %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r14
  movq $1, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r13
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_8
.L_सूची_जोड़ो_दो__wh_देह_6:
  movq $16, %rsi
  movq $8, %rdi
  movq %r12, %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq $8, %r13
  movq %r12, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq -88(%rbp), %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r13
  movq $1, %rsi
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r12
  jmp .L_सूची_जोड़ो_दो__wh_शर्त_5
.L_epilogue_सूची_जोड़ो_दो:
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
  .globl सूची_खोज
  .def सूची_खोज; .scl 2; .type 32; .endef
सूची_खोज:
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

.L_सूची_खोज__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_खोज__if_अंत_2
  jmp .L_सूची_खोज__if_सत्य_1
.L_सूची_खोज__if_अंत_2:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  jmp .L_सूची_खोज__wh_शर्त_3
.L_सूची_खोज__wh_शर्त_3:
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_खोज__wh_अंत_5
  jmp .L_सूची_खोज__wh_देह_4
.L_सूची_खोज__wh_अंत_5:
  movq $-1, %r13
  movq %r13, %rax
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
  je .L_सूची_खोज__if_अंत_7
  jmp .L_सूची_खोज__if_सत्य_6
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
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूची_खोज
.L_epilogue_सूची_खोज:
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

.L_पाठ_बाइट_मिलान__प्रवेश_0:
  movq $0, %r13
  jmp .L_पाठ_बाइट_मिलान__wh_शर्त_1
.L_पाठ_बाइट_मिलान__wh_शर्त_1:
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_बाइट_मिलान__wh_अंत_3
  jmp .L_पाठ_बाइट_मिलान__wh_देह_2
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
  je .L_पाठ_बाइट_मिलान__if_अंत_5
  jmp .L_पाठ_बाइट_मिलान__if_सत्य_4
.L_पाठ_बाइट_मिलान__if_अंत_5:
  movq $1, %r12
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_बाइट_मिलान__wh_शर्त_1
.L_पाठ_बाइट_मिलान__if_सत्य_4:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_बाइट_मिलान
.L_epilogue_पाठ_बाइट_मिलान:
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
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_कोडबिंदु_पूर्व__प्रवेश_0:
  movq $0, %rdi
  movq $0, %r12
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1
.L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1:
  movq %r12, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_कोडबिंदु_पूर्व__wh_अंत_3
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_देह_2
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
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %r13, %r12
  movq %r14, %rdi
  jmp .L_पाठ_कोडबिंदु_पूर्व__wh_शर्त_1
.L_epilogue_पाठ_कोडबिंदु_पूर्व:
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
  je .L_पाठ_कोडबिंदु_खोज__if_अंत_2
  jmp .L_पाठ_कोडबिंदु_खोज__if_सत्य_1
.L_पाठ_कोडबिंदु_खोज__if_अंत_2:
  movq $0, %rdi
  jmp .L_पाठ_कोडबिंदु_खोज__wh_शर्त_3
.L_पाठ_कोडबिंदु_खोज__wh_शर्त_3:
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
  je .L_पाठ_कोडबिंदु_खोज__wh_अंत_5
  jmp .L_पाठ_कोडबिंदु_खोज__wh_देह_4
.L_पाठ_कोडबिंदु_खोज__wh_अंत_5:
  movq $-1, %r14
  movq %r14, %rax
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
  je .L_पाठ_कोडबिंदु_खोज__if_अंत_7
  jmp .L_पाठ_कोडबिंदु_खोज__if_सत्य_6
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
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_कोडबिंदु_खोज
.L_पाठ_कोडबिंदु_खोज__if_सत्य_1:
  leaq .LC_str_19(%rip), %rcx
  movq .LC_str_19_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_पाठ_कोडबिंदु_खोज:
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
  subq $128, %rsp
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
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
  je .L_पाठ_बदल__sc_दायाँ_1
  jmp .L_पाठ_बदल__sc_लघु_2
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
  je .L_पाठ_बदल__sc_दायाँ_4
  jmp .L_पाठ_बदल__sc_लघु_5
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
  je .L_पाठ_बदल__if_अंत_8
  jmp .L_पाठ_बदल__if_सत्य_7
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
  je .L_पाठ_बदल__if_अंत_10
  jmp .L_पाठ_बदल__if_सत्य_9
.L_पाठ_बदल__if_अंत_10:
  movq $0, %rbx
  jmp .L_पाठ_बदल__wh_शर्त_11
.L_पाठ_बदल__wh_शर्त_11:
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
  je .L_पाठ_बदल__wh_अंत_13
  jmp .L_पाठ_बदल__wh_देह_12
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
  je .L_पाठ_बदल__if_अंत_15
  jmp .L_पाठ_बदल__if_सत्य_14
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
  leaq .LC_str_21(%rip), %rcx
  movq .LC_str_21_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_बदल__if_सत्य_7:
  leaq .LC_str_20(%rip), %rcx
  movq .LC_str_20_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_पाठ_बदल:
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
  .globl पाठ_विभाजन
  .def पाठ_विभाजन; .scl 2; .type 32; .endef
पाठ_विभाजन:
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
  movq $0, -216(%rbp)
  movq $0, -224(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -216(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -224(%rbp), %r11
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
  je .L_पाठ_विभाजन__sc_दायाँ_1
  jmp .L_पाठ_विभाजन__sc_लघु_2
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
  je .L_पाठ_विभाजन__if_अंत_5
  jmp .L_पाठ_विभाजन__if_सत्य_4
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
  je .L_पाठ_विभाजन__if_अंत_7
  jmp .L_पाठ_विभाजन__if_सत्य_6
.L_पाठ_विभाजन__if_अंत_7:
  movq $1, %rdi
  movq $0, %r14
  movq %r14, -136(%rbp)
  movq %rdi, -152(%rbp)
  jmp .L_पाठ_विभाजन__wh_शर्त_8
.L_पाठ_विभाजन__wh_शर्त_8:
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
  je .L_पाठ_विभाजन__wh_अंत_10
  jmp .L_पाठ_विभाजन__wh_देह_9
.L_पाठ_विभाजन__wh_अंत_10:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %r13
  movq $16, %r13
  movq $8, %r15
  movq -152(%rbp), %r10
  imulq %r15, %r10
  movq %r10, %r12
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r15
  movq $2, %r12
  movq %r15, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, -168(%rbp)
  movq -168(%rbp), %r11
  movq %r11, -216(%rbp)
  movq $0, %r12
  movq -168(%rbp), %r10
  movq %r12, %r11
  movq -152(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -152(%rbp), %r15
  movq $8, %r12
  movq -168(%rbp), %r10
  movq %r12, %r11
  movq -152(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -152(%rbp), %r15
  movq $0, %r12
  movq $0, %r15
  jmp .L_पाठ_विभाजन__wh_शर्त_14
.L_पाठ_विभाजन__wh_शर्त_14:
  movq %r15, %r10
  cmpq -88(%rbp), %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_विभाजन__wh_अंत_16
  jmp .L_पाठ_विभाजन__wh_देह_15
.L_पाठ_विभाजन__wh_देह_15:
  movq $0, %rsi
  movq %r15, %rbx
  jmp .L_पाठ_विभाजन__wh_शर्त_17
.L_पाठ_विभाजन__wh_शर्त_17:
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
  je .L_किनारा_पाठ_विभाजन_0
  jmp .L_पाठ_विभाजन__wh_देह_18
.L_किनारा_पाठ_विभाजन_0:
  movq %rsi, -200(%rbp)
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
  je .L_पाठ_विभाजन__if_अंत_21
  jmp .L_पाठ_विभाजन__if_सत्य_20
.L_पाठ_विभाजन__if_अंत_21:
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq %r14, %rbx
  jmp .L_पाठ_विभाजन__wh_शर्त_17
.L_पाठ_विभाजन__if_सत्य_20:
  movq $1, %rsi
  movq %rsi, -200(%rbp)
  jmp .L_पाठ_विभाजन__wh_अंत_19
.L_पाठ_विभाजन__wh_अंत_19:
  movq $0, %rdi
  movq -200(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_विभाजन_1
  jmp .L_पाठ_विभाजन__if_सत्य_22
.L_किनारा_पाठ_विभाजन_1:
  movq %rbx, -184(%rbp)
  jmp .L_पाठ_विभाजन__if_अंत_23
.L_पाठ_विभाजन__if_सत्य_22:
  movq -88(%rbp), %r11
  movq %r11, -184(%rbp)
  jmp .L_पाठ_विभाजन__if_अंत_23
.L_पाठ_विभाजन__if_अंत_23:
  movq -184(%rbp), %r10
  subq %r15, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -224(%rbp)
  movq $16, %r13
  movq $16, %rbx
  movq %rbx, %r10
  addq %r15, %r10
  movq %r10, %rsi
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %r14, %rcx
  movq %r13, %rdx
  movq -120(%rbp), %r8
  movq %rsi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rsi
  movq %r12, %r10
  imulq %rsi, %r10
  movq %r10, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %rsi
  movq -168(%rbp), %r10
  movq %rsi, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %rbx
  movq $0, -224(%rbp)
  movq $1, %rbx
  movq %r12, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $0, %rbx
  movq -200(%rbp), %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_विभाजन__if_अंत_25
  jmp .L_पाठ_विभाजन__wh_अंत_16
.L_पाठ_विभाजन__if_अंत_25:
  movq -184(%rbp), %r10
  addq -72(%rbp), %r10
  movq %r10, %rbx
  movq %rbx, %r15
  movq %rsi, %r12
  jmp .L_पाठ_विभाजन__wh_शर्त_14
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
  je .L_पाठ_विभाजन__if_असत्य_13
  jmp .L_पाठ_विभाजन__if_सत्य_11
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
  movq -136(%rbp), %r10
  addq -72(%rbp), %r10
  movq %r10, %rbx
  movq %rbx, %r11
  movq %rsi, %rbx
  movq %r11, %rsi
  jmp .L_पाठ_विभाजन__if_अंत_12
.L_पाठ_विभाजन__if_अंत_12:
  movq %rsi, -136(%rbp)
  movq %rbx, -152(%rbp)
  jmp .L_पाठ_विभाजन__wh_शर्त_8
.L_पाठ_विभाजन__if_सत्य_6:
  leaq .LC_str_23(%rip), %rcx
  movq .LC_str_23_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_विभाजन__if_सत्य_4:
  leaq .LC_str_22(%rip), %rcx
  movq .LC_str_22_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_पाठ_विभाजन:
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
  .globl पाठ_संयोग
  .def पाठ_संयोग; .scl 2; .type 32; .endef
पाठ_संयोग:
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
  movq %rcx, -120(%rbp)
  movq %rdx, -104(%rbp)
  movq $0, -184(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -184(%rbp), %r11
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
  je .L_पाठ_संयोग__if_अंत_2
  jmp .L_पाठ_संयोग__if_सत्य_1
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
  je .L_किनारा_पाठ_संयोग_0
  jmp .L_पाठ_संयोग__if_सत्य_3
.L_किनारा_पाठ_संयोग_0:
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
  movq $0, %r13
  movq $0, %r14
  movq %r14, -136(%rbp)
  movq %r13, -152(%rbp)
  jmp .L_पाठ_संयोग__wh_शर्त_5
.L_पाठ_संयोग__wh_शर्त_5:
  movq -136(%rbp), %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_संयोग__wh_अंत_7
  jmp .L_पाठ_संयोग__wh_देह_6
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
  movq %rdi, %r10
  cmpq -88(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_पाठ_संयोग__wh_अंत_14
  jmp .L_पाठ_संयोग__wh_देह_13
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
  je .L_किनारा_पाठ_संयोग_1
  jmp .L_पाठ_संयोग__if_सत्य_15
.L_किनारा_पाठ_संयोग_1:
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
  je .L_किनारा_पाठ_संयोग_2
  jmp .L_पाठ_संयोग__if_सत्य_17
.L_किनारा_पाठ_संयोग_2:
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
  je .L_पाठ_संयोग__if_अंत_9
  jmp .L_पाठ_संयोग__if_सत्य_8
.L_पाठ_संयोग__if_अंत_9:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq -152(%rbp), %r10
  addq %rdi, %r10
  movq %r10, %rbx
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
  je .L_किनारा_पाठ_संयोग_3
  jmp .L_पाठ_संयोग__if_सत्य_10
.L_किनारा_पाठ_संयोग_3:
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
  movq %rdi, -136(%rbp)
  movq %rbx, -152(%rbp)
  jmp .L_पाठ_संयोग__wh_शर्त_5
.L_पाठ_संयोग__if_सत्य_8:
  leaq .LC_str_24(%rip), %rcx
  movq .LC_str_24_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
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
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_1
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_2
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
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_4
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_5
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
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_7
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_8
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
  je .L_कोडबिंदु_श्वेत_है__if_अंत_11
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_10
.L_कोडबिंदु_श्वेत_है__if_अंत_11:
  movq $160, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_12
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_13
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
  je .L_कोडबिंदु_श्वेत_है__if_अंत_16
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_15
.L_कोडबिंदु_श्वेत_है__if_अंत_16:
  movq $8192, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_श्वेत_है__sc_लघु_18
  jmp .L_कोडबिंदु_श्वेत_है__sc_दायाँ_17
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
  je .L_कोडबिंदु_श्वेत_है__if_अंत_21
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_20
.L_कोडबिंदु_श्वेत_है__if_अंत_21:
  movq $8232, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_22
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_23
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
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_25
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_26
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
  je .L_कोडबिंदु_श्वेत_है__if_अंत_29
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_28
.L_कोडबिंदु_श्वेत_है__if_अंत_29:
  movq $8287, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_कोडबिंदु_श्वेत_है__sc_दायाँ_30
  jmp .L_कोडबिंदु_श्वेत_है__sc_लघु_31
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
  je .L_कोडबिंदु_श्वेत_है__if_अंत_34
  jmp .L_कोडबिंदु_श्वेत_है__if_सत्य_33
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
  subq $128, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, -104(%rbp)
  movq $0, -120(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -120(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_छाँट__प्रवेश_0:
  movq $0, %rsi
  movq -104(%rbp), %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_छाँट__if_अंत_2
  jmp .L_पाठ_छाँट__if_सत्य_1
.L_पाठ_छाँट__if_अंत_2:
  movq $8, %rsi
  movq -104(%rbp), %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -72(%rbp)
  movq $0, %rsi
  movq $0, %r12
  movq $0, %r13
  jmp .L_पाठ_छाँट__wh_शर्त_3
.L_पाठ_छाँट__wh_शर्त_3:
  movq %r13, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_0
  jmp .L_पाठ_छाँट__wh_देह_4
.L_किनारा_पाठ_छाँट_0:
  movq %r12, %rdi
  movq %rsi, -88(%rbp)
  jmp .L_पाठ_छाँट__wh_अंत_5
.L_पाठ_छाँट__wh_देह_4:
  movq $16, %r14
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq -104(%rbp), %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r14, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r15
  movq %r13, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_1
  jmp .L_पाठ_छाँट__if_सत्य_6
.L_किनारा_पाठ_छाँट_1:
  movq %r15, %rdi
  jmp .L_पाठ_छाँट__if_अंत_7
.L_पाठ_छाँट__if_सत्य_6:
  movq $1, %rdi
  jmp .L_पाठ_छाँट__if_अंत_7
.L_पाठ_छाँट__if_अंत_7:
  movq -104(%rbp), %rcx
  movq %r13, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, %rcx
  subq $32, %rsp
  call कोडबिंदु_श्वेत_है
  addq $32, %rsp
  movq %rax, %r15
  movq %r15, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_छाँट__if_अंत_9
  jmp .L_पाठ_छाँट__if_सत्य_8
.L_पाठ_छाँट__if_अंत_9:
  movq %r13, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_छाँट__wh_शर्त_3
.L_पाठ_छाँट__if_सत्य_8:
  movq $1, %rsi
  movq %rsi, %rdi
  movq %r13, -88(%rbp)
  jmp .L_पाठ_छाँट__wh_अंत_5
.L_पाठ_छाँट__wh_अंत_5:
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_छाँट__if_अंत_11
  jmp .L_पाठ_छाँट__if_सत्य_10
.L_पाठ_छाँट__if_अंत_11:
  movq -88(%rbp), %r12
  movq -88(%rbp), %rdi
  jmp .L_पाठ_छाँट__wh_शर्त_12
.L_पाठ_छाँट__wh_शर्त_12:
  movq %rdi, %r10
  cmpq -72(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_छाँट__wh_अंत_14
  jmp .L_पाठ_छाँट__wh_देह_13
.L_पाठ_छाँट__wh_अंत_14:
  movq %r12, %r10
  subq -88(%rbp), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -120(%rbp)
  movq $16, %r15
  movq $16, %rsi
  movq %rsi, %r10
  addq -88(%rbp), %r10
  movq %r10, %rbx
  subq $8, %rsp
  movq %r13, %r11
  pushq %r11
  movq %r14, %rcx
  movq %r15, %rdx
  movq -104(%rbp), %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %rsi
  movq %r14, %rax
  jmp .L_epilogue_पाठ_छाँट
.L_पाठ_छाँट__wh_देह_13:
  movq $16, %rbx
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %rsi
  movq -104(%rbp), %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %rsi
  movq %rdi, %r10
  addq %rsi, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq -72(%rbp), %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_2
  jmp .L_पाठ_छाँट__if_सत्य_15
.L_किनारा_पाठ_छाँट_2:
  movq %rsi, %rbx
  jmp .L_पाठ_छाँट__if_अंत_16
.L_पाठ_छाँट__if_सत्य_15:
  movq $1, %rbx
  jmp .L_पाठ_छाँट__if_अंत_16
.L_पाठ_छाँट__if_अंत_16:
  movq -104(%rbp), %rcx
  movq %rdi, %rdx
  movq %rbx, %r8
  subq $32, %rsp
  call कोडबिंदु_मान
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call कोडबिंदु_श्वेत_है
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_छाँट_3
  jmp .L_पाठ_छाँट__if_सत्य_17
.L_किनारा_पाठ_छाँट_3:
  movq %r12, %rsi
  jmp .L_पाठ_छाँट__if_अंत_18
.L_पाठ_छाँट__if_सत्य_17:
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  jmp .L_पाठ_छाँट__if_अंत_18
.L_पाठ_छाँट__if_अंत_18:
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %r12
  movq %r12, %rdi
  movq %rsi, %r12
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
  je .L_पाठ_आरंभ_में__sc_दायाँ_1
  jmp .L_पाठ_आरंभ_में__sc_लघु_2
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
  je .L_पाठ_आरंभ_में__if_अंत_5
  jmp .L_पाठ_आरंभ_में__if_सत्य_4
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
  je .L_पाठ_आरंभ_में__if_अंत_7
  jmp .L_पाठ_आरंभ_में__if_सत्य_6
.L_पाठ_आरंभ_में__if_अंत_7:
  movq %r12, %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_आरंभ_में__if_अंत_9
  jmp .L_पाठ_आरंभ_में__if_सत्य_8
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
  je .L_पाठ_अंत_में__sc_दायाँ_1
  jmp .L_पाठ_अंत_में__sc_लघु_2
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
  je .L_पाठ_अंत_में__if_अंत_5
  jmp .L_पाठ_अंत_में__if_सत्य_4
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
  je .L_पाठ_अंत_में__if_अंत_7
  jmp .L_पाठ_अंत_में__if_सत्य_6
.L_पाठ_अंत_में__if_अंत_7:
  movq %r12, %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_अंत_में__if_अंत_9
  jmp .L_पाठ_अंत_में__if_सत्य_8
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

  .text
  .globl सञ्चिका_कोष_तैयार
  .def सञ्चिका_कोष_तैयार; .scl 2; .type 32; .endef
सञ्चिका_कोष_तैयार:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_सञ्चिका_कोष_तैयार__प्रवेश_0:
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_कोष_तैयार__if_अंत_2
  jmp .L_सञ्चिका_कोष_तैयार__if_सत्य_1
.L_सञ्चिका_कोष_तैयार__if_सत्य_1:
  movq $8192, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_सञ्चिका_पथ_बफ(%rip)
  movq $262144, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_सञ्चिका_समादेश_बफ(%rip)
  movq $65536, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_सञ्चिका_तर्क_बफ(%rip)
  movq $64, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_दशमलव_बफ(%rip)
  jmp .L_सञ्चिका_कोष_तैयार__if_अंत_2
.L_सञ्चिका_कोष_तैयार__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_कोष_तैयार
.L_epilogue_सञ्चिका_कोष_तैयार:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_कच्चे_से
  .def पाठ_कच्चे_से; .scl 2; .type 32; .endef
पाठ_कच्चे_से:
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
  movq %rdx, %rsi
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_कच्चे_से__प्रवेश_0:
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -72(%rbp)
  movq $16, %r12
  movq $16, %r13
  movq %rbx, %r10
  subq %r13, %r10
  movq %r10, %r14
  movq $16, %rbx
  subq $8, %rsp
  movq %rsi, %r11
  pushq %r11
  movq %rdi, %rcx
  movq %r12, %rdx
  movq %r14, %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_कच्चे_से
.L_epilogue_पाठ_कच्चे_से:
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
  .globl सञ्चिका_है_रन
  .def सञ्चिका_है_रन; .scl 2; .type 32; .endef
सञ्चिका_है_रन:
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

.L_सञ्चिका_है_रन__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_है_रन__if_अंत_2
  jmp .L_सञ्चिका_है_रन__if_सत्य_1
.L_सञ्चिका_है_रन__if_अंत_2:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4096, %rsi
  movq %rdi, %rcx
  movq %rbx, %rdx
  movq %rsi, %r8
  subq $32, %rsp
  call सूत्र_तल_यूटीएफ_चौड़ा
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -56(%rbp)
  movq $0, %rbx
  movq %r12, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -56(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_है_रन__if_अंत_4
  jmp .L_सञ्चिका_है_रन__if_सत्य_3
.L_सञ्चिका_है_रन__if_अंत_4:
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_सञ्चिका_गुण
  addq $32, %rsp
  movq %rax, %rsi
  movq $4294967295, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_है_रन__if_अंत_6
  jmp .L_सञ्चिका_है_रन__if_सत्य_5
.L_सञ्चिका_है_रन__if_अंत_6:
  movq $16, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $2, %rbx
  movq %rdi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq $1, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_है_रन__if_अंत_8
  jmp .L_सञ्चिका_है_रन__if_सत्य_7
.L_सञ्चिका_है_रन__if_अंत_8:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_है_रन
.L_सञ्चिका_है_रन__if_सत्य_7:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_है_रन
.L_सञ्चिका_है_रन__if_सत्य_5:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_है_रन
.L_सञ्चिका_है_रन__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_है_रन
.L_सञ्चिका_है_रन__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_है_रन
.L_epilogue_सञ्चिका_है_रन:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सञ्चिका_पढ़ो_रन
  .def सञ्चिका_पढ़ो_रन; .scl 2; .type 32; .endef
सञ्चिका_पढ़ो_रन:
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -80(%rbp), %r11
  movl $5, %ecx
.Lजड़_सञ्चिका_पढ़ो_रन:
  movq $0, (%r11)
  movq %r11, (%r10,%rax,8)
  incl %eax
  subq $8, %r11
  decl %ecx
  jnz .Lजड़_सञ्चिका_पढ़ो_रन
  movl %eax, gc_roots_count(%rip)

.L_सञ्चिका_पढ़ो_रन__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__if_अंत_2
  jmp .L_सञ्चिका_पढ़ो_रन__if_सत्य_1
.L_सञ्चिका_पढ़ो_रन__if_अंत_2:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4096, %rsi
  movq %rdi, %rcx
  movq %rbx, %rdx
  movq %rsi, %r8
  subq $32, %rsp
  call सूत्र_तल_यूटीएफ_चौड़ा
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -80(%rbp)
  movq $0, %rbx
  movq %r12, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -80(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__if_अंत_4
  jmp .L_सञ्चिका_पढ़ो_रन__if_सत्य_3
.L_सञ्चिका_पढ़ो_रन__if_अंत_4:
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_सञ्चिका_खोलो_प
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -88(%rbp)
  movq $-1, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__if_अंत_6
  jmp .L_सञ्चिका_पढ़ो_रन__if_सत्य_5
.L_सञ्चिका_पढ़ो_रन__if_अंत_6:
  movq %rsi, %rcx
  subq $32, %rsp
  call सूत्र_तल_सञ्चिका_आकार
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -96(%rbp)
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__sc_दायाँ_7
  jmp .L_सञ्चिका_पढ़ो_रन__sc_लघु_8
.L_सञ्चिका_पढ़ो_रन__sc_दायाँ_7:
  movq $2147483647, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_सञ्चिका_पढ़ो_रन__sc_अंत_9
.L_सञ्चिका_पढ़ो_रन__sc_लघु_8:
  movq $1, %rdi
  jmp .L_सञ्चिका_पढ़ो_रन__sc_अंत_9
.L_सञ्चिका_पढ़ो_रन__sc_अंत_9:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__if_अंत_11
  jmp .L_सञ्चिका_पढ़ो_रन__if_सत्य_10
.L_सञ्चिका_पढ़ो_रन__if_अंत_11:
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -104(%rbp)
  movq $0, %r12
  jmp .L_सञ्चिका_पढ़ो_रन__wh_शर्त_12
.L_सञ्चिका_पढ़ो_रन__wh_शर्त_12:
  movq %r12, -112(%rbp)
  movq %r12, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__wh_अंत_14
  jmp .L_सञ्चिका_पढ़ो_रन__wh_देह_13
.L_सञ्चिका_पढ़ो_रन__wh_देह_13:
  movq $16, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %r10
  subq %r12, %r10
  movq %r10, %r14
  movq %rsi, %rcx
  movq %r13, %rdx
  movq %r14, %r8
  subq $32, %rsp
  call सूत्र_तल_पढ़ो
  addq $32, %rsp
  movq %rax, %r15
  movq $0, %r13
  movq %r15, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_पढ़ो_रन__if_अंत_16
  jmp .L_सञ्चिका_पढ़ो_रन__wh_अंत_14
.L_सञ्चिका_पढ़ो_रन__if_अंत_16:
  movq %r12, %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %r13, %r12
  jmp .L_सञ्चिका_पढ़ो_रन__wh_शर्त_12
.L_सञ्चिका_पढ़ो_रन__wh_अंत_14:
  movq $8, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq $16, %rbx
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq $0, -112(%rbp)
  movq $0, %rbx
  movq %rdi, %r10
  movq %r13, %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %r12
  movq %rsi, %rcx
  subq $32, %rsp
  call सूत्र_तल_हैंडल_बंद
  addq $32, %rsp
  movq %rax, %rbx
  movq %rdi, %rax
  jmp .L_epilogue_सञ्चिका_पढ़ो_रन
.L_सञ्चिका_पढ़ो_रन__if_सत्य_10:
  movq %rsi, %rcx
  subq $32, %rsp
  call सूत्र_तल_हैंडल_बंद
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, -88(%rbp)
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सञ्चिका_पढ़ो_रन
.L_सञ्चिका_पढ़ो_रन__if_सत्य_5:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सञ्चिका_पढ़ो_रन
.L_सञ्चिका_पढ़ो_रन__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सञ्चिका_पढ़ो_रन
.L_सञ्चिका_पढ़ो_रन__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सञ्चिका_पढ़ो_रन
.L_epilogue_सञ्चिका_पढ़ो_रन:
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
  .globl सञ्चिका_लिखो_रन
  .def सञ्चिका_लिखो_रन; .scl 2; .type 32; .endef
सञ्चिका_लिखो_रन:
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
  movq $0, -104(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -88(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -96(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सञ्चिका_लिखो_रन__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__sc_दायाँ_1
  jmp .L_सञ्चिका_लिखो_रन__sc_लघु_2
.L_सञ्चिका_लिखो_रन__sc_दायाँ_1:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_सञ्चिका_लिखो_रन__sc_अंत_3
.L_सञ्चिका_लिखो_रन__sc_लघु_2:
  movq $1, %rdi
  jmp .L_सञ्चिका_लिखो_रन__sc_अंत_3
.L_सञ्चिका_लिखो_रन__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_5
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_4
.L_सञ्चिका_लिखो_रन__if_अंत_5:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rdi
  movq $16, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4096, %rdi
  movq %r12, %rcx
  movq %rbx, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call सूत्र_तल_यूटीएफ_चौड़ा
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -88(%rbp)
  movq $0, %rbx
  movq %r13, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -88(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_7
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_6
.L_सञ्चिका_लिखो_रन__if_अंत_7:
  movq sutra_glob_सञ्चिका_पथ_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_सञ्चिका_खोलो_ल
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -96(%rbp)
  movq $-1, %rbx
  movq %rdi, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_9
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_8
.L_सञ्चिका_लिखो_रन__if_अंत_9:
  movq $8, %rbx
  movq %rsi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rbx
  movq $1, %r13
  movq %rbx, -72(%rbp)
  jmp .L_सञ्चिका_लिखो_रन__wh_शर्त_10
.L_सञ्चिका_लिखो_रन__wh_शर्त_10:
  movq -72(%rbp), %r11
  movq %r11, -104(%rbp)
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सञ्चिका_लिखो_रन_0
  jmp .L_सञ्चिका_लिखो_रन__wh_देह_11
.L_किनारा_सञ्चिका_लिखो_रन_0:
  movq %r13, %rbx
  jmp .L_सञ्चिका_लिखो_रन__wh_अंत_12
.L_सञ्चिका_लिखो_रन__wh_देह_11:
  movq $16, %r14
  movq %rsi, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r15, %r10
  addq -72(%rbp), %r10
  movq %r10, %r14
  movq %r12, %r10
  subq -72(%rbp), %r10
  movq %r10, %r15
  movq %rdi, %rcx
  movq %r14, %rdx
  movq %r15, %r8
  subq $32, %rsp
  call सूत्र_तल_लिखो
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %r14
  movq %rbx, %r10
  cmpq %r14, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_14
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_13
.L_सञ्चिका_लिखो_रन__if_अंत_14:
  movq -72(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %r14
  movq %r14, -72(%rbp)
  jmp .L_सञ्चिका_लिखो_रन__wh_शर्त_10
.L_सञ्चिका_लिखो_रन__if_सत्य_13:
  movq $0, %rbx
  jmp .L_सञ्चिका_लिखो_रन__wh_अंत_12
.L_सञ्चिका_लिखो_रन__wh_अंत_12:
  movq %rdi, %rcx
  subq $32, %rsp
  call सूत्र_तल_हैंडल_बंद
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -96(%rbp)
  movq $1, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_16
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_15
.L_सञ्चिका_लिखो_रन__if_सत्य_15:
  movq -72(%rbp), %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq $0, -104(%rbp)
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_सञ्चिका_लिखो_रन__if_अंत_16
  jmp .L_सञ्चिका_लिखो_रन__if_सत्य_17
.L_सञ्चिका_लिखो_रन__if_अंत_16:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_लिखो_रन
.L_सञ्चिका_लिखो_रन__if_सत्य_17:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_लिखो_रन
.L_सञ्चिका_लिखो_रन__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_लिखो_रन
.L_सञ्चिका_लिखो_रन__if_सत्य_6:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_लिखो_रन
.L_सञ्चिका_लिखो_रन__if_सत्य_4:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सञ्चिका_लिखो_रन
.L_epilogue_सञ्चिका_लिखो_रन:
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
  .globl समादेश_उपसर्ग
  .def समादेश_उपसर्ग; .scl 2; .type 32; .endef
समादेश_उपसर्ग:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_समादेश_उपसर्ग__प्रवेश_0:
  leaq .LC_str_25(%rip), %rcx
  movq .LC_str_25_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_समादेश_उपसर्ग
.L_epilogue_समादेश_उपसर्ग:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl समादेश_चलाओ_रन
  .def समादेश_चलाओ_रन; .scl 2; .type 32; .endef
समादेश_चलाओ_रन:
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
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_समादेश_चलाओ_रन__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_समादेश_चलाओ_रन__if_अंत_2
  jmp .L_समादेश_चलाओ_रन__if_सत्य_1
.L_समादेश_चलाओ_रन__if_अंत_2:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  leaq .LC_str_25(%rip), %rcx
  movq .LC_str_25_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -56(%rbp)
  movq $0, -72(%rbp)
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $0, -56(%rbp)
  movq sutra_glob_सञ्चिका_समादेश_बफ(%rip), %r10
  movq %r10, %rbx
  movq $131072, %rdi
  movq %rsi, %rcx
  movq %rbx, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call सूत्र_तल_यूटीएफ_चौड़ा
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, -64(%rbp)
  movq $0, %rbx
  movq %r12, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -64(%rbp)
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_समादेश_चलाओ_रन__if_अंत_4
  jmp .L_समादेश_चलाओ_रन__if_सत्य_3
.L_समादेश_चलाओ_रन__if_अंत_4:
  movq sutra_glob_सञ्चिका_समादेश_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_समादेश
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_समादेश_चलाओ_रन
.L_समादेश_चलाओ_रन__if_सत्य_3:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_समादेश_चलाओ_रन
.L_समादेश_चलाओ_रन__if_सत्य_1:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_समादेश_चलाओ_रन
.L_epilogue_समादेश_चलाओ_रन:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl तर्क_आरंभ_रन
  .def तर्क_आरंभ_रन; .scl 2; .type 32; .endef
तर्क_आरंभ_रन:
  pushq %rbp
  movq %rsp, %rbp
  subq $80, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq $0, -64(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_तर्क_आरंभ_रन__प्रवेश_0:
  movq sutra_glob_तर्क_तैयार(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_तर्क_आरंभ_रन__if_अंत_2
  jmp .L_तर्क_आरंभ_रन__if_सत्य_1
.L_तर्क_आरंभ_रन__if_अंत_2:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rbx
  subq $32, %rsp
  call सूत्र_तल_समादेश_रेखा
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, -64(%rbp)
  movq $8, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rsi
  movq $0, %r12
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call सूत्र_तल_समादेश_विभाजन
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -64(%rbp)
  movq %rsi, %r10
  movq %r10, sutra_glob_तर्क_डब्ल्यू(%rip)
  movq sutra_glob_तर्क_डब्ल्यू(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_तर्क_आरंभ_रन__if_असत्य_5
  jmp .L_तर्क_आरंभ_रन__if_सत्य_3
.L_तर्क_आरंभ_रन__if_असत्य_5:
  movq $0, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $4294967296, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_तर्क_गण(%rip)
  jmp .L_तर्क_आरंभ_रन__if_अंत_4
.L_तर्क_आरंभ_रन__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_तर्क_गण(%rip)
  jmp .L_तर्क_आरंभ_रन__if_अंत_4
.L_तर्क_आरंभ_रन__if_अंत_4:
  movq %rdi, %rcx
  subq $32, %rsp
  call सूत्र_तल_मुक्त
  addq $32, %rsp
  movq %rax, %rbx
  movq $1, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_तर्क_तैयार(%rip)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_तर्क_आरंभ_रन
.L_तर्क_आरंभ_रन__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_तर्क_आरंभ_रन
.L_epilogue_तर्क_आरंभ_रन:
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
  .globl तर्क_सूची_रन
  .def तर्क_सूची_रन; .scl 2; .type 32; .endef
तर्क_सूची_रन:
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

.L_तर्क_सूची_रन__प्रवेश_0:
  subq $32, %rsp
  call तर्क_आरंभ_रन
  addq $32, %rsp
  movq %rax, %rbx
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rbx
  movq sutra_glob_तर्क_गण(%rip), %r10
  movq %r10, %rbx
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
  movq %rax, -72(%rbp)
  movq -72(%rbp), %r11
  movq %r11, -112(%rbp)
  movq $0, %rsi
  movq -72(%rbp), %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $8, %rsi
  movq -72(%rbp), %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %rdi
  movq $0, %rbx
  movq %rbx, -88(%rbp)
  jmp .L_तर्क_सूची_रन__wh_शर्त_1
.L_तर्क_सूची_रन__wh_शर्त_1:
  movq sutra_glob_तर्क_गण(%rip), %r10
  movq %r10, %rsi
  movq -88(%rbp), %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_तर्क_सूची_रन__wh_अंत_3
  jmp .L_तर्क_सूची_रन__wh_देह_2
.L_तर्क_सूची_रन__wh_अंत_3:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq -72(%rbp), %rax
  jmp .L_epilogue_तर्क_सूची_रन
.L_तर्क_सूची_रन__wh_देह_2:
  movq sutra_glob_तर्क_डब्ल्यू(%rip), %r10
  movq %r10, %rsi
  movq $8, %rdi
  movq -88(%rbp), %r10
  imulq %rdi, %r10
  movq %r10, %r13
  movq %rsi, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq sutra_glob_सञ्चिका_तर्क_बफ(%rip), %r10
  movq %r10, %rsi
  movq $65536, %r13
  movq %rdi, %rcx
  movq %rsi, %rdx
  movq %r13, %r8
  subq $32, %rsp
  call सूत्र_तल_चौड़ा_यूटीएफ
  addq $32, %rsp
  movq %rax, %r14
  movq $1, %rsi
  movq %r14, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_तर्क_सूची_रन_0
  jmp .L_तर्क_सूची_रन__if_सत्य_4
.L_किनारा_तर्क_सूची_रन_0:
  movq %rdi, %rsi
  jmp .L_तर्क_सूची_रन__if_अंत_5
.L_तर्क_सूची_रन__if_सत्य_4:
  movq $0, %rsi
  jmp .L_तर्क_सूची_रन__if_अंत_5
.L_तर्क_सूची_रन__if_अंत_5:
  movq %rsi, -104(%rbp)
  movq $16, %rdi
  movq $8, %r13
  movq -88(%rbp), %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq sutra_glob_सञ्चिका_तर्क_बफ(%rip), %r10
  movq %r10, %rdi
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -120(%rbp)
  movq $16, %r15
  movq $16, %r12
  movq %rdi, %r10
  subq %r12, %r10
  movq %r10, %rbx
  movq $16, %rdi
  subq $8, %rsp
  movq %rsi, %r11
  pushq %r11
  movq %r14, %rcx
  movq %r15, %rdx
  movq %rbx, %r8
  movq %rdi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r12
  movq $0, -104(%rbp)
  movq -72(%rbp), %r10
  movq %r13, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %rbx
  movq $0, -120(%rbp)
  movq $1, %rbx
  movq -88(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, -88(%rbp)
  jmp .L_तर्क_सूची_रन__wh_शर्त_1
.L_epilogue_तर्क_सूची_रन:
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
  .globl दशमलव_प्रारूप
  .def दशमलव_प्रारूप; .scl 2; .type 32; .endef
दशमलव_प्रारूप:
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
  movq %rdx, -72(%rbp)

.L_दशमलव_प्रारूप__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call sutra_float_ne
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__if_अंत_2
  jmp .L_दशमलव_प्रारूप__if_सत्य_1
.L_दशमलव_प्रारूप__if_अंत_2:
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r12
  movq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_lt
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_0
  jmp .L_दशमलव_प्रारूप__if_सत्य_3
.L_किनारा_दशमलव_प्रारूप_0:
  movq %rbx, -104(%rbp)
  movq %rdi, -88(%rbp)
  jmp .L_दशमलव_प्रारूप__if_अंत_4
.L_दशमलव_प्रारूप__if_सत्य_3:
  movq $45, %r12
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %r13
  movq $1, %rdi
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r12
  movq %r12, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call sutra_float_sub
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -104(%rbp)
  movq %rdi, -88(%rbp)
  jmp .L_दशमलव_प्रारूप__if_अंत_4
.L_दशमलव_प्रारूप__if_अंत_4:
  movq -104(%rbp), %rcx
  movq -104(%rbp), %rdx
  subq $32, %rsp
  call sutra_float_sub
  addq $32, %rsp
  movq %rax, %r12
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r13
  movq %r12, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call sutra_float_ne
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__if_अंत_6
  jmp .L_दशमलव_प्रारूप__if_सत्य_5
.L_दशमलव_प्रारूप__if_अंत_6:
  movq .LC_dbl_1(%rip), %r10
  movq %r10, %r12
  movq -104(%rbp), %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call sutra_math_round_f
  addq $32, %rsp
  movq %rax, %r12
  movq $0, %r13
  movq %r12, %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__if_अंत_8
  jmp .L_दशमलव_प्रारूप__if_सत्य_7
.L_दशमलव_प्रारूप__if_अंत_8:
  movq $1000000, %r13
  movq %r12, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq $1000000, %r13
  movq %r12, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $0, %r12
  movq %r14, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__if_असत्य_16
  jmp .L_दशमलव_प्रारूप__if_सत्य_14
.L_दशमलव_प्रारूप__if_असत्य_16:
  movq %r14, %rcx
  subq $32, %rsp
  call अंक_गणना
  addq $32, %rsp
  movq %rax, %r12
  movq -88(%rbp), %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %r11
  movq %r14, %r13
  movq %r11, %r14
  jmp .L_दशमलव_प्रारूप__wh_शर्त_17
.L_दशमलव_प्रारूप__wh_शर्त_17:
  movq $0, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__wh_अंत_19
  jmp .L_दशमलव_प्रारूप__wh_देह_18
.L_दशमलव_प्रारूप__wh_अंत_19:
  movq -88(%rbp), %r10
  addq %r12, %r10
  movq %r10, %rbx
  jmp .L_दशमलव_प्रारूप__if_अंत_15
.L_दशमलव_प्रारूप__wh_देह_18:
  movq $1, %rbx
  movq %r14, %r10
  subq %rbx, %r10
  movq %r10, %rsi
  movq $48, %rbx
  movq $10, %r14
  movq %r13, %rax
  movq %r14, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq -72(%rbp), %r10
  movq %rsi, %r11
  movq %r14, %r8
  movb %r8b, (%r10,%r11)
  movq %r14, %rbx
  movq $10, %rbx
  movq %r13, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq %rsi, %r14
  movq %rdi, %r13
  jmp .L_दशमलव_प्रारूप__wh_शर्त_17
.L_दशमलव_प्रारूप__if_सत्य_14:
  movq $48, %rbx
  movq -72(%rbp), %r10
  movq -88(%rbp), %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rsi
  movq $1, %rbx
  movq -88(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rbx
  jmp .L_दशमलव_प्रारूप__if_अंत_15
.L_दशमलव_प्रारूप__if_अंत_15:
  movq $100000, %rsi
  movq %r15, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $100000, %rsi
  movq %r15, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r12
  movq $10000, %rsi
  movq %r12, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %r13
  movq $10000, %rsi
  movq %r12, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq $1000, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %r12
  movq $1000, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r15
  movq $100, %rsi
  movq %r15, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, -120(%rbp)
  movq $100, %rsi
  movq %r15, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq $10, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, -152(%rbp)
  movq $10, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, -136(%rbp)
  movq $-1, %rsi
  movq $0, %r14
  movq %rdi, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_1
  jmp .L_दशमलव_प्रारूप__if_सत्य_20
.L_किनारा_दशमलव_प्रारूप_1:
  jmp .L_दशमलव_प्रारूप__if_अंत_21
.L_दशमलव_प्रारूप__if_सत्य_20:
  movq $0, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_21
.L_दशमलव_प्रारूप__if_अंत_21:
  movq $0, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_2
  jmp .L_दशमलव_प्रारूप__if_सत्य_22
.L_किनारा_दशमलव_प्रारूप_2:
  jmp .L_दशमलव_प्रारूप__if_अंत_23
.L_दशमलव_प्रारूप__if_सत्य_22:
  movq $1, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_23
.L_दशमलव_प्रारूप__if_अंत_23:
  movq $0, %r14
  movq %r12, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_3
  jmp .L_दशमलव_प्रारूप__if_सत्य_24
.L_किनारा_दशमलव_प्रारूप_3:
  jmp .L_दशमलव_प्रारूप__if_अंत_25
.L_दशमलव_प्रारूप__if_सत्य_24:
  movq $2, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_25
.L_दशमलव_प्रारूप__if_अंत_25:
  movq $0, %r14
  movq -120(%rbp), %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_4
  jmp .L_दशमलव_प्रारूप__if_सत्य_26
.L_किनारा_दशमलव_प्रारूप_4:
  jmp .L_दशमलव_प्रारूप__if_अंत_27
.L_दशमलव_प्रारूप__if_सत्य_26:
  movq $3, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_27
.L_दशमलव_प्रारूप__if_अंत_27:
  movq $0, %r14
  movq -152(%rbp), %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_5
  jmp .L_दशमलव_प्रारूप__if_सत्य_28
.L_किनारा_दशमलव_प्रारूप_5:
  jmp .L_दशमलव_प्रारूप__if_अंत_29
.L_दशमलव_प्रारूप__if_सत्य_28:
  movq $4, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_29
.L_दशमलव_प्रारूप__if_अंत_29:
  movq $0, %r14
  movq -136(%rbp), %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_6
  jmp .L_दशमलव_प्रारूप__if_सत्य_30
.L_किनारा_दशमलव_प्रारूप_6:
  jmp .L_दशमलव_प्रारूप__if_अंत_31
.L_दशमलव_प्रारूप__if_सत्य_30:
  movq $5, %rsi
  jmp .L_दशमलव_प्रारूप__if_अंत_31
.L_दशमलव_प्रारूप__if_अंत_31:
  movq $0, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_दशमलव_प्रारूप_7
  jmp .L_दशमलव_प्रारूप__if_सत्य_32
.L_किनारा_दशमलव_प्रारूप_7:
  jmp .L_दशमलव_प्रारूप__if_अंत_33
.L_दशमलव_प्रारूप__if_सत्य_32:
  movq $46, %r14
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq %r14, %r8
  movb %r8b, (%r10,%r11)
  movq %r14, %r15
  movq $1, %r14
  movq %rbx, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq $48, %rbx
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r14
  movq -72(%rbp), %r10
  movq %r15, %r11
  movq %r14, %r8
  movb %r8b, (%r10,%r11)
  movq %r14, %rbx
  movq $1, %rbx
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $48, %rbx
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r14, %r8
  movb %r8b, (%r10,%r11)
  movq %r14, %rbx
  movq $2, %rbx
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $48, %rbx
  movq %rbx, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %rbx
  movq $3, %rbx
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $48, %rbx
  movq %rbx, %r10
  addq -120(%rbp), %r10
  movq %r10, %r12
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %rbx
  movq $4, %rbx
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $48, %rbx
  movq %rbx, %r10
  addq -152(%rbp), %r10
  movq %r10, %r12
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %rbx
  movq $5, %rbx
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $48, %rbx
  movq %rbx, %r10
  addq -136(%rbp), %r10
  movq %r10, %r12
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %rbx
  movq %r15, %r10
  addq %rsi, %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rbx
  jmp .L_दशमलव_प्रारूप__if_अंत_33
.L_दशमलव_प्रारूप__if_अंत_33:
  movq %rbx, %rax
  jmp .L_epilogue_दशमलव_प्रारूप
.L_दशमलव_प्रारूप__if_सत्य_7:
  movq -104(%rbp), %rcx
  subq $32, %rsp
  call sutra_math_round_f
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call अंक_गणना
  addq $32, %rsp
  movq %rax, %rsi
  movq -88(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__if_अंत_10
  jmp .L_दशमलव_प्रारूप__if_सत्य_9
.L_दशमलव_प्रारूप__if_अंत_10:
  jmp .L_दशमलव_प्रारूप__wh_शर्त_11
.L_दशमलव_प्रारूप__wh_शर्त_11:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_दशमलव_प्रारूप__wh_अंत_13
  jmp .L_दशमलव_प्रारूप__wh_देह_12
.L_दशमलव_प्रारूप__wh_अंत_13:
  movq -88(%rbp), %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq %r12, %rax
  jmp .L_epilogue_दशमलव_प्रारूप
.L_दशमलव_प्रारूप__wh_देह_12:
  movq $1, %r12
  movq %rdi, %r10
  subq %r12, %r10
  movq %r10, %r13
  movq $48, %rdi
  movq $10, %r12
  movq %rbx, %rax
  movq %r12, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %r12
  movq -72(%rbp), %r10
  movq %r13, %r11
  movq %r12, %r8
  movb %r8b, (%r10,%r11)
  movq %r12, %rdi
  movq $10, %rdi
  movq %rbx, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rax, %r12
  movq %r13, %rdi
  movq %r12, %rbx
  jmp .L_दशमलव_प्रारूप__wh_शर्त_11
.L_दशमलव_प्रारूप__if_सत्य_9:
  movq $48, %rbx
  movq -72(%rbp), %r10
  movq -88(%rbp), %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rsi
  movq $1, %rbx
  movq -88(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_दशमलव_प्रारूप
.L_दशमलव_प्रारूप__if_सत्य_5:
  movq $105, %rbx
  movq -72(%rbp), %r10
  movq -88(%rbp), %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rsi
  movq $1, %rbx
  movq -88(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $110, %rbx
  movq -72(%rbp), %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rdi
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $102, %rbx
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movb %r8b, (%r10,%r11)
  movq %rbx, %rsi
  movq $1, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_दशमलव_प्रारूप
.L_दशमलव_प्रारूप__if_सत्य_1:
  movq $0, %rbx
  movq $110, %rsi
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %rdi
  movq $1, %rbx
  movq $97, %rsi
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %rdi
  movq $2, %rbx
  movq $110, %rsi
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %rdi
  movq $3, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_दशमलव_प्रारूप
.L_epilogue_दशमलव_प्रारूप:
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
  .globl दशमलव_से_पाठ
  .def दशमलव_से_पाठ; .scl 2; .type 32; .endef
दशमलव_से_पाठ:
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

.L_दशमलव_से_पाठ__प्रवेश_0:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call दशमलव_प्रारूप
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq $16, %r12
  movq $16, %r13
  movq %rbx, %r10
  subq %r13, %r10
  movq %r10, %r14
  movq $16, %rbx
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %rsi, %rcx
  movq %r12, %rdx
  movq %r14, %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rsi, %rax
  jmp .L_epilogue_दशमलव_से_पाठ
.L_epilogue_दशमलव_से_पाठ:
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
  .globl दशमलव_छापो
  .def दशमलव_छापो; .scl 2; .type 32; .endef
दशमलव_छापो:
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

.L_दशमलव_छापो__प्रवेश_0:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call दशमलव_प्रारूप
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rbx
  movq %rdi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq $16, %r12
  movq $16, %r13
  movq %rbx, %r10
  subq %r13, %r10
  movq %r10, %r14
  movq $16, %rbx
  subq $8, %rsp
  movq %rdi, %r11
  pushq %r11
  movq %rsi, %rcx
  movq %r12, %rdx
  movq %r14, %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r13
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_छापो
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, -72(%rbp)
  movq %rbx, %rax
  jmp .L_epilogue_दशमलव_छापो
.L_epilogue_दशमलव_छापो:
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
  .globl रन_क्या_पाठ
  .def रन_क्या_पाठ; .scl 2; .type 32; .endef
रन_क्या_पाठ:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_रन_क्या_पाठ__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -48(%rbp)
  movq $1, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -48(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_रन_क्या_पाठ__if_अंत_2
  jmp .L_रन_क्या_पाठ__if_सत्य_1
.L_रन_क्या_पाठ__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_पाठ
.L_रन_क्या_पाठ__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_पाठ
.L_epilogue_रन_क्या_पाठ:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl रन_क्या_सूची
  .def रन_क्या_सूची; .scl 2; .type 32; .endef
रन_क्या_सूची:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_रन_क्या_सूची__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -48(%rbp)
  movq $2, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -48(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_रन_क्या_सूची__if_अंत_2
  jmp .L_रन_क्या_सूची__if_सत्य_1
.L_रन_क्या_सूची__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_सूची
.L_रन_क्या_सूची__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_सूची
.L_epilogue_रन_क्या_सूची:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl रन_क्या_शब्दकोश
  .def रन_क्या_शब्दकोश; .scl 2; .type 32; .endef
रन_क्या_शब्दकोश:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx
  movq $0, -48(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -48(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_रन_क्या_शब्दकोश__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -48(%rbp)
  movq $4, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -48(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_रन_क्या_शब्दकोश__if_अंत_2
  jmp .L_रन_क्या_शब्दकोश__if_सत्य_1
.L_रन_क्या_शब्दकोश__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_शब्दकोश
.L_रन_क्या_शब्दकोश__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_रन_क्या_शब्दकोश
.L_epilogue_रन_क्या_शब्दकोश:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_रचना
  .def पाठ_रचना; .scl 2; .type 32; .endef
पाठ_रचना:
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
  movq %rdx, %rsi
  movq $0, -72(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_रचना__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_रचना__if_अंत_2
  jmp .L_पाठ_रचना__if_सत्य_1
.L_पाठ_रचना__if_अंत_2:
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -72(%rbp)
  movq $16, %r12
  movq $0, %r13
  subq $8, %rsp
  movq %rsi, %r11
  pushq %r11
  movq %rdi, %rcx
  movq %r12, %rdx
  movq %rbx, %r8
  movq %r13, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_रचना
.L_पाठ_रचना__if_सत्य_1:
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_रचना
.L_epilogue_पाठ_रचना:
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
  .globl पाठ_सूचकांक
  .def पाठ_सूचकांक; .scl 2; .type 32; .endef
पाठ_सूचकांक:
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
  movq %rcx, -72(%rbp)
  movq %rdx, %rsi
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -104(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_पाठ_सूचकांक__प्रवेश_0:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_सूचकांक__if_अंत_2
  jmp .L_पाठ_सूचकांक__if_सत्य_1
.L_पाठ_सूचकांक__if_अंत_2:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_सूचकांक__if_अंत_4
  jmp .L_पाठ_सूचकांक__if_सत्य_3
.L_पाठ_सूचकांक__if_अंत_4:
  movq $8, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq $0, %r13
  subq $32, %rsp
  call सूत्र_गण_चक्र
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, -104(%rbp)
  movq sutra_glob_पसू_कैश_स(%rip), %r10
  movq %r10, %r15
  movq -72(%rbp), %r10
  cmpq %r15, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_सूचकांक_0
  jmp .L_पाठ_सूचकांक__if_सत्य_5
.L_किनारा_पाठ_सूचकांक_0:
  movq %rdi, %rbx
  movq %r13, %rdi
  jmp .L_पाठ_सूचकांक__if_अंत_6
.L_पाठ_सूचकांक__if_सत्य_5:
  movq sutra_glob_पसू_कैश_चक्र(%rip), %r10
  movq %r10, %rbx
  movq %r14, %r10
  cmpq %rbx, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_सूचकांक_1
  jmp .L_पाठ_सूचकांक__if_सत्य_7
.L_किनारा_पाठ_सूचकांक_1:
  movq %rdi, %rbx
  movq %r13, %rdi
  jmp .L_पाठ_सूचकांक__if_अंत_8
.L_पाठ_सूचकांक__if_सत्य_7:
  movq sutra_glob_पसू_कैश_क(%rip), %r10
  movq %r10, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_सूचकांक_2
  jmp .L_पाठ_सूचकांक__if_सत्य_9
.L_किनारा_पाठ_सूचकांक_2:
  movq %rdi, %rbx
  movq %r13, %rdi
  jmp .L_पाठ_सूचकांक__if_अंत_10
.L_पाठ_सूचकांक__if_सत्य_9:
  movq sutra_glob_पसू_कैश_ब(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_पसू_कैश_क(%rip), %r10
  movq %r10, %rdi
  jmp .L_पाठ_सूचकांक__if_अंत_10
.L_पाठ_सूचकांक__if_अंत_10:
  jmp .L_पाठ_सूचकांक__if_अंत_8
.L_पाठ_सूचकांक__if_अंत_8:
  jmp .L_पाठ_सूचकांक__if_अंत_6
.L_पाठ_सूचकांक__if_अंत_6:
  movq %rbx, -88(%rbp)
  jmp .L_पाठ_सूचकांक__wh_शर्त_11
.L_पाठ_सूचकांक__wh_शर्त_11:
  movq -88(%rbp), %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_सूचकांक__wh_अंत_13
  jmp .L_पाठ_सूचकांक__wh_देह_12
.L_पाठ_सूचकांक__wh_अंत_13:
  leaq .LC_str_3(%rip), %rcx
  movq .LC_str_3_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_सूचकांक__wh_देह_12:
  movq $16, %r13
  movq %r13, %r10
  addq -88(%rbp), %r10
  movq %r10, %r15
  movq -72(%rbp), %r10
  movq %r15, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call अक्षर_बाइट_चौड़ाई
  addq $32, %rsp
  movq %rax, %r15
  movq -88(%rbp), %r10
  addq %r15, %r10
  movq %r10, %r13
  movq %rdi, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_सूचकांक__if_अंत_15
  jmp .L_पाठ_सूचकांक__if_सत्य_14
.L_पाठ_सूचकांक__if_अंत_15:
  movq $1, %r15
  movq %rdi, %r10
  addq %r15, %r10
  movq %r10, %rbx
  movq %rbx, %rdi
  movq %r13, -88(%rbp)
  jmp .L_पाठ_सूचकांक__wh_शर्त_11
.L_पाठ_सूचकांक__if_सत्य_14:
  movq -72(%rbp), %r10
  movq %r10, sutra_glob_पसू_कैश_स(%rip)
  movq %rdi, %r10
  movq %r10, sutra_glob_पसू_कैश_क(%rip)
  movq -88(%rbp), %r10
  movq %r10, sutra_glob_पसू_कैश_ब(%rip)
  movq %r14, %r10
  movq %r10, sutra_glob_पसू_कैश_चक्र(%rip)
  movq $0, -104(%rbp)
  movq %r13, %r10
  subq -88(%rbp), %r10
  movq %r10, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -112(%rbp)
  movq $16, %rdi
  movq $16, %r12
  movq %r12, %r10
  addq -88(%rbp), %r10
  movq %r10, %r13
  subq $8, %rsp
  movq %rbx, %r11
  pushq %r11
  movq %rsi, %rcx
  movq %rdi, %rdx
  movq -72(%rbp), %r8
  movq %r13, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r12
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_सूचकांक
.L_पाठ_सूचकांक__if_सत्य_3:
  leaq .LC_str_2(%rip), %rcx
  movq .LC_str_2_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_पाठ_सूचकांक__if_सत्य_1:
  leaq .LC_str_26(%rip), %rcx
  movq .LC_str_26_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_पाठ_सूचकांक:
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
  .globl संग्रह_रन
  .def संग्रह_रन; .scl 2; .type 32; .endef
संग्रह_रन:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_संग्रह_रन__प्रवेश_0:
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_पसू_कैश_स(%rip)
  subq $32, %rsp
  call सूत्र_संग्रह
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_संग्रह_रन
.L_epilogue_संग्रह_रन:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_सूचकांक
  .def सूची_सूचकांक; .scl 2; .type 32; .endef
सूची_सूचकांक:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सूची_सूचकांक__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक__if_अंत_2
  jmp .L_सूची_सूचकांक__if_सत्य_1
.L_सूची_सूचकांक__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक__if_अंत_4
  jmp .L_सूची_सूचकांक__if_सत्य_3
.L_सूची_सूचकांक__if_अंत_4:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_शब्दकोश
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक__if_अंत_6
  jmp .L_सूची_सूचकांक__if_सत्य_5
.L_सूची_सूचकांक__if_अंत_6:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक__sc_दायाँ_7
  jmp .L_सूची_सूचकांक__sc_लघु_8
.L_सूची_सूचकांक__sc_दायाँ_7:
  movq %rsi, %r10
  cmpq %r12, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  jmp .L_सूची_सूचकांक__sc_अंत_9
.L_सूची_सूचकांक__sc_लघु_8:
  movq $1, %rdi
  jmp .L_सूची_सूचकांक__sc_अंत_9
.L_सूची_सूचकांक__sc_अंत_9:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक__if_अंत_11
  jmp .L_सूची_सूचकांक__if_सत्य_10
.L_सूची_सूचकांक__if_अंत_11:
  movq $16, %rdi
  movq $8, %r12
  movq %rsi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_सूचकांक
.L_सूची_सूचकांक__if_सत्य_10:
  leaq .LC_str_28(%rip), %rcx
  movq .LC_str_28_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सूची_सूचकांक__if_सत्य_5:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call शब्दकोश_पाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_सूचकांक
.L_सूची_सूचकांक__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_सूचकांक
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_सूचकांक
.L_सूची_सूचकांक__if_सत्य_1:
  leaq .LC_str_27(%rip), %rcx
  movq .LC_str_27_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_सूचकांक:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_सूचकांक_सेट
  .def सूची_सूचकांक_सेट; .scl 2; .type 32; .endef
सूची_सूचकांक_सेट:
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
  movq %r8, %rdi

.L_सूची_सूचकांक_सेट__प्रवेश_0:
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक_सेट__if_अंत_2
  jmp .L_सूची_सूचकांक_सेट__if_सत्य_1
.L_सूची_सूचकांक_सेट__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_शब्दकोश
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक_सेट__if_अंत_4
  jmp .L_सूची_सूचकांक_सेट__if_सत्य_3
.L_सूची_सूचकांक_सेट__if_अंत_4:
  movq $8, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक_सेट__sc_दायाँ_5
  jmp .L_सूची_सूचकांक_सेट__sc_लघु_6
.L_सूची_सूचकांक_सेट__sc_दायाँ_5:
  movq %rsi, %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r12
  jmp .L_सूची_सूचकांक_सेट__sc_अंत_7
.L_सूची_सूचकांक_सेट__sc_लघु_6:
  movq $1, %r12
  jmp .L_सूची_सूचकांक_सेट__sc_अंत_7
.L_सूची_सूचकांक_सेट__sc_अंत_7:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_सूचकांक_सेट__if_अंत_9
  jmp .L_सूची_सूचकांक_सेट__if_सत्य_8
.L_सूची_सूचकांक_सेट__if_अंत_9:
  movq $16, %r12
  movq $8, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $0, %r12
  movq %r12, %rax
  jmp .L_epilogue_सूची_सूचकांक_सेट
.L_सूची_सूचकांक_सेट__if_सत्य_8:
  leaq .LC_str_28(%rip), %rcx
  movq .LC_str_28_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सूची_सूचकांक_सेट__if_सत्य_3:
  movq %rbx, %rcx
  movq %rsi, %rdx
  movq %rdi, %r8
  subq $32, %rsp
  call शब्दकोश_सेट
  addq $32, %rsp
  movq %rax, %r12
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूची_सूचकांक_सेट
.L_सूची_सूचकांक_सेट__if_सत्य_1:
  leaq .LC_str_27(%rip), %rcx
  movq .LC_str_27_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_सूचकांक_सेट:
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
  .globl पाठ_तुल्य_तेज़
  .def पाठ_तुल्य_तेज़; .scl 2; .type 32; .endef
पाठ_तुल्य_तेज़:
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

.L_पाठ_तुल्य_तेज़__प्रवेश_0:
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य_तेज़__if_अंत_2
  jmp .L_पाठ_तुल्य_तेज़__if_सत्य_1
.L_पाठ_तुल्य_तेज़__if_अंत_2:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य_तेज़__sc_दायाँ_3
  jmp .L_पाठ_तुल्य_तेज़__sc_लघु_4
.L_पाठ_तुल्य_तेज़__sc_दायाँ_3:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_पाठ_तुल्य_तेज़__sc_अंत_5
.L_पाठ_तुल्य_तेज़__sc_लघु_4:
  movq $1, %rdi
  jmp .L_पाठ_तुल्य_तेज़__sc_अंत_5
.L_पाठ_तुल्य_तेज़__sc_अंत_5:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य_तेज़__if_अंत_7
  jmp .L_पाठ_तुल्य_तेज़__if_सत्य_6
.L_पाठ_तुल्य_तेज़__if_अंत_7:
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
  je .L_पाठ_तुल्य_तेज़__if_अंत_9
  jmp .L_पाठ_तुल्य_तेज़__if_सत्य_8
.L_पाठ_तुल्य_तेज़__if_अंत_9:
  movq $0, %rdi
  jmp .L_पाठ_तुल्य_तेज़__wh_शर्त_10
.L_पाठ_तुल्य_तेज़__wh_शर्त_10:
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_तुल्य_तेज़__wh_अंत_12
  jmp .L_पाठ_तुल्य_तेज़__wh_देह_11
.L_पाठ_तुल्य_तेज़__wh_अंत_12:
  movq $1, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_तुल्य_तेज़
.L_पाठ_तुल्य_तेज़__wh_देह_11:
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
  je .L_पाठ_तुल्य_तेज़__if_अंत_14
  jmp .L_पाठ_तुल्य_तेज़__if_सत्य_13
.L_पाठ_तुल्य_तेज़__if_अंत_14:
  movq $1, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %rdi
  jmp .L_पाठ_तुल्य_तेज़__wh_शर्त_10
.L_पाठ_तुल्य_तेज़__if_सत्य_13:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य_तेज़
.L_पाठ_तुल्य_तेज़__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य_तेज़
.L_पाठ_तुल्य_तेज़__if_सत्य_6:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य_तेज़
.L_पाठ_तुल्य_तेज़__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_तुल्य_तेज़
.L_epilogue_पाठ_तुल्य_तेज़:
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
  .globl पाठ_लंबाई_तेज़
  .def पाठ_लंबाई_तेज़; .scl 2; .type 32; .endef
पाठ_लंबाई_तेज़:
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

.L_पाठ_लंबाई_तेज़__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__if_अंत_2
  jmp .L_पाठ_लंबाई_तेज़__if_सत्य_1
.L_पाठ_लंबाई_तेज़__if_अंत_2:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq $0, %r12
  jmp .L_पाठ_लंबाई_तेज़__wh_शर्त_3
.L_पाठ_लंबाई_तेज़__wh_शर्त_3:
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__wh_अंत_5
  jmp .L_पाठ_लंबाई_तेज़__wh_देह_4
.L_पाठ_लंबाई_तेज़__wh_अंत_5:
  movq %r12, %rax
  jmp .L_epilogue_पाठ_लंबाई_तेज़
.L_पाठ_लंबाई_तेज़__wh_देह_4:
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
  je .L_पाठ_लंबाई_तेज़__if_असत्य_8
  jmp .L_पाठ_लंबाई_तेज़__if_सत्य_6
.L_पाठ_लंबाई_तेज़__if_असत्य_8:
  movq $192, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__sc_लघु_10
  jmp .L_पाठ_लंबाई_तेज़__sc_दायाँ_9
.L_पाठ_लंबाई_तेज़__sc_लघु_10:
  movq $0, %r14
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_11
.L_पाठ_लंबाई_तेज़__sc_दायाँ_9:
  movq $224, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r14
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_11
.L_पाठ_लंबाई_तेज़__sc_अंत_11:
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__if_असत्य_14
  jmp .L_पाठ_लंबाई_तेज़__if_सत्य_12
.L_पाठ_लंबाई_तेज़__if_असत्य_14:
  movq $224, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__sc_लघु_16
  jmp .L_पाठ_लंबाई_तेज़__sc_दायाँ_15
.L_पाठ_लंबाई_तेज़__sc_लघु_16:
  movq $0, %r14
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_17
.L_पाठ_लंबाई_तेज़__sc_दायाँ_15:
  movq $240, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r14
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_17
.L_पाठ_लंबाई_तेज़__sc_अंत_17:
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__if_असत्य_20
  jmp .L_पाठ_लंबाई_तेज़__if_सत्य_18
.L_पाठ_लंबाई_तेज़__if_असत्य_20:
  movq $240, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__sc_लघु_22
  jmp .L_पाठ_लंबाई_तेज़__sc_दायाँ_21
.L_पाठ_लंबाई_तेज़__sc_लघु_22:
  movq $0, %r14
  movq %r14, %r13
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_23
.L_पाठ_लंबाई_तेज़__sc_दायाँ_21:
  movq $248, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r13
  jmp .L_पाठ_लंबाई_तेज़__sc_अंत_23
.L_पाठ_लंबाई_तेज़__sc_अंत_23:
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_लंबाई_तेज़__if_असत्य_26
  jmp .L_पाठ_लंबाई_तेज़__if_सत्य_24
.L_पाठ_लंबाई_तेज़__if_असत्य_26:
  movq $1, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_25
.L_पाठ_लंबाई_तेज़__if_सत्य_24:
  movq $4, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_25
.L_पाठ_लंबाई_तेज़__if_अंत_25:
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_19
.L_पाठ_लंबाई_तेज़__if_सत्य_18:
  movq $3, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_19
.L_पाठ_लंबाई_तेज़__if_अंत_19:
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_13
.L_पाठ_लंबाई_तेज़__if_सत्य_12:
  movq $2, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_13
.L_पाठ_लंबाई_तेज़__if_अंत_13:
  movq %r13, %rsi
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_7
.L_पाठ_लंबाई_तेज़__if_सत्य_6:
  movq $1, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %rsi
  jmp .L_पाठ_लंबाई_तेज़__if_अंत_7
.L_पाठ_लंबाई_तेज़__if_अंत_7:
  movq $1, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r12
  jmp .L_पाठ_लंबाई_तेज़__wh_शर्त_3
.L_पाठ_लंबाई_तेज़__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_लंबाई_तेज़
.L_epilogue_पाठ_लंबाई_तेज़:
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
  .globl सूची_लंबाई_तेज़
  .def सूची_लंबाई_तेज़; .scl 2; .type 32; .endef
सूची_लंबाई_तेज़:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सूची_लंबाई_तेज़__प्रवेश_0:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_लंबाई_तेज़
.L_epilogue_सूची_लंबाई_तेज़:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_तत्व_तेज़
  .def सूची_तत्व_तेज़; .scl 2; .type 32; .endef
सूची_तत्व_तेज़:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सूची_तत्व_तेज़__प्रवेश_0:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूची_तत्व_तेज़__sc_दायाँ_1
  jmp .L_सूची_तत्व_तेज़__sc_लघु_2
.L_सूची_तत्व_तेज़__sc_दायाँ_1:
  movq %rsi, %r10
  cmpq %r12, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %rdi
  jmp .L_सूची_तत्व_तेज़__sc_अंत_3
.L_सूची_तत्व_तेज़__sc_लघु_2:
  movq $1, %rdi
  jmp .L_सूची_तत्व_तेज़__sc_अंत_3
.L_सूची_तत्व_तेज़__sc_अंत_3:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूची_तत्व_तेज़__if_अंत_5
  jmp .L_सूची_तत्व_तेज़__if_सत्य_4
.L_सूची_तत्व_तेज़__if_अंत_5:
  movq $16, %rdi
  movq $8, %r12
  movq %rsi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_तत्व_तेज़
.L_सूची_तत्व_तेज़__if_सत्य_4:
  leaq .LC_str_28(%rip), %rcx
  movq .LC_str_28_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_तत्व_तेज़:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_तत्व_सेट_तेज़
  .def सूची_तत्व_सेट_तेज़; .scl 2; .type 32; .endef
सूची_तत्व_सेट_तेज़:
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
  movq %r8, %rdi

.L_सूची_तत्व_सेट_तेज़__प्रवेश_0:
  movq $8, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूची_तत्व_सेट_तेज़__sc_दायाँ_1
  jmp .L_सूची_तत्व_सेट_तेज़__sc_लघु_2
.L_सूची_तत्व_सेट_तेज़__sc_दायाँ_1:
  movq %rsi, %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r12
  jmp .L_सूची_तत्व_सेट_तेज़__sc_अंत_3
.L_सूची_तत्व_सेट_तेज़__sc_लघु_2:
  movq $1, %r12
  jmp .L_सूची_तत्व_सेट_तेज़__sc_अंत_3
.L_सूची_तत्व_सेट_तेज़__sc_अंत_3:
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूची_तत्व_सेट_तेज़__if_अंत_5
  jmp .L_सूची_तत्व_सेट_तेज़__if_सत्य_4
.L_सूची_तत्व_सेट_तेज़__if_अंत_5:
  movq $16, %r12
  movq $8, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूची_तत्व_सेट_तेज़
.L_सूची_तत्व_सेट_तेज़__if_सत्य_4:
  leaq .LC_str_28(%rip), %rcx
  movq .LC_str_28_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सूची_तत्व_सेट_तेज़:
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
  .globl सूची_तत्व_अनि
  .def सूची_तत्व_अनि; .scl 2; .type 32; .endef
सूची_तत्व_अनि:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सूची_तत्व_अनि__प्रवेश_0:
  movq $16, %rdi
  movq $8, %r12
  movq %rsi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूची_तत्व_अनि
.L_epilogue_सूची_तत्व_अनि:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूची_तत्व_सेट_अनि
  .def सूची_तत्व_सेट_अनि; .scl 2; .type 32; .endef
सूची_तत्व_सेट_अनि:
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
  movq %r8, %rdi

.L_सूची_तत्व_सेट_अनि__प्रवेश_0:
  movq $16, %r12
  movq $8, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %r12, %r10
  addq %r14, %r10
  movq %r10, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूची_तत्व_सेट_अनि
.L_epilogue_सूची_तत्व_सेट_अनि:
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
  .globl सीमा_दावा_ऊपर
  .def सीमा_दावा_ऊपर; .scl 2; .type 32; .endef
सीमा_दावा_ऊपर:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_सीमा_दावा_ऊपर__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सीमा_दावा_ऊपर__if_अंत_2
  jmp .L_सीमा_दावा_ऊपर__if_सत्य_1
.L_सीमा_दावा_ऊपर__if_अंत_2:
  movq $8, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_सीमा_दावा_ऊपर__if_अंत_4
  jmp .L_सीमा_दावा_ऊपर__if_सत्य_3
.L_सीमा_दावा_ऊपर__if_अंत_4:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सीमा_दावा_ऊपर
.L_सीमा_दावा_ऊपर__if_सत्य_3:
  leaq .LC_str_28(%rip), %rcx
  movq .LC_str_28_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_सीमा_दावा_ऊपर__if_सत्य_1:
  leaq .LC_str_27(%rip), %rcx
  movq .LC_str_27_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_सीमा_दावा_ऊपर:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl विदेशी_पता
  .def विदेशी_पता; .scl 2; .type 32; .endef
विदेशी_पता:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_विदेशी_पता__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_विदेशी_पता__if_अंत_2
  jmp .L_विदेशी_पता__if_सत्य_1
.L_विदेशी_पता__if_अंत_2:
  movq $16, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_विदेशी_पता
.L_विदेशी_पता__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_विदेशी_पता
.L_epilogue_विदेशी_पता:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl विदेशी_से_पाठ
  .def विदेशी_से_पाठ; .scl 2; .type 32; .endef
विदेशी_से_पाठ:
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

.L_विदेशी_से_पाठ__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_विदेशी_से_पाठ__if_अंत_2
  jmp .L_विदेशी_से_पाठ__if_सत्य_1
.L_विदेशी_से_पाठ__if_अंत_2:
  movq $0, %rsi
  jmp .L_विदेशी_से_पाठ__wh_शर्त_3
.L_विदेशी_से_पाठ__wh_शर्त_3:
  movq %rbx, %r10
  movq %rsi, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_विदेशी_से_पाठ__wh_अंत_5
  jmp .L_विदेशी_से_पाठ__wh_देह_4
.L_विदेशी_से_पाठ__wh_अंत_5:
  movq %rsi, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -72(%rbp)
  movq $16, %r12
  movq $0, %r13
  subq $8, %rsp
  movq %rsi, %r11
  pushq %r11
  movq %rdi, %rcx
  movq %r12, %rdx
  movq %rbx, %r8
  movq %r13, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  movq %rdi, %rax
  jmp .L_epilogue_विदेशी_से_पाठ
.L_विदेशी_से_पाठ__wh_देह_4:
  movq $1, %rdi
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $1048576, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_विदेशी_से_पाठ__if_अंत_7
  jmp .L_विदेशी_से_पाठ__if_सत्य_6
.L_विदेशी_से_पाठ__if_अंत_7:
  movq %r12, %rsi
  jmp .L_विदेशी_से_पाठ__wh_शर्त_3
.L_विदेशी_से_पाठ__if_सत्य_6:
  leaq .LC_str_29(%rip), %rcx
  movq .LC_str_29_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_विदेशी_से_पाठ__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_विदेशी_से_पाठ
.L_epilogue_विदेशी_से_पाठ:
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
  .globl वस्तु_रचना
  .def वस्तु_रचना; .scl 2; .type 32; .endef
वस्तु_रचना:
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

.L_वस्तु_रचना__प्रवेश_0:
  movq $16, %rsi
  movq $8, %rdi
  movq %rbx, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %rdi
  movq $3, %rsi
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
  jmp .L_epilogue_वस्तु_रचना
.L_epilogue_वस्तु_रचना:
  subl $1, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_दश_दायाँ
  .def पाठ_दश_दायाँ; .scl 2; .type 32; .endef
पाठ_दश_दायाँ:
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

.L_पाठ_दश_दायाँ__प्रवेश_0:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rdi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rdi
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call दशमलव_प्रारूप
  addq $32, %rsp
  movq %rax, %r12
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rsi
  movq %r12, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq $16, %r13
  movq $16, %r14
  movq %rsi, %r10
  subq %r14, %r10
  movq %r10, %r15
  movq $16, %rsi
  subq $8, %rsp
  movq %r12, %r11
  pushq %r11
  movq %rdi, %rcx
  movq %r13, %rdx
  movq %r15, %r8
  movq %rsi, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, -80(%rbp)
  movq %rsi, %rax
  jmp .L_epilogue_पाठ_दश_दायाँ
.L_epilogue_पाठ_दश_दायाँ:
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
  .globl पाठ_दश_बायाँ
  .def पाठ_दश_बायाँ; .scl 2; .type 32; .endef
पाठ_दश_बायाँ:
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

.L_पाठ_दश_बायाँ__प्रवेश_0:
  subq $32, %rsp
  call सञ्चिका_कोष_तैयार
  addq $32, %rsp
  movq %rax, %rdi
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rdi
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call दशमलव_प्रारूप
  addq $32, %rsp
  movq %rax, %r12
  movq sutra_glob_दशमलव_बफ(%rip), %r10
  movq %r10, %rbx
  movq %r12, %rcx
  subq $32, %rsp
  call पाठ_आवंटित
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -80(%rbp)
  movq $16, %r13
  movq $16, %r14
  movq %rbx, %r10
  subq %r14, %r10
  movq %r10, %r15
  movq $16, %rbx
  subq $8, %rsp
  movq %r12, %r11
  pushq %r11
  movq %rdi, %rcx
  movq %r13, %rdx
  movq %r15, %r8
  movq %rbx, %r9
  subq $32, %rsp
  call खंड_प्रतिलिपि
  addq $48, %rsp
  movq %rax, %r14
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rbx
  movq %rdi, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, -80(%rbp)
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_दश_बायाँ
.L_epilogue_पाठ_दश_बायाँ:
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
  .globl पाठ_योग_गतिक
  .def पाठ_योग_गतिक; .scl 2; .type 32; .endef
पाठ_योग_गतिक:
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

.L_पाठ_योग_गतिक__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rsi, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %r12
  movq $1, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_पाठ_योग_गतिक__sc_दायाँ_1
  jmp .L_पाठ_योग_गतिक__sc_लघु_2
.L_पाठ_योग_गतिक__sc_दायाँ_1:
  movq $1, %r13
  movq %r12, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_पाठ_योग_गतिक__sc_अंत_3
.L_पाठ_योग_गतिक__sc_लघु_2:
  movq $1, %r13
  jmp .L_पाठ_योग_गतिक__sc_अंत_3
.L_पाठ_योग_गतिक__sc_अंत_3:
  movq %r13, %r10
  cmpq $0, %r10
  je .L_पाठ_योग_गतिक__if_अंत_5
  jmp .L_पाठ_योग_गतिक__if_सत्य_4
.L_पाठ_योग_गतिक__if_अंत_5:
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %r13, %rax
  jmp .L_epilogue_पाठ_योग_गतिक
.L_पाठ_योग_गतिक__if_सत्य_4:
  movq $0, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_योग_गतिक_0
  jmp .L_पाठ_योग_गतिक__if_सत्य_6
.L_किनारा_पाठ_योग_गतिक_0:
  jmp .L_पाठ_योग_गतिक__if_अंत_7
.L_पाठ_योग_गतिक__if_सत्य_6:
  movq %rbx, %rcx
  subq $32, %rsp
  call संख्या_से_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rbx
  jmp .L_पाठ_योग_गतिक__if_अंत_7
.L_पाठ_योग_गतिक__if_अंत_7:
  movq $0, %rdi
  movq %r12, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_पाठ_योग_गतिक_1
  jmp .L_पाठ_योग_गतिक__if_सत्य_8
.L_किनारा_पाठ_योग_गतिक_1:
  jmp .L_पाठ_योग_गतिक__if_अंत_9
.L_पाठ_योग_गतिक__if_सत्य_8:
  movq %rsi, %rcx
  subq $32, %rsp
  call संख्या_से_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rsi
  jmp .L_पाठ_योग_गतिक__if_अंत_9
.L_पाठ_योग_गतिक__if_अंत_9:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_योग_गतिक
.L_epilogue_पाठ_योग_गतिक:
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
  .globl पाठ_खोज_गतिक
  .def पाठ_खोज_गतिक; .scl 2; .type 32; .endef
पाठ_खोज_गतिक:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_पाठ_खोज_गतिक__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_खोज_गतिक__if_अंत_2
  jmp .L_पाठ_खोज_गतिक__if_सत्य_1
.L_पाठ_खोज_गतिक__if_अंत_2:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_पाठ_खोज_गतिक__if_अंत_4
  jmp .L_पाठ_खोज_गतिक__if_सत्य_3
.L_पाठ_खोज_गतिक__if_अंत_4:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call सूची_खोज
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_खोज_गतिक
.L_पाठ_खोज_गतिक__if_सत्य_3:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_पाठ_खोज_गतिक__if_अंत_6
  jmp .L_पाठ_खोज_गतिक__if_सत्य_5
.L_पाठ_खोज_गतिक__if_अंत_6:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_कोडबिंदु_खोज
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_खोज_गतिक
.L_पाठ_खोज_गतिक__if_सत्य_5:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_खोज_गतिक
.L_पाठ_खोज_गतिक__if_सत्य_1:
  movq $-1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_पाठ_खोज_गतिक
.L_epilogue_पाठ_खोज_गतिक:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl शब्दकोश_कुंजियाँ_रन
  .def शब्दकोश_कुंजियाँ_रन; .scl 2; .type 32; .endef
शब्दकोश_कुंजियाँ_रन:
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

.L_शब्दकोश_कुंजियाँ_रन__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_कुंजियाँ_रन__if_अंत_2
  jmp .L_शब्दकोश_कुंजियाँ_रन__if_सत्य_1
.L_शब्दकोश_कुंजियाँ_रन__if_अंत_2:
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq $8, %rsi
  movq %rdi, %r10
  imulq %rsi, %r10
  movq %r10, %r13
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %rsi
  movq $2, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, -88(%rbp)
  movq $0, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rsi
  movq $8, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rsi
  movq $0, %rbx
  jmp .L_शब्दकोश_कुंजियाँ_रन__wh_शर्त_3
.L_शब्दकोश_कुंजियाँ_रन__wh_शर्त_3:
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_शब्दकोश_कुंजियाँ_रन__wh_अंत_5
  jmp .L_शब्दकोश_कुंजियाँ_रन__wh_देह_4
.L_शब्दकोश_कुंजियाँ_रन__wh_अंत_5:
  subq $32, %rsp
  call सूत्र_जीसी_छोड़ो
  addq $32, %rsp
  movq %rax, %rsi
  movq %r13, %rax
  jmp .L_epilogue_शब्दकोश_कुंजियाँ_रन
.L_शब्दकोश_कुंजियाँ_रन__wh_देह_4:
  movq $16, %rsi
  movq $8, %r14
  movq %rbx, %r10
  imulq %r14, %r10
  movq %r10, %r15
  movq %rsi, %r10
  addq %r15, %r10
  movq %r10, %r14
  movq $16, %rsi
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %r13, %r10
  movq %r14, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r15
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %r14, %rbx
  jmp .L_शब्दकोश_कुंजियाँ_रन__wh_शर्त_3
.L_शब्दकोश_कुंजियाँ_रन__if_सत्य_1:
  movq $0, %rbx
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
  movq %r12, -80(%rbp)
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
  jmp .L_epilogue_शब्दकोश_कुंजियाँ_रन
.L_epilogue_शब्दकोश_कुंजियाँ_रन:
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
  .globl पाठ_बड़ा
  .def पाठ_बड़ा; .scl 2; .type 32; .endef
पाठ_बड़ा:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_पाठ_बड़ा__प्रवेश_0:
  movq $1, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_अक्षर_रूप
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_बड़ा
.L_epilogue_पाठ_बड़ा:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl पाठ_छोटा
  .def पाठ_छोटा; .scl 2; .type 32; .endef
पाठ_छोटा:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_पाठ_छोटा__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_अक्षर_रूप
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_पाठ_छोटा
.L_epilogue_पाठ_छोटा:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl भाजन_शून्य_फेंको
  .def भाजन_शून्य_फेंको; .scl 2; .type 32; .endef
भाजन_शून्य_फेंको:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_भाजन_शून्य_फेंको__प्रवेश_0:
  leaq .LC_str_30(%rip), %rcx
  movq .LC_str_30_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call फेंको
  addq $32, %rsp
.L_epilogue_भाजन_शून्य_फेंको:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निकास_उपसर्ग
  .def निकास_उपसर्ग; .scl 2; .type 32; .endef
निकास_उपसर्ग:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_निकास_उपसर्ग__प्रवेश_0:
  leaq .LC_str_31(%rip), %rcx
  movq .LC_str_31_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_निकास_उपसर्ग
.L_epilogue_निकास_उपसर्ग:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निकास_अनियंत्रित
  .def निकास_अनियंत्रित; .scl 2; .type 32; .endef
निकास_अनियंत्रित:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_निकास_अनियंत्रित__प्रवेश_0:
  leaq .LC_str_32(%rip), %rcx
  movq .LC_str_32_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_निकास_अनियंत्रित
.L_epilogue_निकास_अनियंत्रित:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl निकास_न्यूलाइन
  .def निकास_न्यूलाइन; .scl 2; .type 32; .endef
निकास_न्यूलाइन:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_निकास_न्यूलाइन__प्रवेश_0:
  leaq .LC_str_33(%rip), %rcx
  movq .LC_str_33_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_निकास_न्यूलाइन
.L_epilogue_निकास_न्यूलाइन:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_अपवाद_निकास
  .def सूत्र_अपवाद_निकास; .scl 2; .type 32; .endef
सूत्र_अपवाद_निकास:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -56(%rbp), %r11
  movl $5, %ecx
.Lजड़_सूत्र_अपवाद_निकास:
  movq $0, (%r11)
  movq %r11, (%r10,%rax,8)
  incl %eax
  subq $8, %r11
  decl %ecx
  jnz .Lजड़_सूत्र_अपवाद_निकास
  movl %eax, gc_roots_count(%rip)

.L_सूत्र_अपवाद_निकास__प्रवेश_0:
  subq $32, %rsp
  call सूत्र_जीसी_दबाओ
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_अपवाद_निकास__if_असत्य_3
  jmp .L_सूत्र_अपवाद_निकास__if_सत्य_1
.L_सूत्र_अपवाद_निकास__if_असत्य_3:
  movq %rbx, %rcx
  subq $32, %rsp
  call रन_क्या_पाठ
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सूत्र_अपवाद_निकास__if_असत्य_6
  jmp .L_सूत्र_अपवाद_निकास__if_सत्य_4
.L_सूत्र_अपवाद_निकास__if_असत्य_6:
  leaq .LC_str_31(%rip), %rcx
  movq .LC_str_31_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -88(%rbp)
  movq %rbx, %rcx
  subq $32, %rsp
  call संख्या_से_पाठ
  addq $32, %rsp
  movq %rax, %rdi
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %r12
  movq $0, -88(%rbp)
  movq %r12, %rbx
  jmp .L_सूत्र_अपवाद_निकास__if_अंत_5
.L_सूत्र_अपवाद_निकास__if_सत्य_4:
  leaq .LC_str_31(%rip), %rcx
  movq .LC_str_31_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -80(%rbp)
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -80(%rbp)
  movq %rdi, %rbx
  jmp .L_सूत्र_अपवाद_निकास__if_अंत_5
.L_सूत्र_अपवाद_निकास__if_अंत_5:
  jmp .L_सूत्र_अपवाद_निकास__if_अंत_2
.L_सूत्र_अपवाद_निकास__if_सत्य_1:
  leaq .LC_str_32(%rip), %rcx
  movq .LC_str_32_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rbx
  jmp .L_सूत्र_अपवाद_निकास__if_अंत_2
.L_सूत्र_अपवाद_निकास__if_अंत_2:
  movq %rbx, -64(%rbp)
  leaq .LC_str_33(%rip), %rcx
  movq .LC_str_33_len(%rip), %rdx
  subq $32, %rsp
  call पाठ_रचना
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call पाठ_जोड़
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -56(%rbp)
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movq $16, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $8, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, -56(%rbp)
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call सूत्र_तल_त्रुटि
  addq $32, %rsp
  movq %rax, %rbx
  movq $1, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_निकास
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_अपवाद_निकास
.L_epilogue_सूत्र_अपवाद_निकास:
  subl $5, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl जीसी_अंक_बफ
  .def जीसी_अंक_बफ; .scl 2; .type 32; .endef
जीसी_अंक_बफ:
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
  movq %rdx, -88(%rbp)

.L_जीसी_अंक_बफ__प्रवेश_0:
  movq $0, %rdi
  movq -88(%rbp), %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_जीसी_अंक_बफ__if_अंत_2
  jmp .L_जीसी_अंक_बफ__if_सत्य_1
.L_जीसी_अंक_बफ__if_अंत_2:
  movq $0, %rdi
  movq -88(%rbp), %r11
  movq %r11, -104(%rbp)
  movq %rdi, -120(%rbp)
  jmp .L_जीसी_अंक_बफ__wh_शर्त_3
.L_जीसी_अंक_बफ__wh_शर्त_3:
  movq $0, %r13
  movq -104(%rbp), %r10
  cmpq %r13, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_जीसी_अंक_बफ__wh_अंत_5
  jmp .L_जीसी_अंक_बफ__wh_देह_4
.L_जीसी_अंक_बफ__wh_अंत_5:
  movq -120(%rbp), %r14
  movq -88(%rbp), %r13
  jmp .L_जीसी_अंक_बफ__wh_शर्त_6
.L_जीसी_अंक_बफ__wh_शर्त_6:
  movq $0, %r15
  movq %r14, %r10
  cmpq %r15, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_जीसी_अंक_बफ__wh_अंत_8
  jmp .L_जीसी_अंक_बफ__wh_देह_7
.L_जीसी_अंक_बफ__wh_अंत_8:
  movq -72(%rbp), %r10
  addq -120(%rbp), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_अंक_बफ
.L_जीसी_अंक_बफ__wh_देह_7:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq -72(%rbp), %r10
  addq %r14, %r10
  movq %r10, %r15
  movq $1, %rsi
  movq %r15, %r10
  subq %rsi, %r10
  movq %r10, %r12
  movq $48, %rsi
  movq $10, %r15
  movq %r13, %rax
  movq %r15, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r15
  movq %rbx, %r10
  movq %r12, %r11
  movq %r15, %r8
  movb %r8b, (%r10,%r11)
  movq %r15, %rsi
  movq $10, %rbx
  movq %r13, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rsi
  movq $1, %rbx
  movq %r14, %r10
  subq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %r14
  movq %rsi, %r13
  jmp .L_जीसी_अंक_बफ__wh_शर्त_6
.L_जीसी_अंक_बफ__wh_देह_4:
  movq $1, %rbx
  movq -120(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $10, %rbx
  movq -104(%rbp), %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq %rdi, -104(%rbp)
  movq %rsi, -120(%rbp)
  jmp .L_जीसी_अंक_बफ__wh_शर्त_3
.L_जीसी_अंक_बफ__if_सत्य_1:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $48, %rsi
  movq %rbx, %r10
  movq -72(%rbp), %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %rdi
  movq $1, %rbx
  movq -72(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_जीसी_अंक_बफ
.L_epilogue_जीसी_अंक_बफ:
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
  .globl जीसी_ल_चक्र
  .def जीसी_ल_चक्र; .scl 2; .type 32; .endef
जीसी_ल_चक्र:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)

.L_जीसी_ल_चक्र__प्रवेश_0:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $2, %rsi
  movq $154, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $3, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $5, %rsi
  movq $149, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $6, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $7, %rsi
  movq $165, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $8, %rsi
  movq $141, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $9, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $11, %rsi
  movq $176, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $12, %rsi
  movq $58, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $13, %rsi
  movq $32, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $14, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_ल_चक्र
.L_epilogue_जीसी_ल_चक्र:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl जीसी_ल_सक्रिय
  .def जीसी_ल_सक्रिय; .scl 2; .type 32; .endef
जीसी_ल_सक्रिय:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)

.L_जीसी_ल_सक्रिय__प्रवेश_0:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $2, %rsi
  movq $184, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $3, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $5, %rsi
  movq $149, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $6, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $7, %rsi
  movq $165, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $8, %rsi
  movq $141, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $9, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $11, %rsi
  movq $176, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $12, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $13, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $14, %rsi
  movq $191, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $15, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $16, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $17, %rsi
  movq $175, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $18, %rsi
  movq $58, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $19, %rsi
  movq $32, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $20, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_ल_सक्रिय
.L_epilogue_जीसी_ल_सक्रिय:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl जीसी_ल_संग्रहित
  .def जीसी_ल_संग्रहित; .scl 2; .type 32; .endef
जीसी_ल_संग्रहित:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)

.L_जीसी_ल_संग्रहित__प्रवेश_0:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $2, %rsi
  movq $184, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $3, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $4, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $5, %rsi
  movq $130, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $6, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $7, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $8, %rsi
  movq $151, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $9, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq $165, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $11, %rsi
  movq $141, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $12, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $13, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $14, %rsi
  movq $176, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $15, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $16, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $17, %rsi
  movq $185, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $18, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $19, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $20, %rsi
  movq $191, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $21, %rsi
  movq $224, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $22, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $23, %rsi
  movq $164, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $24, %rsi
  movq $58, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $25, %rsi
  movq $32, %rdi
  movq %rbx, %r10
  movq %rsi, %r11
  movq %rdi, %r8
  movb %r8b, (%r10,%r11)
  movq %rdi, %r12
  movq $26, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_ल_संग्रहित
.L_epilogue_जीसी_ल_संग्रहित:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl जीसी_पंक्ति_छापो
  .def जीसी_पंक्ति_छापो; .scl 2; .type 32; .endef
जीसी_पंक्ति_छापो:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_जीसी_पंक्ति_छापो__प्रवेश_0:
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call जीसी_अंक_बफ
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_पंक्ति_छापो
.L_epilogue_जीसी_पंक्ति_छापो:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl जीसी_स्थिति_रन
  .def जीसी_स्थिति_रन; .scl 2; .type 32; .endef
जीसी_स्थिति_रन:
  pushq %rbp
  movq %rsp, %rbp
  subq $96, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq $0, -64(%rbp)
  movq $0, -72(%rbp)
  movq $0, -80(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -64(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_जीसी_स्थिति_रन__प्रवेश_0:
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_जीसी_स्थिति_रन__if_अंत_2
  jmp .L_जीसी_स्थिति_रन__if_सत्य_1
.L_जीसी_स्थिति_रन__if_सत्य_1:
  movq $96, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_जीसी_बफ(%rip)
  jmp .L_जीसी_स्थिति_रन__if_अंत_2
.L_जीसी_स्थिति_रन__if_अंत_2:
  subq $32, %rsp
  call जीसी_ल_चक्र
  addq $32, %rsp
  movq %rax, %rbx
  subq $32, %rsp
  call सूत्र_गण_चक्र
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -64(%rbp)
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call जीसी_अंक_बफ
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -64(%rbp)
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  subq $32, %rsp
  call जीसी_ल_सक्रिय
  addq $32, %rsp
  movq %rax, %rbx
  subq $32, %rsp
  call सूत्र_गण_सक्रिय
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -72(%rbp)
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call जीसी_अंक_बफ
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -72(%rbp)
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  subq $32, %rsp
  call जीसी_ल_संग्रहित
  addq $32, %rsp
  movq %rax, %rbx
  subq $32, %rsp
  call सूत्र_गण_संग्रहित
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -80(%rbp)
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call जीसी_अंक_बफ
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -80(%rbp)
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $10, %rsi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movb %r8b, (%r10,%r11)
  movq %rsi, %r12
  movq sutra_glob_जीसी_बफ(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %rbx, %rcx
  addq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call सूत्र_तल_मुद्रण
  addq $32, %rsp
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_जीसी_स्थिति_रन
.L_epilogue_जीसी_स्थिति_रन:
  subl $3, gc_roots_count(%rip)
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl दशमलव_बिट
  .def दशमलव_बिट; .scl 2; .type 32; .endef
दशमलव_बिट:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)
  movq %rcx, %rbx

.L_दशमलव_बिट__प्रवेश_0:
  movq %rbx, %rax
  jmp .L_epilogue_दशमलव_बिट
.L_epilogue_दशमलव_बिट:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl बिट_दशमलव
  .def बिट_दशमलव; .scl 2; .type 32; .endef
बिट_दशमलव:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)
  movq %rcx, %rbx

.L_बिट_दशमलव__प्रवेश_0:
  movq %rbx, %rax
  jmp .L_epilogue_बिट_दशमलव
.L_epilogue_बिट_दशमलव:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl दो_बावन
  .def दो_बावन; .scl 2; .type 32; .endef
दो_बावन:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)

.L_दो_बावन__प्रवेश_0:
  movq sutra_glob_घा_बावन(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_दो_बावन__if_अंत_2
  jmp .L_दो_बावन__if_सत्य_1
.L_दो_बावन__if_सत्य_1:
  movq $1, %rbx
  movq $0, %rsi
  jmp .L_दो_बावन__wh_शर्त_3
.L_दो_बावन__wh_शर्त_3:
  movq $52, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_दो_बावन__wh_अंत_5
  jmp .L_दो_बावन__wh_देह_4
.L_दो_बावन__wh_अंत_5:
  movq %rbx, %r10
  movq %r10, sutra_glob_घा_बावन(%rip)
  jmp .L_दो_बावन__if_अंत_2
.L_दो_बावन__if_अंत_2:
  movq sutra_glob_घा_बावन(%rip), %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_दो_बावन
.L_दो_बावन__wh_देह_4:
  movq $2, %rdi
  movq %rbx, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq $1, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  movq %r12, %rbx
  jmp .L_दो_बावन__wh_शर्त_3
.L_epilogue_दो_बावन:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl लघुगणक_रन
  .def लघुगणक_रन; .scl 2; .type 32; .endef
लघुगणक_रन:
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

.L_लघुगणक_रन__प्रवेश_0:
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_le
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_लघुगणक_रन__if_अंत_2
  jmp .L_लघुगणक_रन__if_सत्य_1
.L_लघुगणक_रन__if_अंत_2:
  subq $32, %rsp
  call दो_बावन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rbx, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $2048, %r12
  movq %rdi, %rax
  movq %r12, %r10
  cqto
  idivq %r10
  movq %rdx, %r13
  movq $1023, %rdi
  movq %r13, %r10
  subq %rdi, %r10
  movq %r10, %r12
  movq %rbx, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq $1023, %rbx
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r13
  movq %rdi, %r10
  addq %r13, %r10
  movq %r10, %rbx
  movq .LC_dbl_2(%rip), %r10
  movq %r10, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_gt
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_लघुगणक_रन_0
  jmp .L_लघुगणक_रन__if_सत्य_3
.L_किनारा_लघुगणक_रन_0:
  movq %rbx, %rsi
  movq %r12, -88(%rbp)
  jmp .L_लघुगणक_रन__if_अंत_4
.L_लघुगणक_रन__if_सत्य_3:
  movq .LC_dbl_3(%rip), %r10
  movq %r10, %rsi
  movq %rbx, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %rdi
  movq $1, %rbx
  movq %r12, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, -88(%rbp)
  movq %rdi, %rsi
  jmp .L_लघुगणक_रन__if_अंत_4
.L_लघुगणक_रन__if_अंत_4:
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %rdi
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call sutra_float_sub
  addq $32, %rsp
  movq %rax, %r12
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %rdi
  movq %rsi, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call sutra_float_add
  addq $32, %rsp
  movq %rax, %r13
  movq %r12, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call sutra_float_div
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, -72(%rbp)
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r12
  movq $1, %r13
  jmp .L_लघुगणक_रन__wh_शर्त_5
.L_लघुगणक_रन__wh_शर्त_5:
  movq $40, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_लघुगणक_रन__wh_अंत_7
  jmp .L_लघुगणक_रन__wh_देह_6
.L_लघुगणक_रन__wh_अंत_7:
  movq .LC_dbl_5(%rip), %r10
  movq %r10, %r14
  movq %r14, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r15
  movq .LC_dbl_6(%rip), %r10
  movq %r10, %r14
  movq -88(%rbp), %rcx
  subq $32, %rsp
  call sutra_int_to_float
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %rbx
  movq %r15, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call sutra_float_add
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_लघुगणक_रन
.L_लघुगणक_रन__wh_देह_6:
  movq %r13, %rcx
  subq $32, %rsp
  call sutra_int_to_float
  addq $32, %rsp
  movq %rax, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call sutra_float_div
  addq $32, %rsp
  movq %rax, %rdi
  movq %r12, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call sutra_float_add
  addq $32, %rsp
  movq %rax, %rbx
  movq %rsi, %rcx
  movq -72(%rbp), %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %rdi
  movq $2, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %r12
  movq %r12, %r13
  movq %rbx, %r12
  movq %rdi, %rsi
  jmp .L_लघुगणक_रन__wh_शर्त_5
.L_लघुगणक_रन__if_सत्य_1:
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_लघुगणक_रन
.L_epilogue_लघुगणक_रन:
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
  .globl घातांकी_रन
  .def घातांकी_रन; .scl 2; .type 32; .endef
घातांकी_रन:
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

.L_घातांकी_रन__प्रवेश_0:
  subq $32, %rsp
  call दो_बावन
  addq $32, %rsp
  movq %rax, %rsi
  movq .LC_dbl_7(%rip), %r10
  movq %r10, %rdi
  movq %rbx, %rcx
  movq %rdi, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %rcx
  subq $32, %rsp
  call sutra_math_round_f
  addq $32, %rsp
  movq %rax, %rdi
  movq $1000, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_घातांकी_रन_0
  jmp .L_घातांकी_रन__if_सत्य_1
.L_किनारा_घातांकी_रन_0:
  jmp .L_घातांकी_रन__if_अंत_2
.L_घातांकी_रन__if_सत्य_1:
  movq $1000, %rdi
  jmp .L_घातांकी_रन__if_अंत_2
.L_घातांकी_रन__if_अंत_2:
  movq $-1000, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_घातांकी_रन_1
  jmp .L_घातांकी_रन__if_सत्य_3
.L_किनारा_घातांकी_रन_1:
  jmp .L_घातांकी_रन__if_अंत_4
.L_घातांकी_रन__if_सत्य_3:
  movq $-1000, %rdi
  jmp .L_घातांकी_रन__if_अंत_4
.L_घातांकी_रन__if_अंत_4:
  movq .LC_dbl_6(%rip), %r10
  movq %r10, %r12
  movq %rdi, %rcx
  subq $32, %rsp
  call sutra_int_to_float
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r14
  movq %rbx, %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call sutra_float_sub
  addq $32, %rsp
  movq %rax, -72(%rbp)
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %rbx
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %r13
  movq $1, %r14
  jmp .L_घातांकी_रन__wh_शर्त_5
.L_घातांकी_रन__wh_शर्त_5:
  movq $20, %r15
  movq %r14, %r10
  cmpq %r15, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_घातांकी_रन__wh_अंत_7
  jmp .L_घातांकी_रन__wh_देह_6
.L_घातांकी_रन__wh_अंत_7:
  movq $1023, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r15
  movq %r15, %r10
  imulq %rsi, %r10
  movq %r10, %r12
  movq %r13, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r15
  movq %r15, %rax
  jmp .L_epilogue_घातांकी_रन
.L_घातांकी_रन__wh_देह_6:
  movq %rbx, %rcx
  movq -72(%rbp), %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r12
  movq %r14, %rcx
  subq $32, %rsp
  call sutra_int_to_float
  addq $32, %rsp
  movq %rax, %rbx
  movq %r12, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call sutra_float_div
  addq $32, %rsp
  movq %rax, %r15
  movq %r13, %rcx
  movq %r15, %rdx
  subq $32, %rsp
  call sutra_float_add
  addq $32, %rsp
  movq %rax, %rbx
  movq $1, %r12
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %r14
  movq %rbx, %r13
  movq %r15, %rbx
  jmp .L_घातांकी_रन__wh_शर्त_5
.L_epilogue_घातांकी_रन:
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
  .globl रन_घात
  .def रन_घात; .scl 2; .type 32; .endef
रन_घात:
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

.L_रन_घात__प्रवेश_0:
  movq %rsi, %rcx
  subq $32, %rsp
  call sutra_math_round_f
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call sutra_int_to_float
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_eq
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_रन_घात__if_अंत_2
  jmp .L_रन_घात__if_सत्य_1
.L_रन_घात__if_सत्य_1:
  movq .LC_dbl_8(%rip), %r10
  movq %r10, %r12
  movq %r12, %r10
  btcq $63, %r10
  movq %r10, %r13
  movq %rsi, %rcx
  movq %r13, %rdx
  subq $32, %rsp
  call sutra_float_ge
  addq $32, %rsp
  movq %rax, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_रन_घात__if_अंत_2
  jmp .L_रन_घात__if_सत्य_3
.L_रन_घात__if_सत्य_3:
  movq .LC_dbl_8(%rip), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_le
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_रन_घात__if_अंत_2
  jmp .L_रन_घात__if_सत्य_5
.L_रन_घात__if_अंत_2:
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r12
  movq %rbx, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_gt
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_रन_घात__if_अंत_17
  jmp .L_रन_घात__if_सत्य_16
.L_रन_घात__if_अंत_17:
  movq .LC_dbl_0(%rip), %r10
  movq %r10, %r12
  movq %r12, %rax
  jmp .L_epilogue_रन_घात
.L_रन_घात__if_सत्य_16:
  movq %rbx, %rcx
  subq $32, %rsp
  call लघुगणक_रन
  addq $32, %rsp
  movq %rax, %r12
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call घातांकी_रन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_रन_घात
.L_रन_घात__if_सत्य_5:
  movq $0, %rsi
  movq $0, %r12
  movq %rdi, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_रन_घात_0
  jmp .L_रन_घात__if_सत्य_7
.L_किनारा_रन_घात_0:
  movq %rsi, %r11
  movq %rdi, %rsi
  movq %r11, %rdi
  jmp .L_रन_घात__if_अंत_8
.L_रन_घात__if_सत्य_7:
  movq $1, %rsi
  movq $0, %r12
  movq %r12, %r10
  subq %rdi, %r10
  movq %r10, %r13
  movq %rsi, %rdi
  movq %r13, %rsi
  jmp .L_रन_घात__if_अंत_8
.L_रन_घात__if_अंत_8:
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %r12
  movq %rbx, %r11
  movq %rsi, %rbx
  movq %r12, %rsi
  movq %r11, %r12
  jmp .L_रन_घात__wh_शर्त_9
.L_रन_घात__wh_शर्त_9:
  movq $0, %r13
  movq %rbx, %r10
  cmpq %r13, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_रन_घात__wh_अंत_11
  jmp .L_रन_घात__wh_देह_10
.L_रन_घात__wh_अंत_11:
  movq $1, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_रन_घात__if_अंत_15
  jmp .L_रन_घात__if_सत्य_14
.L_रन_घात__if_अंत_15:
  movq %rsi, %rax
  jmp .L_epilogue_रन_घात
.L_रन_घात__if_सत्य_14:
  movq .LC_dbl_4(%rip), %r10
  movq %r10, %r13
  movq %r13, %rcx
  movq %rsi, %rdx
  subq $32, %rsp
  call sutra_float_div
  addq $32, %rsp
  movq %rax, %r14
  movq %r14, %rax
  jmp .L_epilogue_रन_घात
.L_रन_घात__wh_देह_10:
  movq $2, %r13
  movq %rbx, %rax
  movq %r13, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq $1, %r13
  movq %r14, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_रन_घात_1
  jmp .L_रन_घात__if_सत्य_12
.L_किनारा_रन_घात_1:
  jmp .L_रन_घात__if_अंत_13
.L_रन_घात__if_सत्य_12:
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rsi
  jmp .L_रन_घात__if_अंत_13
.L_रन_घात__if_अंत_13:
  movq %r12, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call sutra_float_mul
  addq $32, %rsp
  movq %rax, %r13
  movq $2, %r12
  movq %rbx, %rax
  movq %r12, %r10
  cqto
  idivq %r10
  movq %rax, %r14
  movq %r13, %r12
  movq %r14, %rbx
  jmp .L_रन_घात__wh_शर्त_9
.L_epilogue_रन_घात:
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

  .data
  .globl sutra_glob_प्रयत्न_गहराई
sutra_glob_प्रयत्न_गहराई:
  .quad 0
  .globl sutra_glob_प्रयत्न_ढेर
sutra_glob_प्रयत्न_ढेर:
  .quad 0
  .globl sutra_glob_प्रयत्न_जड़_गण
sutra_glob_प्रयत्न_जड़_गण:
  .quad 0
  .globl sutra_glob_सक्रिय_अपवाद
sutra_glob_सक्रिय_अपवाद:
  .quad 0
  .globl sutra_glob_सञ्चिका_पथ_बफ
sutra_glob_सञ्चिका_पथ_बफ:
  .quad 0
  .globl sutra_glob_सञ्चिका_समादेश_बफ
sutra_glob_सञ्चिका_समादेश_बफ:
  .quad 0
  .globl sutra_glob_सञ्चिका_तर्क_बफ
sutra_glob_सञ्चिका_तर्क_बफ:
  .quad 0
  .globl sutra_glob_तर्क_तैयार
sutra_glob_तर्क_तैयार:
  .quad 0
  .globl sutra_glob_तर्क_गण
sutra_glob_तर्क_गण:
  .quad 0
  .globl sutra_glob_तर्क_डब्ल्यू
sutra_glob_तर्क_डब्ल्यू:
  .quad 0
  .globl sutra_glob_दशमलव_बफ
sutra_glob_दशमलव_बफ:
  .quad 0
  .globl sutra_glob_पसू_कैश_स
sutra_glob_पसू_कैश_स:
  .quad 0
  .globl sutra_glob_पसू_कैश_क
sutra_glob_पसू_कैश_क:
  .quad 0
  .globl sutra_glob_पसू_कैश_ब
sutra_glob_पसू_कैश_ब:
  .quad 0
  .globl sutra_glob_पसू_कैश_चक्र
sutra_glob_पसू_कैश_चक्र:
  .quad 0
  .globl sutra_glob_जीसी_बफ
sutra_glob_जीसी_बफ:
  .quad 0
  .globl sutra_glob_घा_बावन
sutra_glob_घा_बावन:
  .quad 0
  .section .rdata,"dr"
  .align 8
.LC_dbl_0:
  .double 0.0
  .align 8
.LC_dbl_1:
  .double 1000000.0
  .align 8
.LC_dbl_2:
  .double 1.4142135623730951
  .align 8
.LC_dbl_3:
  .double 0.5
  .align 8
.LC_dbl_4:
  .double 1.0
  .align 8
.LC_dbl_5:
  .double 2.0
  .align 8
.LC_dbl_6:
  .double 0.6931471805599453
  .align 8
.LC_dbl_7:
  .double 1.4426950408889634
  .align 8
.LC_dbl_8:
  .double 1024.0
.LC_str_0:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\252\340\244\276\340\244\240_\340\244\211\340\244\252\340\244\226\340\244\202\340\244\241_\340\244\254\340\244\276\340\244\207\340\244\237: \340\244\213\340\244\243 \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225\0"
.LC_str_0_len:
  .quad 94
.LC_str_1:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\252\340\244\276\340\244\240_\340\244\211\340\244\252\340\244\226\340\244\202\340\244\241_\340\244\254\340\244\276\340\244\207\340\244\237: \340\244\254\340\244\276\340\244\207\340\244\237-\340\244\270\340\245\200\340\244\256\340\244\276 \340\244\205\340\244\244\340\244\277\340\244\225\340\245\215\340\244\260\340\244\276\340\244\250\340\245\215\340\244\244\340\244\276\0"
.LC_str_1_len:
  .quad 125
.LC_str_2:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\205\340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\256\340\244\276\340\244\250 (Index cannot be negative)\0"
.LC_str_2_len:
  .quad 103
.LC_str_3:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\252\340\244\276\340\244\240\340\244\270\340\245\215\340\244\257 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\205\340\244\244\340\244\277\340\244\225\340\245\215\340\244\260\340\244\276\340\244\250\340\245\215\340\244\244\340\244\276 (String index out of bounds)\0"
.LC_str_3_len:
  .quad 120
.LC_str_4:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\206\340\244\260\340\244\202\340\244\255\340\244\203 \340\244\205\340\244\250\340\245\215\340\244\244\340\245\215\340\244\257\340\244\244\340\244\203 \340\244\205\340\244\247\340\244\277\340\244\225\340\244\203 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277 (start > end)\0"
.LC_str_4_len:
  .quad 112
.LC_str_5:
  .ascii "[\340\244\266\340\244\254\340\245\215\340\244\246\340\244\225\340\245\213\340\244\266]\0"
.LC_str_5_len:
  .quad 23
.LC_str_6:
  .ascii "[\340\244\270\340\245\202\340\244\232\340\245\200]\0"
.LC_str_6_len:
  .quad 14
.LC_str_7:
  .ascii "\340\244\266\340\245\202\340\244\250\340\245\215\340\244\257\340\244\256\340\245\215\0"
.LC_str_7_len:
  .quad 21
.LC_str_8:
  .ascii "\340\244\252\340\244\276\340\244\240\0"
.LC_str_8_len:
  .quad 9
.LC_str_9:
  .ascii "\340\244\266\340\244\254\340\245\215\340\244\246\340\244\225\340\245\213\340\244\266\0"
.LC_str_9_len:
  .quad 21
.LC_str_10:
  .ascii "\340\244\270\340\245\202\340\244\232\340\245\200\0"
.LC_str_10_len:
  .quad 12
.LC_str_11:
  .ascii "\340\244\270\340\244\202\340\244\226\340\245\215\340\244\257\340\244\276\0"
.LC_str_11_len:
  .quad 18
.LC_str_12:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\266\340\244\254\340\245\215\340\244\246\340\244\225\340\245\213\340\244\266 \340\244\252\340\244\260 \340\244\270\340\245\207\340\244\237 \340\244\252\340\245\215\340\244\260\340\244\257\340\244\276\340\244\270\0"
.LC_str_12_len:
  .quad 99
.LC_str_13:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\252\340\244\260 \340\244\234\340\245\213\340\244\241\340\244\274\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_13_len:
  .quad 90
.LC_str_14:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\270\340\245\207 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\250\340\244\277\340\244\225\340\244\276\340\244\262\340\244\276 \340\244\234\340\244\276 \340\244\270\340\244\225\340\244\244\340\244\276\340\245\244\0"
.LC_str_14_len:
  .quad 123
.LC_str_15:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\252\340\244\260 \340\244\241\340\244\276\340\244\262\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_15_len:
  .quad 87
.LC_str_16:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\241\340\244\276\340\244\262\340\245\207\340\244\202: \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\270\340\245\207 \340\244\254\340\244\276\340\244\271\340\244\260\0"
.LC_str_16_len:
  .quad 97
.LC_str_17:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\244\260 \340\244\270\340\245\207 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\271\340\244\237\340\244\276\340\244\250\340\244\276 \340\244\205\340\244\270\340\244\202\340\244\255\340\244\265\0"
.LC_str_17_len:
  .quad 100
.LC_str_18:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\271\340\244\237\340\244\276\340\244\217\340\244\202: \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\270\340\245\207 \340\244\254\340\244\276\340\244\271\340\244\260\0"
.LC_str_18_len:
  .quad 97
.LC_str_19:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\226\340\245\213\340\244\234\340\245\207\340\244\202: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\226\340\245\213\340\244\234 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_19_len:
  .quad 117
.LC_str_20:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\254\340\244\246\340\244\262\340\245\207\340\244\202 \340\244\256\340\245\207\340\244\202 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\271\340\245\210\0"
.LC_str_20_len:
  .quad 113
.LC_str_21:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\254\340\244\246\340\244\262\340\245\207\340\244\202: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\226\340\245\213\340\244\234 \340\244\252\340\244\276\340\244\240 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_21_len:
  .quad 117
.LC_str_22:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\277\340\244\244 \340\244\225\340\245\207 \340\244\244\340\244\260\340\245\215\340\244\225 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\271\340\245\213 \340\244\270\340\244\225\340\244\244\340\245\207\0"
.LC_str_22_len:
  .quad 116
.LC_str_23:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\277\340\244\244: \340\244\260\340\244\277\340\244\225\340\245\215\340\244\244 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\225 \340\244\256\340\244\276\340\244\250\340\245\215\340\244\257 \340\244\250 \340\244\205\340\244\270\340\245\215\340\244\244\340\244\277\340\245\244\0"
.LC_str_23_len:
  .quad 122
.LC_str_24:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\270\340\244\202\340\244\257\340\245\213\340\244\234\340\244\277\340\244\244 \340\244\256\340\245\207\340\244\202 \340\244\270\340\245\202\340\244\232\340\245\200 \340\244\225\340\245\207 \340\244\270\340\244\255\340\245\200 \340\244\244\340\244\244\340\245\215\340\244\265 \340\244\252\340\244\276\340\244\240 \340\244\271\340\245\213\340\244\250\340\245\207 \340\244\232\340\244\276\340\244\271\340\244\277\340\244\217\340\245\244\0"
.LC_str_24_len:
  .quad 142
.LC_str_25:
  .ascii "cmd.exe /c \0"
.LC_str_25_len:
  .quad 11
.LC_str_26:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\252\340\244\276\340\244\240 \340\244\252\340\244\260 \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\252\340\245\215\340\244\260\340\244\257\340\244\276\340\244\270\0"
.LC_str_26_len:
  .quad 99
.LC_str_27:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257 \340\244\270\340\245\202\340\244\232\340\245\200 \340\244\252\340\244\260 \340\244\270\340\245\202\340\244\232\340\244\225\340\244\276\340\244\202\340\244\225 \340\244\252\340\245\215\340\244\260\340\244\257\340\244\276\340\244\270\0"
.LC_str_27_len:
  .quad 102
.LC_str_28:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\270\340\245\202\340\244\232\340\245\215\340\244\257\340\244\276\340\244\203 \340\244\270\340\245\200\340\244\256\340\244\276 \340\244\205\340\244\244\340\244\277\340\244\225\340\245\215\340\244\260\340\244\276\340\244\250\340\245\215\340\244\244\340\244\276 (Array index out of bounds)\0"
.LC_str_28_len:
  .quad 122
.LC_str_29:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\265\340\244\277\340\244\246\340\245\207\340\244\266\340\245\200_\340\244\270\340\245\207_\340\244\252\340\244\276\340\244\240: 1MB \340\244\244\340\244\225 NUL-\340\244\205\340\244\202\340\244\244 \340\244\250\340\244\271\340\245\200\340\244\202 \340\244\256\340\244\277\340\244\262\340\244\276 (\340\244\227\340\244\262\340\244\244 \340\244\270\340\245\202\340\244\232\340\244\225?)\0"
.LC_str_29_len:
  .quad 139
.LC_str_30:
  .ascii "\340\244\205\340\244\250\340\245\201\340\244\267\340\245\215\340\244\240\340\244\276\340\244\250-\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\266\340\245\202\340\244\250\340\245\215\340\244\257\340\245\207\340\244\250 \340\244\265\340\244\277\340\244\255\340\244\276\340\244\234\340\244\250\340\244\256\340\245\215 \340\244\250 \340\244\270\340\244\256\340\245\215\340\244\255\340\244\265\340\244\244\340\244\277 (Division by zero)\0"
.LC_str_30_len:
  .quad 142
.LC_str_31:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203: \0"
.LC_str_31_len:
  .quad 23
.LC_str_32:
  .ascii "\340\244\244\340\245\215\340\244\260\340\245\201\340\244\237\340\244\277\340\244\203 \342\200\224 \340\244\205\340\244\250\340\244\277\340\244\257\340\244\202\340\244\244\340\245\215\340\244\260\340\244\277\340\244\244 \340\244\205\340\244\252\340\244\265\340\244\276\340\244\246 (Uncaught exception)\0"
.LC_str_32_len:
  .quad 93
.LC_str_33:
  .ascii "\n\0"
.LC_str_33_len:
  .quad 1

