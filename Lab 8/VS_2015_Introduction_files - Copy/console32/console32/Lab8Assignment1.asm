.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA                   ; reserve storage for data
num BYTE ?
saveaddress DWORD ?
sum DWORD ?
.CODE                           ; start of main program code
main    PROC        
  codebegin:
        mov num,254
        mov sum,0
  codeLoop1:
        add num,1
        mov eax,sum
        add al,num
        mov sum,eax
        jmp codeLoop1
        mov sum,0
        jmp saveaddress 
        mov eax,sum
        jmp eax
        mov sum,0
        jmp DWORD PTR[ebx]
        mov eax,0


        ret

main    ENDP

END          ; end of source code
