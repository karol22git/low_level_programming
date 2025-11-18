
section .text

global tablicuj

tablicuj:
    push ebp
    mov ebp, esp
    %define a qword [ebp + 8]
    %define b qword [ebp + 16]
    %define P qword [ebp + 24]
    %define Q qword [ebp + 32]
    %define xmin qword [ebp + 40]
    %define xmax qword [ebp + 48]
    %define k dword [ebp + 56]
    mov edx, [ebp + 60]
    mov ecx, k
    sub esp, 8
    mov [esp], dword 2
    %define two dword [esp]
    mov [esp+4], dword 1
    %define one dword [esp+4]
    _p:

    finit
    fld xmax
    fld xmin
    fsubp st1

    fild k
    fild one
    fsubp st1
    fdivp st1

    fld xmin
    fild two
    fldpi
    fld P
    fmulp st1
    fmulp st1

    fild two
    fldpi
    fld Q
    fmulp st1
    fmulp st1

    ; czyli teraz na stosie mam od konca step, x, wyrazenie P, wyrazenia Q
    tablicuj_loop:
    fld st1
    fmul st3
    fsin
    fmul st0
    fld a
    fmulp st1

    fld st1
    fmul st4
    fsin
    fmul st0
    fld b
    fmulp st1
    faddp st1

    fstp qword [edx]
    add edx, 8
    fld st2
    fadd st4
    fstp st3

    loop tablicuj_loop
    add esp, 8
    mov esp, ebp
    pop ebp
    ret