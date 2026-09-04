/* तल.s — सूत्र OS-तल (हाथ से लिखा, कोई C नहीं)
 * ============================================================
 * kernel32 के सीधे wrappers। यही वह न्यूनतम परत है जिसके नीचे
 * Windows पर कुछ नहीं — कोई stable syscall ABI नहीं है।
 *
 *   सूत्र_तल_आवंटन(rcx = बाइट्स)          -> rax = पता     [VirtualAlloc]
 *   सूत्र_तल_मुक्त(rcx = पता)              -> void          [VirtualFree]
 *   सूत्र_तल_मुद्रण(rcx = पता, rdx = लंबाई) -> void          [GetStdHandle + WriteFile]
 *   सूत्र_तल_निकास(rcx = कोड)              -> कभी नहीं लौटता  [ExitProcess]
 *   memcpy / memmove / memset / memcmp / strlen — हाथ से (libc-मुक्त)
 *   _setjmp(rcx=env,rdx=frame) / सूत्र_दीर्घकूद(rcx=env,rdx=roots) — न्यूनतम, no-SEH
 *   gc_roots[] + gc_roots_count (.bss) + sutra_gc_push_root/pop_root/
 *     root_count/root_deref — GC रूट-स्टैक (Sutra संग्राहक इन्हें पढ़ता)
 *   सूत्र_तल_{यूटीएफ_चौड़ा,चौड़ा_यूटीएफ,सञ्चिका_*,पढ़ो,लिखो,हैंडल_बंद,
 *     समादेश_रेखा,समादेश_विभाजन,स्थानीय_मुक्त,समादेश} — सञ्चिका I/O + तर्क
 *     + प्रक्रिया (kernel32/shell32; रचना मूल_रनटाइम.सूत्र में)
 *
 * Windows x64 ABI: तर्क rcx,rdx,r8,r9; 32-बाइट shadow; call पर rsp 16-संरेखित।
 * callee-preserved: rbx rbp rdi rsi rsp r12-r15.
 * ============================================================ */
  .text

  .globl सूत्र_तल_आवंटन
  .def सूत्र_तल_आवंटन; .scl 2; .type 32; .endef
सूत्र_तल_आवंटन:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp            /* shadow; entry rsp≡8 → +push rbp ≡0 → -32 ≡0 */
  movq %rcx, %rdx           /* dwSize */
  xorq %rcx, %rcx           /* lpAddress = NULL */
  movq $0x3000, %r8         /* MEM_COMMIT | MEM_RESERVE */
  movq $0x04, %r9           /* PAGE_READWRITE */
  call VirtualAlloc
  addq $32, %rsp
  popq %rbp
  ret

  .globl सूत्र_तल_मुक्त
  .def सूत्र_तल_मुक्त; .scl 2; .type 32; .endef
सूत्र_तल_मुक्त:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  xorq %rdx, %rdx           /* dwSize = 0 (MEM_RELEASE के साथ आवश्यक) */
  movq $0x8000, %r8         /* MEM_RELEASE */
  call VirtualFree
  addq $32, %rsp
  popq %rbp
  ret

  .globl सूत्र_तल_मुद्रण
  .def सूत्र_तल_मुद्रण; .scl 2; .type 32; .endef
सूत्र_तल_मुद्रण:
  pushq %rbp
  movq %rsp, %rbp
  pushq %rsi
  pushq %rdi               /* entry≡8 → rbp≡0 → rsi≡8 → rdi≡0 */
  movq %rcx, %rsi          /* पता  */
  movq %rdx, %rdi          /* लंबाई */
  movq $-11, %rcx          /* STD_OUTPUT_HANDLE */
  subq $32, %rsp
  call GetStdHandle        /* rax = handle */
  addq $32, %rsp
  subq $48, %rsp           /* 32 shadow + 8 bytesWritten(@40) + 8 for 5th arg(@32) */
  movq %rax, %rcx          /* hFile */
  movq %rsi, %rdx          /* lpBuffer */
  movq %rdi, %r8           /* nNumberOfBytesToWrite */
  leaq 40(%rsp), %r9       /* lpNumberOfBytesWritten (scratch) */
  movq $0, 32(%rsp)        /* lpOverlapped = NULL */
  call WriteFile
  addq $48, %rsp
  popq %rdi
  popq %rsi
  popq %rbp
  ret

  .globl सूत्र_तल_त्रुटि
  .def सूत्र_तल_त्रुटि; .scl 2; .type 32; .endef
