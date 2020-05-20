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
            sal     rax, 1
            ; add     rax, rax    ; multiply by 2, same as adding with itself or sal above
    mov     rsp, rbp
    pop     rbp
    ret


