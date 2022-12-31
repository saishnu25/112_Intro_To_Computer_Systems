; Example assembly language program -- adds 158 to number in memory
; Author:  Saishnu Ramesh Kumar
; Date:    10/07/2021
comment & we can comment in this 
way to &

.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data

;wordOp WORD 15

.CODE                           ; start of main program code
main    PROC
        
        ;add dx, wordOp ;sub bl, dh ;inc ecx ;dec cl ;neg ebx

        ;mov ebx, 000610132H
        ;mov ecx, 0FF250F75H

       ;sub ebx, ecx

       ;mov cx, 00D31H

       ;inc cx

       ;mov eax, 000000001H

       ;dec eax

       ;mov ebx, 0FFFFFFFFH

       ;neg ebx





        ret
main    ENDP

END                             ; end of source code