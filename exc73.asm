global iloczyn



iloczyn:
    pop rax

    push r9
    push r8
    push rcx
    push rdx
    push rsi

    mov rsi, rsp
    mov r8, rbx
    mov r9, rax


    xor rax, rax
    mov rcx, rdi
    mov rax, [rsi]
    pp:

iloczyn_loop:
    mov rbx, [rsi]
    xor rdx, rdx
    mul rbx
    add rsi, 8
    loop iloczyn_loop

done:
    mov rbx, r8

    pop rsi
    pop rdx
    pop rcx
    pop r8
    pop r8
    push r9
    ret