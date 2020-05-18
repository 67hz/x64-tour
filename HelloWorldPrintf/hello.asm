;hello.asm
extern  printf      ; declare function as external
section .data
    msg db "hello, world",0
    fmtstr  db   "This is our string: %s",10,0 ; printf format
section .bss
section .text
	global main
main:
    push    rbp   ; rbp is base pointer used for functions
    mov     rbp, rsp  ; rsp is stack pointer register
    mov     rdi, fmtstr  ; 1st arg printf
    mov     rsi, msg     ; 2nd arg printf
    mov     rax, 0       ; no xmm registers involved
    call    printf
    mov     rsp, rbp
    pop     rbp
    mov     rax, 60      ; 60 = exit
    mov     rdi, 0       ; 0 = success exit code
    syscall              ; quit

