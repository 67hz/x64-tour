SECTION   .data

SECTION   .text
GLOBAL  _start

_start: 
mov   eax,1     ; linux kernel cmd # (sys call) for exiting a program

mov   ebx,0     ; status # to return to OS

int   080h      ; wake up kernel to run exit

