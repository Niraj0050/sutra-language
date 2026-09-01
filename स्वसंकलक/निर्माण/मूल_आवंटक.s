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
  je .L_किनारा_श्रेणी_का_0
  jmp .L_श्रेणी_का__if_सत्य_1
.L_किनारा_श्रेणी_का_0:
  jmp .L_श्रेणी_का__if_अंत_2
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
  je .L_किनारा_मुक्त_तालिका_तैयार_0
  jmp .L_मुक्त_तालिका_तैयार__if_सत्य_1
.L_किनारा_मुक्त_तालिका_तैयार_0:
  jmp .L_मुक्त_तालिका_तैयार__if_अंत_2
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
  movq %rdi, %rcx
  subq $32, %rsp
  call संरेखित16
  addq $32, %rsp
  movq %rax, %rbx
  jmp .L_नया_अखंड__if_अंत_2
.L_नया_अखंड__if_अंत_2:
  movq %rbx, -64(%rbp)
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
  movq $0, -64(%rbp)
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
  je .L_किनारा_नया_अखंड_1
  jmp .L_नया_अखंड__if_सत्य_3
.L_किनारा_नया_अखंड_1:
  jmp .L_नया_अखंड__if_असत्य_5
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
  .globl शून्य_भरो
  .def शून्य_भरो; .scl 2; .type 32; .endef
