; Example assembly language program -- adds two numbers
; Author:  Saishnu Ramesh Kumar
; Date:    11/4/2021

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

var BYTE "a"

.CODE

toUpper MACRO var
    local upper

    mov al, var
    cmp al, 061h

    jl upper
    cmp al, 07ah

    jg upper
    sub al, 020h
    mov var, al

    upper:

ENDM


_MainProc PROC
        
        toUpper var
        mov al, var

        mov al, 0
        ret
_MainProc ENDP
END                             ; end of source code

