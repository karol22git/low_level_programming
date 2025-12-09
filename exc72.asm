global wartosc


wartosc:
    push rbp
    mov rbp, rsp
    push rcx
    mov rcx, rdi

    mulsd xmm0, xmm2
    addsd xmm0, xmm1
    movsd xmm1, xmm0

    cmp rcx, 1
    je done

    cmp rcx, 0
    je one

    dec rcx
wartosc_loop:
        mulsd xmm0, xmm1
    loop wartosc_loop
    jmp done

one:
    divsd xmm0, xmm0

done:
    pop rcx
    mov rsp, rbp
    pop rbp
    ret