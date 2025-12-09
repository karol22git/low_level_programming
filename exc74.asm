
global podatek, wypisz

extern printf

podatek:
    push rbp 
    mov rbp, rsp
    push rbx
    push rcx
    ;zz:
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx

    mov rax, rdi
    shr rax, 32

    movsx rbx, edx

    mov rcx, rdx
    shr rcx, 32

    sub rsp, 4
    mov [rsp], eax
    movss xmm0, [rsp]
    mov [rsp], ebx
    movss xmm1, [rsp]
    mov [rsp], ecx
    movss xmm2, [rsp]
    add rsp, 4

    subss xmm0, xmm1
    mulss xmm0, xmm2

    pop rcx
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

wypisz:
    push rbp 
    mov rbp, rsp

    push rbx
    push rcx
    push rdx
    push rdi
    mov eax, [rdi+4]
    shl rax, 32
    mov ebx, [rdi+12]
    shl rbx, 32
    xor rcx, rcx
    mov ecx,[rdi+8]
    or  rbx, rcx
    mov rdi, rax
    mov rdx, rbx
    call podatek
    cvtss2sd xmm1,xmm0


    pop rdi
    mov eax, [rdi+4]
    movd xmm0, eax
    cvtss2sd xmm0, xmm0

    mov eax, [rdi]
    mov rdi, text
    mov esi, eax
    mov rax, 2
    sub rsp, 8
    call printf
    add rsp, 8



    pop rdx
    pop rcx
    pop rbx
    mov rsp, rbp
    pop rbp
    ret

section .data
    text db "Faktura %d : obrot %f podatek %f\n", 0ah