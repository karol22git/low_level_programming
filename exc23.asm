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

    mov rax, number
    call st_to_int
    mov r8, rax
    mov r9, 2
    xor r10, r10

    call is_prime
    cmp rax, 1
    je already_a_prime

    jmp prime_factors_loop
    already_a_prime:
        mov rax, r8
        inc r10
        push rax
        jmp limit

    ; w r8 liczba badana
    ; w r9 aktualnie rozpatrywany dzielnik
    prime_factors_loop:
        cmp r9, r8
        jg limit

        mov rax, r9
        call is_prime
        cmp rax, 1
        jne not_a_prime

        mov rax, r8
        mov rbx, r9
        call is_dividable
        cmp rax, 1
        jne not_a_divisior

        ;mov rax, r9
        push r9
        inc r10
        mov rax, r9
        ;call print_int
        mov rax, r8
        div r9
        mov r8, rax
        call is_prime
        cmp rax, 1
        je already_a_prime

        jmp prime_factors_loop

        not_a_divisior:
            inc r9
            jmp prime_factors_loop

        not_a_prime:
            inc r9
            jmp prime_factors_loop
    limit:
        print_loopl:
        ;mov rax, r10
        ;mov rbx, 8
        ;mul rbx
        mov rax, [rsp+r10*8-8]
        call print_int
        mov rax, ' '
        push rax
        mov rsi, rsp
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        dec r10
        add rsp, 8
        cmp r10, 0
    jg print_loopl
    mov rax, 60 
    mov rdi, 0 
    syscall  


section .bss
    number resb 8
section .data
    question db "Podaj 8 bajtowa liczbe: ", 0ah
    question_lenght  equ $ - question