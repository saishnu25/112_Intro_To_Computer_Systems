; IO.H -- header file for I/O macros (listing suppressed)
.NOLIST      ; turn off listing

; 64-bit version with windows I/O
; must be used with project framework defining showOutput and getInput
; R. Detmer   2/2008
EXTRN getInput:PROC, showOutput:PROC, atodproc:PROC, dtoaproc:PROC, wtoaproc:PROC, atowproc:PROC


dtoa        MACRO  dest,source         ; convert double to ASCII string
            mov    [rsp+32], rcx       ; save registers used to pass parameters
            mov    [rsp+40], rdx
			sub    rcx,rcx             ; clear rcx
            mov    ecx, source         ; source value
            lea    rdx,dest            ; destination address
            call   dtoaproc            ; call dtoaproc(source,dest)
            mov    rcx, [rsp+32]       ; restore registers used to pass parameters
            mov    rdx, [rsp+40]
            ENDM

atod        MACRO  source              ; convert ASCII string to integer in rax
            mov    [rsp+32], rcx       ; save register used to pass parameters
            mov    [rsp+40], rbx       ; save registers destroyed by atodproc
            mov    [rsp+48], rdx

            lea    rcx,source          ; source address to rcx
            call   atodproc            ; call atodproc(source)
            mov    rcx, [rsp+32]       ; restore register used to pass parameters
            mov    rbx, [rsp+40]       ; restore registers destroyed by atodproc
            mov    rdx, [rsp+48]
            ENDM

wtoa        MACRO  dest,source         ; convert word to ASCII string
            mov    [rsp+32], rcx       ; save registers used to pass parameters
            mov    [rsp+40], rdx
            sub    rcx,rcx             ; clear rcx
            mov    cx, source          ; source value
            lea    rdx,dest            ; destination address
            call   wtoaproc            ; call dtoaproc(source,dest)
            mov    rcx, [rsp+32]       ; restore registers used to pass parameters
            mov    rdx, [rsp+40]
            ENDM

atow        MACRO  source              ; convert ASCII string to integer in AX
            mov    [rsp+32], rcx       ; save register used to pass parameters
            mov    [rsp+40], rbx       ; save registers destroyed by atowproc
            mov    [rsp+48], rdx
            lea    rcx,source          ; source address to rcx
            call   atowproc            ; call atowproc(source)
            mov    rcx, [rsp+32]       ; restore register used to pass parameters
            mov    rbx, [rsp+40]       ; restore registers destroyed by atowproc
            mov    rdx, [rsp+48]

            ENDM

output      MACRO  outLbl, outStr      ; display label and string
            mov    [rsp+32], rcx       ; save registers used to pass parameters
            mov    [rsp+40], rdx
            mov    [rsp+48], rax       ; save registers destroyed by getInput
            mov    [rsp+56], r8
            mov    [rsp+64], r9
            mov    [rsp+72], r10
            mov    [rsp+80], r11
            lea    rcx, outLbl         ; label address
            lea    rdx, outStr         ; string address
            cld
            call   showOutput          ; showOutput(outLbl, outStr)
            mov    rcx, [rsp+32]       ; restore registers used to pass parameters
            mov    rdx, [rsp+40]
            mov    rax, [rsp+48]       ; restore registers destoyed by getInput
            mov    r8, [rsp+56]
            mov    r9, [rsp+64]
            mov    r10, [rsp+72]
            mov    r11, [rsp+80]
            ENDM

input       MACRO  inPrompt, inStr, maxLength     ; prompt for and input  string
            mov    [rsp+32], rcx       ; save registers used to pass parameters
            mov    [rsp+40], rdx
            mov    [rsp+48], r8
            mov    [rsp+56], rax       ; save registers destroyed by getInput
            mov    [rsp+64], r9
            mov    [rsp+72], r10
            mov    [rsp+80], r11
            lea    rcx,inPrompt        ; prompt address
            lea    rdx,inStr           ; destination address
            sub    r8,r8               ; clear r8
            mov    r8d, maxLength      ; length of input string
            call   getInput            ; getInput(inPrompt, inStr, maxLength)
            mov    rcx, [rsp+32]       ; restore registers used to pass parameters
            mov    rdx, [rsp+40]
            mov    r8, [rsp+48]
            mov    rax, [rsp+56]       ; restore registers destoyed by getInput
            mov    r9, [rsp+64]
            mov    r10, [rsp+72]
            mov    r11, [rsp+80]
            ENDM

.NOLISTMACRO ; suppress macro expansion listings
.LIST        ; begin listing
