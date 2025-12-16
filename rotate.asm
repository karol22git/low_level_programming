global _Z6rotateji, _Z6rotatehi

_Z6rotatehi:
    push rbp
    mov rbp, rsp
    push rcx

    xor rcx, rcx
    mov cl, sil
    rol dil, cl
    xor rax, rax
    mov al, dil


    pop rcx
    mov rsp, rbp
    pop rbp
    ret

_Z6rotateji:
    push rbp
    mov rbp, rsp
    push rcx
    xor rcx, rcx
    mov cl, sil
    rol rdi, cl
    mov rax, rdi
    pop rcx
    mov rsp, rbp
    pop rbp
    ret
