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
 * बाहरी: sutra_throw_div_by_zero (C), gc_roots/gc_roots_count/
 * sutra_try_depth/sutra_active_exception (C globals) — link पर resolve।
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
  call sutra_throw_div_by_zero
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
