%include "helper.asm"

SECTION .text


global _start

_start:
    pop eax
    pop eax
    pop eax
    call string_to_int
    mov [range], eax 
    mov ebp, esp
    imul dword [four]
    sub esp, eax
    mov ebx, -4
    mov eax, [one]
    mov edx, 1
    mov edi, 0
    _fill_loop:
        mov [ebp + ebx], eax
        cmp edx, [range]
        je next_step
        sub ebx, 4
        inc edx  
    jmp _fill_loop
next_step:
    mov esi, 1
    mov ebx, -8

    fetch_loop:
        mov eax, [ebp + ebx]
        inc esi
        sub ebx, 4
        mov ecx, 2
        cmp esi, [range]
        je next_step_2
        cmp eax, [one]
        je proceed_sieve   
    jmp fetch_loop

    proceed_sieve:
       mov eax, esi
       imul ecx
       cmp eax, [range]
       jg fetch_loop
       inc ecx
       imul dword [four]
       imul dword [none]
       mov [ebp + eax],  edi
    jmp proceed_sieve

    next_step_2:
        mov esi, 1
        mov edi, -4
    write_loop:
        mov eax, [ebp + edi]
        cmp eax, [zero]
        je no_prime
        cmp esi, 10
        jg g_than_10
        mov eax, esi
        add eax, 48
        call print_one_number
        call print_new_line
        jmp no_prime
        g_than_10:
            mov eax, esi
            push esi
            push edi
            call print_integer
            pop edi
            pop esi
        no_prime:

        inc esi
        sub edi, 4
        cmp esi, [range]
        je _end
    jmp write_loop
    _end:
    mov ebx, 0 
    mov eax, 1
    int 80h



SECTION .data
equal db "equal", 0ah
four dd 4
one dd 1
none dd -1
zero dd 0
two dd 2

SECTION .bss
range: RESD 1