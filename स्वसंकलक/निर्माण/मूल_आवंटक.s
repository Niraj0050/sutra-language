  .text
  .globl श्रेणी_का
  .def श्रेणी_का; .scl 2; .type 32; .endef
श्रेणी_का:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_श्रेणी_का__प्रवेश_0:
  movq $4096, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_श्रेणी_का__if_अंत_2
  jmp .L_श्रेणी_का__if_सत्य_1
.L_श्रेणी_का__if_अंत_2:
  movq $16, %rsi
  movq %rbx, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_श्रेणी_का
.L_श्रेणी_का__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_श्रेणी_का
.L_epilogue_श्रेणी_का:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl मुक्त_तालिका_तैयार
  .def मुक्त_तालिका_तैयार; .scl 2; .type 32; .endef
मुक्त_तालिका_तैयार:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_मुक्त_तालिका_तैयार__प्रवेश_0:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_मुक्त_तालिका_तैयार__if_अंत_2
  jmp .L_मुक्त_तालिका_तैयार__if_सत्य_1
.L_मुक्त_तालिका_तैयार__if_सत्य_1:
  movq $2056, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_मुक्त_तालिका(%rip)
  jmp .L_मुक्त_तालिका_तैयार__if_अंत_2
.L_मुक्त_तालिका_तैयार__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_मुक्त_तालिका_तैयार
.L_epilogue_मुक्त_तालिका_तैयार:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)

.L_सूत्र_स्वजीसी_आरंभ__प्रवेश_0:
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_जीसी_चालू(%rip)
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_जीसी_दबाव(%rip)
  movq $134217728, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_जीसी_सीमा(%rip)
  movq $1, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_ऑटो_सक्षम(%rip)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_स्वजीसी_आरंभ
.L_epilogue_सूत्र_स्वजीसी_आरंभ:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_जीसी_दबाओ
  .def सूत्र_जीसी_दबाओ; .scl 2; .type 32; .endef
सूत्र_जीसी_दबाओ:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_सूत्र_जीसी_दबाओ__प्रवेश_0:
  movq sutra_glob_जीसी_दबाव(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_जीसी_दबाव(%rip)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_जीसी_दबाओ
.L_epilogue_सूत्र_जीसी_दबाओ:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_जीसी_छोड़ो
  .def सूत्र_जीसी_छोड़ो; .scl 2; .type 32; .endef
सूत्र_जीसी_छोड़ो:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)

