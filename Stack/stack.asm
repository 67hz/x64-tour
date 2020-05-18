; stack.asm
extern printf
section .data
    strng       db      "ABCDE",0
    strngLen    equ     $ - strng -1 ; stringlength without 0, take mem location and subtract location of (strng - 1)
    fmt1        db      "The original string: %s",10,0
    fmt2        db      "The reversed string: %s",10,0
section .bss
section .text
    global main
main:
push    rbp
mov     rbp,rsp

; Print the original string
    mov     rdi, fmt1
    mov     rsi, strng      ; new line below
    mov     rax, 0          ; no xmm registers involved (floating point)
    call printf

; push the string char per char on stack
    xor     rax,rax         ; init with 0s
    mov     rbx, strng      ; address of string in rbx
    mov     rcx, strngLen   ; length in the rcx counter
    mov     r12, 0          ; r12 as a pointer
    pushLoop:
        mov     al, byte [rbx+r12]  ; move char(byte) into rax: al = low 8 bit rax

        push    rax                 ; push rax on the stack
        inc     r12                 ; increase char pointer with 1 
        loop    pushLoop            ; continue loop
; pop string char per char from stack
; this will reverse the string
        mov     rbx, strng          ; address of strng in rbx
        mov     rcx, strngLen       ; length in rcx counter
        mov     r12, 0              ; r12 as pointer
    popLoop:
        pop     rax                 ; pop a char from stack
        mov     byte [rbx+r12], al   ; mov char into strng
        inc     r12                 ; increase char pointer with 1
        loop    popLoop             ; continue loop
        mov     byte [rbx+r12],0    ; terminate string with 0

; print reversed string
    mov     rdi, fmt2
    mov     rsi, strng
    mov     rax, 0
    call printf

mov     rsp,rbp
pop     rbp
ret

    
    
    
