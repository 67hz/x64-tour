; rect.asm
%macro  epilogue 0
    push    rbp
    mov     rbp, rsp
%endmacro
section .data
section .bss
section .text
global rarea
rarea:
    section .text
        epilogue
        mov     rax, rdi
        imul    rsi
        leave
        ret

global rcircum
rcircum:
    section .text
        epilogue
        mov     rax, rdi
        add     rax, rsi
        imul    rax, 2
        shl     rax, 1  ; multiply by 2
        leave
        ret
