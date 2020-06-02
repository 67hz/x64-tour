; bits3.asm
extern printc
extern printf
section .data
        msg1        db      "No bits are set:",10,0
        msg2        db      10,"Set bit #4, the 5th bit:",10,0
        msg3        db      10,"Set bit #7, the 8th bit:",10,0
        msg4        db      10,"Set bit #8:",10,0
        msg5        db      10,"Set bit #61:",10,0
        msg6        db      10,"Clear bit #8:",10,0
        msg7        db      10,"Test bit #61:",10,0   
        bitflags    dq      0
section .bss
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp 
; print title
    mov     rdi, msg1
    xor     rax, rax
    call    printf

; print bitflags
    mov     rdi, [bitflags]
    call    printc

; set bit 4 (=5th bit)
    ; print title
    mov     rdi, msg2
    xor     rax, rax
    call    printf

    bts     qword [bitflags],4      ; set bit 4
    ; print bitflags
    mov     rdi, [bitflags]
    call    printc
; set bit 7
    mov     rdi, msg3
    xor     rax, rax
    call    printf
    bts     qword [bitflags],7
    mov     rdi, [bitflags]
    call    printc
; set bit 8
    mov     rdi, msg4
    xor     rax, rax
    call    printf
    bts     qword [bitflags],8
    mov     rdi, [bitflags]
    call    printc
; set bit 61
    mov     rdi, msg5
    xor     rax, rax
    call    printf
    bts     qword [bitflags],61
    mov     rdi, [bitflags]
    call    printc
; clear bit 8
    mov     rdi, msg6
    xor     rax, rax
    call    printf
    btr     qword [bitflags],8  ; test and reset 8
    mov     rdi, [bitflags]
    call    printc
; test bit 61 (sets CF to 1 if 1)
    mov     rdi, msg7
    xor     rax, rax
    call    printf
    xor     rdi, rdi
    mov     rax, 61     ; bit 61 to be tested so put in rax
    xor     rdi, rdi    ; make sure all bits are 0
    bt      [bitflags], rax     ; bit test
    setc    dil         ; set dil (=low rdi) to 1
    call    printc      ; display rdi

leave
ret
