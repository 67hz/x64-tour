; cmdline.asm
extern printf
section .data
    msg     db      "The command and arguments: ",10,0
    fmt     db      "%s",10,0
section .bss
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        mov     r12, rdi        ; # of args including program name
        mov     r13, rsi        ; address of args array
; print title
        mov     rdi, msg
        call    printf
        mov     rbx, 0
; print command and args
.ploop:      ; loop through array and print
        mov     rdi, fmt
        mov     rsi, qword [r13 + rbx * 8] ; 8 is length of address pointed to (8 bytes -> 64 bit address)
        call    printf
        inc     rbx
        cmp     rbx, r12        ; # args reached
        jl      .ploop
leave
ret
