global _Z5zerujPjj
global _Z6kopiujPjS_j
global  _ZN6BigInt5dodajEj
global _ZN6BigInt6pomnozEj
global _ZN6BigInt14podzielZResztaEj
_Z5zerujPjj:
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

_Z6kopiujPjS_j:
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


; w rdi wskaznik this
; w rsi pierwszy argument

 _ZN6BigInt5dodajEj:
    push rbp
    mov rbp, rsp
    push rcx
    push rbx

    xor rbx, rbx
    xor rax, rax
    xor ecx, ecx
    mov ecx, dword [rdi]

    add rdi, 8
    mov eax, 1
    mov edi, dword [rdi]
    mov eax, [edi]

    add eax, esi
    setc bl

    mov dword [edi], eax
    add edi, 4
    dec rcx
    cmp bl, 0
    je done_with_no_carry

    cmp rcx, 0
    je done_with_carry

carry_add_loop: 
    mov eax, [edi]
    add eax, ebx
    setc bl
    mov dword [edi], eax
    add edi, 4
    cmp bl, 0
    je done_with_no_carry
loop carry_add_loop

done_with_carry:
    mov rax, 1
    jmp done
    done_with_no_carry:
    xor rax, rax

    done:
    pop rbx
    pop rcx
    mov rsp, rbp
    pop rbp
    ret


 _ZN6BigInt6pomnozEj:
    push rbp
    mov rbp, rsp
    push rbx
    xor rax, rax
    xor rcx, rcx
    xor rbx, rbx
    mov r8d, esi ; tutaj mamy n
    mov ecx, dword [rdi] ; tutaj mamy rozmiar liczby
    add rdi, 8 ; uwzgledniamy cos tam i mamy wskaznik do tablicy elemntow
    mov edi, dword [rdi] ;teraz w edi mamy wskaznik na tablice
    ff:


    mov eax, [edi]
    xor rdx, rdx
    mul r8d
    mov [edi], eax
    cmp edx, 0
    je no_carry
    add bl, 1
    jmp carry_done
    no_carry:
    xor rbx, rbx
    carry_done:
    dec ecx
    cmp ecx, 0
    je pomnoz_done
    add edi, 4

    xor r10d, r10d
pomnoz_loop:
    mov r9d, edx
    mov r11d, r10d

    xor edx, edx
    mov eax, [edi]
    mul r8d

    add eax, r9d


    setb bl
    cmp bl, 1
    je add_overflow

xor r10d, r10d
    jmp add_overflow_handled

add_overflow:
    mov r10d, 1
add_overflow_handled:
    xor ebx, ebx
    add eax, r11d

    setb bl
    cmp bl, 1
    je add_overflow2

    jmp add_overflow2_handled

add_overflow2:
    add r10d, 1
add_overflow2_handled:
gg:
xor rbx, rbx
mov [edi], eax
add edi, 4
loop pomnoz_loop

    cmp edx, 0
    jg m_overflow


    cmp r10d,0 
    jg a_overflow

    xor rbx, rbx
    jmp pomnoz_done

m_overflow:
    mov rbx, 1
    jmp pomnoz_done

a_overflow:
    mov rbx,1
pomnoz_done:
    mov rax, rbx
    pop rbx
    mov rsp, rbp
    pop rbp
    ret


 _ZN6BigInt14podzielZResztaEj:
    push rbp
    mov rbp, rsp
    push rbx


    xor r10d, r10d ;reszta
    mov r8d, esi ; tutaj mamy n
    mov ecx, dword [rdi] ; tutaj mamy rozmiar liczby
    add rdi, 8 ; uwzgledniamy cos tam i mamy wskaznik do tablicy elemntow
    mov edi, dword [rdi] ;teraz w edi mamy wskaznik na tablice

    mov eax, ecx
    mov ebx, 4
    mul ebx
    add edi, eax
    sub edi, 4
    xor eax, eax
    kkk:
    ;dopiero tutja mamy koncowy element tablicy
    xor rax, rax
    mov ebx, [edi]
    add rax, rbx
    xor rax, rax
    div r8d
    mov [edi], eax
    mov r10d, edx
    dec ecx
    sub edi, 4
    cmp ecx, 0
    je div_done
div_loop:
    xor rax, rax
    mov eax, r10d
    shl rax, 32
    xor rbx, rbx
    mov ebx, [edi]
    add rax, rbx
    xor rdx, rdx
    div r8d
    mov [edi], eax
    mov r10d, edx
    sub edi, 4
loop div_loop
div_done:
    xor rax, rax
    mov eax, r10d
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
