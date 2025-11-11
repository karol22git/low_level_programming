BITS 32
section .text
global minmax
minmax:
enter 0, 0     ;  tworzymy ramkę stosu na początku funkcji
    ;ENTER 0,0 = PUSH EBP / MOV EPB, ESP
    ;po wykonaniu enter 0,0
    ;w [ebp]    znajduje się stary EBP
    ;w [ebp+4]  znajduje się adres powrotny z procedury
    ;w [ebp+8]  znajduje się pierwszy parametr,
    ;w [ebp+12] znajduje się drugi parametr
    ;itd.
    _d:
    push ecx
    push ebx
    mov ecx, [ebp+12]
    _p:
    mov eax, [ebp+ecx*4+12]
    mov ebx, [ebp+ecx*4+12]
    minmax_loop:
        mov edx, [ebp+ecx*4+12]
        cmp eax, edx
        jg AgD
        mov eax, edx
        jmp cmp_done
        AgD:
        cmp ebx, edx
        jl cmp_done
        mov ebx, edx
        cmp_done:
    loop minmax_loop
    mov ecx, [ebp+8]
    mov [ecx], ebx
    add ecx, 4
    mov [ecx], eax
    pop ebx
    pop ecx
    ;pop ecx
    ;pop ebx
leave
ret
