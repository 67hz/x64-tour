section .data
section .bss
section .text

; double asum(double [], int);
global asum
asum:

    section .text
; calculate sum
    
    push    rbp
    mov     rbp, rsp

    mov     rcx, rsi        ; length into rcx
    mov     rbx, rdi        ; address of array
    mov     r12, 0
    movsd   xmm0, qword [rbx+r12*8]  ; mov from src (rsi) to xmm0
    dec     rcx         ; 1st elem of array in xmm0 so dec loop once

    sloop:
        inc     r12
        addsd   xmm0, qword [rbx+r12*8] ; offset by counter bytes and add scalar double
        loop    sloop
leave
ret     ; return sum is already in xmm0 for double return value
        
        
