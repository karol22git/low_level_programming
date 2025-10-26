%include "64_library.asm"
section .text

global _start

_start:
    mov rax, 1     
    mov rdi, 1          
    mov rsi, question
    mov rdx, question_lenght
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, number
    mov rdx, 8
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, liczba
    mov rdx, liczba_l
    syscall
    mov rax, number
    call string_length
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, number
    syscall

    mov rax, number
    call st_to_int
    call is_prime
    cmp rax, 1
    je prime
    
    mov rax, 1
    mov rdi, 2
    mov rsi, result2
    mov rdx, result2_l
    syscall
    jmp e_
    prime:
        mov rax, 1
        mov rdi, 1
        mov rsi, result1
        mov rdx, result1_l
        syscall


    e_:
    mov rax, 60 
    mov rdi, 0 
    syscall  


section .bss
    number resb 8
section .data
    question db "Podaj 8 bajtowa liczbe: ", 0ah
    question_lenght  equ $ - question
    good db "dziala! ", 0ah
    good_l equ $ - good
    result1 db " jest pierwsza!", 0ah
    result1_l equ $ - result1
    result2 db " nie jest pierwsza. ", 0ah
    result2_l equ $ - result2
    liczba db "Liczba: "
    liczba_l equ $ - liczba