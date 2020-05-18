;alive.asm

section .data
    msg1    db  "Hello, World!",0
    msg2    db  "Alive and Kicking!",0
    radius  dq  357                     ; no string, not displayable?
    pi      dq  3.14                    ; no string, not displayable?
    fmtstr  db  "%s",10,0               ; format for printing string
    fmtflt  db  "%lf",10,0              ; float
    fmtint  db  "%d",10,0               ; int
section .bss
section .text
extern      printf
    global  main
main:
    push    rbp         ; function prologue - base pointer reg
    mov     rbp,rsp     ; function prologue  - stack pointer
    ; print msg1
    mov     rax, 0      ; no floating point
    mov     rdi, fmtstr ; put string in rdi
    mov     rsi, msg1   ; point rsi to item to be printed
    call    printf
    ; print msg2
    mov     rax, 0
    mov     rdi, fmtstr
    mov     rsi, msg2
    call    printf
    ; print radius
    mov     rax, 0      ; no floating point
    mov     rdi, fmtint
    mov     rsi, [radius]
    call    printf
    ; print pi
    mov     rax, 1      ; 1 xmm register used
    movq    xmm0, [pi]  ; put floating point value in xmm reg with movq [radius] means content at address radius. printf takes mem address for strings and values for numbers
    mov     rdi, fmtflt
    call    printf

    mov     rsp, rbp
    pop     rbp
ret                     ; same as mov rax,60   \ mov ri, 0  \  syscall

