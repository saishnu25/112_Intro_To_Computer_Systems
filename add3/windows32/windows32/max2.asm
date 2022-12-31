; Example assembly language program -- adds two numbers
; Author:  Saishnu Ramesh Kumar
; Date:    11/4/2021

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

.CODE

sampleMax MACRO num1, num2

    mov eax, num1
    mov eax, num2

    cmp eax

    ENDM


_MainProc PROC
        
        sampleMax 012h,055h

        sampleAdd ebx, ecx

        mov eax, 0
        ret
_MainProc ENDP
END                             ; end of source code

