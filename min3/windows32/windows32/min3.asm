; Example assembly language program -- adds two numbers
; Author:  Saishnu Ramesh Kumar
; Date:    11/4/2021

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

.CODE

sampleMin MACRO num1, num2, num3

    mov eax, num1
    mov eax, num2
    cmp eax, num3

    jle _MainProc
    mov eax, num3

    ENDM


_MainProc PROC
        
        sampleMin 065h,055h, 0100h

        sampleMin ebx, ecx, edx

        mov eax, 0
        ret
_MainProc ENDP
END                             ; end of source code

