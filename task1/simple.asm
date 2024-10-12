%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    xor eax, eax    ; initializez eax 
    xor ebx, ebx    ; initializez ebx pt a stoca caracterele shiftate

    start:
        cmp ecx, 0 
        ;; Verifică dacă s-au procesat toate caracterele
        je end

        mov al, byte [esi]  ; pun caracterul curent din string-ul plain
        inc esi             ; Incrementează pointer-ul string-ului plain
        cmp al, 'A'         ; Verifică dacă caracterul este literă mare
        jb not_letter
        cmp al, 'Z'
        ja not_letter
        add al, dl          ; Aplic shiftarea la dreapta cu pasul specificat
        cmp al, 'Z'         ; Verifică dacă depășește litera 'Z' după shiftare
        jbe letter_done
        sub al, 26          ; Ajustează caracterul pentru a se încadra în intervalul 'A'-'Z'
        jmp letter_done

    not_letter:
        ; Tratare cazuri speciale pentru alte caractere

    letter_done:
        mov byte [edi], al   ; Stochează caracterul criptat în string-ul enc_string
        inc edi             
        ; Incrementează pointer-ul string-ului enc_string
        dec ecx             
        ; Decrementează numărul de caractere procesate
        jmp start      
        ; Revine la începutul buclei

end:
    ;; Your code ends here
        
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
