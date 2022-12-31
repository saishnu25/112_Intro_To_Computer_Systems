; data conversion procedures - 64-bit versions
; author:  R. Detmer
; Date: November 2007

PUBLIC wtoaproc, atowproc, dtoaproc, atodproc

.CODE

; dtoaproc(source, dest)
; convert double (source) to string of 11 characters at given destination address
; source integer passed as a quadword, but only low-order doubleword is processed
dtoaproc    PROC
            push   rax                  ; save registers used in procedure
            push   rbx
            push   rdi
            mov    rdi,rdx              ; copy destination address
ifSpecialD: cmp    ecx,80000000h        ; special case -2,147,483,648?
            jne    EndIfSpecialD        ; if not, then normal case
            mov    BYTE PTR [rdi],'-'   ; manually put in ASCII codes
            mov    BYTE PTR [rdi+1],'2' ;   for -2,147,483,648
            mov    BYTE PTR [rdi+2],'1'
            mov    BYTE PTR [rdi+3],'4'
            mov    BYTE PTR [rdi+4],'7'
            mov    BYTE PTR [rdi+5],'4'
            mov    BYTE PTR [rdi+6],'8'
            mov    BYTE PTR [rdi+7],'3'
            mov    BYTE PTR [rdi+8],'6'
            mov    BYTE PTR [rdi+9],'4'
            mov    BYTE PTR [rdi+10],'8'
            jmp    ExitDToA            ; done with special case
EndIfSpecialD:

            mov    rbx,0               ; loop counter
for10D:     mov    BYTE PTR [rdi+rbx],' '  ; spaces in destination
            inc    rbx
            cmp    rbx, 10             ; count < 10?
            jl     for10D              ; repeat if so
            
            add    rdi, 10             ; point at end of destination field
            mov    eax,ecx             ; copy source   

IfNegD:     cmp    eax,0               ; check sign of number
            jge    EndIfNegD           ; skip if not negative
            neg    eax                 ; number in EAX now >= 0
EndIfNegD:

            mov    ebx,10              ; divisor
WhileMoreD: mov    edx,0               ; extend number to doubleword
            div    ebx                 ; divide by 10
            add    dl,30h              ; convert remainder to character
            mov    [rdi],dl            ; put character in string
            dec    rdi                 ; move forward to next position
            cmp    eax,0               ; check quotient
            jnz    WhileMoreD          ; continue if quotient not zero

IfSignD:    cmp    ecx,0               ; check sign of number
            jge    EndIfSignD          ; skip if not negative
            mov    BYTE PTR [rdi],'-'  ; sign for negative number
EndIfSignD:

ExitDToA:   pop    rdi                 ; restore registers
            pop    rbx 
            pop    rax
            ret                        ;exit
dtoaproc    ENDP

; atodproc(source)
; Procedure to scan data segment starting at source address, interpreting 
; ASCII characters as an doubleword-size integer value which is returned in EAX.

; Leading blanks are skipped.  A leading - or + sign is acceptable.
; Digit(s) must immediately follow the sign (if any).
; Memory scan is terminated by any non-digit.

; No error checking is done. If the number is outside the range for a
; signed doubleword, then the return value is undefined.

atodproc    PROC
WhileBlankD:cmp    BYTE PTR [rcx],' '  ; space?
            jne    EndWhileBlankD      ; exit if not
            inc    rcx                 ; increment character pointer
            jmp    WhileBlankD         ; and try again
EndWhileBlankD:

            mov    rbx,1               ; default sign multiplier
IfPlusD:    cmp    BYTE PTR [rcx],'+'  ; leading + ?
            je     SkipSignD           ; if so, skip over
IfMinusD:   cmp    BYTE PTR [rcx],'-'  ; leading - ?
            jne    EndIfSignD          ; if not, save default +
            mov    rbx,-1              ; -1 for minus sign
SkipSignD:  inc    rcx                 ; move past sign
EndIfSignD:

            push   rbx                 ; save sign multiplier
            mov    rax,0               ; number being accumulated

WhileDigitD:cmp    BYTE PTR [rcx],'0'  ; compare next character to '0'
            jl     EndWhileDigitD      ; not a digit if smaller than '0'
            cmp    BYTE PTR [rcx],'9'  ; compare to '9'
            jg     EndWhileDigitD      ; not a digit if bigger than '9'
            imul   rax,10              ; multiply old number by 10
            mov    bl,[rcx]            ; ASCII character to BL
            and    rbx,0Fh             ; convert to single-digit integer
            add    rax,rbx             ; add to sum
            inc    rcx                 ; increment character pointer
            jmp    WhileDigitD         ; go try next character
EndWhileDigitD:

            pop    rbx                 ; sign multiplier
; if value is < 80000000h, multiply by sign
            cmp    eax,80000000h       ; 80000000h?
            jnb    endIfMaxD           ; skip if not
            imul   rbx                 ; make signed number
endIfMaxD:

            ret                        ; exit
atodproc    ENDP

; wtoaproc(source, dest)
; convert word (source) to string of 11 characters at given destination address
; source integer passed as a quadword, but only low-order word is processed
wtoaproc    PROC
            push   rax                  ; save registers used in procedure
            push   rbx
            push   rdi
            mov    rdi,rdx              ; copy destination address
ifSpecialW: cmp    rcx,8000h            ; special case -32,767?
            jne    EndIfSpecialW        ; if not, then normal case
            mov    BYTE PTR [rdi],'-'   ; manually put in ASCII codes
            mov    BYTE PTR [rdi+1],'3' ;   for -2,147,483,648
            mov    BYTE PTR [rdi+2],'2'
            mov    BYTE PTR [rdi+3],'7'
            mov    BYTE PTR [rdi+4],'6'
            mov    BYTE PTR [rdi+5],'8'
            jmp    ExitWToA            ; done with special case
EndIfSpecialW:

            mov    rbx,0               ; loop counter
for5W:      mov    BYTE PTR [rdi+rbx],' '  ; spaces in destination
            inc    rbx
            cmp    rbx, 5              ; count < 5?
            jl     for5W               ; repeat if so
            
            add    rdi, 5              ; point at end of destination field
            mov    eax,ecx             ; copy source   

IfNegW:     cmp    ax,0                ; check sign of number
            jge    EndIfNegW           ; skip if not negative
            neg    ax                  ; number in EAX now >= 0
EndIfNegW:

            mov    ebx,10              ; divisor
WhileMoreW: mov    edx,0               ; extend number to doubleword
            div    ebx                 ; divide by 10
            add    dl,30h              ; convert remainder to character
            mov    [rdi],dl            ; put character in string
            dec    rdi                 ; move forward to next position
            cmp    eax,0               ; check quotient
            jnz    WhileMoreW          ; continue if quotient not zero

IfSignW:    cmp    cx,0                ; check sign of number
            jge    EndIfSignW          ; skip if not negative
            mov    BYTE PTR [rdi],'-'  ; sign for negative number
EndIfSignW:

ExitWToA:   pop    rdi                 ; restore registers
            pop    rbx 
            pop    rax
            ret                        ;exit
wtoaproc    ENDP

; atowproc(source)
; Procedure to scan data segment starting at source address, interpreting 
; ASCII characters as an word-size integer value which is returned in AX.

; Leading blanks are skipped.  A leading - or + sign is acceptable.
; Digit(s) must immediately follow the sign (if any).
; Memory scan is terminated by any non-digit.

; No error checking is done. If the number is outside the range for a
; signed word, then the return value is undefined.

atowproc    PROC
WhileBlankW:cmp    BYTE PTR [rcx],' '  ; space?
            jne    EndWhileBlankW      ; exit if not
            inc    rcx                 ; increment character pointer
            jmp    WhileBlankW         ; and try again
EndWhileBlankW:

            mov    rbx,1               ; default sign multiplier
IfPlusW:    cmp    BYTE PTR [rcx],'+'  ; leading + ?
            je     SkipSignW           ; if so, skip over
IfMinusW:   cmp    BYTE PTR [rcx],'-'  ; leading - ?
            jne    EndIfSignW          ; if not, save default +
            mov    rbx,-1              ; -1 for minus sign
SkipSignW:  inc    rcx                 ; move past sign
EndIfSignW:

            push   rbx                 ; save sign multiplier
            mov    rax,0               ; number being accumulated

WhileDigitW:cmp    BYTE PTR [rcx],'0'  ; compare next character to '0'
            jl     EndWhileDigitW      ; not a digit if smaller than '0'
            cmp    BYTE PTR [rcx],'9'  ; compare to '9'
            jg     EndWhileDigitW      ; not a digit if bigger than '9'
            imul   rax,10              ; multiply old number by 10
            mov    bl,[rcx]            ; ASCII character to BL
            and    rbx,0Fh             ; convert to single-digit integer
            add    rax,rbx             ; add to sum
            inc    rcx                 ; increment character pointer
            jmp    WhileDigitW         ; go try next character
EndWhileDigitW:

            pop    rbx                 ; sign multiplier
; if value is < 8000h, multiply by sign
            cmp    ax,8000h            ; 8000h?
            jnb    endIfMaxW           ; skip if not
            imul   rbx                 ; make signed number
endIfMaxW:

            ret                        ; exit
atowproc    ENDP

            END
