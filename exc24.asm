%include "64_library.asm"

section .text

global _start

_start:
    mov r8, 101
    mov r9, 200
    mov r10, 30
    xor r11, r11
    mov rax, r10
    mov rbx, r8
    call NWD
    call print_int

    mov rax, 60 
    mov rdi, 0 
    syscall  