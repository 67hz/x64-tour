; printb.asm
; rdi holds value - 1st arg by convention
; finalize value correctness, add space after every byte
extern printf
section .data
    num_bits            dq          64
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
        mov         r12, rdi    ; r12 storage of value
.bloop:
        xor         rax, rax
        mov         rax, r12    ; copy target value into rax
        sar         rax, cl-1     ; must be 8 byte reg
        jz          .isZero  ; num & 1 == 0
        jnz         .notZero


        
.loopdeaux:
        mov         rdi, fmt1
        mov         rsi, rbx
        mov         rax, 0      ; no xmm0 registers
; printf steps on rcx so preserve or 
        push        rcx
        call        printf      ; @TODO call printf after processing all bits
        pop         rcx         ; fails because rcx pops when 0 loads a garbage value
        loop        .bloop

        ; dec         rcx
        ; test        rcx,rcx     ; fastest is it a zero test
        ; jgz         .bloop


.notZero:
    mov         rbx, 1
    jmp         .loopdeaux

.isZero:
    mov         rbx, 0
    jmp         .loopdeaux
        
pop     r12
pop     rbx

mov     rsp, rbp
pop     rbp
ret
        


