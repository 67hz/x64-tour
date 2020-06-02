; macro.asm
extern printf

%define     double_it(r)        sal r,1         ; single line macro

%macro      prntf 2     ; multiline macro with 2 args
        section .data
            %%arg1      db      %1,0            ; first arg
            %%fmtint    db      "%s %ld",10,0   ; format string
        section .text
            mov     rdi, %%fmtint
            mov     rsi, %%arg1
            mov     rdx, [%2]           ; 2nd arg
            mov     rax, 0              ; no floating point
            call    printf
%endmacro

section .data
        number      dq      15
section .bss
section .text
    global main
main:
push    rbp
mov     rbp, rsp
        prntf       "The number is", number
        mov         rax, [number]
        double_it(rax)
        mov         [number], rax
        prntf       "The number times 2 is", number
leave
ret