सूत्र_तल_त्रुटि:                /* (rcx=पता, rdx=लंबाई) → stderr WriteFile */
  pushq %rbp
  movq %rsp, %rbp
  pushq %rsi
  pushq %rdi
  movq %rcx, %rsi
  movq %rdx, %rdi
  movq $-12, %rcx           /* STD_ERROR_HANDLE */
  subq $32, %rsp
  call GetStdHandle
  addq $32, %rsp
  subq $48, %rsp
  movq %rax, %rcx
  movq %rsi, %rdx
  movq %rdi, %r8
  leaq 40(%rsp), %r9
  movq $0, 32(%rsp)
  call WriteFile
  addq $48, %rsp
  popq %rdi
  popq %rsi
  popq %rbp
  ret

  .globl सूत्र_तल_निकास
  .def सूत्र_तल_निकास; .scl 2; .type 32; .endef
सूत्र_तल_निकास:
  subq $40, %rsp            /* entry≡8 → -40 ≡0 for call */
  call ExitProcess          /* नहीं लौटता */
  addq $40, %rsp
  ret

/* ============================================================
 * स्मृति-प्रचालन — हाथ से (gcc का loop-idiom-recognition asm को नहीं छूता)
 * Win64 ABI: तर्क rcx,rdx,r8 ; rdi/rsi callee-saved → push/pop
 * यही libc का memcpy/memset/memcmp/strlen replace करते।
 * ============================================================ */

  .globl memcpy
  .def memcpy; .scl 2; .type 32; .endef
memcpy:
  movq %rcx, %rax          /* लौटाओ = गंतव्य */
  pushq %rdi
  pushq %rsi
  movq %rcx, %rdi
  movq %rdx, %rsi
  movq %r8, %rcx
  cld
  rep movsb
  popq %rsi
  popq %rdi
  ret

  .globl memmove
  .def memmove; .scl 2; .type 32; .endef
memmove:
  movq %rcx, %rax
  pushq %rdi
  pushq %rsi
  movq %rcx, %rdi
  movq %rdx, %rsi
  movq %r8, %rcx
  cmpq %rsi, %rdi
  jbe .Lmm_fwd
  /* गंतव्य > स्रोत → पीछे से copy (overlap-सुरक्षित) */
  leaq -1(%rdi,%rcx), %rdi
  leaq -1(%rsi,%rcx), %rsi
  std
  rep movsb
  cld
  jmp .Lmm_done
.Lmm_fwd:
  cld
  rep movsb
.Lmm_done:
  popq %rsi
  popq %rdi
  ret

  .globl memset
  .def memset; .scl 2; .type 32; .endef
memset:
  movq %rcx, %r9           /* गंतव्य सहेजो (लौटाना है) */
  pushq %rdi
  movq %rcx, %rdi
  movl %edx, %eax          /* भरण-बाइट al में */
  movq %r8, %rcx
  cld
  rep stosb
  movq %r9, %rax
  popq %rdi
  ret

  .globl memcmp
  .def memcmp; .scl 2; .type 32; .endef
memcmp:
  pushq %rdi
  pushq %rsi
  movq %rcx, %rsi
  movq %rdx, %rdi
  movq %r8, %rcx
  xorl %eax, %eax
  testq %rcx, %rcx
  jz .Lmemcmp_done
  cld
  repe cmpsb
  je .Lmemcmp_done
  movzbl -1(%rsi), %eax
  movzbl -1(%rdi), %edx
  subl %edx, %eax
.Lmemcmp_done:
  popq %rsi
  popq %rdi
  ret

  .globl strlen
  .def strlen; .scl 2; .type 32; .endef
