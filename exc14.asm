; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026

%include "simple_library.asm"

section .text

global _start
_start:
    mov eax, template
    mov ebx, template_length
    call simple_print
    mov eax, 13
    xor ebx, ebx
    int 80h

    mov esi, eax
    xor edx, edx
    mov ebx, 10
    div ebx
    add edx, '0'

   ; mov al, 1 + '0'
    mov [template + 13], dl
    xor edx, edx
    mov ebx, 6
    div ebx
    add edx, '0'
    mov [template +12], dl

    xor edx, edx
    mov ebx, 10
    div ebx
    add edx, '0'
    mov [template + 10], dl

    xor edx, edx
    mov ebx, 6
    div ebx
    add edx, '0'
    mov [template + 9], dl

    xor edx, edx
    mov ebx, 24
    div ebx
    mov eax, edx
    add eax, 2
    xor edx, edx
    mov ebx, 10
    div ebx
    add al, '0'
    add dl, '0'
    mov [template+7], dl
    mov [template+6], al


    mov eax, template
    mov ebx, template_length
    call simple_print
    call simple_quit

section .data
    template db "Time: ##:##:##", 0ah
    template_length equ $ - template