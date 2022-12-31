;
;	Author: Saishnu Ramesh Kumar
;	Date: 11/11/2021
;

.586
.MODEL FLAT
.STACK  4096            ; reserve 4096-byte stack
.DATA                   ; reserve storage for data

.CODE          ; start of main program code

DWORD primeArray 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97
DWORD prime
DWORD index
DWORD candidate

main    PROC

mov eax, prime[1]
mov eax, 2 ; first prime number
mov eax, prime[2]
mov eax, 3 ; second prime number
	
mov eax, candidate
mov eax, 5 ; first candidate for new prime

jmp primeCount
jmp loop

;primeCount Proc
primeCount:

	mov eax, primeCount
	primeCount, 2
	jmp loop

endprimeCount:

;loop Proc
loop:
	
	;loop2 Proc
	loop2:

		jle primeCount, 100
		mov eax, index
		index, 1
		and prime, index
		idiv, index, candidate
		inc index

	ENDloop2:
	
	if index jg primeCount
	mov ebx, prime, 0
	inc primeCount
	prime[primeCount], candidate
	end if

	add candidate, 2

ENDloop:

ret
main    ENDP
END                             ; end of source code