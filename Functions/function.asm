; function.asm
extern printf
section .data
    radius      dq      10.0
    pi          dq      3.14
    fmt         db      "The area of the circle is %.2f",10,0
section .bss
section .text
    global main
;-------------------------------------------------------------------------------
main:
    push    rbp         ; push onto stack to make it 16 byte aligned: rsp should end in 0 (when 16 byte aligned)
    mov     rbp, rsp    ; preserve rsp (contains the return address)
    call    area
    mov     rdi,fmt
    movsd   xmm1, [radius]      ; move float to xmm1
    mov     rax, 1              ; area in xmm0, 1 xmm register to print
    call printf
leave           ; pop rbp
ret
;-------------------------------------------------------------------------------
area:
    push    rbp
    mov     rbp, rsp
    movsd   xmm0, [radius]      ; move float to xmm0
    mulsd   xmm0, [radius]      ; r^2
    mulsd   xmm0, [pi]
leave
ret