शून्य_भरो:
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
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -72(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -80(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_शून्य_भरो__प्रवेश_0:
  movq $0, %rdi
  jmp .L_शून्य_भरो__wh_शर्त_1
.L_शून्य_भरो__wh_शर्त_1:
  movq %rdi, -72(%rbp)
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
  je .L_किनारा_शून्य_भरो_0
  jmp .L_शून्य_भरो__wh_देह_2
.L_किनारा_शून्य_भरो_0:
  jmp .L_शून्य_भरो__wh_अंत_3
.L_शून्य_भरो__wh_अंत_3:
  movq %rdi, %r12
  jmp .L_शून्य_भरो__wh_शर्त_4
.L_शून्य_भरो__wh_शर्त_4:
  movq %r12, -80(%rbp)
  movq %r12, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_शून्य_भरो_1
  jmp .L_शून्य_भरो__wh_देह_5
.L_किनारा_शून्य_भरो_1:
  jmp .L_शून्य_भरो__wh_अंत_6
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
  movq $0, -80(%rbp)
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
  movq $0, -72(%rbp)
  movq %r13, %rdi
  jmp .L_शून्य_भरो__wh_शर्त_1
.L_epilogue_शून्य_भरो:
  subl $2, gc_roots_count(%rip)
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
  subq $160, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq %rcx, %rbx
  movq %rdx, -72(%rbp)
  movq $0, -120(%rbp)
  movq $0, -128(%rbp)
  movq $0, -136(%rbp)
  movq $0, -144(%rbp)
  movq $0, -152(%rbp)
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
  movl %eax, gc_roots_count(%rip)

.L_सूत्र_आवंटन__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call संरेखित16
  addq $32, %rsp
  movq %rax, %rdi
  movq %rdi, -120(%rbp)
  movq $16, %rbx
  movq %rbx, %r10
  addq %rdi, %r10
  movq %r10, -104(%rbp)
  subq $32, %rsp
  call मुक्त_तालिका_तैयार
  addq $32, %rsp
  movq %rax, %rbx
  movq sutra_glob_ऑटो_सक्षम(%rip), %r10
  movq %r10, %rbx
  movq $1, %r13
  movq %rbx, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_0
  jmp .L_सूत्र_आवंटन__if_सत्य_1
.L_किनारा_सूत्र_आवंटन_0:
  jmp .L_सूत्र_आवंटन__if_अंत_2
.L_सूत्र_आवंटन__if_सत्य_1:
  movq sutra_glob_जीसी_चालू(%rip), %r10
  movq %r10, %rbx
  movq $0, %r13
  movq %rbx, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_1
  jmp .L_सूत्र_आवंटन__if_सत्य_3
.L_किनारा_सूत्र_आवंटन_1:
  jmp .L_सूत्र_आवंटन__if_अंत_4
.L_सूत्र_आवंटन__if_सत्य_3:
  movq sutra_glob_जीसी_दबाव(%rip), %r10
  movq %r10, %rbx
  movq $0, %r13
  movq %rbx, %r10
  cmpq %r13, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_2
  jmp .L_सूत्र_आवंटन__if_सत्य_5
.L_किनारा_सूत्र_आवंटन_2:
  jmp .L_सूत्र_आवंटन__if_अंत_6
.L_सूत्र_आवंटन__if_सत्य_5:
  movq sutra_glob_आवंटित_बाइट्स(%rip), %r10
  movq %r10, %rbx
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %r13
  movq %rbx, %r10
  cmpq %r13, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_3
  jmp .L_सूत्र_आवंटन__if_सत्य_7
.L_किनारा_सूत्र_आवंटन_3:
  jmp .L_सूत्र_आवंटन__if_अंत_8
.L_सूत्र_आवंटन__if_सत्य_7:
  movq $1, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_जीसी_चालू(%rip)
  subq $32, %rsp
  call सूत्र_संग्रह
  addq $32, %rsp
  movq %rax, %rbx
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $0, %rbx
  movq %rbx, %r10
  movq %r10, sutra_glob_जीसी_चालू(%rip)
  jmp .L_सूत्र_आवंटन__if_अंत_8
.L_सूत्र_आवंटन__if_अंत_8:
  jmp .L_सूत्र_आवंटन__if_अंत_6
.L_सूत्र_आवंटन__if_अंत_6:
  jmp .L_सूत्र_आवंटन__if_अंत_4
.L_सूत्र_आवंटन__if_अंत_4:
  jmp .L_सूत्र_आवंटन__if_अंत_2
.L_सूत्र_आवंटन__if_अंत_2:
  movq %rdi, %rcx
  subq $32, %rsp
  call श्रेणी_का
  addq $32, %rsp
  movq %rax, -88(%rbp)
  movq -88(%rbp), %r11
  movq %r11, -128(%rbp)
  movq $0, %r13
  movq -88(%rbp), %r10
  cmpq %r13, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_4
  jmp .L_सूत्र_आवंटन__if_सत्य_9
.L_किनारा_सूत्र_आवंटन_4:
  jmp .L_सूत्र_आवंटन__if_असत्य_11
.L_सूत्र_आवंटन__if_असत्य_11:
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
  jmp .L_सूत्र_आवंटन__wh_शर्त_14
.L_सूत्र_आवंटन__wh_शर्त_14:
  movq %rsi, -136(%rbp)
  movq %r13, -144(%rbp)
  movq $0, %r14
  movq %r13, %r10
  cmpq %r14, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_5
  jmp .L_सूत्र_आवंटन__wh_देह_15
.L_किनारा_सूत्र_आवंटन_5:
  jmp .L_सूत्र_आवंटन__wh_अंत_16
.L_सूत्र_आवंटन__wh_अंत_16:
  jmp .L_सूत्र_आवंटन__if_अंत_10
.L_सूत्र_आवंटन__wh_देह_15:
  movq $8, %r14
  movq %r13, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r15
  movq $16, %r14
  movq %r13, %r10
  movq %r14, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %r15, %r10
  cmpq %rdi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_6
  jmp .L_सूत्र_आवंटन__if_सत्य_17
.L_किनारा_सूत्र_आवंटन_6:
  jmp .L_सूत्र_आवंटन__if_अंत_18
.L_सूत्र_आवंटन__if_अंत_18:
  movq %r13, %rsi
  movq %rbx, %r13
  jmp .L_सूत्र_आवंटन__wh_शर्त_14
.L_सूत्र_आवंटन__if_सत्य_17:
  movq $0, %r14
  movq %rsi, %r10
  cmpq %r14, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_7
  jmp .L_सूत्र_आवंटन__if_सत्य_19
.L_किनारा_सूत्र_आवंटन_7:
  jmp .L_सूत्र_आवंटन__if_असत्य_21
.L_सूत्र_आवंटन__if_असत्य_21:
  movq $16, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r14
  movq $0, -136(%rbp)
  jmp .L_सूत्र_आवंटन__if_अंत_20
.L_सूत्र_आवंटन__if_सत्य_19:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rsi
  movq $0, %r12
  movq %rsi, %r10
  movq %r12, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r14
  jmp .L_सूत्र_आवंटन__if_अंत_20
.L_सूत्र_आवंटन__if_अंत_20:
  movq $0, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rsi
  movq $16, %rbx
  movq %r13, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %rcx
  movq %r15, %rdx
  subq $32, %rsp
  call शून्य_भरो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq %r13, %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq $0, -144(%rbp)
  movq %rsi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_सूत्र_आवंटन__if_सत्य_9:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rbx
  movq $8, %rsi
  movq -88(%rbp), %r10
  imulq %rsi, %r10
  movq %r10, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rsi
  movq $0, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_8
  jmp .L_सूत्र_आवंटन__if_सत्य_12
.L_किनारा_सूत्र_आवंटन_8:
  jmp .L_सूत्र_आवंटन__if_अंत_13
.L_सूत्र_आवंटन__if_अंत_13:
  jmp .L_सूत्र_आवंटन__if_अंत_10
.L_सूत्र_आवंटन__if_अंत_10:
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rbx
  movq $0, %r12
  movq %rbx, %r10
  cmpq %r12, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_आवंटन_9
  jmp .L_सूत्र_आवंटन__if_सत्य_22
.L_किनारा_सूत्र_आवंटन_9:
  jmp .L_सूत्र_आवंटन__if_अंत_23
.L_सूत्र_आवंटन__if_सत्य_22:
  movq -104(%rbp), %rcx
  subq $32, %rsp
  call नया_अखंड
  addq $32, %rsp
  movq %rax, %rbx
  jmp .L_सूत्र_आवंटन__if_अंत_23
.L_सूत्र_आवंटन__if_अंत_23:
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rbx
  movq $8, %r12
  movq %rbx, %r10
  movq %r12, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $16, %r12
  movq %rbx, %r10
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
  je .L_किनारा_सूत्र_आवंटन_10
  jmp .L_सूत्र_आवंटन__if_सत्य_24
.L_किनारा_सूत्र_आवंटन_10:
  movq %r13, %r12
  jmp .L_सूत्र_आवंटन__if_अंत_25
.L_सूत्र_आवंटन__if_सत्य_24:
  movq -104(%rbp), %rcx
  subq $32, %rsp
  call नया_अखंड
  addq $32, %rsp
  movq %rax, %rbx
  movq sutra_glob_अखंड_वर्तमान(%rip), %r10
  movq %r10, %rbx
  movq $0, %r12
  jmp .L_सूत्र_आवंटन__if_अंत_25
.L_सूत्र_आवंटन__if_अंत_25:
  movq %rbx, -152(%rbp)
  movq $32, %r13
  movq %rbx, %r10
  addq %r13, %r10
  movq %r10, %r14
  movq %r14, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq $8, %r14
  movq %r12, %r10
  addq -104(%rbp), %r10
  movq %r10, %r15
  movq %rbx, %r10
  movq %r14, %r11
  movq %r15, %r8
  movq %r8, (%r10,%r11)
  movq %r15, %r12
  movq $0, -152(%rbp)
  movq $0, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %r12
  movq $8, %rbx
  movq %r13, %r10
  movq %rbx, %r11
  movq %rdi, %r8
  movq %r8, (%r10,%r11)
  movq %rdi, %r12
  movq $0, -120(%rbp)
  movq sutra_glob_आवंटित_बाइट्स(%rip), %r10
  movq %r10, %rbx
  movq %rbx, %r10
  addq -104(%rbp), %r10
  movq %r10, %rdi
  movq %rdi, %r10
  movq %r10, sutra_glob_आवंटित_बाइट्स(%rip)
  movq $16, %rbx
  movq %r13, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_सूत्र_आवंटन__if_सत्य_12:
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rbx
  movq $8, %rdi
  movq -88(%rbp), %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq $0, -128(%rbp)
  movq $16, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq %rbx, %r10
  movq %r12, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %rdi
  movq $0, %rbx
  movq %rsi, %r10
  movq %rbx, %r11
  movq -72(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -72(%rbp), %rdi
  movq $16, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq $8, %rbx
  movq %rsi, %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq %rdi, %rcx
  movq %r12, %rdx
  subq $32, %rsp
  call शून्य_भरो
  addq $32, %rsp
  movq %rax, %rbx
  movq $16, %rbx
  movq %rsi, %r10
  addq %rbx, %r10
  movq %r10, %rdi
  movq %rdi, %rax
  jmp .L_epilogue_सूत्र_आवंटन
.L_epilogue_सूत्र_आवंटन:
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
  .globl सूत्र_मुक्त
  .def सूत्र_मुक्त; .scl 2; .type 32; .endef
सूत्र_मुक्त:
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

.L_सूत्र_मुक्त__प्रवेश_0:
  movq $0, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_मुक्त_0
  jmp .L_सूत्र_मुक्त__if_सत्य_1
.L_किनारा_सूत्र_मुक्त_0:
  jmp .L_सूत्र_मुक्त__if_अंत_2
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
  movq %rbx, -72(%rbp)
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
  movq $0, -72(%rbp)
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
  .globl सूत्र_पुनः_आवंटन
  .def सूत्र_पुनः_आवंटन; .scl 2; .type 32; .endef
सूत्र_पुनः_आवंटन:
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
  movq $0, -88(%rbp)
  movq $0, -96(%rbp)
  movq $0, -104(%rbp)
  movq $0, -112(%rbp)
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
  leaq -112(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

.L_सूत्र_पुनः_आवंटन__प्रवेश_0:
  movq $0, %rdi
  movq %rbx, %r10
  cmpq %rdi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_पुनः_आवंटन_0
  jmp .L_सूत्र_पुनः_आवंटन__if_सत्य_1
.L_किनारा_सूत्र_पुनः_आवंटन_0:
  jmp .L_सूत्र_पुनः_आवंटन__if_अंत_2
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
  movq %rdi, -88(%rbp)
  movq -72(%rbp), %r10
  cmpq %r13, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_पुनः_आवंटन_1
  jmp .L_सूत्र_पुनः_आवंटन__if_सत्य_3
.L_किनारा_सूत्र_पुनः_आवंटन_1:
  movq %r13, %r12
  jmp .L_सूत्र_पुनः_आवंटन__if_अंत_4
.L_सूत्र_पुनः_आवंटन__if_सत्य_3:
  movq -72(%rbp), %r12
  jmp .L_सूत्र_पुनः_आवंटन__if_अंत_4
.L_सूत्र_पुनः_आवंटन__if_अंत_4:
  movq %r12, -96(%rbp)
  movq $0, %r13
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_5
.L_सूत्र_पुनः_आवंटन__wh_शर्त_5:
  movq %r13, -104(%rbp)
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
  je .L_किनारा_सूत्र_पुनः_आवंटन_2
  jmp .L_सूत्र_पुनः_आवंटन__wh_देह_6
.L_किनारा_सूत्र_पुनः_आवंटन_2:
  jmp .L_सूत्र_पुनः_आवंटन__wh_अंत_7
.L_सूत्र_पुनः_आवंटन__wh_अंत_7:
  movq %r13, %r14
  jmp .L_सूत्र_पुनः_आवंटन__wh_शर्त_8
.L_सूत्र_पुनः_आवंटन__wh_शर्त_8:
  movq %r14, -112(%rbp)
  movq %r14, %r10
  cmpq %r12, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_पुनः_आवंटन_3
  jmp .L_सूत्र_पुनः_आवंटन__wh_देह_9
.L_किनारा_सूत्र_पुनः_आवंटन_3:
  jmp .L_सूत्र_पुनः_आवंटन__wh_अंत_10
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
  movq $0, -112(%rbp)
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
  movq $0, -104(%rbp)
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
  .globl अखंड_में_है
  .def अखंड_में_है; .scl 2; .type 32; .endef
अखंड_में_है:
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

.L_अखंड_में_है__प्रवेश_0:
  movq sutra_glob_अखंड_प्रथम(%rip), %r10
  movq %r10, %rsi
  jmp .L_अखंड_में_है__wh_शर्त_1
.L_अखंड_में_है__wh_शर्त_1:
  movq %rsi, -64(%rbp)
  movq $0, %rdi
  movq %rsi, %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_अखंड_में_है_0
  jmp .L_अखंड_में_है__wh_देह_2
.L_किनारा_अखंड_में_है_0:
  jmp .L_अखंड_में_है__wh_अंत_3
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
  je .L_किनारा_अखंड_में_है_1
  jmp .L_अखंड_में_है__sc_दायाँ_4
.L_किनारा_अखंड_में_है_1:
  jmp .L_अखंड_में_है__sc_लघु_5
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
  je .L_किनारा_अखंड_में_है_2
  jmp .L_अखंड_में_है__if_सत्य_7
.L_किनारा_अखंड_में_है_2:
  jmp .L_अखंड_में_है__if_अंत_8
.L_अखंड_में_है__if_अंत_8:
  movq $0, %rdi
  movq %rsi, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, -64(%rbp)
  movq %r12, %rsi
  jmp .L_अखंड_में_है__wh_शर्त_1
.L_अखंड_में_है__if_सत्य_7:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_अखंड_में_है
.L_epilogue_अखंड_में_है:
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
  je .L_किनारा_सूत्र_ब्लॉक_प्रकार_0
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_1
.L_किनारा_सूत्र_ब्लॉक_प्रकार_0:
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_अंत_2
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
  je .L_किनारा_सूत्र_ब्लॉक_प्रकार_1
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_3
.L_किनारा_सूत्र_ब्लॉक_प्रकार_1:
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_अंत_4
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
  je .L_किनारा_सूत्र_ब्लॉक_प्रकार_2
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_5
.L_किनारा_सूत्र_ब्लॉक_प्रकार_2:
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_अंत_6
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
  je .L_किनारा_सूत्र_ब्लॉक_प्रकार_3
  jmp .L_सूत्र_ब्लॉक_प्रकार__sc_लघु_8
.L_किनारा_सूत्र_ब्लॉक_प्रकार_3:
  jmp .L_सूत्र_ब्लॉक_प्रकार__sc_दायाँ_7
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
  je .L_किनारा_सूत्र_ब्लॉक_प्रकार_4
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_सत्य_10
.L_किनारा_सूत्र_ब्लॉक_प्रकार_4:
  jmp .L_सूत्र_ब्लॉक_प्रकार__if_अंत_11
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

.L_सूत्र_क्या_पाठ__प्रवेश_0:
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
  je .L_किनारा_सूत्र_क्या_पाठ_0
  jmp .L_सूत्र_क्या_पाठ__if_सत्य_1
.L_किनारा_सूत्र_क्या_पाठ_0:
  jmp .L_सूत्र_क्या_पाठ__if_अंत_2
.L_सूत्र_क्या_पाठ__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_सूत्र_क्या_पाठ__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_पाठ
.L_epilogue_सूत्र_क्या_पाठ:
  subl $1, gc_roots_count(%rip)
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

.L_सूत्र_क्या_सूची__प्रवेश_0:
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
  je .L_किनारा_सूत्र_क्या_सूची_0
  jmp .L_सूत्र_क्या_सूची__if_सत्य_1
.L_किनारा_सूत्र_क्या_सूची_0:
  jmp .L_सूत्र_क्या_सूची__if_अंत_2
.L_सूत्र_क्या_सूची__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_सूत्र_क्या_सूची__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_सूची
.L_epilogue_सूत्र_क्या_सूची:
  subl $1, gc_roots_count(%rip)
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

.L_सूत्र_क्या_वस्तु__प्रवेश_0:
  movq %rbx, %rcx
  subq $32, %rsp
  call सूत्र_ब्लॉक_प्रकार
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -48(%rbp)
  movq $3, %rbx
  movq %rsi, %rcx
  movq %rbx, %rdx
  subq $32, %rsp
  call पाठ_तुल्य
  addq $32, %rsp
  movq %rax, %rdi
  movq $0, -48(%rbp)
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_क्या_वस्तु_0
  jmp .L_सूत्र_क्या_वस्तु__if_सत्य_1
.L_किनारा_सूत्र_क्या_वस्तु_0:
  jmp .L_सूत्र_क्या_वस्तु__if_अंत_2
.L_सूत्र_क्या_वस्तु__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_सूत्र_क्या_वस्तु__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_वस्तु
.L_epilogue_सूत्र_क्या_वस्तु:
  subl $1, gc_roots_count(%rip)
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

.L_सूत्र_क्या_शब्दकोश__प्रवेश_0:
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
  je .L_किनारा_सूत्र_क्या_शब्दकोश_0
  jmp .L_सूत्र_क्या_शब्दकोश__if_सत्य_1
.L_किनारा_सूत्र_क्या_शब्दकोश_0:
  jmp .L_सूत्र_क्या_शब्दकोश__if_अंत_2
.L_सूत्र_क्या_शब्दकोश__if_अंत_2:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_सूत्र_क्या_शब्दकोश__if_सत्य_1:
  movq $1, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_क्या_शब्दकोश
.L_epilogue_सूत्र_क्या_शब्दकोश:
  subl $1, gc_roots_count(%rip)
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
  je .L_किनारा_चिह्नित_कच्चा_0
  jmp .L_चिह्नित_कच्चा__if_सत्य_1
.L_किनारा_चिह्नित_कच्चा_0:
  jmp .L_चिह्नित_कच्चा__if_अंत_2
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
  je .L_किनारा_चिह्नित_कच्चा_1
  jmp .L_चिह्नित_कच्चा__if_सत्य_3
.L_किनारा_चिह्नित_कच्चा_1:
  jmp .L_चिह्नित_कच्चा__if_अंत_4
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
  je .L_किनारा_चिह्नित_कच्चा_2
  jmp .L_चिह्नित_कच्चा__sc_लघु_6
.L_किनारा_चिह्नित_कच्चा_2:
  jmp .L_चिह्नित_कच्चा__sc_दायाँ_5
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
  je .L_किनारा_चिह्नित_कच्चा_3
  jmp .L_चिह्नित_कच्चा__if_सत्य_8
.L_किनारा_चिह्नित_कच्चा_3:
  jmp .L_चिह्नित_कच्चा__if_अंत_9
.L_चिह्नित_कच्चा__if_अंत_9:
  movq $256, %rbx
  movq %rsi, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_कच्चा_4
  jmp .L_चिह्नित_कच्चा__if_सत्य_10
.L_किनारा_चिह्नित_कच्चा_4:
  jmp .L_चिह्नित_कच्चा__if_अंत_11
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

.L_चिह्नित__प्रवेश_0:
  movq $65536, %rsi
  movq %rbx, %r10
  cmpq %rsi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_0
  jmp .L_चिह्नित__if_सत्य_1
.L_किनारा_चिह्नित_0:
  jmp .L_चिह्नित__if_अंत_2
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
  je .L_किनारा_चिह्नित_1
  jmp .L_चिह्नित__if_सत्य_3
.L_किनारा_चिह्नित_1:
  jmp .L_चिह्नित__if_अंत_4
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
  je .L_किनारा_चिह्नित_2
  jmp .L_चिह्नित__sc_लघु_6
.L_किनारा_चिह्नित_2:
  jmp .L_चिह्नित__sc_दायाँ_5
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
  je .L_किनारा_चिह्नित_3
  jmp .L_चिह्नित__if_सत्य_8
.L_किनारा_चिह्नित_3:
  jmp .L_चिह्नित__if_अंत_9
.L_चिह्नित__if_अंत_9:
  movq $256, %rsi
  movq %r12, %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_4
  jmp .L_चिह्नित__if_सत्य_10
.L_किनारा_चिह्नित_4:
  jmp .L_चिह्नित__if_अंत_11
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
  je .L_किनारा_चिह्नित_5
  jmp .L_चिह्नित__sc_लघु_13
.L_किनारा_चिह्नित_5:
  jmp .L_चिह्नित__sc_दायाँ_12
.L_चिह्नित__sc_दायाँ_12:
  movq $3, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %rsi
  jmp .L_चिह्नित__sc_अंत_14
.L_चिह्नित__sc_लघु_13:
  movq $1, %rsi
  jmp .L_चिह्नित__sc_अंत_14
.L_चिह्नित__sc_अंत_14:
  movq %rsi, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_6
  jmp .L_चिह्नित__if_सत्य_15
.L_किनारा_चिह्नित_6:
  jmp .L_चिह्नित__if_असत्य_17
.L_चिह्नित__if_असत्य_17:
  movq $4, %rsi
  movq %r13, %r10
  cmpq %rsi, %r10
  sete %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_7
  jmp .L_चिह्नित__if_सत्य_21
.L_किनारा_चिह्नित_7:
  jmp .L_चिह्नित__if_अंत_22
.L_चिह्नित__if_सत्य_21:
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
  je .L_किनारा_चिह्नित_8
  jmp .L_चिह्नित__if_सत्य_23
.L_किनारा_चिह्नित_8:
  jmp .L_चिह्नित__if_अंत_24
.L_चिह्नित__if_सत्य_23:
  movq %r12, %rcx
  subq $32, %rsp
  call चिह्नित_कच्चा
  addq $32, %rsp
  movq %rax, %rsi
  movq $0, %rsi
  jmp .L_चिह्नित__wh_शर्त_25
.L_चिह्नित__wh_शर्त_25:
  movq %rsi, -80(%rbp)
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_9
  jmp .L_चिह्नित__wh_देह_26
.L_किनारा_चिह्नित_9:
  jmp .L_चिह्नित__wh_अंत_27
.L_चिह्नित__wh_अंत_27:
  jmp .L_चिह्नित__if_अंत_24
.L_चिह्नित__if_अंत_24:
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
  je .L_किनारा_चिह्नित_10
  jmp .L_चिह्नित__if_सत्य_28
.L_किनारा_चिह्नित_10:
  jmp .L_चिह्नित__if_अंत_29
.L_चिह्नित__if_सत्य_28:
  movq %r14, %rcx
  subq $32, %rsp
  call चिह्नित_कच्चा
  addq $32, %rsp
  movq %rax, %r13
  jmp .L_चिह्नित__if_अंत_29
.L_चिह्नित__if_अंत_29:
  jmp .L_चिह्नित__if_अंत_22
.L_चिह्नित__if_अंत_22:
  jmp .L_चिह्नित__if_अंत_16
.L_चिह्नित__wh_देह_26:
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
  movq $0, -80(%rbp)
  movq %r14, %rsi
  jmp .L_चिह्नित__wh_शर्त_25
.L_चिह्नित__if_सत्य_15:
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rdi
  movq $0, %rsi
  jmp .L_चिह्नित__wh_शर्त_18
.L_चिह्नित__wh_शर्त_18:
  movq %rsi, -88(%rbp)
  movq %rsi, %r10
  cmpq %rdi, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_चिह्नित_11
  jmp .L_चिह्नित__wh_देह_19
.L_किनारा_चिह्नित_11:
  jmp .L_चिह्नित__wh_अंत_20
.L_चिह्नित__wh_अंत_20:
  jmp .L_चिह्नित__if_अंत_16
.L_चिह्नित__if_अंत_16:
  movq $0, %r12
  movq %r12, %rax
  jmp .L_epilogue_चिह्नित
.L_चिह्नित__wh_देह_19:
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
  movq $0, -88(%rbp)
  movq %r13, %rsi
  jmp .L_चिह्नित__wh_शर्त_18
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
  .globl सूत्र_संग्रह
  .def सूत्र_संग्रह; .scl 2; .type 32; .endef
सूत्र_संग्रह:
  pushq %rbp
  movq %rsp, %rbp
  subq $656, %rsp
  movq %rbx, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdi, -24(%rbp)
  movq %r12, -32(%rbp)
  movq %r13, -40(%rbp)
  movq %r14, -48(%rbp)
  movq %r15, -56(%rbp)
  movq $0, -440(%rbp)
  movq $0, -448(%rbp)
  movq $0, -456(%rbp)
  movq $0, -464(%rbp)
  movq $0, -472(%rbp)
  movq $0, -480(%rbp)
  movq $0, -488(%rbp)
  movq $0, -496(%rbp)
  movq $0, -504(%rbp)
  movq $0, -512(%rbp)
  movq $0, -520(%rbp)
  movq $0, -528(%rbp)
  movq $0, -536(%rbp)
  movq $0, -544(%rbp)
  movq $0, -552(%rbp)
  movq $0, -560(%rbp)
  movq $0, -568(%rbp)
  movq $0, -576(%rbp)
  movq $0, -584(%rbp)
  movq $0, -592(%rbp)
  movq $0, -600(%rbp)
  movq $0, -608(%rbp)
  movq $0, -616(%rbp)
  movq $0, -624(%rbp)
  movq $0, -632(%rbp)
  movq $0, -640(%rbp)
  movl gc_roots_count(%rip), %eax
  leaq gc_roots(%rip), %r10
  leaq -440(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -448(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -456(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -464(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -472(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -480(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -488(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -496(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -504(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -512(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -520(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -528(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -536(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -544(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -552(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -560(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -568(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -576(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -584(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -592(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -600(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -608(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -616(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -624(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -632(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  leaq -640(%rbp), %r11
  movq %r11, (%r10,%rax,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)

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
  movq -72(%rbp), %r11
  movq %r11, -448(%rbp)
  movq $0, %rdi
  movq -72(%rbp), %r10
  cmpq %rdi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r12
  movq %r12, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_0
  jmp .L_सूत्र_संग्रह__wh_देह_2
.L_किनारा_सूत्र_संग्रह_0:
  jmp .L_सूत्र_संग्रह__wh_अंत_3
.L_सूत्र_संग्रह__wh_अंत_3:
  subq $32, %rsp
  call sutra_gc_root_count
  addq $32, %rsp
  movq %rax, -104(%rbp)
  movq $0, %r12
  movq %r12, -120(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_7
.L_सूत्र_संग्रह__wh_शर्त_7:
  movq -120(%rbp), %r11
  movq %r11, -456(%rbp)
  movq -120(%rbp), %r10
  cmpq -104(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_1
  jmp .L_सूत्र_संग्रह__wh_देह_8
.L_किनारा_सूत्र_संग्रह_1:
  jmp .L_सूत्र_संग्रह__wh_अंत_9
.L_सूत्र_संग्रह__wh_अंत_9:
  subq $32, %rsp
  call sutra_gc_active_exc
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
  movq -328(%rbp), %r11
  movq %r11, -152(%rbp)
  movq -312(%rbp), %r11
  movq %r11, -168(%rbp)
  movq -296(%rbp), %rsi
  movq -280(%rbp), %r15
  movq -264(%rbp), %r14
  movq %r13, -136(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_10
.L_सूत्र_संग्रह__wh_शर्त_10:
  movq -136(%rbp), %r11
  movq %r11, -464(%rbp)
  movq %r14, -472(%rbp)
  movq %r15, -480(%rbp)
  movq %rsi, -488(%rbp)
  movq -168(%rbp), %r11
  movq %r11, -496(%rbp)
  movq -152(%rbp), %r11
  movq %r11, -504(%rbp)
  movq $0, %r12
  movq -136(%rbp), %r10
  cmpq %r12, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r13
  movq %r13, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_2
  jmp .L_सूत्र_संग्रह__wh_देह_11
.L_किनारा_सूत्र_संग्रह_2:
  jmp .L_सूत्र_संग्रह__wh_अंत_12
.L_सूत्र_संग्रह__wh_अंत_12:
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, %r12
  movq %r12, %r10
  subq -88(%rbp), %r10
  movq %r10, %r13
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %r12
  movq $4, %rdi
  movq %r12, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rax, %rbx
  movq %r13, %r10
  cmpq %rbx, %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_3
  jmp .L_सूत्र_संग्रह__if_सत्य_21
.L_किनारा_सूत्र_संग्रह_3:
  jmp .L_सूत्र_संग्रह__if_अंत_22
.L_सूत्र_संग्रह__if_सत्य_21:
  movq sutra_glob_जीसी_सीमा(%rip), %r10
  movq %r10, %rbx
  movq $2, %rdi
  movq %rbx, %r10
  imulq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_जीसी_सीमा(%rip)
  jmp .L_सूत्र_संग्रह__if_अंत_22
.L_सूत्र_संग्रह__if_अंत_22:
  movq $0, %rbx
  movq %rbx, %rax
  jmp .L_epilogue_सूत्र_संग्रह
.L_सूत्र_संग्रह__wh_देह_11:
  movq $8, %rbx
  movq -136(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, -184(%rbp)
  movq $0, %rbx
  movq %rsi, %r13
  movq %r15, %r12
  movq -152(%rbp), %r15
  movq %r14, %rsi
  movq -168(%rbp), %r14
  movq %rbx, -200(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_13
.L_सूत्र_संग्रह__wh_शर्त_13:
  movq -200(%rbp), %r11
  movq %r11, -512(%rbp)
  movq %rsi, -520(%rbp)
  movq %r12, -528(%rbp)
  movq %r13, -536(%rbp)
  movq %r14, -544(%rbp)
  movq %r15, -552(%rbp)
  movq -200(%rbp), %r10
  cmpq -184(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %rdi
  movq %rdi, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_4
  jmp .L_सूत्र_संग्रह__wh_देह_14
.L_किनारा_सूत्र_संग्रह_4:
  jmp .L_सूत्र_संग्रह__wh_अंत_15
.L_सूत्र_संग्रह__wh_अंत_15:
  movq $0, %rdi
  movq -136(%rbp), %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %rbx
  movq %r15, -152(%rbp)
  movq %r14, -168(%rbp)
  movq %r12, %r15
  movq %rsi, %r14
  movq %r13, %rsi
  movq %rbx, -136(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_10
.L_सूत्र_संग्रह__wh_देह_14:
  movq $32, %rbx
  movq -136(%rbp), %r10
  addq %rbx, %r10
  movq %r10, %rsi
  movq %rsi, %r10
  addq -200(%rbp), %r10
  movq %r10, %rbx
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -248(%rbp)
  movq $8, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq (%r10,%r11), %r10
  movq %r10, -232(%rbp)
  movq $256, %rsi
  movq -248(%rbp), %rax
  movq %rsi, %r10
  cqto
  idivq %r10
  movq %rdx, -216(%rbp)
  movq $0, %rsi
  movq -216(%rbp), %r10
  cmpq %rsi, %r10
  setne %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_5
  jmp .L_सूत्र_संग्रह__if_सत्य_16
.L_किनारा_सूत्र_संग्रह_5:
  movq %r15, %rsi
  jmp .L_सूत्र_संग्रह__if_अंत_17
.L_सूत्र_संग्रह__if_सत्य_16:
  movq $256, %rsi
  movq -248(%rbp), %r10
  cmpq %rsi, %r10
  setge %al
  movzbq %al, %r10
  movq %r10, %r14
  movq %r14, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_6
  jmp .L_सूत्र_संग्रह__if_सत्य_18
.L_किनारा_सूत्र_संग्रह_6:
  jmp .L_सूत्र_संग्रह__if_असत्य_20
.L_सूत्र_संग्रह__if_असत्य_20:
  movq -232(%rbp), %rcx
  subq $32, %rsp
  call श्रेणी_का
  addq $32, %rsp
  movq %rax, %rsi
  movq %rsi, -440(%rbp)
  movq $0, %r14
  movq $0, %r13
  movq %rbx, %r10
  movq %r14, %r11
  movq %r13, %r8
  movq %r8, (%r10,%r11)
  movq %r13, %r12
  movq $16, %r12
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %r13
  movq $8, %r14
  movq %rsi, %r10
  imulq %r14, %r10
  movq %r10, %rdi
  movq %r13, %r10
  movq %rdi, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %rbx, %r10
  movq %r12, %r11
  movq %r14, %r8
  movq %r8, (%r10,%r11)
  movq %r14, %rdi
  movq sutra_glob_मुक्त_तालिका(%rip), %r10
  movq %r10, %rdi
  movq $8, %r12
  movq %rsi, %r10
  imulq %r12, %r10
  movq %r10, %r13
  movq %rdi, %r10
  movq %r13, %r11
  movq %rbx, %r8
  movq %r8, (%r10,%r11)
  movq %rbx, %r12
  movq sutra_glob_गण_संग्रहित(%rip), %r10
  movq %r10, %rdi
  movq $1, %r12
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %r13
  movq %r13, %r10
  movq %r10, sutra_glob_गण_संग्रहित(%rip)
  movq sutra_glob_गण_पुनःप्राप्त(%rip), %r10
  movq %r10, %rdi
  movq %rdi, %r10
  addq -232(%rbp), %r10
  movq %r10, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_गण_पुनःप्राप्त(%rip)
  jmp .L_सूत्र_संग्रह__if_अंत_19
.L_सूत्र_संग्रह__if_सत्य_18:
  movq $0, %rsi
  movq %rbx, %r10
  movq %rsi, %r11
  movq -216(%rbp), %r8
  movq %r8, (%r10,%r11)
  movq -216(%rbp), %rdi
  movq sutra_glob_गण_सक्रिय(%rip), %r10
  movq %r10, %rsi
  movq $1, %rdi
  movq %rsi, %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq %r12, %r10
  movq %r10, sutra_glob_गण_सक्रिय(%rip)
  movq %r15, %rsi
  jmp .L_सूत्र_संग्रह__if_अंत_19
.L_सूत्र_संग्रह__if_अंत_19:
  jmp .L_सूत्र_संग्रह__if_अंत_17
.L_सूत्र_संग्रह__if_अंत_17:
  movq $16, %rdi
  movq -200(%rbp), %r10
  addq %rdi, %r10
  movq %r10, %r12
  movq $0, -512(%rbp)
  movq %r12, %r10
  addq -232(%rbp), %r10
  movq %r10, %rdi
  movq %rsi, %r15
  movq -216(%rbp), %r14
  movq -232(%rbp), %r13
  movq -248(%rbp), %r12
  movq %rbx, %rsi
  movq %rdi, -200(%rbp)
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
  movq $0, -456(%rbp)
  movq %rsi, -120(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_7
.L_सूत्र_संग्रह__wh_देह_2:
  movq $8, %rbx
  movq -72(%rbp), %r10
  movq %rbx, %r11
  movq (%r10,%r11), %r10
  movq %r10, -424(%rbp)
  movq $0, %rbx
  jmp .L_सूत्र_संग्रह__wh_शर्त_4
.L_सूत्र_संग्रह__wh_शर्त_4:
  movq %rbx, -560(%rbp)
  movq -408(%rbp), %r11
  movq %r11, -568(%rbp)
  movq -392(%rbp), %r11
  movq %r11, -576(%rbp)
  movq -376(%rbp), %r11
  movq %r11, -584(%rbp)
  movq -360(%rbp), %r11
  movq %r11, -592(%rbp)
  movq -344(%rbp), %r11
  movq %r11, -600(%rbp)
  movq -264(%rbp), %r11
  movq %r11, -608(%rbp)
  movq -280(%rbp), %r11
  movq %r11, -616(%rbp)
  movq -296(%rbp), %r11
  movq %r11, -624(%rbp)
  movq -312(%rbp), %r11
  movq %r11, -632(%rbp)
  movq -328(%rbp), %r11
  movq %r11, -640(%rbp)
  movq %rbx, %r10
  cmpq -424(%rbp), %r10
  setl %al
  movzbq %al, %r10
  movq %r10, %r15
  movq %r15, %r10
  cmpq $0, %r10
  je .L_किनारा_सूत्र_संग्रह_7
  jmp .L_सूत्र_संग्रह__wh_देह_5
.L_किनारा_सूत्र_संग्रह_7:
  jmp .L_सूत्र_संग्रह__wh_अंत_6
.L_सूत्र_संग्रह__wh_अंत_6:
  movq $0, %r15
  movq -72(%rbp), %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r14
  movq %r14, -72(%rbp)
  jmp .L_सूत्र_संग्रह__wh_शर्त_1
.L_सूत्र_संग्रह__wh_देह_5:
  movq $32, %r14
  movq -72(%rbp), %r10
  addq %r14, %r10
  movq %r10, %r15
  movq %r15, %r10
  addq %rbx, %r10
  movq %r10, %r14
  movq $0, %r15
  movq %r14, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r13
  movq $8, %r15
  movq %r14, %r10
  movq %r15, %r11
  movq (%r10,%r11), %r10
  movq %r10, %r12
  movq $0, %r15
  movq $256, %rdi
  movq %r13, %rax
  movq %rdi, %r10
  cqto
  idivq %r10
  movq %rdx, %rsi
  movq %r14, %r10
  movq %r15, %r11
  movq %rsi, %r8
  movq %r8, (%r10,%r11)
  movq %rsi, %rdi
  movq $16, %rsi
  movq %rbx, %r10
  addq %rsi, %r10
  movq %r10, %rdi
  movq $0, -560(%rbp)
  movq %rdi, %r10
  addq %r12, %r10
  movq %r10, %rbx
  jmp .L_सूत्र_संग्रह__wh_शर्त_4
.L_epilogue_सूत्र_संग्रह:
  subl $26, gc_roots_count(%rip)
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

