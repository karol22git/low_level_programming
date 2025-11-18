section .text

global iloczyn_skalarny


iloczyn_skalarny:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]
    mov edx, [ebp + 16]
    finit
    fldz
    dot_loop: 
        fld tword [ebx]
        fld tword [edx]
        fmulp st1
        faddp st1
        add ebx, 12
        add edx, 12
    loop dot_loop
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret