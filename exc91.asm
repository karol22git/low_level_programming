global diff

diff:
    push rbp
    mov rbp, rsp
    push rbx
    mov rax, rdx
diff_loop:
    cmp rax, 33
    jl no_more_packed
    vmovdqu ymm0, [rsi]
    add rsi, 1
    vmovdqu ymm1, [rsi]
    vpsubsb ymm1, ymm0
    vmovdqu [rdi], ymm1
    add rdi, 32
    sub rax, 32
    add rsi, 31
jmp diff_loop
vxorps zmm1, zmm1
vxorps zmm0, zmm0
no_more_packed:

mov r8, rax
xor rax, rax
sub rsp, 33
mov rcx, 33
load_loop:
    cmp rax, r8
    jge load_zero
    xor rbx, rbx
    mov bl, byte [rsi]
    mov [rsp+rax], bl
    inc rsi
    jmp load_done
load_zero:
    mov [rsp+rax], byte 0
load_done:
    inc rax
loop load_loop
    vmovdqu ymm0, [rsp]
    vmovdqu ymm1, [rsp+1]
    vpsubsb ymm1, ymm0
    vmovdqu [rsp], ymm1
    xor rax, rax
save_loop:
    xor rbx, rbx
    mov bl, byte [rsp+rax]
    mov [rdi], bl
    inc rdi
    inc rax
    cmp rax, r8
    je done
jmp save_loop
    done:
    add rsp, 33
    pop rbx
    mov rsp, rbp
    pop rbp
    ret