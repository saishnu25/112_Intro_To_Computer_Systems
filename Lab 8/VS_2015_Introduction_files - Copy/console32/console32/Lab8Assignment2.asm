.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA                   ; reserve storage for data
cmpvalue DWORD 0FFFFFF38H
.CODE                           ; start of main program code
main    PROC
     codebegin:
        mov eax, 00000004Fh

        ; cmp eax, cmpvalue
        ; jl jmpaddress
        
        ;cmp eax, cmpvalue
        ;jb jmpaddress
        
       ; cmp eax, 04fh
       ; je jmpaddress
        
       ; cmp eax,79
        ;jne jmpaddress
        
        ;cmp cmpvalue,0
        ;jbe jmpaddress
        
       ;cmp cmpvalue,-200
       ;jge jmpaddress
        
        ;add eax,200
        ;js jmpaddress
        
        add cmpvalue, 200
        jz jmpaddress
    jmpaddress:
        mov eax,0
        ret
main    ENDP

END          ; end of source code