.L_सूत्र_जीसी_छोड़ो__प्रवेश_0:
  movq sutra_glob_जीसी_दबाव(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_जीसी_दबाव(%rip)
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_जीसी_छोड़ो
.L_epilogue_सूत्र_जीसी_छोड़ो:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_संरेखित16__प्रवेश_0:
  movq $15, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $16, %rbx
  movq %rdi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rsi
  movq $16, %rbx
  movq %rsi, %r10
  imulq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_संरेखित16
.L_epilogue_संरेखित16:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx

.L_नया_अखंड__प्रवेश_0:
  movq $16777216, %rsi
  movq $64, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_नया_अखंड_0
  jmp .L_नया_अखंड__if_सत्य_1
.L_किनारा_नया_अखंड_0:
  movq %rsi, %rbx
  jmp .L_नया_अखंड__if_अंत_2
.L_नया_अखंड__if_सत्य_1:
  movq $64, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $15, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $16, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $16, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rbx
  jmp .L_नया_अखंड__if_अंत_2
.L_नया_अखंड__if_अंत_2:
  movq $32, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call सूत्र_तल_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rdi
  movq $0, %r12
  movq %rsi, %r10
  movq %rdi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq $8, %rdi
  movq $0, %r12
  movq %rsi, %r10
  movq %rdi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq $16, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r12
  movq sutra_glob_अखंड_प्रथम(%rip), %r10
  movq %r10, %rbx
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_नया_अखंड__if_असत्य_5
  jmp .L_नया_अखंड__if_सत्य_3
.L_नया_अखंड__if_असत्य_5:
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rbx
  movq $0, %rdi
  movq %rbx, %r10
  movq %rdi, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r12
  jmp .L_नया_अखंड__if_अंत_4
.L_नया_अखंड__if_सत्य_3:
  movq %rsi, %r10
  movq %r10, sutra_glob_अखंड_प्रथम(%rip)
  jmp .L_नया_अखंड__if_अंत_4
.L_नया_अखंड__if_अंत_4:
  movq %rsi, %r10
  movq %r10, sutra_glob_अखंड_वर्तमान(%rip)
  movq %rsi, %rax
  jmp .L_epilogue_नया_अखंड
.L_epilogue_नया_अखंड:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %rcx, %rbx
  movq %rdx, %rsi

.L_शून्य_भरो__प्रवेश_0:
  movq $0, %rdi
  jmp .L_शून्य_भरो__wh_शर्त_1
.L_शून्य_भरो__wh_शर्त_1:
  movq $8, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq %rsi, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_शून्य_भरो__wh_अंत_3
  jmp .L_शून्य_भरो__wh_देह_2
.L_शून्य_भरो__wh_अंत_3:
  movq %rdi, %r12
  jmp .L_शून्य_भरो__wh_शर्त_4
.L_शून्य_भरो__wh_शर्त_4:
  movq %r12, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_शून्य_भरो__wh_अंत_6
  jmp .L_शून्य_भरो__wh_देह_5
.L_शून्य_भरो__wh_अंत_6:
  movq $0, %rax
  jmp .L_epilogue_शून्य_भरो
.L_शून्य_भरो__wh_देह_5:
  movq $0, %r13
  movq %rbx, %r10
  movq %r12, %r11
  movq %r13, %r8
  movb %r8b, (%r10,%r11)
  movq %r13, %r14
  movq $1, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r12
  jmp .L_शून्य_भरो__wh_शर्त_4
.L_शून्य_भरो__wh_देह_2:
  movq $0, %r12
  movq %rbx, %r10
  movq %rdi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq $8, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %rdi
  jmp .L_शून्य_भरो__wh_शर्त_1
.L_epilogue_शून्य_भरो:
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
  .globl सूत्र_आवंटन
  .def सूत्र_आवंटन; .scl 2; .type 32; .endef
सूत्र_आवंटन:
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
  movq %rdx, -72(%rbp)

.L_सूत्र_आवंटन__प्रवेश_0:
  movq $15, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $16, %rbx
  movq %r12, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rax, %rdi
  movq $16, %rbx
  movq %rdi, %r10
  imulq %rbx, %r10
  movq %r10, %r12
  movq $16, %rbx
  movq %r12, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_0
  jmp .L_सूत्र_आवंटन__if_सत्य_1
.L_किनारा_सूत्र_आवंटन_0:
  movq %r12, %rbx
  jmp .L_सूत्र_आवंटन__if_अंत_2
.L_सूत्र_आवंटन__if_सत्य_1:
  movq $16, %rbx
  jmp .L_सूत्र_आवंटन__if_अंत_2
.L_सूत्र_आवंटन__if_अंत_2:
  movq $16, %rdi
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, -104(%rbp)
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq %rax, %rdi
  movq sutra_glob_ऑटो_सक्षम(%rip), %r10
  movq %r10, %rdi
  movq $1, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_4
  jmp .L_सूत्र_आवंटन__if_सत्य_3
.L_सूत्र_आवंटन__if_सत्य_3:
  movq sutra_glob_जीसी_चालू(%rip), %r10
  movq %r10, %rdi
  movq $0, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_4
  jmp .L_सूत्र_आवंटन__if_सत्य_5
.L_सूत्र_आवंटन__if_सत्य_5:
  movq sutra_glob_जीसी_दबाव(%rip), %r10
  movq %r10, %rdi
  movq $0, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_4
  jmp .L_सूत्र_आवंटन__if_सत्य_7
.L_सूत्र_आवंटन__if_सत्य_7:
  movq sutra_glob_आवंटित_बाइट्स(%rip), %r10
  movq %r10, %rdi
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_4
  jmp .L_सूत्र_आवंटन__if_सत्य_9
.L_सूत्र_आवंटन__if_सत्य_9:
  movq $1, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_जीसी_चालू(%rip)
  subq $32, %rsp
  call सूत्र_संग्रह
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $0, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_जीसी_चालू(%rip)
  jmp .L_सूत्र_आवंटन__if_अंत_4
.L_सूत्र_आवंटन__if_अंत_4:
  movq %rbx, %rcx
  subq $32, %rsp
  call श्रेणी_का
  addq $32, %rsp
  movq %rax, -88(%rbp)
  movq $0, %r13
  movq -88(%rbp), %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_असत्य_13
  jmp .L_सूत्र_आवंटन__if_सत्य_11
.L_सूत्र_आवंटन__if_असत्य_13:
  movq $0, %r13
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %r14
  movq $0, %r15
  movq %r14, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rsi, %r11
  movq %r13, %rsi
  movq %r11, %r13
  jmp .L_सूत्र_आवंटन__wh_शर्त_16
.L_सूत्र_आवंटन__wh_शर्त_16:
  movq $0, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_12
  jmp .L_सूत्र_आवंटन__wh_देह_17
.L_सूत्र_आवंटन__wh_देह_17:
  movq $8, %r14
  movq %r13, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq $16, %r14
  movq %r13, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq %r15, %r10
  cmpq %rbx, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_20
  jmp .L_सूत्र_आवंटन__if_सत्य_19
.L_सूत्र_आवंटन__if_अंत_20:
  movq %r13, %rsi
  movq %rdi, %r13
  jmp .L_सूत्र_आवंटन__wh_शर्त_16
.L_सूत्र_आवंटन__if_सत्य_19:
  movq $0, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_असत्य_23
  jmp .L_सूत्र_आवंटन__if_सत्य_21
.L_सूत्र_आवंटन__if_असत्य_23:
  movq $16, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r14
  jmp .L_सूत्र_आवंटन__if_अंत_22
.L_सूत्र_आवंटन__if_सत्य_21:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rsi
  movq $0, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r14
  jmp .L_सूत्र_आवंटन__if_अंत_22
.L_सूत्र_आवंटन__if_अंत_22:
  movq $0, %rsi
  movq %r13, %r10
  movq %rsi, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rdi
  movq $16, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  movq %r15, %rdx
  subq $32, %rsp
  call शून्य_भरो
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_सूत्र_आवंटन__if_सत्य_11:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rsi
  movq $8, %rdi
  movq -88(%rbp), %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_12
  jmp .L_सूत्र_आवंटन__if_सत्य_14
.L_सूत्र_आवंटन__if_अंत_12:
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rsi
  movq $0, %r12
  movq %rsi, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूत्र_आवंटन__if_अंत_25
  jmp .L_सूत्र_आवंटन__if_सत्य_24
.L_सूत्र_आवंटन__if_सत्य_24:
  movq -104(%rbp), %rcx
  subq $32, %rsp
  call नया_अखंड
  addq $32, %rsp
  movq %rax, %rsi
  jmp .L_सूत्र_आवंटन__if_अंत_25
.L_सूत्र_आवंटन__if_अंत_25:
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rsi
  movq $8, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $16, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r13, %r10
  addq -104(%rbp), %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq %r14, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_1
  jmp .L_सूत्र_आवंटन__if_सत्य_26
.L_किनारा_सूत्र_आवंटन_1:
  movq %r13, %r12
  jmp .L_सूत्र_आवंटन__if_अंत_27
.L_सूत्र_आवंटन__if_सत्य_26:
  movq -104(%rbp), %rcx
  subq $32, %rsp
  call नया_अखंड
  addq $32, %rsp
  movq %rax, %rsi
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rsi
  movq $0, %r12
  jmp .L_सूत्र_आवंटन__if_अंत_27
.L_सूत्र_आवंटन__if_अंत_27:
  movq $32, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq $8, %r14
  movq %r12, %r10
  addq -104(%rbp), %r10
  movq %r10, %r15
  movq %rsi, %r10
  movq %r14, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r12
  movq $0, %rsi
  movq %r13, %r10
  movq %rsi, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %r12
  movq $8, %rsi
  movq %r13, %r10
  movq %rsi, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r12
  movq sutra_glob_आवंटित_बाइट्स(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %r10
  addq -104(%rbp), %r10
  movq %r10, %rsi
  movq %rsi, %r10
  movq %r10, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $16, %rbx
  movq %r13, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_सूत्र_आवंटन__if_सत्य_14:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rbx
  movq $8, %rsi
  movq -88(%rbp), %r10
  imulq %rsi, %r10
  movq %r10, %r12
  movq $16, %rsi
  movq %rdi, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r12, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %rsi
  movq $0, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rsi
  movq $16, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $8, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rsi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call शून्य_भरो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq %rdi, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_epilogue_सूत्र_आवंटन:
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
  .globl सूत्र_मुक्त
  .def सूत्र_मुक्त; .scl 2; .type 32; .endef
सूत्र_मुक्त:
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

.L_सूत्र_मुक्त__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_मुक्त__if_अंत_2
  jmp .L_सूत्र_मुक्त__if_सत्य_1
.L_सूत्र_मुक्त__if_अंत_2:
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq %rax, %rsi
  movq $16, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq $8, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call श्रेणी_का
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %rsi
  movq $0, %r12
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r12, %r8
  movq %r8, (%r10,%r11)
  movq %r12, %r13
  movq $16, %rsi
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %r12
  movq $8, %r13
  movq %rbx, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %r12, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r12
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rsi
  movq $8, %r12
  movq %rbx, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rsi, %r10
  movq %r13, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %rbx
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_मुक्त
.L_सूत्र_मुक्त__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_मुक्त
.L_epilogue_सूत्र_मुक्त:
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
  .globl सूत्र_पुनः_आवंटन
  .def सूत्र_पुनः_आवंटन; .scl 2; .type 32; .endef
सूत्र_पुनः_आवंटन:
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

.L_सूत्र_पुनः_आवंटन__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूत्र_पुनः_आवंटन__if_अंत_2
  jmp .L_सूत्र_पुनः_आवंटन__if_सत्य_1
.L_सूत्र_पुनः_आवंटन__if_अंत_2:
  movq $16, %rdi
  movq %rbx, %r10
  subq %rdi, %r10
  movq %r10, %r12
  movq $0, %rdi
  movq %r12, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $256, %rdi
  movq %r13, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %r14
  movq $8, %rdi
  movq %r12, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq -72(%rbp), %rcx
  movq %r14, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %rdi
  movq -72(%rbp), %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_पुनः_आवंटन_0
  jmp .L_सूत्र_पुनः_आवंटन__if_सत्य_3
.L_किनारा_सूत्र_पुनः_आवंटन_0:
  movq %r13, %r12
  jmp .L_सूत्र_पुनः_आवंटन__if_अंत_4
.L_सूत्र_पुनः_आवंटन__if_सत्य_3:
  movq -72(%rbp), %r12
  jmp .L_सूत्र_पुनः_आवंटन__if_अंत_4
.L_सूत्र_पुनः_आवंटन__if_अंत_4:
  movq $0, %r13
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_5
.L_सूत्र_पुनः_आवंटन__wh_शर्त_5:
  movq $8, %r14
  movq %r13, %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq %r12, %r10
  setle %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_पुनः_आवंटन__wh_अंत_7
  jmp .L_सूत्र_पुनः_आवंटन__wh_देह_6
.L_सूत्र_पुनः_आवंटन__wh_अंत_7:
  movq %r13, %r14
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_8
.L_सूत्र_पुनः_आवंटन__wh_शर्त_8:
  movq %r14, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सूत्र_पुनः_आवंटन__wh_अंत_10
  jmp .L_सूत्र_पुनः_आवंटन__wh_देह_9
.L_सूत्र_पुनः_आवंटन__wh_अंत_10:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_मुक्त
  addq $32, %rsp
  movq %rax, %r15
  movq %rdi, %rax
  jmp .L_epilogue_सूत्र_पुनः_आवंटन
.L_सूत्र_पुनः_आवंटन__wh_देह_9:
  movq %rbx, %r10
  movq %r14, %r11
  movzbq (%r10,%r11), %r10
  movq %r10, %r15
  movq %rdi, %r10
  movq %r14, %r11
  movq %r15, %r8
  movb %r8b, (%r10,%r11)
  movq %r15, %rsi
  movq $1, %rsi
  movq %r14, %r10
  addq %rsi, %r10
  movq %r10, %r15
  movq %r15, %r14
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_8
.L_सूत्र_पुनः_आवंटन__wh_देह_6:
  movq %rbx, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rdi, %r10
  movq %r13, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r14
  movq $8, %rsi
  movq %r13, %r10
  addq %rsi, %r10
  movq %r10, %r14
  movq %r14, %r13
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_5
.L_सूत्र_पुनः_आवंटन__if_सत्य_1:
  movq $2, %rbx
  movq -72(%rbp), %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call सूत्र_आवंटन
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_सूत्र_पुनः_आवंटन
.L_epilogue_सूत्र_पुनः_आवंटन:
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
  .globl अखंड_में_है
  .def अखंड_में_है; .scl 2; .type 32; .endef
अखंड_में_है:
  pushq %rbp
  movq %rsp, %rbp
  subq $64, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx

.L_अखंड_में_है__प्रवेश_0:
  movq sutra_glob_अखंड_प्रथम(%rip), %r10
  movq %r10, %rsi
  jmp .L_अखंड_में_है__wh_शर्त_1
.L_अखंड_में_है__wh_शर्त_1:
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_अखंड_में_है__wh_अंत_3
  jmp .L_अखंड_में_है__wh_देह_2
.L_अखंड_में_है__wh_अंत_3:
  movq $0, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_अखंड_में_है
.L_अखंड_में_है__wh_देह_2:
  movq $32, %rdi
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $8, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r12, %r10
  addq %r13, %r10
  movq %r10, %rdi
  movq %rbx, %r10
  cmpq %r12, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_अखंड_में_है__sc_लघु_5
  jmp .L_अखंड_में_है__sc_दायाँ_4
.L_अखंड_में_है__sc_लघु_5:
  movq $0, %r12
  movq %r12, %rdi
  jmp .L_अखंड_में_है__sc_अंत_6
.L_अखंड_में_है__sc_दायाँ_4:
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %rdi
  jmp .L_अखंड_में_है__sc_अंत_6
.L_अखंड_में_है__sc_अंत_6:
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_अखंड_में_है__if_अंत_8
  jmp .L_अखंड_में_है__if_सत्य_7
.L_अखंड_में_है__if_अंत_8:
  movq $0, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %r12, %rsi
  jmp .L_अखंड_में_है__wh_शर्त_1
.L_अखंड_में_है__if_सत्य_7:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अखंड_में_है
.L_epilogue_अखंड_में_है:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl सूत्र_ब्लॉक_प्रकार
  .def सूत्र_ब्लॉक_प्रकार; .scl 2; .type 32; .endef
सूत्र_ब्लॉक_प्रकार:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %rcx, %rbx

.L_सूत्र_ब्लॉक_प्रकार__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_ब्लॉक_प्रकार__if_अंत_2
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_1
.L_सूत्र_ब्लॉक_प्रकार__if_अंत_2:
  movq $16, %rsi
  movq %rbx, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq $0, %rsi
  movq %rdi, %r10
  cmpq %rsi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूत्र_ब्लॉक_प्रकार__if_अंत_4
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_3
.L_सूत्र_ब्लॉक_प्रकार__if_अंत_4:
  movq $16, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अखंड_में_है
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सूत्र_ब्लॉक_प्रकार__if_अंत_6
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_5
.L_सूत्र_ब्लॉक_प्रकार__if_अंत_6:
  movq $0, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $256, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %rdi
  movq $1, %rbx
  movq %rdi, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सूत्र_ब्लॉक_प्रकार__sc_दायाँ_7
  jmp .L_सूत्र_ब्लॉक_प्रकार__sc_लघु_8
.L_सूत्र_ब्लॉक_प्रकार__sc_दायाँ_7:
  movq $4, %rbx
  movq %rdi, %r10
  cmpq %rbx, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %rbx
  jmp .L_सूत्र_ब्लॉक_प्रकार__sc_अंत_9
.L_सूत्र_ब्लॉक_प्रकार__sc_लघु_8:
  movq $1, %rbx
  jmp .L_सूत्र_ब्लॉक_प्रकार__sc_अंत_9
.L_सूत्र_ब्लॉक_प्रकार__sc_अंत_9:
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_सूत्र_ब्लॉक_प्रकार__if_अंत_11
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_10
.L_सूत्र_ब्लॉक_प्रकार__if_अंत_11:
  movq %rdi, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_सूत्र_ब्लॉक_प्रकार__if_सत्य_10:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_सूत्र_ब्लॉक_प्रकार__if_सत्य_5:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_सूत्र_ब्लॉक_प्रकार__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_सूत्र_ब्लॉक_प्रकार__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_ब्लॉक_प्रकार
.L_epilogue_सूत्र_ब्लॉक_प्रकार:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सूत्र_क्या_पाठ__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $1, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_क्या_पाठ__if_अंत_2
  jmp .L_सूत्र_क्या_पाठ__if_सत्य_1
.L_सूत्र_क्या_पाठ__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_सूत्र_क्या_पाठ__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_epilogue_सूत्र_क्या_पाठ:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सूत्र_क्या_सूची__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $2, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_क्या_सूची__if_अंत_2
  jmp .L_सूत्र_क्या_सूची__if_सत्य_1
.L_सूत्र_क्या_सूची__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_सूत्र_क्या_सूची__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_epilogue_सूत्र_क्या_सूची:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सूत्र_क्या_वस्तु__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $3, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_क्या_वस्तु__if_अंत_2
  jmp .L_सूत्र_क्या_वस्तु__if_सत्य_1
.L_सूत्र_क्या_वस्तु__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_सूत्र_क्या_वस्तु__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_epilogue_सूत्र_क्या_वस्तु:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %rcx, %rbx

.L_सूत्र_क्या_शब्दकोश__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq $4, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_क्या_शब्दकोश__if_अंत_2
  jmp .L_सूत्र_क्या_शब्दकोश__if_सत्य_1
.L_सूत्र_क्या_शब्दकोश__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_सूत्र_क्या_शब्दकोश__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_epilogue_सूत्र_क्या_शब्दकोश:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
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
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %rcx, %rbx

.L_चिह्नित_कच्चा__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_चिह्नित_कच्चा__if_अंत_2
  jmp .L_चिह्नित_कच्चा__if_सत्य_1
.L_चिह्नित_कच्चा__if_अंत_2:
  movq $16, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अखंड_में_है
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_चिह्नित_कच्चा__if_अंत_4
  jmp .L_चिह्नित_कच्चा__if_सत्य_3
.L_चिह्नित_कच्चा__if_अंत_4:
  movq $0, %rbx
  movq %rdi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $256, %rbx
  movq %rsi, %rax
  movq %rbx, %r10
  cqto
  idivq %r10
  movq %rdx, %r12
  movq $1, %rbx
  movq %r12, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_चिह्नित_कच्चा__sc_दायाँ_5
  jmp .L_चिह्नित_कच्चा__sc_लघु_6
.L_चिह्नित_कच्चा__sc_दायाँ_5:
  movq $4, %rbx
  movq %r12, %r10
  cmpq %rbx, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %rbx
  jmp .L_चिह्नित_कच्चा__sc_अंत_7
.L_चिह्नित_कच्चा__sc_लघु_6:
  movq $1, %rbx
  jmp .L_चिह्नित_कच्चा__sc_अंत_7
.L_चिह्नित_कच्चा__sc_अंत_7:
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_चिह्नित_कच्चा__if_अंत_9
  jmp .L_चिह्नित_कच्चा__if_सत्य_8
.L_चिह्नित_कच्चा__if_अंत_9:
  movq $256, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_चिह्नित_कच्चा__if_अंत_11
  jmp .L_चिह्नित_कच्चा__if_सत्य_10
.L_चिह्नित_कच्चा__if_सत्य_10:
  movq $0, %rbx
  movq $256, %rsi
  movq %r12, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %rbx, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %rsi
  jmp .L_चिह्नित_कच्चा__if_अंत_11
.L_चिह्नित_कच्चा__if_अंत_11:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_चिह्नित_कच्चा__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_चिह्नित_कच्चा__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_चिह्नित_कच्चा__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित_कच्चा
.L_epilogue_चिह्नित_कच्चा:
  movq -8(%rbp), %rbx
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdi
  movq -32(%rbp), %r12
  movq -40(%rbp), %r13
  movq %rbp, %rsp
  popq %rbp
  ret

  .text
  .globl चिह्नित
  .def चिह्नित; .scl 2; .type 32; .endef
चिह्नित:
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

.L_चिह्नित__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_2
  jmp .L_चिह्नित__if_सत्य_1
.L_चिह्नित__if_अंत_2:
  movq $16, %rsi
  movq %rbx, %r10
  subq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %rcx
  subq $32, %rsp
  call अखंड_में_है
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_4
  jmp .L_चिह्नित__if_सत्य_3
.L_चिह्नित__if_अंत_4:
  movq $0, %rsi
  movq %rdi, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $256, %rsi
  movq %r12, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, %r13
  movq $1, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_चिह्नित__sc_दायाँ_5
  jmp .L_चिह्नित__sc_लघु_6
.L_चिह्नित__sc_दायाँ_5:
  movq $4, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  setg %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %rsi
  jmp .L_चिह्नित__sc_अंत_7
.L_चिह्नित__sc_लघु_6:
  movq $1, %rsi
  jmp .L_चिह्नित__sc_अंत_7
.L_चिह्नित__sc_अंत_7:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_9
  jmp .L_चिह्नित__if_सत्य_8
.L_चिह्नित__if_अंत_9:
  movq $256, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_11
  jmp .L_चिह्नित__if_सत्य_10
.L_चिह्नित__if_अंत_11:
  movq $0, %rsi
  movq $256, %r12
  movq %r13, %r10
  addq %r12, %r10
  movq %r10, %r14
  movq %rdi, %r10
  movq %rsi, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %r12
  movq $2, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_असत्य_14
  jmp .L_चिह्नित__if_सत्य_12
.L_चिह्नित__if_असत्य_14:
  movq $3, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_असत्य_22
  jmp .L_चिह्नित__if_सत्य_20
.L_चिह्नित__if_असत्य_22:
  movq $4, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_13
  jmp .L_चिह्नित__if_सत्य_26
.L_चिह्नित__if_सत्य_26:
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
  movq $0, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_29
  jmp .L_चिह्नित__if_सत्य_28
.L_चिह्नित__if_सत्य_28:
  movq %r12, %rcx
  subq $32, %rsp
  call चिह्नित_कच्चा
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rsi
  jmp .L_चिह्नित__wh_शर्त_30
.L_चिह्नित__wh_शर्त_30:
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_29
  jmp .L_चिह्नित__wh_देह_31
.L_चिह्नित__if_अंत_29:
  movq $24, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq $0, %r13
  movq %r14, %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_13
  jmp .L_चिह्नित__if_सत्य_33
.L_चिह्नित__if_सत्य_33:
  movq %r14, %rcx
  subq $32, %rsp
  call चिह्नित_कच्चा
  addq $32, %rsp
  movq %rax, %r13
  jmp .L_चिह्नित__if_अंत_13
.L_चिह्नित__wh_देह_31:
  movq $16, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq %r12, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %r14
  movq $16, %r13
  movq %rsi, %r10
  imulq %r13, %r10
  movq %r10, %r14
  movq $8, %r13
  movq %r14, %r10
  addq %r13, %r10
  movq %r10, %r15
  movq %r12, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %r14
  movq $1, %r13
  movq %rsi, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %rsi
  jmp .L_चिह्नित__wh_शर्त_30
.L_चिह्नित__if_सत्य_20:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  jmp .L_चिह्नित__wh_शर्त_23
.L_चिह्नित__wh_शर्त_23:
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_13
  jmp .L_चिह्नित__wh_देह_24
.L_चिह्नित__wh_देह_24:
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
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %r12, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %r13
  movq $1, %r12
  movq %rsi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %rsi
  jmp .L_चिह्नित__wh_शर्त_23
.L_चिह्नित__if_सत्य_12:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $16, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %rbx
  movq %r12, %r10
  cmpq %rbx, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_13
  jmp .L_चिह्नित__if_सत्य_15
.L_चिह्नित__if_सत्य_15:
  movq %r12, %rcx
  subq $32, %rsp
  call चिह्नित_कच्चा
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %rbx
  jmp .L_चिह्नित__wh_शर्त_17
.L_चिह्नित__wh_शर्त_17:
  movq %rbx, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_चिह्नित__if_अंत_13
  jmp .L_चिह्नित__wh_देह_18
.L_चिह्नित__if_अंत_13:
  movq $0, %rsi
  movq %rsi, %rax
  jmp .L_epilogue_चिह्नित
.L_चिह्नित__wh_देह_18:
  movq $8, %rsi
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r13
  movq %r12, %r10
  movq %r13, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq %rsi, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %r13
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %r13
  movq %r13, %rbx
  jmp .L_चिह्नित__wh_शर्त_17
.L_चिह्नित__if_सत्य_10:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित
.L_चिह्नित__if_सत्य_8:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित
.L_चिह्नित__if_सत्य_3:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित
.L_चिह्नित__if_सत्य_1:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_चिह्नित
.L_epilogue_चिह्नित:
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
  .globl सूत्र_संग्रह
  .def सूत्र_संग्रह; .scl 2; .type 32; .endef
सूत्र_संग्रह:
  pushq %rbp
  movq %rsp, %rbp
  subq $224, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)

.L_सूत्र_संग्रह__प्रवेश_0:
  movq sutra_glob_गण_चक्र(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_गण_चक्र(%rip)
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq %rax, %rbx
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, -88(%rbp)
  movq sutra_glob_अखंड_प्रथम(%rip), %r10
  movq %r10, %rsi
  movq %rsi, -72(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_1
.L_सूत्र_संग्रह__wh_शर्त_1:
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__wh_अंत_3
  jmp .L_सूत्र_संग्रह__wh_देह_2
.L_सूत्र_संग्रह__wh_अंत_3:
  subq $32, %rsp
  call sutra_gc_root_count
  addq $32, %rsp
  movq %rax, -104(%rbp)
  movq $0, %r12
  movq %r12, -120(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_7
.L_सूत्र_संग्रह__wh_शर्त_7:
  movq -120(%rbp), %r10
  cmpq -104(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__wh_अंत_9
  jmp .L_सूत्र_संग्रह__wh_देह_8
.L_सूत्र_संग्रह__wh_अंत_9:
  subq $32, %rsp
  call सक्रिय_अपवाद_लो
  addq $32, %rsp
  movq %rax, %r13
  movq %r13, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %r14
  movq $0, %r13
  movq %r13, %r10
  movq %r10, sutra_glob_गण_सक्रिय(%rip)
  movq sutra_glob_अखंड_प्रथम(%rip), %r10
  movq %r10, %r13
  movq %r13, -152(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_10
.L_सूत्र_संग्रह__wh_शर्त_10:
  movq $0, %r14
  movq -152(%rbp), %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__wh_अंत_12
  jmp .L_सूत्र_संग्रह__wh_देह_11
.L_सूत्र_संग्रह__wh_अंत_12:
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, %r14
  movq %r14, %r10
  subq -88(%rbp), %r10
  movq %r10, %r15
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %r14
  movq $4, %rsi
  movq %r14, %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rax, %rbx
  movq %r15, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__sc_लघु_22
  jmp .L_सूत्र_संग्रह__sc_दायाँ_21
.L_सूत्र_संग्रह__sc_लघु_22:
  movq $0, %rbx
  jmp .L_सूत्र_संग्रह__sc_अंत_23
.L_सूत्र_संग्रह__sc_दायाँ_21:
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %rbx
  movq $17179869184, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %rbx
  jmp .L_सूत्र_संग्रह__sc_अंत_23
.L_सूत्र_संग्रह__sc_अंत_23:
  movq %rbx, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__if_अंत_25
  jmp .L_सूत्र_संग्रह__if_सत्य_24
.L_सूत्र_संग्रह__if_सत्य_24:
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %rbx
  movq $2, %rsi
  movq %rbx, %r10
  imulq %rsi, %r10
  movq %r10, %r14
  movq %r14, %r10
  movq %r10, sutra_glob_जीसी_सीमा(%rip)
  jmp .L_सूत्र_संग्रह__if_अंत_25
.L_सूत्र_संग्रह__if_अंत_25:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_संग्रह
.L_सूत्र_संग्रह__wh_देह_11:
  movq $8, %rbx
  movq -152(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, -136(%rbp)
  movq $0, %rbx
  movq %rbx, -184(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_13
.L_सूत्र_संग्रह__wh_शर्त_13:
  movq -184(%rbp), %r10
  cmpq -136(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__wh_अंत_15
  jmp .L_सूत्र_संग्रह__wh_देह_14
.L_सूत्र_संग्रह__wh_अंत_15:
  movq $0, %r14
  movq -152(%rbp), %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq %r15, -152(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_10
.L_सूत्र_संग्रह__wh_देह_14:
  movq $32, %r14
  movq -152(%rbp), %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r15, %r10
  addq -184(%rbp), %r10
  movq %r10, %r14
  movq $0, %r15
  movq %r14, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $8, %r15
  movq %r14, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, -168(%rbp)
  movq $256, %r15
  movq %rdi, %rax
  movq %r15, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq $0, %r15
  movq %rsi, %r10
  cmpq %r15, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__if_अंत_17
  jmp .L_सूत्र_संग्रह__if_सत्य_16
.L_सूत्र_संग्रह__if_सत्य_16:
  movq $256, %r13
  movq %rdi, %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__if_असत्य_20
  jmp .L_सूत्र_संग्रह__if_सत्य_18
.L_सूत्र_संग्रह__if_असत्य_20:
  movq -168(%rbp), %rcx
  subq $32, %rsp
  call श्रेणी_का
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, %r13
  movq $0, %r15
  movq %r14, %r10
  movq %r13, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r12
  movq $16, %r12
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %r13
  movq $8, %r15
  movq %rdi, %r10
  imulq %r15, %r10
  movq %r10, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq %r14, %r10
  movq %r12, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %rbx
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rbx
  movq $8, %r12
  movq %rdi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r13, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %rdi
  movq sutra_glob_गण_संग्रहित(%rip), %r10
  movq %r10, %rbx
  movq $1, %rdi
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_गण_संग्रहित(%rip)
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %r10
  addq -168(%rbp), %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_गण_पुनःप्राप्त(%rip)
  jmp .L_सूत्र_संग्रह__if_अंत_17
.L_सूत्र_संग्रह__if_सत्य_18:
  movq $0, %rbx
  movq %r14, %r10
  movq %rbx, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  movq sutra_glob_गण_सक्रिय(%rip), %r10
  movq %r10, %rbx
  movq $1, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_गण_सक्रिय(%rip)
  jmp .L_सूत्र_संग्रह__if_अंत_17
.L_सूत्र_संग्रह__if_अंत_17:
  movq $16, %rbx
  movq -184(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  addq -168(%rbp), %r10
  movq %r10, %rbx
  movq %rbx, -184(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_13
.L_सूत्र_संग्रह__wh_देह_8:
  movq -120(%rbp), %rcx
  subq $32, %rsp
  call sutra_gc_root_deref
  addq $32, %rsp
  movq %rax, %rbx
  movq %rbx, %rcx
  subq $32, %rsp
  call चिह्नित
  addq $32, %rsp
  movq %rax, %rsi
  movq $1, %rbx
  movq -120(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, -120(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_7
.L_सूत्र_संग्रह__wh_देह_2:
  movq $8, %rbx
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, -200(%rbp)
  movq $0, %rbx
  jmp .L_सूत्र_संग्रह__wh_शर्त_4
.L_सूत्र_संग्रह__wh_शर्त_4:
  movq %rbx, %r10
  cmpq -200(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_सूत्र_संग्रह__wh_अंत_6
  jmp .L_सूत्र_संग्रह__wh_देह_5
.L_सूत्र_संग्रह__wh_अंत_6:
  movq $0, %rdi
  movq -72(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %r12, -72(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_1
.L_सूत्र_संग्रह__wh_देह_5:
  movq $32, %rdi
  movq -72(%rbp), %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $0, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $8, %r12
  movq %rdi, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq $0, %r12
  movq $256, %r15
  movq %r13, %rax
  movq %r15, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq %rdi, %r10
  movq %r12, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %r13
  movq $16, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  addq %r14, %r10
  movq %r10, %rbx
  jmp .L_सूत्र_संग्रह__wh_शर्त_4
.L_epilogue_सूत्र_संग्रह:
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
  .globl सूत्र_गण_चक्र
  .def सूत्र_गण_चक्र; .scl 2; .type 32; .endef
सूत्र_गण_चक्र:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rbx, -8(%rbp)

.L_सूत्र_गण_चक्र__प्रवेश_0:
  movq sutra_glob_गण_चक्र(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_गण_चक्र
.L_epilogue_सूत्र_गण_चक्र:
  movq -8(%rbp), %rbx
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
  movq %rbx, -8(%rbp)

.L_सूत्र_गण_सक्रिय__प्रवेश_0:
  movq sutra_glob_गण_सक्रिय(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_गण_सक्रिय
.L_epilogue_सूत्र_गण_सक्रिय:
  movq -8(%rbp), %rbx
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
  movq %rbx, -8(%rbp)

.L_सूत्र_गण_संग्रहित__प्रवेश_0:
  movq sutra_glob_गण_संग्रहित(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_गण_संग्रहित
.L_epilogue_सूत्र_गण_संग्रहित:
  movq -8(%rbp), %rbx
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
  movq %rbx, -8(%rbp)

.L_सूत्र_गण_पुनःप्राप्त__प्रवेश_0:
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_गण_पुनःप्राप्त
.L_epilogue_सूत्र_गण_पुनःप्राप्त:
  movq -8(%rbp), %rbx
  movq %rbp, %rsp
  popq %rbp
  ret

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
  .section .rdata,"dr"

