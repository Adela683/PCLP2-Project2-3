
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE


; Direcția stânga-sus
    mov edx, eax
    sub edx, 1
    cmp edx, 0
    jl skip_left_up
    mov edi, ebx
    sub edi, 1
    cmp edi, 0
    jl skip_left_up
    mov esi, edx
    imul esi, 8
    add esi, edi
    mov byte [ecx + esi], 1
    

skip_left_up:
    ; Direcția dreapta-sus
    mov edx, eax
    sub edx, 1
    cmp edx, 0
    jl skip_right_up
    mov edi, ebx
    add edi, 1
    cmp edi, 7
    jg skip_right_up
    mov esi, edx
    imul esi, 8
    add esi, edi
    mov byte [ecx + esi], 1

skip_right_up:
    ; Direcția stânga-jos
    mov edx, eax
    add edx, 1
    cmp edx, 7
    jg skip_left_down
    mov edi, ebx
    sub edi, 1
    cmp edi, 0
    jl skip_left_down
    mov esi, edx
    imul esi, 8
    add esi, edi
    mov byte [ecx + esi], 1

skip_left_down:
    ;; Direcția dreapta-jos
    mov edx, eax
    add edx, 1
    cmp edx, 8
    jg skip_right_down
    mov edi, ebx
    add edi, 1
    cmp edi, 7
    jg skip_right_down
    mov esi, edx
    imul esi, 8
    add esi, edi
    mov byte [ecx + esi], 1

skip_right_down:
    jmp end

    ; Verifică dacă piesa este pe margine și actualizează tabela în consecință
on_top_edge:
    ; Verifică doar direcțiile dreapta-jos și stânga-jos
    mov esi, eax
    add esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi], 1
    jmp end

on_bottom_edge:
    ; Verifică doar direcțiile dreapta-sus și stânga-sus
    mov esi, eax
    sub esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi] , 1
    jmp end

on_left_edge:
    ; Verifică doar direcțiile dreapta-sus și dreapta-jos
    mov esi, eax
    sub esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi], 1
    mov esi, eax
    add esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi], 1
    jmp end

on_right_edge:
    ; Verifică doar direcțiile stânga-sus și stânga-jos
    mov esi, eax
    sub esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi], 1
    mov esi, eax
    add esi, 1
    imul esi, 8
    add esi, ebx
    mov byte [ecx + esi], 1
    jmp end

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY