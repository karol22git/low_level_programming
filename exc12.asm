; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026

%include "simple_library.asm"

section .text

global _start

_start:
    mov eax, question1
    mov ebx, question1_length
    call simple_print
    call simple_read_one_digit
    sub eax, '0'
    push eax
    mov eax, question2
    mov ebx, question2_length
    call simple_print
    call simple_read_one_digit
    sub eax, '0'
    pop ebx
    xor edx, edx
    mul ebx
    call simple_print_integer
    call simple_new_line
    call simple_quit



section .data
    question1 db "Podaj pierwsza cyfre: ", 0ah
    question1_length equ $ - question1
    question2 db "Podaj druga cyfre: ", 0ah
    question2_length equ $ - question2