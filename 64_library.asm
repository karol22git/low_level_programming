; Karol Melanczuk
; Programowanie Niskopoziomowe 2025/2026


string_length:
    push rdx
    push rbx
    xor rdx, rdx
    xor rbx, rbx
    string_loop:
        mov bl, [rax]
        inc rax
        cmp bl, 0ah
        je string_length_done
        inc rdx
    jmp string_loop
    string_length_done:
    mov rax, rdx
    pop rbx
    pop rdx
    ret

st_to_int:
    push rdi
    push rdx
    push rbx
    push rcx
    xor rcx, rcx
    xor rdx, rdx
    mov rdi, rax
    xor rax, rax
    mov rbx, 10
    st_to_int_loop:
        mov cl, [rdi]
        cmp cl, 0ah
        je st_to_int_end
        cmp cl, 0
        je st_to_int_end
        sub cl, '0'
        mul rbx
        add rax, rcx
        inc rdi
        jmp st_to_int_loop
    st_to_int_end:
    pop rbx
    pop rdx
    pop rdi
    pop rcx
    ret
    
print_digit:
    push rdi
    push rsi
    push rdx
    add rax, '0'
    push rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    pop rax
    pop rdx
    pop rsi
    pop rdi
    ret

is_dividable:
    push rdx
    xor rdx, rdx
    div rbx
    cmp rdx, 0
    je dividable
    mov rax, 0
    jmp is_done
    dividable:
        mov rax, 1
    is_done:
    pop rdx
    ret

square_condition:
    push rdx
    mul rax
    cmp rax, rbx
    jg grtr
    mov rax, 0
    jmp grtr_done    
    grtr:
        mov rax, 1
    grtr_done:
    pop rdx
    ret

is_prime:
    push rsi
    push r8
    push r9
    xor r8, r8
    mov r8, 1
    xor rsi, rsi
    mov rsi, 2
    mov rdi, rax
    prime_loop:
        mov rax, rsi
        mov rbx, rdi
        call square_condition
        cmp rax, 1
        je is_prime_loop_done
        mov rax, rdi
        mov rbx, rsi
        call is_dividable
        cmp rax, 1
        je found_dividable
        jmp not_found_dividable
        found_dividable:
            mov r8, 0
            jmp is_prime_loop_done
        not_found_dividable:
            inc rsi
            jmp prime_loop    
    is_prime_loop_done:
    mov rax, r8
    pop r9
    pop r8
    pop rsi
    ret

primitve_square:
    push rdi
    push rsi
    push rdx
    mov rdi, rax
    mov rsi, 2
    mov rax, rsi
    square_loop:
        mul rsi
        cmp rax, rdi
        jg found_square
        inc rsi
        mov rax, rsi
        jmp square_loop

    found_square:
        mov rax, rsi
        dec rax
        pop rdx
        pop rsi
        pop rdi
        ret

print_int:
    push rsp
    push rsi
    push r9
    push r8

    xor rsi, rsi
    mov r9, 0
    cmp rax, 0
    jge positive
        mov r9, 1
        neg rax
    positive:
    mov r8, 0
    mov rbx, 10
    main_loop:
        xor rdx, rdx
        div rbx
        add rdx, '0'
        push rdx
        inc rsi
        cmp rax, 0
        je main_loop_done
        jmp main_loop

    main_loop_done:
    mov r8, rsi
    cmp r9, 0
    je positive_number
    mov rax, '-'
    push rax
    inc r8
    ;mov rsi, rsp
    ;mov rax, 1
    ;mov rdi, 1
    ;mov rdx, 1
    ;syscall
    ;pop rax
    positive_number:
    print_loop:
        mov rsi, rsp
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        dec r8
        add rsp, 8
        cmp r8, 0
    jg print_loop

    ;mov rax, ' '
    ;push rax
    ;mov rsi, rsp
    ;mov rax, 1
    ;mov rdi, 1
    ;mov rdx, 1
    ;syscall
    ;push rax
    ;pop rax
    pop r8
    pop r9
    pop rsi
    pop rsp
    ret


