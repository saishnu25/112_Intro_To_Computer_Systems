;
;	@author: Saishnu Ramesh Kumar
;	Date: 11/18/2021
;

.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA                   ; reserve storage for data

.CODE                           ; start of main program code
main    PROC
	
	;--- Exercise 7.1.1 ---
	;-- Part a, b, c, d --

	;mov bx, 0FA75h
	;mov cx, 03102h

	;and bx, cx
	;or bx, cx
	;xor bx, cx
	;not bx

	;-- Part e, f, ,g, h --
	;mov ax, 0FA75h

	;and ax, 000fh
	;or ax, 0fff0h
	;xor ax, 0ffffh
	;test ax, 0004h

	;-- Part i, j, k, l, m --
	;mov cx, 08EBAh

	;not cx
	;or cx, 0EDF2h
	;and cx, 0EDF2h
	;xor cx, 0EDF2h
	;test cx, 0EDF2h

	;-- Part n, o, p, q, r --
	;mov dx, 0b6A3h

	;not dx
	;or dx, 64C8h
	;and dx, 64C8h
	;xor dx, 64C8h
	;test dx, 64C8h

	;--- END OF EXERCISE 7.1.1 ---


	;--- Exercise 7.2.1 ---
	;-- Part a to l
	;mov ax, 0A8B5h

	;shl ax, 1
	;shr ax, 1
	;sar ax, 1
	;rol ax, 1
	;ror ax, 1

	;mov cl, 004h
	;mov cl, 01h
	;mov cl, 00h

	;sal ax, cl
	;shr ax, 04h
	;sar ax, cl
	;rol ax, cl
	;ror ax, 04h

	;rcl ax, 1
	;rol ax, 1 USING THIS FOR PART K instead of the previous line of code

	;rcr ax, 01h

	;--Part m to p --
	;mov bx, 08EBAh

	;shl bx, 3
	;shr bx, 3
	;sal bx, 3
	;sar bx, 3
	
	;--- END OF EXERCISE 7.2.1 ---

ret
main    ENDP
END                             ; end of source code