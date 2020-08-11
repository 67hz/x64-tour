; fCALC.asm
extern printf
section .data
    number1     dq      9.0
    number2     dq      73.0
    foo         dq      42.0
    bar         dq      6.12
    fmt         db      "The numbers are %f and %f",10,0 

    fmtfloat    db      "%s %f",10,0
    f_sum       db      "The float sum of %f and %f is %f",10,0
    f_dif       db      "The float difference of %f and %f is %f",10,0
    f_mul       db      "The float product of %f and %f is %f",10,0
    f_div       db      "The float division of %f and %f is %f",10,0
    f_sqrt      db      "The float squareroot of %f is %f",10,0
section .bss
section .text
    global main
main:
    push    rbp     ; will segfault without push/pop rbp
    mov     rbp,rsp
; print numbers
    movsd   xmm0, [number1]
    movsd   xmm1, [number2]
    mov     rdi, fmt
    mov     rax,2           ; 2 floats
    call printf
; sum
    movsd   xmm2, [number1]     ; double precision float into xmm
    addsd   xmm2, [number2]     ; add double precision to xmm
        ; print result
        movsd   xmm0, [number1]
        movsd   xmm1, [number2]
        mov     rdi,f_sum
        mov     rax,3
        call printf         ; printf pulls xmm registers in order xmm0-n and removes from reg
; difference
    movsd   xmm2, [number1]
    subsd   xmm2, [number2]
        ; print result
        movsd   xmm0, [number1]
        movsd   xmm1, [number2]
        mov     rdi,f_dif
        mov     rax, 3
        call printf
; multiplication
    movsd   xmm2, [number1]
    mulsd   xmm2, [number2]
        ; print result
        movsd   xmm0, [number1]
        movsd   xmm1, [number2]
        mov     rdi,f_mul
        mov     rax, 3
        call printf
; division
    movsd   xmm2, [foo]
    divsd   xmm2, [bar]
        ; print result
        movsd   xmm0, [foo]
        movsd   xmm1, [bar]
        mov     rdi, f_div
        mov     rax, 1 ; book says 1 float - isn't it 3?
        call printf
; square root
    sqrtsd  xmm1, [number1] ; sqrt double precision in xmm1
        ; print result
        mov     rdi, f_sqrt
        movsd   xmm0, [number1]
        mov     rax, 2      ; 2 float
        call printf
; exit
    mov rsp, rbp
    pop rbp             ; undo push from beginning
