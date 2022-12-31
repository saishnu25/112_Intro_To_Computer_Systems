; Example assembly language program -- adds two numbers
; Author:  Saishnu Ramesh Kumar
; Date:    12/2/2021
.586
.MODEL FLAT
INCLUDE io.h            ; header file for input/output
.STACK 4096
.DATA

;Single Precision
sample1 real4  175.5
sample2 real4  0.09375

;Double Precision
sample3 real8 -0.0078125
sample4 real8 -11.75

;Double Extended Precision
sample5 real10 3160.0
sample6 real10 -1.25

fpvalue real4 0.5
intvalue dword 6
fp1 real4 35.0
fp2 real4 24.0
fp3 real4 23.0
fp4 real4 12.0
fp5 real4 9.0

.CODE

_MainProc PROC
fld fp1
fld fp2
fld fp3
fld fp4
fld fp5

;Exercise 9.2 (from a to h)
fld st(2)
fld fpValue
fild intValue

fldpi

fst st(4)
fstp st(4)
fst fpValue
fistp intValue
;End of Exercise 9.2

mov eax,0
ret
_MainProc ENDP
END   ; end of source code