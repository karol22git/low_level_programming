%include "helper.asm"


SECTION .text

global _start


_start:
    pop ecx
    pop ecx
    pop eax
    call string_to_int
    mov [prime_candidate], eax
    cvtsi2ss xmm0, eax
    sqrtss xmm1, xmm0
    cvtss2si eax, xmm1
    add eax, 1
    mov [square_root], eax
    
    mov esi, 2
loop:
    mov ebx, esi
    sub ebx, [square_root]
    cmp ebx, 0 
    jz prime
    mov eax, [prime_candidate]
    div esi
    cmp edx, 0
    jz divisor_found
    inc esi
    xor edx, edx
    jmp loop

divisor_found:
    mov ecx, [prime_candidate]
    cmp ecx, 2
    jz prime
    mov eax, no
    call print_message
    call print_new_line
    jmp end
prime:
    mov eax, yes
    call print_message
    call print_new_line
end:
    mov ebx, 0 
    mov eax, 1
    int 80h


SECTION .data
err db "error", 0Ah, 0h
yes db "yes", 0Ah, 0h
no db "no", 0Ah, 0h

SECTION .bss
square_root: resd 1
prime_candidate: resd 1