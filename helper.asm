
string_length:
    xor ebx, ebx
string_length_loop:
    cmp byte [eax], 0 
    jz string_length_done
    add ebx, 1
    add eax, 1
    jmp string_length_loop
string_length_done:
    sub ebx, 1
    mov eax, ebx
    ret

print_new_line:
    ;push eax
    mov eax, 0Ah
    push eax
    mov ecx, esp
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 80h
    pop eax
    ;pop eax
    ret

print_message:
    push eax
    mov ecx, esp
    pop eax
    call string_length
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    int 80h
    ret

find_number_indicator:
    xor esi, esi
    xor edi, edi
    mov edx, 1
    mov esi, 10
    mov ecx, eax
indicator_loop:
        div esi
        cmp eax, 0
        jz indicator_done
        add edi, 1
        mov eax, esi
        mov ebx, 10
        mul ebx
        mov esi, eax
        mov eax, ecx
        jmp indicator_loop
indicator_done:
    mov eax, edi
    ret


ten_to_n:
    mov edi, eax
    mov eax, 1
    mov ebx, 10
    ten_to_n_loop:
        mul ebx
        sub edi, 1
        cmp edi, 0
        jz ten_to_n_done
        jmp ten_to_n_loop
    ten_to_n_done:
    ret

print_one_number:
    push eax
    mov ecx, esp
    pop eax
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 80h
    ret

print_integer:
    push eax
    call find_number_indicator
    mov edi, eax
    pop esi
    print_integer_loop:
        push edi
        mov eax, edi
        call ten_to_n
        pop edi
        mov ebx, eax
        mov eax, esi
        div ebx
        push ebx
        push eax
        add eax, 48
        call print_one_number
        pop eax
        pop ebx
        mul ebx
        sub esi, eax
        sub edi, 1
        cmp edi, 0
        jz print_integer_end
        jmp print_integer_loop
    print_integer_end:
        mov eax, esi
        add eax, 48
        call print_one_number
        call print_new_line
    ret