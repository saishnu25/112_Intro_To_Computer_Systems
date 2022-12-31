; Example assembly language program -- adds two numbers
; Author:  Saishnu Ramesh Kumar
; Date:    12/2/2021
.586
.MODEL FLAT
INCLUDE io.h            ; header file for input/output
.STACK 4096
.DATA

promptInput BYTE "Enter a string to trim", 0
strInput BYTE 80 DUP (?)
strResult BYTE 80 DUP (?)
resultLbl BYTE "After trim:", 0

num DWORD ?
decbase DWORD 10
fp4Res REAL4 ?
signflg DWORD 1

.CODE
;===========================================================================================
; ASCII To Float (char str[])
; Description: Converts the string to a floating point number
; Parameter: NULL terminated string
; Return Value: The floating point number to be stored in ST(i.e. st(0))


strtrim PROC

	dec strInput
	jnz strtrim

strtrim ENDP

strlen PROC
	
	push  edi
	sub ebx, ebx
	mov edi, [EBP+8]
	not ecx
	
	cld

	repne scasb 
	not ecx
	pop edi
	
	ret

strlen ENDP


AsciiToFloat PROC
	push EBP
	mov EBP, ESP
	push EBX
	push EAX
	push ECX
	push EDX
	push ESI
	push EDI
	pushfd

	mov EBX, [EBP+8]
	push EBX
	call strtrim
	call strlen

	fldz

	;find decimal point
	mov ECX, 0
	mov EBX, 1
	mov EDI, [EBP+8]

	;check for negative sign
		cmp ECX, EAX
		je noMoreCharacters
		cmp BYTE PTR [EDI], '-'
		jne LoopWholeCalc
		mov signflg, -1
		inc EDI
		inc ECX

		LoopWholeCalc:
			cmp ECX, EAX
			je noMoreCharacters
			cmp BYTE PTR [EDI], '.'
			je foundDecimal
			mov EDX, 0
			mov DL, BYTE PTR [EDI]
			sub EDX, '0'
			mov num, EDX
			fimul decbase
			fiadd num
			inc EDI
			inc ECX
			jmp LoopWholeCalc

			foundDecimal:
				inc ECX
				inc EDI

				fld1

				LoopFractionCalc:
					cmp ECX, EAX
					je noMoreCharacters
					mov EDX, 0
					mov DL, BYTE PTR [EDI]
					sub EDX, '0'
					mov num, EDX
					fidiv decbase
					fild num
					fmul st, st(1)
					faddp st(2), st
					inc EDI
					inc ECX
				jmp LoopFractionCalc


				noMoreCharacters:
					fstp st ;fstp fp4Res

					add ESP, 4
					popfd
					pop EDI
					pop ESI
					pop EDX
					pop ECX
					pop EAX
					pop EBX
					pop EBP

					ret
AsciiToFloat ENDP

_MainProc PROC

	input promptInput, strInput, 80
	lea ebx, strInput
	push ebx
	call strtrim
	call AsciiToFloat
	add esp, 4
	output resultLbl, strInput
		
		mov eax, 0 ;exit, return code 0

	ret
_MainProc ENDP
END   ; end of source code