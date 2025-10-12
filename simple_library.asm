; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026

; w eax - napis do wyprintowania
; w ebx - jego dlugosc
simple_print:
    push ecx
    push edx
    mov ecx, eax
    mov edx, ebx
    
    mov eax, 4
    mov ebx, 1
    int 80h

    pop edx
    pop ecx
    ret

simple_print_from_stack:
    push ecx
    push edx
    push eax
    mov ecx, esp 
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 80h
    pop eax
    pop edx
    pop ecx
    ret

simple_quit:
    mov eax, 1
    mov ebx, 0
    int 80h
    ret

simple_string_length:
    push    ebx
    mov     ebx, eax
    nextchar:
        cmp     byte [eax], 0
        jz      finished
        inc     eax
        jmp     nextchar
    
    finished:
        sub     eax, ebx
        pop     ebx
        ret
 

 simple_read_one_digit:
    push ebx
    push ecx
    push edx
    sub esp, 4
    mov dword [esp], 0 
    mov eax, 3
    mov ebx, 0
    mov ecx, esp
    mov edx, 4
    int 80h

    movzx eax, byte [esp]
    add esp, 4
    pop edx
    pop ecx
    pop ebx
    ret


simple_new_line:
    push eax
    push ebx
    mov eax, 0ah
    mov ebx, 1
    call simple_print_from_stack
    pop ebx
    pop eax
    ret

simple_print_integer:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    xor esi, esi
    mov ebx, 10
    mov ecx, eax
    loop:
        mov eax, ecx
        xor edx, edx
        div ebx
        add edx, '0'
        push edx
        inc esi
        sub edx, '0'
        mov ecx, eax
        cmp eax, 0
        jz loop_done
        jmp loop
    
    loop_done:
        pop eax
        mov ebx, 4
        call simple_print_from_stack
        sub esi, 1
        cmp esi, 0
        jz print_done
        jmp loop_done
    
    print_done:
        pop esi
        pop edx
        pop ecx
        pop ebx
        pop eax
        ret