global suma

suma:
    push rbp
    mov rbp, rsp
    push rcx

    mov rcx, rdi
    xor rax, rax
    add rax, [rsi]
    dec rcx
    add rsi, 4
    cmp rcx, 0
    je done
    suma_loop:
        add rax, [rsi]
        add rsi, 4
    loop suma_loop
    done:
    pop rcx
    
    mov rsp, rbp
    pop rbp
    ret
