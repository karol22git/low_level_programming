
global gradientSSE


gradientSSE:
    push rbp
    mov rbp, rsp
    push rbx
    sub rsp, 4
    mov [rsp], ecx
    

    mov r8, rdx

    mov rax, rdx
    mov rbx, -1
    imul rbx
    mov r10, rax
    mov rcx, 8
grad_loop:
    vmovdqu ymm0, [rsi+4]
    vmovdqu ymm1, [rsi-4]

    vpsubps ymm0, ymm1
    vmulps ymm0, ymm0

    vmovdqu ymm2, [rsi+r8*4]
    vmovdqu ymm3, [rsi+r10*4]

    vpsubps ymm2, ymm3
    vmulps ymm2, ymm2

    vaddps ymm0, ymm2

    vsqrtps ymm0, ymm0

    vmovss xmm1, dword [rsp]
    vinsertf128 ymm1, ymm1, xmm1, 0 
    vshufps ymm1, ymm1, ymm1, 0
    vmulps ymm0, ymm1
    vmovdqu [rdi], ymm0
    add rdi, 256
    add rsi, 256
loop grad_loop
    pop rbx
    add rsp, 4
    mov rsp, rbp
    pop rbp
    ret