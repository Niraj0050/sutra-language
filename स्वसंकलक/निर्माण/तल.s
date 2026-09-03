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
