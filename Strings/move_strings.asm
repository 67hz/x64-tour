; move_strings.asm
%macro prnt 2
    mov     rax, 1      ; 1 = write
    mov     rdi, 1      ; 1 = stdout
    mov     rsi, %1
    mov     rdx, %2
    syscall
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, NL
        mov     rdx, 1      ; length to print
    syscall
%endmacro
section .data
    length      equ     95
	codes		db    	"12345"
    NL          db      0xa
    string1     db      10,"my_string of ASCII:"
    string2     db      10,"my_string of zeros:"
    string3     db      10,"my_string of ones:"
    string4     db      10,"again my_string of ASCII:"
    string5     db      10,"copy my_string to other_string:"
    string6     db      10,"reverse copy my_string to other_string"
section .bss
    my_string       resb    length
    other_string    resb    length 
section .text
    global main
main:
push rbp
mov  rbp, rsp   
;-------------------------------------------------------------------------------
; fill string with printable ascii chars
        prnt    string1, 20
        mov     rax, 32
        mov     rdi, my_string
	mov 	rcx, length
str_loop1:
	mov 	byte[rdi], al
	inc		rdi
	inc 	al
	loop	str_loop1
	prnt 	my_string,length

mov rsp, rbp
pop rbp
ret
