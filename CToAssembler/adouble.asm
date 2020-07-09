; void adouble(double [], int);

section .data
section .bss
section .text
global adouble
adouble:
    section .text

push    rbp
mov     rbp, rsp
; double elements of double[]
            mov     rbx, rdi    ; address of array
            mov     rcx, rsi    ; array length
            mov     r12, 0

        aloop:
            movsd   xmm0, qword [rbx+r12*8] ; take double from array
            addsd   xmm0, xmm0      ; double it
            movsd   qword [rbx+r12*8], xmm0 ; put back into array
            inc     r12
            loop    aloop
leave
ret
