section .data
	; declare global vars here

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	push ebp
	push esp					; Echivalent cu mov ebp, esp
	pop ebp

	push esi
	push edi					; Salvam cei 3 registrii necesari
	push ebx
	
	xor eax, eax
	push dword [ebp + 8]		; Mutam in eax char* -ul
	pop eax
	
	xor ecx, ecx
nr_caractere:					; Calculam numarul de caractere in ecx
	cmp byte [eax + ecx] , 0
	je exit_nr_caracter
	inc ecx
	jmp nr_caractere
	
exit_nr_caracter:

xor esi, esi

prima_parcurgere:

check_vocala:					; Parcurgem si vefificam ch curent daca este
	cmp byte [eax + esi], 'a'	; vocala
	je push_stiva
	cmp byte [eax + esi], 'e'
	je push_stiva
	cmp byte [eax + esi], 'i'
	je push_stiva
	cmp byte [eax + esi], 'o'
	je push_stiva
	cmp byte [eax + esi], 'u'
	je push_stiva

	jmp exit_check_vocala

push_stiva:
	push word [eax + esi]		; Punem pe stiva vocala curent ca un word (2bytes)

exit_check_vocala:
	add esi, 1
	cmp esi, ecx
	jl prima_parcurgere			; Iteram prin toate ch din char*

	xor esi, esi
doi_parcurgere:
	xor ebx, ebx
	xor edx, edx
check_vocala_doi:				; Iteram din nou prin text
	cmp byte [eax + esi], 'a'
	je pop_stiva
	cmp byte [eax + esi], 'e'
	je pop_stiva
	cmp byte [eax + esi], 'i'
	je pop_stiva
	cmp byte [eax + esi], 'o'
	je pop_stiva
	cmp byte [eax + esi], 'u'
	je pop_stiva

	jmp exit_check_vocala_doi

pop_stiva:
	pop dx						; Salvam in dx caracterele puse la prima
								; iteratie (sunt deja in ordine inv).

	xor dh, dh

	cmp dl, byte [eax + esi]	; vedem max dintre ch curent si ala de shcimb
	jg big_ch_1

small_ch_1:
	push word [eax + esi]		
	pop bx						; caracter curent
	xor bh, bh

	sub bl, dl					; ch_curent - ch_schimb
	sub byte [eax + esi], bl	; scazi din ch din string diferenta
	jmp exit_check_vocala_doi

big_ch_1:
	sub dl, byte [eax + esi]
	add byte [eax + esi], dl

exit_check_vocala_doi:
	add esi, 1
	cmp esi, ecx
	jl doi_parcurgere

	pop ebx
	pop edi
	pop esi

	push ebp
	pop esp
	pop ebp

	ret
	