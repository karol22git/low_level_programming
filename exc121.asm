global zmien
global oblicz

extern malloc
section .text

zmien:
    push rbp
    mov rbp, rsp

    push rdi
    mov rdi, 16
    call malloc
    pop r8

    mov rdx, oblicz
    mov [rax], rdx

    mov [r8],rax

    mov rsp, rbp
    pop rbp
    ret


oblicz:
    mov eax, esi
    add eax, eax
    add eax, esi
    ret