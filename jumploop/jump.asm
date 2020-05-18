; jump.asm
extern printf
section .data
    number     dq      1000000000
    fmt        db      "The sum from 0 to %ld is %ld",10,0
section .bss
section .text
    global main
main:
    push        rbp
    mov         rbp, rsp
    mov         rbx, 0      ; counter      
    xor         rax, rax    ; sum will be in rax
    
jloop:
    add         rax, rbx
    inc         rbx
    cmp         rbx, [number]   ; number reached?
    jle         jloop           ; not reached so continue

    mov         rdi, fmt        ; prepare for displaying
    mov         rsi, [number]   ; first printf arg into rsi
    mov         rdx, rax        ; second printf arg into rdx
    xor         rax, rax        ; clear rax
    call        printf
    mov         rsp, rbp
    pop         rbp
    ret
    
    


