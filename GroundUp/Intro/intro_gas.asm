.section  .data

.section  .text
.globl  _start

_start:
movl  $1, %eax  # linux kernel cmd # (sys call) for exiting a program

movl  $0, %ebx  # status # to return to OS

int   $0x80     # wake up kernel to run exit
