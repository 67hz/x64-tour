; file.asm
section .data
; expressions for conditional assembly
        CREATE      equ     1
        OVERWRITE   equ     1
        APPEND      equ     1
        O_WRITE     equ     1
        READ        equ     1
        O_READ      equ     1
        DELETE      equ     1

; syscall symbols
        NR_read     equ     0
        NR_write    equ     1
        NR_open     equ     2
        NR_close    equ     3
        NR_lseek    equ     8
        NR_create   equ     85
        NR_unlink   equ     87

; creation and status flags
        O_CREATE    equ     00000100q
        O_APPEND    equ     00002000q

; access mode
        O_RDONLY    equ     000000q
        O_WRONLY    equ     000001q
        O_RDWR      equ     000002q 

; create mode (permissions)
        S_IRUSR     equ     00400q      ; user read permission
        S_IWUSR    equ     00200q
        NL          equ     0xa
        bufferlen   equ     64
        fileName    db      "testfile.txt",0
        FD          dq      0       ; file descriptor

        text1       db      "1. Hello... to everyone!",NL,0
        len1        dq      $-text1-1       ; remove 0
        text2       db      "2. I am him!",NL,0
        len2        dq      $-text2-1
        text3       db      "3. Alive and kicking!",NL,0
        len3        dq      $-text3-1
        text4       db      "Adios !!!",NL,0
        len4        dq      $-text4-1

        error_Create    db  "error creating file",NL,0
        error_Close     db  "error closing file",NL,0
        error_Write     db  "error writing to file",NL,0
        error_Open      db  "error opening file",NL,0
        error_Append    db  "error appending file",NL,0
        error_Delete    db  "error deleting file",NL,0
        error_Read      db  "error reading file",NL,0
        error_Print     db  "error printing string",NL,0
        error_Position  db  "error positioning in file",NL,0
        
        success_Create  db  "File created and opened",NL,0
        success_Close   db  "File closed",NL,NL,0
        success_Write   db  "Written to file",NL,0
        success_Open    db  "File opened for R/W",NL,0
        success_Append  db  "File opened for appending",NL,0
        success_Delete  db  "File deleted",NL,0
        success_Read    db  "Reading file",NL,0
        success_Position db     "Positioned in file",NL,0

section .bss
    buffer      resb    bufferlen
section .text
    global main
main:
    push    rbp
    mov     rbp,rsp
%IF CREATE
; CREATE AND OPEN A FILE, THEN CLOSE -------------------------------------------
; create and open file
    mov     rdi, fileName
    call    createFile
    mov     qword [FD], rax     ; save descriptor

; write to file #1
    mov     rdi, qword [FD]     ; rdi gets file descriptor
    mov     rsi, text1          ; rsi gets text to write
    mov     rdx, qword [len1]   ; rdx gets length to write
    call    writeFile

; close file
    mov     rdi, qword [FD]
    call    closeFile

%ENDIF
%IF OVERWRITE
; OPEN ANE OVERWRITE A FILE, THEN CLOSE ----------------------------------------
; open file
    mov     rdi, fileName
    call    openFile
    mov     qword [FD], rax     ; save file descriptor
; write to file #2 OVERWRITE
    mov     rdi, qword [FD]
    mov     rsi, text2
    mov     rdx, qword [len2]
    call    writeFile
; close file
    mov     rdi, qword [FD]     ; writing clobbers rdi so put fd back
    call    closeFile
%ENDIF
%IF APPEND
; OPEN ANE APPEND TO A FILE, THEN CLOSE ----------------------------------------
; open file to append
    mov     rdi, fileName
    call    appendFile
    mov     qword [FD], rax     ; save FD
; write to file #3 APPEND
    mov     rdi, qword [FD]     ; rdi gets FD for write call
    mov     rsi, text3
    mov     rdx, qword [len3]
    call    writeFile
; close file
    mov     rdi, qword [FD]
    call    closeFile
%ENDIF
%IF O_WRITE
; OPEN AND OVERWRITE AT AN OFFSET IN A FILE, THEN CLOSE ------------------------
; open file to write
    mov     rdi, fileName
    call    openFile
    mov     qword [FD], rax     ; save FD
; position file at offset
    mov     rdi, qword [FD]
    mov     rsi, qword [len2]   ; offset @ this location
    mov     rdx, 0
    call    positionFile
; write to file at offset
    mov     rdi, qword [FD]
    mov     rsi, text4
    mov     rdx, qword [len4]
    call    writeFile
; close file
    mov     rdi, qword [FD]
    call    closeFile
%ENDIF
%IF READ
; OPEN AND READ FROM A FILE, THEN CLOSE ----------------------------------------
; open file to read
    mov     rdi, fileName
    call    openFile
    mov     qword [FD], rax     ; save FD