NWD:
    push rcx
    nwd_loop:
    cmp rbx, 0
    je nwd_done
    mov rcx, rbx
    call aModb
    mov rbx, rax
    mov rax, rcx
    jmp nwd_loop
    nwd_done:
        ;mov rax, rbx
        pop rcx
        ret


aModb:
    push rdx
    xor rdx, rdx
    cmp rbx, 0
    je corner_0
    div rbx
    mov rax, rdx
    pop rdx
    corner_0:
    ret

print_space:

    mov rax, ' '
    push rax
    mov rsi, rsp
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rax
    ret

print_newline:
    mov rax, 0ah
    push rax
    mov rsi, rsp
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rax
    ret

read_input:
    push rdi
    push rsi
    push rdx
    mov rsi, rax
    mov rax, 0
    mov rdi, 0
    mov rdx, 8
    syscall
    pop rdx
    pop rsi
    pop rdi
    ret

simple_print:
    push rsi
    push rdx
    push rdi
    mov rsi, rax
    mov rdx, rbx
    mov rax, 1
    mov rdi, 1
    syscall
    pop rdi
    pop rdx
    pop rsi
    ret

signed_st_to_int:
    push rdi
    push rdx
    push rbx
    push rcx
    push r8

    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8

    mov rdi, rax
    xor rax, rax
    mov rbx, 10

    cmp byte [rdi], '-'
    jne signed_st_to_int_loop
        mov r8, 1
        inc rdi
    signed_st_to_int_loop:
        mov cl, [rdi]
        cmp cl, 0ah
        je signed_st_to_int_end
        cmp cl, 0
        je signed_st_to_int_end
        sub cl, '0'
        mul rbx
        add rax, rcx
        inc rdi
        jmp signed_st_to_int_loop
    signed_st_to_int_end:
    cmp r8, 1
        jne next
          neg rax
    next:
    pop r8
    pop rbx
    pop rdx
    pop rdi
    pop rcx
    ret

find_max:
    pop rbp
    pop rax
    pop rbx
    xor r8, r8
    mov r9, rax
    movsx r8, dword [rbx]
    find_max_loop:
        cmp r9, 0
        je find_max_done
        movsx rax, dword [rbx]
        cmp rax, r8
        jl not_greater
            mov r8, rax
        not_greater:
            dec r9
            add rbx, 4
            jmp find_max_loop
    find_max_done:
    mov rax, r8
    push rbp
    ret

encription:
    pop rbp
    pop r8  ; szyfr
    pop r9  ; wiadomsc
    outer_encr_loop:
        xor rax, rax
        mov ax, [r8]
        cmp al, 0
        je encription_done
        add r8, 2
        mov rbx, r9
        inner_encr_loop:
            cmp byte [rbx], 0ah
            je outer_encr_loop
            cmp ah, byte [rbx]
            je find_high   
            cmp al, byte [rbx]
            je find_lower
            inc rbx
            jmp inner_encr_loop
            find_high:
                mov byte [rbx], al
                inc rbx
                jmp inner_encr_loop
            find_lower:
                mov byte [rbx], ah
                inc rbx
                jmp inner_encr_loop
    encription_done:
    push rbp
    ret

signed_int_to_string:
    push rsp
    push r10
    xor r10, r10
    cmp rax, 0
    jge positivex
        mov r10b, '-'
        shl r10, 8
        ;mov r9, 1
        neg rax
    positivex:
    mov rbx, 10
    main_loopx:
        shl r10, 8
        xor rdx, rdx
        div rbx
        add rdx, '0'
        mov r10b, dl
        cmp rax, 0
        je main_loop_donex
        jmp main_loopx
    main_loop_donex:
    mov rax, r10
    pop r9
    pop rsp
    ret