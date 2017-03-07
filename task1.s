section	.rodata
LC0:
	DB	"%s", 10, 0	; Format string

section .bss
LC1:
	RESB	32

section .text
	align 16
	global my_func
	extern printf


my_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	mov ecx, dword [ebp+8]	; Get argument (pointer to string)
	pushad			; Save registers
	mov ebx, ecx ; save the location 
	mov edx, LC1
	mov eax , 0 ; eax=counter

counter:  ; count the length
	cmp BYTE [ecx] , 10
	JZ CAL
	inc eax
	inc ecx
	JMP counter

CAL:
	mov ecx, ebx
	shr eax, 1
	JC CalOdd

CalEven:
	cmp BYTE [ecx] , 10
	JZ finish
	mov AL, [ecx];
	sub AL, 48;
	shl AL , 2;
	inc ecx
	add AL, [ecx]
	sub AL, 48;
	cmp BYTE AL, 10
	JGE ADD55
	add AL, 48 ;back to ascii

ConEven:
	inc ecx
	mov [edx], AL
	inc edx
	cmp BYTE [ecx] , 10
	JZ finish
	jmp CalEven

CalOdd:
	mov AL,0
	cmp BYTE [ecx] , 10
	JZ finish
	add AL, [ecx]
	JMP ConEven

ADD55:
	add AL, 55
	JMP ConEven

finish:
	push	LC1		; Call printf with 2 arguments: pointer to str
	push	LC0		; and pointer to format string.
	call	printf
	add 	esp, 8		; Clean up stack after call

	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret

