%include "helper.asm"

SECTION .text


global _start

_start:
    pop eax
    pop eax
    pop eax
    call string_to_int
    mov ebx, 4
    mov r8d, eax ;zakres
    mov ebp, 2 ; aktualna i
    imul ebx
    sub esp, eax
    mov edi, eax
    mov ebx, 1
    mov edx, 4
    fullfill_loop:
        mov [esp], ebx
        inc ecx
        mov eax, ecx
        cmp ecx, r8d
        jz fullfill_done
        sub eax, 1
        mul edx
        add esp, eax
        jmp fullfill_loop
    fullfill_done:
    mov eax, r8d
    mov ebx, 4
    imul ebx
    sub esp, eax
    mov ecx, 1

fetch_loop:
    inc ecx
    mov eax, ecx
    sub eax, 1
    imul ebx
    add esp, eax
    mov eax, [esp]
    cmp eax, 1
    jz proceed_sieve
    jmp fetch_loop

proceed_sieve:
    mov edx, 2
    mov ebx, eax
sieve_loop:
    imul edx
    inc edx
    sub eax, 1
    imul ebx
    add esp, eax
    mov ecx, [esp]
    cmp ecx, r8d
    jg 

    


_end:
    mov ebx, 0 
    mov eax, 1
    int 80h

SECTION .data
equal db "equal", 0ah