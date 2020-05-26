; bits2.asm
extern printf
section .data
        msgn1       db          "Number 1 is = %d",0
        msgn2       db          "Number 2 is = %d",0
        msg1        db          "SHL 2 = OK multiply by 4",0
        msg2        db          "SHR 2 = WRONG divide by 4",0
        msg3        db          "SAL 2 = correctly multiply by 4",0
        msg4        db          "SAR 2 = correctly divide by 4",0
        msg5        db          "SHR 2 = OK divide by 4",0

        number1     dq          8
        number2     dq          -8
        result      dq          0           ; not needed?

section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp

; SHL
; positive number
    mov     rsi, msg1
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    shl     rax, 2          ; multiply by 4
    mov     rsi, rax
    call    printres
; negative number
    mov     rsi, msg1
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    shl     rax, 2
    mov     rsi, rax
    call    printres
; SAL
; positive number
    mov     rsi, msg3
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    sal     rax, 2          ; multiply by 4 (arithmetic)
    mov     rsi, rax
    call    printres
; negative number
    mov     rsi, msg2
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    shr     rax, 2          ; divide by 4 (logic) - incorrect with signed
    mov     [result], rax
    mov     rsi, rax
    call    printres
; SHR
; positive number
    mov     rsi, msg5
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    shr     rax, 2          ; div by 4 (logic)
    mov     rsi, rax
    call    printres
; negative number
    mov     rsi, msg2
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    shr     rax, 2              ; div by 4 (logic); wrong with signed
    mov     [result], rax
    mov     rsi, rax
    call    printres
; SAR
; positive number
    mov     rsi, msg4
    call    printmsg
    mov     rsi, [number1]
    call    printnbr
    mov     rax, [number1]
    sar     rax, 2          ; div by 4 (arithmetic)
    mov     rsi, rax
    call    printres
; negative number
    mov     rsi, msg4
    call    printmsg
    mov     rsi, [number2]
    call    printnbr
    mov     rax, [number2]
    sar     rax, 2      ; divide by 4 (arithmetic)
    mov     rsi, rax
    call    printres



leave
ret
;-------------------------------------------------------------------------------
printmsg:
    section .data
        .fmtstr     db      10,"%s",10,0    ; format for string
    section .text
        mov         rdi, .fmtstr
        xor         rax, rax
        call        printf
    ret
;-------------------------------------------------------------------------------
printnbr:
    section .data
        .fmtstr     db      "The original number is %lld",10,0
    section .text
        mov         rdi,.fmtstr
        xor         rax,rax
        call        printf
    ret
;-------------------------------------------------------------------------------
printres:
    section .data
        .fmtstr     db      "The resulting number is %lld",10,0
    section .text
        mov         rdi,.fmtstr
        xor         rax,rax
        call        printf
    ret

