; betterloop
extern printf
section .data
    number      dq      1000000000
    fmt         db      "The sum from 0 to %ld is %ld",10,0   ; \n and 0 terminator
section .bss
section .text
    global main
main:
    push        rbp
    mov         rbp, rsp
    mov         rcx, [number]
    xor         rax, rax
bloop:
    add         rax, rcx        ; add rcx to sum held in rax; rcx auto decs on every loop
    loop        bloop
                                ; until rcx = 0
    mov         rdi, fmt
    mov         rsi, [number]
    mov         rdx, rax
    xor         rax, rax
    call        printf
    mov         rsp, rbp
    pop         rbp
    ret
