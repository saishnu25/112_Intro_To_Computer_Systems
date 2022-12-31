; Example assembly language program -- Getting the factorial of a inputted number
; Author:  Saishnu Ramesh Kumar
; Date:    10/28/2021

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

num DWORD ?

prompt1 BYTE "Enter first number", 0

string BYTE 40 DUP(?)
resultLb1 BYTE "The factorial is", 0

result BYTE 11 DUP(?), 0 ;string to factorial

.CODE

; main proc
_MainProc PROC

        input   prompt1, string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     num, eax    ; store in memory
        
        push num

        call myFactorialProc
        call myFactorialProcRec


        dtoa result, eax    ; convert to ASCII characters
        output resultLb1, result ; output label and sum

        mov     eax, 0  ; exit with return code 0
        ret

_MainProc ENDP
END  ; end of source code


; code for non recursive factorial
myFactorialProc PROC

    mov eax, num

    loop eax, DWORD PTR [ebp - 4]
    dec eax 

    mov result, eax

myFactorialProc ENDP

; code for recursive factorial
myFactorialProcRec PROC

    cmp DWORD PTR [ebp - 4], eax
    mov eax, 1

    mov eax, DWORD PTR[ebp - 4]
    sub eax, 1
    mov, edi, eax
    loop myFactorialProcRec
    imul eax, DWORD PTR[ebp - 4]
    dec eax

    mov result, eax

myFactorialProcRec ENDP
 