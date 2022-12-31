; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

INCLUDE io.h            ; header file for input/output

.DATA               ; reserve storage for data
number1   DWORD   ?
number2   DWORD   ?
prompt1   BYTE    "Enter first number", 0
prompt2   BYTE    "Enter second number", 0
string    BYTE    40 DUP (?)
resultLbl BYTE    "The sum is", 0
sum       BYTE    11 DUP(?), 0

.CODE
MainProc  PROC
          sub     rsp, 120        ; reserve stack space for MainProc
          input   prompt1, string, 40   ; read ASCII characters
          atod    string          ; convert to integer
          mov     number1, eax    ; store in memory

          input   prompt2, string, 40   ; repeat for second number
          atod    string
          mov     number2, eax
        
          mov     eax, number1    ; first number to EAX
          add     eax, number2    ; add second number
          dtoa    sum, eax        ; convert to ASCII characters
          output  resultLbl, sum  ; output label and sum

          add     rsp, 120        ; restore stack
          mov     rax, 0          ; value to return (0)
          ret
MainProc ENDP
END

