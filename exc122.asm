global zmien
global mest
extern malloc

section .text

; czyli "template" wyglada tak
;mamy w r8 void*
; robimy [r8] dostajym te klase
; teraz [klasa] dostajemy vtable



zmien:
    push rbp
    mov rbp, rsp
    push rdi
    mov rdi, 24
    call malloc
    pop r8

    mov rcx, gest
    mov [rax], rcx

    mov rbx, [r8]
    mov rdx, [rbx+8]
    mov [rax+8], rdx

    mov rdx, [rbx]
    mov [rax+16], rdx

    mov [r8], rax

    mov rsp, rbp
    pop rbp
    ret


gest:
    mov rax, [rdi]
    mov rax, [rax+16]
    sub rsp, 8
    call rax
    add rsp, 8
    sub rax, 1
    ret