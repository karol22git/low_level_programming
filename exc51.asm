section .text
; y=ax^3+bx^2+cx+d.
global wartosc
wartosc:
    push ebp
    mov ebp, esp
    finit

    %define a qword [ebp+8]
    %define b qword [ebp+16]
    %define c qword [ebp+24]
    %define d qword [ebp+32]
    %define x qword [ebp+40]
    fld a
    fmul x
    fadd b
    fmul x
    fadd c
    fmul x
    fadd d

    wartosc_done:
        mov esp, ebp
        pop ebp
    ret