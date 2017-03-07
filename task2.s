section	.rodata
LC0:
	DB	"%016llx", 10, 0

section .bss
LC1:
	RESB	8
LC2:
	RESB	4

section .text
	align 16
	global calc_func
	extern printf
	extern compare

calc_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	mov ebx, dword [ebp+8]	; Get argument (pointer to string)
	pushad			; Save registers
	mov edx, dword [ebp+12]
	mov [LC2], edx

starting_loop:
	mov dword [LC1],0
	mov dword [LC1+4],0
	mov eax, 0;
	mov ecx, 0; 
	mov edx, 0; counter word position 

main_loop:
	mov eax, 0;
	mov al, [ebx+edx]
	and al, 15
	mov ah , al
	shr al, 1
	and ah, 1
	cmp ah , 1
	je firstcarry1

firstcarry0:
	mov cl, 7
	sub cl,al 
	add byte [LC1+ecx], 16
	jmp finished_with_num1

firstcarry1:
	mov cl, 7
	sub cl,al 
	add byte [LC1+ecx], 1

finished_with_num1:
	mov al, [ebx+edx]
	shr al, 4
	and al, 15
	mov ah , al
	shr al, 1
	and ah, 1
	cmp ah , 1
	je secondcarry1

secondcarry0:
	mov cl, 7
	sub cl,al 
	add byte [LC1+ecx], 16
	jmp finished_with_num2

secondcarry1:
	mov cl, 7
	sub cl,al 
	add byte [LC1+ecx], 1

finished_with_num2:
	inc edx;
	cmp edx , 8
	jl main_loop

	push	LC1	
	push	ebx		
	call	compare
	add esp , 8;
	cmp eax , 1
	je finish

	sub dword [LC2], 1
	cmp dword [LC2], 0
	je finish

	mov ecx, [LC1]
	mov edx, [LC1+4]
	mov [ebx], ecx
	mov [ebx+4], edx
	jmp starting_loop

finish:
	push    dword [LC1+4]
	push	dword [LC1]		
	push	LC0		
	call	printf
	add 	esp, 12		; Clean up stack after call

	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret