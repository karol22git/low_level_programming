global sum


section .text

sum:
    push rbp
    mov rbp, rsp
    push rbx
    cmp rax, 0
    je .version1
    cmp rax, 1
    je .version2
    jmp .version3

.version1:
    mov rbx, 0
    jmp .computations

.version2:
    mov rbx, 8
    jmp .computations

.version3:
    mov rbx, 16

.computations:
    mov rcx, rsi
    xor r8, r8

sub rsp, 48
movsd [rsp], xmm0
movsd [rsp+16], xmm1
xorsd xmm3, xmm3
movsd [rsp+32], xmm3
mov rsi, rdi

.computations.loop:
    movsd xmm0, [rsp]
    movsd xmm1, [rsp + 16]
    mov rdi, rsi
    mov rdi, [rdi]
    mov rdi, [rdi]
    add rdi, rbx
    push rsi
    push rbx
    push rcx
    call rdi
    pop rcx
    pop rbx
    pop rsi
    movsd xmm1, [rsp+32]
    addsd xmm0, xmm1
    movsd [rsp+32], xmm0
    add rsi, 8
loop .computations.loop
    pop rbx
    mov rsp, rbp
    pop rbp