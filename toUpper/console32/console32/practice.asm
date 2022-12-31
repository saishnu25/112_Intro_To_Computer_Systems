.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA                   ; reserve storage for data

.CODE                           ; start of main program code
main    PROC

	mov eax, 5
	add eax, eax
ret
main    ENDP
END                             ; end of source code