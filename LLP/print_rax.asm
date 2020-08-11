section .data
codes:
	db	'0123456789ABCDEF'

section .text
global _start
_start:
	; number 1122... in hex format
	mov 	rax, 0x1122334455667788

	mov 	rdi, 1
	mov 	rdx, 1
	mov 	rcx, 64
	; each 4 bits should be ouptut as one hex digit
	; shift and AND to isolate them
	; result is offset in 'codes' array
.loop:
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
	jnz 	.loop

	mov 	rax, 60 	; exit syscall
	xor 	rdi, rdi
	syscall
