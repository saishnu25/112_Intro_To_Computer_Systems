; Example assembly language program -- adds 158 to number in memory
; Author:  Saishnu Ramesh Kumar
; Date:    09/16/2021
comment & we can comment in this 
way to &

.586
.MODEL FLAT

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
number  DWORD   -105
sum     DWORD   ?

.CODE                           ; start of main program code
main    PROC
        mov     eax, number     ; first number to EAX
        add     eax, 158        ; add 158
        mov     sum, eax        ; sum to memory

        mov   eax, 0            ; exit with return code 0
        ret
main    ENDP

END                             ; end of source code
