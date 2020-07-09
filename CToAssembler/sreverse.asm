section .data
section .bss
section .text

; void sreverse(char *, int strlen);

global sreverse
sreverse:
    push    rbp
    mov     rbp, rsp

pushing:

        mov     rcx, rsi        ; strlen
        mov     rbx, rdi        ; char* to string
        mov     r12, 0

    pushLoop:
        mov     rax, qword [rbx + r12]  ; mov by 1 char and fill rax
        push    rax
        inc     r12
        loop    pushLoop

popping:

        mov     rcx, rsi
        mov     rbx, rdi
        mov     r12, 0

    popLoop:
        pop     rax
        mov     byte [rbx + r12], al    ; 1 byte off stack into rbx
        inc     r12
        loop    popLoop

mov     rax, rdi        ; return value into rax per calling convention
leave                   
ret
