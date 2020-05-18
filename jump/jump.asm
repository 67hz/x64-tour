; jump.asm
extern printf
section .data
    number1     dq      42
    number2     dq      41
    fmt1        db      "NUMBER1 >= NUMBER2",10,0
    fmt2        db      "NUMBER1 < NUMBER2",10,0
    
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    mov     rax, [number1]      ; mov numbers into register
    mov     rbx, [number2]
    cmp     rax, rbx            ; compare rax, rbx
    jge     greater             ; rax greater or equal, go to greater
    mov     rdi, fmt2           ; rax is smaller, continue here
    xor     rax, rax            ; no xmm involved
    call    printf              ; display fmt2
    jmp     exit
greater:
    mov     rdi, fmt1           ; rax is greater
    mov     rax, 0              ; no xmm involved
    call    printf              ; dispaly fmt1
exit:
    mov     rsp, rbp
    pop     rbp
    ret
