%include "64_library.asm"

section .text

global _start

_start:
    ;pop rcx
    ;mov rax, [rsp]
    pop rax
    pop rax
    pop rax
    call st_to_int
    mov r10, rax
    pop rax
    call st_to_int
    mov r8, rax
    pop rax
    call st_to_int
    mov r9, rax
    ;mov r8, 100
    ;mov r9, 1000
    ;mov r10, 5
    xor r11, r11
    tst_loop2:
        cmp r8, r9
        jge done_
        mov rax, r10
        mov rbx, r8
        call NWD
        cmp rax, 1
        je i_have_nwd_1
        inc r8
        jmp tst_loop2
        i_have_nwd_1:
            push r8
            inc r8
            inc r11
            jmp tst_loop2
    done_:
        prnt_loop:
        mov rax, [rsp +r11*8 -8]
        push r11
        call print_int
        call print_space
        pop r11
        dec r11
        cmp r11, 0
        jg prnt_loop
    call print_newline
    mov rax, 60 
    mov rdi, 0 
    syscall  