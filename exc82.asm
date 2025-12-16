global zeruj, kopiuj

zeruj:
    push rbp
    mov rbp, rsp
    push rcx

    cld
    mov rcx, rsi
    xor rax, rax
    rep stosd

    pop rcx
    mov rsp, rbp
    pop rbp
    ret

kopiuj:
    push rbp
    mov rbp, rsp
    push rcx
    
    cld
    mov rcx, rdx
    rep movsd


    pop rcx
    mov rsp, rbp
    pop rbp
    ret