strlen:
  movq %rcx, %rax
.Lstrlen_loop:
  cmpb $0, (%rax)
  je .Lstrlen_done
  incq %rax
  jmp .Lstrlen_loop
.Lstrlen_done:
  subq %rcx, %rax
  ret

/* ============================================================
 * _setjmp / सूत्र_दीर्घकूद — न्यूनतम (कोई SEH unwind)। jmp_buf विन्यास:
 *   0  ret-addr   8  rsp(post-ret)
 *   16 rbx  24 rbp  32 rsi  40 rdi  48 r12  56 r13  64 r14  72 r15
 *   80..224  xmm6..xmm15  (16 बाइट प्रत्येक)
 * rcx = jmp_buf ; _setjmp का rdx (frame) अनदेखा (0 = non-SEH)।
 * leaf कार्य — कोई shadow/alignment चिंता नहीं। %r10 volatile scratch।
 * ============================================================ */

  .globl _setjmp
  .def _setjmp; .scl 2; .type 32; .endef
_setjmp:
  movq (%rsp), %r10
  movq %r10, 0(%rcx)
  leaq 8(%rsp), %r10
  movq %r10, 8(%rcx)
  movq %rbx, 16(%rcx)
  movq %rbp, 24(%rcx)
  movq %rsi, 32(%rcx)
  movq %rdi, 40(%rcx)
  movq %r12, 48(%rcx)
  movq %r13, 56(%rcx)
  movq %r14, 64(%rcx)
  movq %r15, 72(%rcx)
  movups %xmm6, 80(%rcx)
  movups %xmm7, 96(%rcx)
  movups %xmm8, 112(%rcx)
  movups %xmm9, 128(%rcx)
  movups %xmm10, 144(%rcx)
  movups %xmm11, 160(%rcx)
  movups %xmm12, 176(%rcx)
  movups %xmm13, 192(%rcx)
  movups %xmm14, 208(%rcx)
  movups %xmm15, 224(%rcx)
  xorl %eax, %eax
  ret

/* सूत्र_दीर्घकूद(rcx = env, rdx = gc_roots snapshot) — फेंको से बुलाया।
 * gc_roots_count बहाल करता (longjmp reg-restore नहीं करता), setjmp को 1
 * लौटाता, फिर regs/rsp/ret-addr बहाल कर catch-बिंदु पर कूदता। val सदा 1। */
  .globl सूत्र_दीर्घकूद
  .def सूत्र_दीर्घकूद; .scl 2; .type 32; .endef
सूत्र_दीर्घकूद:
  movl %edx, gc_roots_count(%rip)
  movl $1, %eax
  movq 16(%rcx), %rbx
  movq 24(%rcx), %rbp
  movq 32(%rcx), %rsi
  movq 40(%rcx), %rdi
  movq 48(%rcx), %r12
  movq 56(%rcx), %r13
  movq 64(%rcx), %r14
  movq 72(%rcx), %r15
  movups 80(%rcx), %xmm6
  movups 96(%rcx), %xmm7
  movups 112(%rcx), %xmm8
  movups 128(%rcx), %xmm9
  movups 144(%rcx), %xmm10
  movups 160(%rcx), %xmm11
  movups 176(%rcx), %xmm12
  movups 192(%rcx), %xmm13
  movups 208(%rcx), %xmm14
  movups 224(%rcx), %xmm15
  movq 0(%rcx), %r10
  movq 8(%rcx), %rsp
  jmp *%r10

/* ============================================================
 * float (दशमलव) SSE प्रचालन — पूर्व sutra_runtime.c के __asm__ blob में।
 * bits int64 में आते-जाते (rcx,rdx → xmm ; rax ← xmm)। कोई libm।
 * बाहरी: भाजन_शून्य_फेंको (मूल_रनटाइम.सूत्र) — link पर resolve।
 * ============================================================ */
  .text

  .globl sutra_float_add
  .def sutra_float_add; .scl 2; .type 32; .endef
sutra_float_add:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  addsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_sub
  .def sutra_float_sub; .scl 2; .type 32; .endef
