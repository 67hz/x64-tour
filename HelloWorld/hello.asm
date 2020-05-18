;hello.asm
section .data
    msg db "hello, world",0
    NL  db 0xa  ; ascii new line

section .bss
section .text
	global main
main:
  mov   rax, 1        ; system call number (1: stdout) should be stored in rax
  mov   rdi, 1        ; argument #1 in rdi: where to write (descriptor)?
  mov   rsi, msg  ; argument #2 in rsi: where does the string start?
  mov   rdx, 12       ; argument #3 in rdx: how many bytes to write? length of msg w/o 0
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, NL
  mov rdx, 1
  syscall

  mov   rax, 60       ; 'exit' syscall number
  xor   rdi, rdi      ; xor with self will zero bits == mov rdi, 0
  syscall
