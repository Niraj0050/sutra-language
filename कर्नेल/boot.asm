; कर्नेल/boot.asm — Sutra freestanding kernel-code के लिए न्यूनतम boot stub
; ============================================================
; x86 का mandatory bring-up handshake करता — कोई OS/firmware यह नहीं करता
; हमारे लिए, यह हर OS को खुद करना पड़ता (Linux/Windows की तरह — हार्डवेयर
; की माँग है, किसी और का design "copy" नहीं):
;
;   16-बिट real mode → A20 सक्षम → 32-बिट protected mode (flat GDT) →
;   पेज-टेबल (पहले 2MB identity-map) → 64-बिट long mode
;
; फिर डिस्क सेक्टर 2 से आगे (`sutrac.exe --freestanding` का आउटपुट, इस
; boot sector के ठीक बाद disk पर रखा हुआ) 0x7E00 पर लोड करके वहाँ `call`
; करता — यानी कोई भी Sutra freestanding kernel सीधे यहीं से चलना शुरू
; होता, अपनी मर्ज़ी से VGA टेक्स्ट-बफर (0xB8000), raw memory, आदि छू सकता।
;
; प्रयोग: कर्नेल/निर्माण.ps1 देखो (असेम्बल + disk-image + QEMU बूट सब करता)।
;
; नोट: फ़ाइल-नाम जान-बूझकर ASCII है ("बूट.asm" नहीं) — nasm/qemu जैसे
; native टूल्स को कमांड-लाइन argument के रूप में दिया गया Devanagari पथ
; कभी-कभी OS की ANSI codepage argv-decoding में '?' में बदल जाता है
; (Sutra के अपने .सूत्र स्रोत यह समस्या नहीं झेलते — सुत्रC खुद
; GetCommandLineW से wide-char argv पढ़ता; तीसरे-पक्ष के पुराने-ANSI
; टूल्स नहीं)। निर्माण.ps1 इसीलिए इस डायरेक्टरी में cd करके सिर्फ़ बेयर
; ASCII फ़ाइल-नाम टूल्स को देता।

[BITS 16]
[ORG 0x7C00]

KERNEL_LOAD_SEG  equ 0x0000
KERNEL_LOAD_OFF  equ 0x7E00
KERNEL_SECTORS   equ 32          ; 16KB हेडरूम — ज़रूरत बढ़े तो बढ़ाओ

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mov [boot_drive], dl

    in al, 0x92                  ; A20 line (fast gate)
    or al, 2
    out 0x92, al

    mov ah, 0x02                 ; BIOS: read sectors
    mov al, KERNEL_SECTORS
    mov ch, 0
    mov cl, 2                    ; सेक्टर 2 से (1 = यह boot sector)
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, KERNEL_LOAD_SEG
    mov es, bx
    mov bx, KERNEL_LOAD_OFF
    int 0x13
    jc disk_fail

    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:protected_mode_start

disk_fail:
    hlt
    jmp $

[BITS 32]
protected_mode_start:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; न्यूनतम पेज-टेबल: PML4[0]->PDPT->PD[0] = पहला 2MB identity, एक ही
    ; 2MB page से (PT स्तर नहीं चाहिए)
    mov edi, 0x1000
    xor eax, eax
    mov ecx, 3072                ; 3 पेज (PML4+PDPT+PD), साफ करने को
    rep stosd

    mov dword [0x1000], 0x2003   ; PML4[0] -> 0x2000, present+write
    mov dword [0x2000], 0x3003   ; PDPT[0] -> 0x3000, present+write
    mov dword [0x3000], 0x83     ; PD[0]   -> 0x0,    present+write+PS(2MB)

    mov eax, 0x1000
    mov cr3, eax

    mov eax, cr4
    or eax, 1 << 5                ; PAE
    mov cr4, eax

    mov ecx, 0xC0000080           ; EFER
    rdmsr
    or eax, 1 << 8                ; LME
    wrmsr

    mov eax, cr0
    or eax, 1 << 31               ; PG (LME साथ मिलकर long mode सक्षम)
    mov cr0, eax

    lgdt [gdt64_descriptor]
    jmp CODE_SEG64:long_mode_start

[BITS 64]
long_mode_start:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov rsp, 0x90000

    ; COM1 सीरियल init (8N1, 115200) — डीबग आउटपुट के लिए, boot-stub का
    ; अपना; Sutra कर्नेल-कोड अभी सीधे port I/O नहीं कर सकता (कोई
    ; अंतर्_पोर्ट_* बिल्टिन नहीं अभी) — यह सिर्फ़ stub की अपनी progress
    ; लॉगिंग है
    mov dx, 0x3F9
    xor al, al
    out dx, al
    mov dx, 0x3FB
    mov al, 0x80
    out dx, al
    mov dx, 0x3F8
    mov al, 1
    out dx, al
    mov dx, 0x3F9
    xor al, al
    out dx, al
    mov dx, 0x3FB
    mov al, 3
    out dx, al

    lea rsi, [msg_boot_ok]
    call print_serial

    ; *** Sutra freestanding कर्नेल में कूदो ***
    call KERNEL_LOAD_OFF

    ; सामान्य कर्नेल यहाँ कभी नहीं लौटता — लौटे तो साफ़ दिखे, चुपचाप
    ; अटके नहीं
    lea rsi, [msg_returned]
    call print_serial

.hang:
    hlt
    jmp .hang

; rsi = null-terminated string -> COM1
print_serial:
    push rax
    push rdx
    push rsi
.loop:
    mov al, [rsi]
    cmp al, 0
    je .done
    mov dx, 0x3F8
    out dx, al
    inc rsi
    jmp .loop
.done:
    pop rsi
    pop rdx
    pop rax
    ret

msg_boot_ok: db "SUTRA-BOOT: long mode ready, entering kernel...", 0
msg_returned: db " KERNEL RETURNED (unexpected) - halting.", 0

; --- GDT (32-बिट protected mode, flat) ---
gdt_start:
    dq 0
gdt_code:
    dw 0xFFFF, 0
    db 0, 10011010b, 11001111b, 0
gdt_data:
    dw 0xFFFF, 0
    db 0, 10010010b, 11001111b, 0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

; --- GDT64 (long mode) ---
gdt64_start:
    dq 0
gdt64_code:
    dw 0, 0
    db 0, 10011010b, 00100000b, 0
gdt64_end:

gdt64_descriptor:
    dw gdt64_end - gdt64_start - 1
    dd gdt64_start

CODE_SEG64 equ gdt64_code - gdt64_start

boot_drive: db 0

times 510-($-$$) db 0
dw 0xAA55
