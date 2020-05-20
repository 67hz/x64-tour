; printb.asm
; rdi holds value - 1st arg by convention
extern printf
section .data
    num_bits            dq          63
    fmt1                db          "%d",0
section .bss
    s                   resq        1
    resulti             resq        1
    modulo              resq        1
section .text
    global printc
printc:
push    rbp
mov     rbp, rsp
        push        rbx     ; callee-saved reg
        push        r12     ; callee-saved reg
        xor         rbx, rbx
        xor         r12, r12
        mov         rcx, [num_bits]
        mov         r12, rdi    ; lt storage of value
bloop:
        push rcx
        xor         rax, rax
        mov         rax, r12    ; copy target value into rax
        sar         rax, cl
        test        rax, 1  ; AND compare rax with 1
        jz          isZero  ; num & 1 == 0

        mov         rbx, 1
        jmp         loopdeaux

        
loopdeaux:
        mov         rdi, fmt1
        mov         rsi, rbx
        mov         rax, 0      ; no xmm0 registers
; printf steps on rcx so preserve or 
        call        printf      ; @TODO call printf after processing all bits
        pop         rcx
        loop        bloop

isZero:
    mov         rbx, 0
    loop        loopdeaux
        
pop     r12
pop     rbx

mov     rsp, rbp
pop     rbp
ret
        


