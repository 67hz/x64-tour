; rect.asm
section .data
section .bss
section .text
;-------------------------------------------------------------------------------
global r_area
r_area:
    section .text
    push    rbp
    mov     rbp, rsp
            mov     rax, rsi    ; rsi side2
            imul    rax, rdi    ; rdi side1
    mov     rsp, rbp
    pop     rbp
    ret
;-------------------------------------------------------------------------------
global r_circum
r_circum:
    section .text
    push    rbp
    mov     rbp, rsp
            mov     rax, rsi    ; rsi side2
            add     rax, rdi    ; + side1
            add     rax, rax    ; multiply @TODO try by 2 sal 1?
    mov     rsp, rbp
    pop     rbp
    ret


