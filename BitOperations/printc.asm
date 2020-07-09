; printb.asm
; rdi holds value - 1st arg by convention
; add space after every byte
extern printf
section .data
    num_bits            dq          64
    byte_length         dq          8
    fmt1                db          "%d",0
    fmtstr              db          "%s",0
    blank_space         db          " ",0
    blank_line          db          0xA
section .text
    global printc
printc:
push    rbp
mov     rbp, rsp
push        r12     ; callee-saved reg
        xor         r12, r12
        mov         rcx, [num_bits]
        mov         r12, rdi    ; r12 storage of value
.bloop:
        dec         rcx
        xor         rax, rax
        mov         rax, rcx
        inc         rax         ; rcx+1 % 8 == 0
        div         qword [byte_length]
        cmp         rdx, 0      ; rdx gets rem of div r/m64
        jg         .andprint

        ; print blank space between bytes
        mov         rsi, blank_space
        mov         rdi, fmtstr
        mov         rax, 0
        push        rcx
        call        printf
        pop         rcx

.andprint:
        mov         rax, r12    ; copy target value into rax
        sar         rax, cl     ; must be 8 byte reg
        and         rax, 1      ; want either a 1 or 0 to insert into string

        mov         rdi, fmt1
        mov         rsi, rax
        mov         rax, 0      ; no xmm0 registers
; printf steps on rcx so preserve
        push        rcx
        call        printf      ; @TODO call printf after processing all bits
        pop         rcx

        test        rcx,rcx     ; fastest is a zero test
        jnz         .bloop

        mov         rdi, fmtstr
        mov         rsi, blank_line
        mov         rax, 0
        call        printf


pop     r12
mov     rsp, rbp
pop     rbp
ret
        


