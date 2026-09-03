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
 *   _setjmp(rcx=env,rdx=frame) / sr_longjmp(rcx=env,rdx=val) — न्यूनतम, no-SEH
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
 * _setjmp / sr_longjmp — न्यूनतम (कोई SEH unwind)। jmp_buf विन्यास:
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

  .globl sr_longjmp
  .def sr_longjmp; .scl 2; .type 32; .endef
sr_longjmp:
  movl %edx, %eax
  testl %eax, %eax
  jnz .Llj_v
  movl $1, %eax
.Llj_v:
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