sutra_float_sub:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  subsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_mul
  .def sutra_float_mul; .scl 2; .type 32; .endef
sutra_float_mul:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  mulsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_div
  .def sutra_float_div; .scl 2; .type 32; .endef
sutra_float_div:
  movq %rdx, %xmm1
  xorpd %xmm2, %xmm2
  ucomisd %xmm2, %xmm1
  jne .Lfdiv_ok
  jp .Lfdiv_ok
  subq $40, %rsp
  call भाजन_शून्य_फेंको        /* मूल_रनटाइम.सूत्र (पूर्व C sutra_throw_div_by_zero) */
  addq $40, %rsp
.Lfdiv_ok:
  movq %rcx, %xmm0
  divsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_eq
  .def sutra_float_eq; .scl 2; .type 32; .endef
sutra_float_eq:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  sete %al
  setnp %cl
  andb %cl, %al
  movzbq %al, %rax
  ret

  .globl sutra_float_ne
  .def sutra_float_ne; .scl 2; .type 32; .endef
sutra_float_ne:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  setne %al
  setp %cl
  orb %cl, %al
  movzbq %al, %rax
  ret

  .globl sutra_float_lt
  .def sutra_float_lt; .scl 2; .type 32; .endef
sutra_float_lt:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm0, %xmm1
  seta %al
  movzbq %al, %rax
  ret

  .globl sutra_float_gt
  .def sutra_float_gt; .scl 2; .type 32; .endef
sutra_float_gt:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  seta %al
  movzbq %al, %rax
  ret

  .globl sutra_float_le
  .def sutra_float_le; .scl 2; .type 32; .endef
sutra_float_le:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm0, %xmm1
  setae %al
  movzbq %al, %rax
  ret

  .globl sutra_float_ge
  .def sutra_float_ge; .scl 2; .type 32; .endef
sutra_float_ge:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  ucomisd %xmm1, %xmm0
  setae %al
  movzbq %al, %rax
  ret

  .globl sutra_int_to_float
  .def sutra_int_to_float; .scl 2; .type 32; .endef
sutra_int_to_float:
  cvtsi2sdq %rcx, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_float_to_int
  .def sutra_float_to_int; .scl 2; .type 32; .endef
sutra_float_to_int:
  movq %rcx, %xmm0
  cvttsd2siq %xmm0, %rax
  ret

  .globl sutra_math_sqrt_f
  .def sutra_math_sqrt_f; .scl 2; .type 32; .endef
sutra_math_sqrt_f:
  movq %rcx, %xmm0
  sqrtsd %xmm0, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_math_abs_f
  .def sutra_math_abs_f; .scl 2; .type 32; .endef
sutra_math_abs_f:
  movq %rcx, %rax
  btrq $63, %rax
  ret

  .globl sutra_math_min_f
  .def sutra_math_min_f; .scl 2; .type 32; .endef
sutra_math_min_f:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  minsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  .globl sutra_math_max_f
  .def sutra_math_max_f; .scl 2; .type 32; .endef
sutra_math_max_f:
  movq %rcx, %xmm0
  movq %rdx, %xmm1
  maxsd %xmm1, %xmm0
  movq %xmm0, %rax
  ret

  /* गोल: half-away-from-zero (llround जैसा) = trunc(x + copysign(0.5,x)) */
  .globl sutra_math_round_f
  .def sutra_math_round_f; .scl 2; .type 32; .endef
sutra_math_round_f:
  movq %rcx, %xmm0
  movq %rcx, %rax
  movabsq $0x8000000000000000, %rdx
  andq %rdx, %rax
  movabsq $0x3FE0000000000000, %rdx
  orq %rdx, %rax
  movq %rax, %xmm1
  addsd %xmm1, %xmm0
  cvttsd2siq %xmm0, %rax
  ret

  .globl sutra_math_sqrt
  .def sutra_math_sqrt; .scl 2; .type 32; .endef
