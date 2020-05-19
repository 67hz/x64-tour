; function5.asm

extern printf
section .data
    first       db      "A",0
    second      db      "B",0
    third       db      "C",0
    fourth      db      "D",0
    fifth       db      "E",0
    sixth       db      "F",0
    seventh     db      "G",0
    eighth      db      "H",0
    ninth       db      "I",0
    tenth       db      "J",0
    fmt1        db      "The string is:%s%s%s%s%s%s%s%s%s%s",10,0
    fmt2        db      "PI = %f",10,0
    pi          dq      3.14
section .bss
section .text
    global main
main:
push    rbp
mov     rbp, rsp

    mov     rdi, fmt1   ; first use the registers
    mov     rsi, first
    mov     rdx, second
    mov     rcx, third
    mov     r8, fourth
    mov     r9, fifth
    
    push    tenth       ; start pushing in
    push    ninth
    push    eighth
    push    seventh
    push    sixth
    mov     rax, 0      ; no xmm registers
    call    printf
    and     rsp, 0xfffffffffffffff0; 16-byte align the stack; only last digit (last 4 bytes) zero-ed; if stack was aligned already, this does nothing since would end in 0 already
    movsd   xmm0, [pi]   ; now print a floating point
    mov     rax, 1      ; 1 float to print
    mov     rdi, fmt2
    call    printf

; leave same as mov rsp, rbp
; followed by pop rbp
leave
ret


