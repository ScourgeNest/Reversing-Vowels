section .data
	; declare global vars here

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	push ebp; push the base pointer on the stack
	push esp; push the stack pointer on the stack
	pop ebp; set the base pointer to the top of the stack
	pusha; push all registers on the stack

	push dword [ebp + 8]; push the address of the string on the stack
	pop eax; pop the address of the string in eax
	xor ecx, ecx; clear ecx
while:
	cmp byte [eax], 97 ; compare the current char with 'a'
	je found_vowel; if equal, jump to found_vowel
	cmp byte [eax], 101; compare the current char with 'e'
	je found_vowel; if equal, jump to found_vowel
	cmp byte [eax], 105; compare the current char with 'i'
	je found_vowel; if equal, jump to found_vowel
	cmp byte [eax], 111; compare the current char with 'o'
	je found_vowel; if equal, jump to found_vowel
	cmp byte [eax], 117; compare the current char with 'u'
	je found_vowel; if equal, jump to found_vowel

end_found_vowel:

	inc eax; increment the address of the string
	cmp byte [eax], 0; compare the current char with 0
	je end_while; if equal, jump to end_while
	jmp while; jump to while

end_while:
	
	push dword [ebp + 8]; push the address of the string on the stack
	pop eax; pop the address of the string in eax
	xor ecx, ecx; clear ecx

while2:
	cmp byte [eax], 97; compare the current char with 'a'
	je found_vowel2; if equal, jump to found_vowel2
	cmp byte [eax], 101; compare the current char with 'e'
	je found_vowel2; if equal, jump to found_vowel2
	cmp byte [eax], 105; compare the current char with 'i'
	je found_vowel2; if equal, jump to found_vowel2
	cmp byte [eax], 111; compare the current char with 'o'
	je found_vowel2; if equal, jump to found_vowel2
	cmp byte [eax], 117; compare the current char with 'u'
	je found_vowel2; if equal, jump to found_vowel2

end_found_vowel2:
	inc eax; increment the address of the string
	cmp byte [eax], 0; compare the current char with 0
	je end_while2; if equal, jump to end_while2
	jmp while2; jump to while2

end_while2:


	popa; pop all registers from the stack
	pop ebp; pop the base pointer from the stack
	ret; return

found_vowel:
	xor cx, cx; clear cx
	push word [eax]; push the current char on the stack
	pop cx; pop the current char in cx
	shl cx, 8; shift the current char 8 bits to the left
	shr cx, 8; shift the current char 8 bits to the right
	push cx; push the current char on the stack
	jmp end_found_vowel; jump to end_found_vowel

found_vowel2:
	xor cx, cx; clear cx
	pop cx; pop the current char in cx
	push word [eax]; push the current char on the stack
	pop dx; pop the current char in dx
	shr dx, 8; shift the current char 8 bits to the right
	shl dx, 8; shift the current char 8 bits to the left
	
	or dx, cx; or the current char with the previous char
	push dx; push the current char on the stack
	pop word [eax]; pop the current char in the string
	
	jmp end_found_vowel2; jump to end_found_vowel2