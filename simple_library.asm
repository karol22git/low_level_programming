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
 