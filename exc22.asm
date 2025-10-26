%include "64_library.asm"

section .text

global _start

_start:
    xor rsi, rsi
    mov rax, -98123
    cmp rax, 0
    jg positive
        mov r9, 1
        mov rbx, -1
        mul rbx
    positive:
    mov r8, 0
    mov rbx, 10
    main_loop:
        xor rdx, rdx
        div rbx
        add rdx, '0'
        push rdx
        inc rsi
        cmp rax, 0
        je main_loop_done
        jmp main_loop

    main_loop_done:
    mov r8, rsi
    cmp r9, 0
    je positive_number
    mov rax, '-'
    push rax
    mov rsi, rsp
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rax
    positive_number:
    print_loop:
        mov rsi, rsp
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        dec r8
        add rsp, 8
        cmp r8, 0
    jg print_loop

    mov rax, 0ah
    push rax
    mov rsi, rsp
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rax


    mov rax, 60 
    mov rdi, 0 
    syscall 