sutra_math_sqrt:
  cvtsi2sdq %rcx, %xmm0
  sqrtsd %xmm0, %xmm0
  movabsq $0x3FE0000000000000, %rax
  movq %rax, %xmm1
  addsd %xmm1, %xmm0
  cvttsd2siq %xmm0, %rax
  ret

  .globl sutra_gc_push_root
  .def sutra_gc_push_root; .scl 2; .type 32; .endef
sutra_gc_push_root:
  movl gc_roots_count(%rip), %eax
  cmpl $1000000, %eax
  jge .Lgc_push_overflow
  leaq gc_roots(%rip), %rdx
  movslq %eax, %r8
  movq %rcx, (%rdx,%r8,8)
  incl %eax
  movl %eax, gc_roots_count(%rip)
  ret
.Lgc_push_overflow:
  movl $1, %ecx
  subq $40, %rsp
  call सूत्र_तल_निकास

  .globl sutra_gc_pop_root
  .def sutra_gc_pop_root; .scl 2; .type 32; .endef
sutra_gc_pop_root:
  movl gc_roots_count(%rip), %eax
  testl %eax, %eax
  jle .Lgc_pop_done
  decl %eax
  leaq gc_roots(%rip), %rdx
  movslq %eax, %r8
  cmpq %rcx, (%rdx,%r8,8)
  jne .Lgc_pop_mismatch
  movl %eax, gc_roots_count(%rip)
.Lgc_pop_done:
  ret
.Lgc_pop_mismatch:
  movl $1, %ecx
  subq $40, %rsp
  call सूत्र_तल_निकास

/* sutra_exception_pop / sutra_get_exception_value अब C shim → मूल_रनटाइम.सूत्र
 * (अपवाद_पॉप / सक्रिय_अपवाद_लो) — प्रयत्न-गहराई/सक्रिय-अपवाद Sutra global हैं। */

/* ============================================================
 * GC रूट-सरणी + गणक — पूर्व sutra_runtime.c में (void** gc_roots[1e6],
 * volatile int gc_roots_count)। हर संकलित मॉड्यूल inline
 * gc_roots(%rip) / gc_roots_count(%rip) छूता है (उत्सर्जक की रूट-
 * रजिस्ट्रेशन, तथा नीचे push/pop/root_count/root_deref, तथा
 * सूत्र_दीर्घकूद)। स्पष्ट .bss (COMMON नहीं — 8MB COMMON ब्लॉक इमेज-
 * लेआउट बिगाड़ता → REL32 overflow; C पक्ष -fno-common से .bss में जाता था)।
 * ============================================================ */
  .bss
  .align 32
  .globl gc_roots
gc_roots:
  .space 8000000
  .align 8
  .globl gc_roots_count
gc_roots_count:
  .space 8
  .text

/* sutra_gc_root_count() -> rax = gc_roots_count   (Sutra संग्राहक बुलाता) */
  .globl sutra_gc_root_count
  .def sutra_gc_root_count; .scl 2; .type 32; .endef
sutra_gc_root_count:
  movl gc_roots_count(%rip), %eax   /* 32-बिट लोड rax को शून्य-विस्तारित; गणक ≥ 0 */
  ret

/* sutra_gc_root_deref(rcx = i) -> rax = *gc_roots[i]  (सीमा-बाहर / NULL → 0) */
  .globl sutra_gc_root_deref
  .def sutra_gc_root_deref; .scl 2; .type 32; .endef
sutra_gc_root_deref:
  movl gc_roots_count(%rip), %eax
  cmpq %rax, %rcx
  jae .Lgrd_zero                    /* अचिह्नित: i<0 (विशाल) तथा i>=गणक दोनों पकड़े */
  leaq gc_roots(%rip), %rdx
  movq (%rdx,%rcx,8), %rax          /* rax = gc_roots[i]  (void**) */
  testq %rax, %rax
  jz .Lgrd_zero
  movq (%rax), %rax                 /* rax = *slot */
  ret
.Lgrd_zero:
  xorl %eax, %eax
  ret

/* ============================================================
 * सञ्चिका I/O + तर्क + समादेश — kernel32 / shell32 पतले wrappers।
 * OS-तल का सञ्चिका-भाग (जैसे ऊपर VirtualAlloc / WriteFile)। सब ≤3
 * तर्क लेते → Sutra से सीधे call, struct-मार्शलिंग यहीं बंद।
 * रचना-तर्क (loop / बफ़र / UTF-8↔UTF-16) मूल_रनटाइम.सूत्र में।
 * ऊपरी 32 बिट DWORD-वापसी पर movl %eax,%eax से शून्य-विस्तारित।
 * ============================================================ */

/* सूत्र_तल_यूटीएफ_चौड़ा(rcx=u8ptr, rdx=wdst, r8=wcap) -> rax = wchar गणना (0=विफल)
 * MultiByteToWideChar(CP_UTF8, 0, u8ptr, -1, wdst, wcap) */
  .globl सूत्र_तल_यूटीएफ_चौड़ा
  .def सूत्र_तल_यूटीएफ_चौड़ा; .scl 2; .type 32; .endef
सूत्र_तल_यूटीएफ_चौड़ा:
  subq $56, %rsp
  movq %rdx, 32(%rsp)        /* lpWideCharStr = wdst */
  movq %r8, 40(%rsp)         /* cchWideChar   = wcap */
  movq %rcx, %r8             /* lpMultiByteStr = u8ptr */
  movl $65001, %ecx          /* CP_UTF8 */
  xorl %edx, %edx            /* dwFlags = 0 */
  movq $-1, %r9              /* cbMultiByte = -1 (null-सहित) */
  call MultiByteToWideChar
  movl %eax, %eax
  addq $56, %rsp
  ret

/* सूत्र_तल_चौड़ा_यूटीएफ(rcx=wptr, rdx=u8dst, r8=u8cap) -> rax = बाइट गणना (null सहित; 0=विफल)
 * WideCharToMultiByte(CP_UTF8, 0, wptr, -1, u8dst, u8cap, NULL, NULL) */
  .globl सूत्र_तल_चौड़ा_यूटीएफ
  .def सूत्र_तल_चौड़ा_यूटीएफ; .scl 2; .type 32; .endef
सूत्र_तल_चौड़ा_यूटीएफ:
  subq $72, %rsp
  movq %rdx, 32(%rsp)        /* lpMultiByteStr    = u8dst */
  movq %r8, 40(%rsp)         /* cbMultiByte       = u8cap */
  movq $0, 48(%rsp)          /* lpDefaultChar     = NULL */
  movq $0, 56(%rsp)          /* lpUsedDefaultChar = NULL */
  movq %rcx, %r8             /* lpWideCharStr     = wptr */
  movl $65001, %ecx
  xorl %edx, %edx
  movq $-1, %r9              /* cchWideChar = -1 */
  call WideCharToMultiByte
  movl %eax, %eax
  addq $72, %rsp
  ret

/* सूत्र_तल_सञ्चिका_गुण(rcx=wpath) -> rax = GetFileAttributesW (0xFFFFFFFF = विफल) */
  .globl सूत्र_तल_सञ्चिका_गुण
  .def सूत्र_तल_सञ्चिका_गुण; .scl 2; .type 32; .endef
सूत्र_तल_सञ्चिका_गुण:
  subq $40, %rsp
  call GetFileAttributesW
  movl %eax, %eax
  addq $40, %rsp
  ret

/* सूत्र_तल_सञ्चिका_खोलो_प(rcx=wpath) -> rax = handle (पढ़ने; -1 = विफल)
 * CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL) */
  .globl सूत्र_तल_सञ्चिका_खोलो_प
  .def सूत्र_तल_सञ्चिका_खोलो_प; .scl 2; .type 32; .endef
सूत्र_तल_सञ्चिका_खोलो_प:
  subq $72, %rsp
  movl $0x80000000, %edx     /* GENERIC_READ (zero-ext) */
  movl $1, %r8d              /* FILE_SHARE_READ */
  xorl %r9d, %r9d            /* lpSecurityAttributes = NULL */
  movq $3, 32(%rsp)          /* OPEN_EXISTING */
  movq $0x80, 40(%rsp)       /* FILE_ATTRIBUTE_NORMAL */
  movq $0, 48(%rsp)          /* hTemplateFile = NULL */
  call CreateFileW
  addq $72, %rsp
  ret

