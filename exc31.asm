%include "64_library.asm"

section .text
global _start

_start:
    xor r8, r8
    user_input_loop:
        sub rsp, 8
        inc r8
        mov rax, rsp    
        call read_input
        mov rax, rsp
        cmp byte [rax], '0'
        je user_input_loop_done
        jmp user_input_loop
    user_input_loop_done:
    mov rax, rsp
    call read_input
    mov rax, rsp
    call signed_st_to_int
    add rsp, 8
    mov r9, rax
    xor r10, r10
    xor r11, r11
    summing:
        mov rax, rsp
        call signed_st_to_int
        xor rdx, rdx
        cqo
        idiv r9
        cmp rdx, 0
        jne not_dividable_by_a
        inc r10
        not_dividable_by_a:
        dec r8
        add rsp, 8
        cmp r8, 0
        je ddd_
        jmp summing
    ddd_:
    mov rax, r10
    call print_int
    call print_newline
mov rax, 60 
mov rdi, 0 
syscall 