section .text


global prostopadloscian

prostopadloscian:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    finit

    %define a dword [ebp + 8]
    %define b dword [ebp + 12]
    %define c dword [ebp + 16]

    sub esp, 4
    mov [esp], dword 2

    %define two dword [esp]
    mov ebx, [ebp + 20]
    mov ecx, [ebp + 24]
        fld a
        fmul b
        fmul c
    fstp dword [ebx]
        fild two
        fld a
        fmul b
        ;fild two
        fmul st1
        ;fstp dword [ecx]
        fld a
        fmul c
        ;fild two
        fmul st2
        faddp st1 
;fstp dword [ecx]
        fld b
        fmul c
        ;fild two
        fmul st2
        faddp st1
        ;faddp st1 

    fstp dword [ecx]
    fstp
    prostopadloscian_done:
        add esp, 4
        pop ecx
        pop ebx
        mov esp, ebp
        pop ebp
    ret