/* सूत्र_तल_सञ्चिका_खोलो_ल(rcx=wpath) -> rax = handle (लिखने; CREATE_ALWAYS; -1 = विफल) */
  .globl सूत्र_तल_सञ्चिका_खोलो_ल
  .def सूत्र_तल_सञ्चिका_खोलो_ल; .scl 2; .type 32; .endef
सूत्र_तल_सञ्चिका_खोलो_ल:
  subq $72, %rsp
  movl $0x40000000, %edx     /* GENERIC_WRITE */
  xorl %r8d, %r8d            /* dwShareMode = 0 */
  xorl %r9d, %r9d
  movq $2, 32(%rsp)          /* CREATE_ALWAYS */
  movq $0x80, 40(%rsp)
  movq $0, 48(%rsp)
  call CreateFileW
  addq $72, %rsp
  ret

/* सूत्र_तल_सञ्चिका_आकार(rcx=handle) -> rax = बाइट्स (-1 = विफल) */
  .globl सूत्र_तल_सञ्चिका_आकार
  .def सूत्र_तल_सञ्चिका_आकार; .scl 2; .type 32; .endef
सूत्र_तल_सञ्चिका_आकार:
  subq $40, %rsp
  leaq 32(%rsp), %rdx        /* &LARGE_INTEGER (pad slot = scratch) */
  call GetFileSizeEx
  testl %eax, %eax
  jz .Lfsz_fail
  movq 32(%rsp), %rax
  addq $40, %rsp
  ret
.Lfsz_fail:
  movq $-1, %rax
  addq $40, %rsp
  ret

/* सूत्र_तल_पढ़ो(rcx=handle, rdx=buf, r8=n) -> rax = बाइट्स पढ़े (0 = EOF/विफल) */
  .globl सूत्र_तल_पढ़ो
  .def सूत्र_तल_पढ़ो; .scl 2; .type 32; .endef
सूत्र_तल_पढ़ो:
  subq $56, %rsp
  movq $0, 32(%rsp)          /* lpOverlapped = NULL */
  movl $0, 40(%rsp)          /* bytesRead scratch */
  leaq 40(%rsp), %r9
  call ReadFile
  testl %eax, %eax
  jz .Lrd_fail
  movl 40(%rsp), %eax
  addq $56, %rsp
  ret
.Lrd_fail:
  xorl %eax, %eax
  addq $56, %rsp
  ret

/* सूत्र_तल_लिखो(rcx=handle, rdx=buf, r8=n) -> rax = बाइट्स लिखे (0 = विफल) */
  .globl सूत्र_तल_लिखो
  .def सूत्र_तल_लिखो; .scl 2; .type 32; .endef
सूत्र_तल_लिखो:
  subq $56, %rsp
  movq $0, 32(%rsp)
  movl $0, 40(%rsp)
  leaq 40(%rsp), %r9
  call WriteFile
  testl %eax, %eax
  jz .Lwr_fail
  movl 40(%rsp), %eax
  addq $56, %rsp
  ret
.Lwr_fail:
  xorl %eax, %eax
  addq $56, %rsp
  ret

/* सूत्र_तल_हैंडल_बंद(rcx=handle) -> CloseHandle */
  .globl सूत्र_तल_हैंडल_बंद
  .def सूत्र_तल_हैंडल_बंद; .scl 2; .type 32; .endef
सूत्र_तल_हैंडल_बंद:
  subq $40, %rsp
  call CloseHandle
  addq $40, %rsp
  ret

/* सूत्र_तल_समादेश_रेखा() -> rax = GetCommandLineW (स्थिर — मुक्त मत करो) */
  .globl सूत्र_तल_समादेश_रेखा
  .def सूत्र_तल_समादेश_रेखा; .scl 2; .type 32; .endef
सूत्र_तल_समादेश_रेखा:
  subq $40, %rsp
  call GetCommandLineW
  addq $40, %rsp
  ret

/* सूत्र_तल_समादेश_विभाजन(rcx=wcmdline, rdx=&count) -> rax = LPWSTR* (सूत्र_तल_स्थानीय_मुक्त करो) */
  .globl सूत्र_तल_समादेश_विभाजन
  .def सूत्र_तल_समादेश_विभाजन; .scl 2; .type 32; .endef
सूत्र_तल_समादेश_विभाजन:
  subq $40, %rsp
  call CommandLineToArgvW
  addq $40, %rsp
  ret

/* सूत्र_तल_स्थानीय_मुक्त(rcx=ptr) -> LocalFree */
  .globl सूत्र_तल_स्थानीय_मुक्त
  .def सूत्र_तल_स्थानीय_मुक्त; .scl 2; .type 32; .endef
सूत्र_तल_स्थानीय_मुक्त:
  subq $40, %rsp
  call LocalFree
  addq $40, %rsp
  ret

/* सूत्र_तल_समादेश(rcx = wide "cmd.exe /c …") -> rax = प्रक्रिया exit-कोड (-1 = विफल)
 * CreateProcessW + WaitForSingleObject + GetExitCodeProcess + CloseHandle×2 */
  .globl सूत्र_तल_समादेश
  .def सूत्र_तल_समादेश; .scl 2; .type 32; .endef
सूत्र_तल_समादेश:
  pushq %rbp
  movq %rsp, %rbp
  pushq %rbx
  pushq %rdi                 /* entry≡8 → rbp≡0 → rbx≡8 → rdi≡0 */
  movq %rcx, %rbx            /* wcmd बचाओ (rep stosq rcx/rdi/rax मिटाता) */
  subq $208, %rsp            /* 32 shadow + 48 (6 stack args) + 104 si + 24 pi ; ≡0 */
  leaq 80(%rsp), %rdi        /* si @ +80 (104B), pi @ +184 (24B) — शून्य: 128B */
  xorl %eax, %eax
  movl $16, %ecx
  rep stosq
  movl $104, 80(%rsp)        /* si.cb = sizeof(STARTUPINFOW) */
  xorq %rcx, %rcx            /* lpApplicationName   = NULL */
  movq %rbx, %rdx            /* lpCommandLine       = wcmd */
  xorq %r8, %r8             /* lpProcessAttributes = NULL */
  xorq %r9, %r9             /* lpThreadAttributes  = NULL */
  movq $1, 32(%rsp)          /* bInheritHandles     = TRUE */
  movq $0, 40(%rsp)          /* dwCreationFlags     = 0 */
  movq $0, 48(%rsp)          /* lpEnvironment       = NULL */
  movq $0, 56(%rsp)          /* lpCurrentDirectory  = NULL */
  leaq 80(%rsp), %rax
  movq %rax, 64(%rsp)        /* lpStartupInfo       = &si */
  leaq 184(%rsp), %rax
  movq %rax, 72(%rsp)        /* lpProcessInformation = &pi */
  call CreateProcessW
  testl %eax, %eax
  jz .Lcmd_fail
  movq 184(%rsp), %rdi       /* pi.hProcess (rdi callee-saved, pushed) */
  movq %rdi, %rcx
  movq $-1, %rdx             /* INFINITE */
  call WaitForSingleObject
  movq %rdi, %rcx
  leaq 32(%rsp), %rdx        /* &exitCode (shadow reuse post-CreateProcessW) */
  movl $0, 32(%rsp)
  call GetExitCodeProcess
  movl 32(%rsp), %ebx        /* exit code -> rbx (CloseHandle के पार) */
  movq %rdi, %rcx
  call CloseHandle
  movq 192(%rsp), %rcx       /* pi.hThread */
  call CloseHandle
  movl %ebx, %eax
  jmp .Lcmd_done
.Lcmd_fail:
  movq $-1, %rax
.Lcmd_done:
  addq $208, %rsp
  popq %rdi
  popq %rbx
  popq %rbp
  ret
