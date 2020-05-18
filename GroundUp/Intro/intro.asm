SECTION   .data
SECTION   .text
GLOBAL    _start

_start:
mov eax, 1    ; linux kernel syscall exit #


mov ebx, 0    ; status # to return

int      080h ; wake up kernel to run exit
