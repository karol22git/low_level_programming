BITS 32
section .text
global iloczyn
iloczyn:
    push ebp 
    mov ebp,esp 
    push ebx
    push ecx
    push edx
    push edi

    mov ecx, [ebp+8]
    mov edi, [ebp+12]

    xor eax, eax
    xor edx, edx

    mov eax, [edi]
    dec ecx
    cmp ecx, 0
        je .done
    .addition_loop:
        add edi, 4
        mov ebx, [edi]
        imul eax, ebx
    loop .addition_loop

    .done:
        pop edi
        pop edx
        pop ecx
        pop ebx
        MOV ESP, EBP
        POP EBP 
ret
