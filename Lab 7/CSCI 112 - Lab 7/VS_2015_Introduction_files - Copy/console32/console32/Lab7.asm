; Example assembly language program -- adds 158 to number in memory
; Author:  Saishnu Ramesh Kumar
; Date:    10/14/2021
comment & we can comment in this 
way to &

.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data

count BYTE 0000000FCH

.CODE                           ; start of main program code
main    PROC
        
        mov AX,25
mul AL

        ret
main    ENDP

END                             ; end of source code