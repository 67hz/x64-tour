; function6.asm
extern printf
section .data
    first       db      "A"
    second      db      "B"
    third       db      "C"
    fourth      db      "D"
    fifth       db      "E"
    sixth       db      "F"
    seventh     db      "G"
    eighth      db      "H"
    ninth       db      "I"
    tenth       db      "J"
    fmt         db      "The string is %s",10,0
section .bss
    flist       resb    11  ; length of string + terminating 0
section .text
    global main
main:
push    rbp
mov     rbp, rsp 
        mov     rdi, flist      ; length
        mov     rsi, first
        mov     rdx, second
        mov     rcx, third
        mov     r8, fourth
        mov     r9, fifth
        push    tenth
        push    ninth
        push    eighth
        push    seventh
        push    sixth
        call    lfunc           ; call function
        ; print result
        mov     rdi, fmt
        mov     rsi, flist
        mov     rax, 0          ; no xmm registers
        call printf
leave
ret
;-------------------------------------------------------------------------------
lfunc:
push    rbp
mov     rbp, rsp
        xor     rax, rax        ; clear rax (esp higher bits)
        mov     al, byte[rsi]   ; move content 1st arg to al, byte optional since size is known
        mov     [rdi], al       ; store al (low8 of rax) to memory
        mov     al, byte[rdx]   ; move 2nd arg to al 
        mov     [rdi+1], al     ; store al to memory with offset
        mov     al, byte[rcx]
        mov     [rdi+2], al
        mov     al, byte[r8]
        mov     [rdi+3], al
        mov     al, byte[r9]
        mov     [rdi+4], al
; now fetch arguments from stack
        ; never know if rbx is used in main so preserve and restore before leaving function
        push    rbx             ; callee saved; temp register for building string in flist
        xor     rbx, rbx
        mov     rax, qword [rbp+16]  ; first value: initial stack
                                    ; + rip + rbp
        mov     bl, byte [rax]       ; extract character into lowest 8 of rbx
        mov     [rdi+5], bl         ; store character to memory
        mov     rax, qword [rbp+24] ; continue with next value
        mov     bl, byte [rax]
        mov     [rdi+6], bl
        mov     rax, qword [rbp+32]
        mov     bl, byte [rax]
        mov     [rdi+7], bl
        mov     rax, qword [rbp+40]
        mov     bl, byte [rax]
        mov     [rdi+8], bl
        mov     rax, qword [rbp+48]
        mov     bl, byte [rax]
        mov     [rdi+9], bl
        mov     bl,0            ; for terminating 0?
        mov     [rdi+10], bl
pop     rbx         ; callee saved
mov     rsp,rbp     ; next 2 lines same as leave
pop     rbp
ret
        

