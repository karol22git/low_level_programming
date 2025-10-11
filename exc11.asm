; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026

%include "simple_library.asm"
section .text

global _start

_start:
    mov eax, greeting
    mov ebx, length
    call simple_print

    mov eax, 3 ; wywołanie systemowe 
    mov ebx, 0 ; skąd czytamy
    mov ecx, user_input ; gdzie zapisujemy
    mov edx, 255 ; ile czytamy
    int 80h

    mov eax, hello
    mov ebx, hello_length
    call simple_print

    mov eax, user_input
    call simple_string_length

    mov ebx, eax
    sub ebx, 1
    mov eax, user_input
    call simple_print

    mov eax, greeting2
    mov ebx, greetings2_length
    call simple_print

    call simple_quit

section .data
    greeting db "Witaj, jak masz na imie? "
    length equ $ - greeting
    hello db "Czesc, "
    hello_length equ $ - hello
    greeting2 db ". Bardzo milo jest mi Cie poznac.", 0ah
    greetings2_length equ $ - greeting2

section .bss
    user_input: resb 255