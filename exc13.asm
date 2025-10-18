; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026

%include "simple_library.asm"

section .text

global _start

_start:
    ; wrongly append create
    ;mov ecx, 2000o || 2o || 1o
    ;mov ecx, 1o || 2000o || 100o
    mov ecx, 02001o
    mov     ebx, filename       ; filename we created above
    mov     eax, 5              ; invoke SYS_OPEN (kernel opcode 5)
    mov edx, 0644o
    int     80h 

    mov esi, eax

    mov eax, 4
    mov ebx, esi
    mov ecx, text   
    mov edx, text_length 
    int 80h          

    mov eax, 6
    mov ebx, esi
    int 80h

    call simple_quit


section .data
    text db "Karol Melanczuk", 0ah
    text_length equ $ - text
    filename db "zad13.txt", 0ah
    filename_length equ $ - filename
