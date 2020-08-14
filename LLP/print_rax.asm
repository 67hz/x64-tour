section .data
codes:
	db	'0123456789ABCDEF'
NL: 
	db 	0xa

section .text
global _start

print_newline:
	push 	rbp
	mov 	rbp, rsp

	mov 	rax, 1
	mov 	rdi, 1
	mov 	rsi, NL
	mov 	rdx, 1

	syscall

	mov 	rsp, rbp
	pop 	rbp
	ret

; each 4 bits should be ouptut as one hex digit
; shift and AND to isolate them
; result is offset in 'codes' array

print_hex:
	push 	rbp
	mov 	rbp, rsp
	mov 	rdi, 1
	mov 	rdx, 1
	mov 	rcx, 64
	mov 	rax, 0x1122334455667788

	iterate:
		push 	rax
		sub 	rcx, 4

		sar 	rax, cl
		and 	rax, 0xf

		lea 	rsi, [codes + rax]
		mov 	rax, 1

		; sycall clobbers rcx and r11
		push 	rcx
		syscall
		pop 	rcx
		pop 	rax

		test 	rcx, rcx
		jnz 	iterate


	mov 	rsp, rbp
	pop 	rbp
	ret


_start:
	push 	rbp
	mov    	rbp, rsp

	call print_hex


	call print_newline
	call print_newline


	mov 	rax, 60 	; exit syscall
	xor 	rdi, rdi
	syscall