; read from file
    mov     rdi, qword [FD]
    mov     rsi, buffer
    mov     rdx, bufferlen      ; # chars to read
    call    readFile
    mov     rdi, rax            ; rax holds read data ATP
    call    printString
; close file
    mov     rdi, qword [FD]
    call    closeFile
%ENDIF
%IF O_READ
; OPEN AND READ AT AN OFFSET FROM A FILE, THEN CLOSE ---------------------------
; open file to read
    mov     rdi, fileName
    call    openFile
    mov     qword [FD], rax     ; save returned FD
; position file at offset
    mov     rdi, qword[FD]      ; rdi holds FD in most system calls
    mov     rsi, qword[len2]    ; offset in rsi
    mov     rdx, 0              ; whence?
    call    positionFile
; read from file
    mov     rdi, qword[FD]
    mov     rsi, buffer
    mov     rdx, 10             ; # chars to read
    call    readFile
    mov     rdi, rax            ; rax holds read data
    call    printString         ; so print it
; close file
    mov     rdi, qword [FD]
    call    closeFile
%ENDIF
%IF DELETE
; DELETE A FILE ----------------------------------------------------------------
; delete file
    mov     rdi, fileName
    call    deleteFile
%ENDIF

leave
ret
; FILE MANIPULATION FUNCTIONS---------------------------------------------------
;-------------------------------------------------------------------------------
global readFile
readFile:
    mov     rax, NR_read
    syscall         ; rax contains # chars read, reads into buffer in rsi
    cmp     rax, 0
    jl      readerror
    mov     byte[rsi+rax],0 ; add a terminating 1
    mov     rax, rsi

    mov     rdi, success_Read
    push    rax             ; caller saved - holding read data
    call    printString
    pop     rax
    ret
    
readerror:
    mov     rdi, error_Read
    call    printString
    ret
;-------------------------------------------------------------------------------
global positionFile
positionFile:
    mov     rax, NR_lseek
    syscall
    cmp     rax, 0
    jl      positionerror
    mov     rdi, success_Position
    call    printString
    ret
positionerror:
    mov     rdi, error_Position
    call    printString
    ret
;-------------------------------------------------------------------------------
global appendFile
appendFile:
    ; do we need to push rbp?
    mov     rax, NR_open
    mov     rsi, O_RDWR|O_APPEND
    syscall
    cmp     rax, 0
    jl      appenderror
    mov     rdi, success_Append
    push    rax
    call    printString
    pop     rax
    ret
appenderror:
    mov     rdi, error_Append
    call    printString
    ret
;-------------------------------------------------------------------------------
global writeFile
writeFile:
    mov     rax, NR_write
    syscall
    cmp     rax, 0
    jl      writeerror
    mov     rdi, success_Write
    call    printString
    ret
writeerror:
    mov     rdi, error_Write
    call    printString
    ret
;-------------------------------------------------------------------------------
global createFile
createFile:                         ; filename in rdi
    mov     rax, NR_create
    mov     rsi, S_IRUSR |S_IWUSR
    syscall
    cmp     rax, 0          ; fd in rax
    jl      createerror
    mov     rdi, success_Create
    push    rax             ; caller saved
    call    printString
    pop     rax             ; caller saved
    ret
createerror:
    mov     rdi, error_Create
    call    printString
    ret
;-------------------------------------------------------------------------------
global openFile
openFile:   ; rdi has FD
    mov     rax, NR_open        ; syscall # in rax
    mov     rsi, O_RDWR         ; flags in rsi
    syscall
    cmp     rax, 0
    jl      .openerror
    mov     rdi, success_Open
    push    rax         ; caller saved, printing eats rax
    call    printString
    pop     rax         ; caller saved
    ret
.openerror:
    mov     rdi, error_Open
    call    printString
    ret
;-------------------------------------------------------------------------------
global closeFile
closeFile:
    mov     rax, NR_close
    syscall
    cmp     rax, 0
    jl      closeerror
    mov     rdi, success_Close
    call    printString
    ret
closeerror:
    mov     rdi, error_Close
    call    printString
    ret
global deleteFile
deleteFile:
    mov     rax, NR_unlink
    syscall
    cmp     rax, 0
    jl      deleteerror
    mov     rdi, success_Delete
    call    printString
    ret
deleteerror:
    mov     rdi, error_Delete
    call    printString
    ret
;-------------------------------------------------------------------------------
; PRINT FEEDBACK
;-------------------------------------------------------------------------------
global printString
printString:
; Count characters
    mov     r12, rdi
    mov     rdx, 0
strLoop:
    cmp     byte [r12], 0
    je      strDone
    inc     rdx         ; increment length in rdx
    inc     r12
    jmp     strLoop
strDone:
    cmp     rdx, 0      ; no string (0 length)
    je      prtDone
    mov     rsi, rdi
    mov     rax, 1      ; 1 = write
    mov     rdi, 1      ; 1 = stdout
    syscall
prtDone:
    ret




