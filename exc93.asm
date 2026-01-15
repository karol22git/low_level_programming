global scaleSSE

scaleSSE:
    push rbp
    mov rbp, rsp
    mov r8, rdx


sub rsp, 4
mov dword [rsp],4
movss xmm7, dword [rsp]
vbroadcastss ymm7, xmm7
add rsp, 4



mov rcx, 50
scale_loop:
    vmovups ymm0, [rsi]
    vmovups ymm1, [rsi+4]
    vmovups ymm2, [rsi+4*r8]
    vmovups ymm3, [rsi+ 4*r8+ 4]

    vaddps ymm4, ymm0, ymm1
    vaddps ymm4, ymm4, ymm2
    vaddps ymm4, ymm4, ymm3

    vdivps ymm4, ymm4, ymm7
    ; 10 00 10 00
    ;a0 od prawej
    vpermilps ymm0, ymm0, 0x88
    ;[avg0, avg2, avg0, avg2, avg4, avg6, avg4, avg6]

    vmovlps [rdi], xmm0
    vextractf128 xmm1, ymm0, 1
    vmovlps [rdi + 8], xmm1
    
    add rdi, 16
    add rsi, 32
loop scale_loop

    mov rsp, rbp
    pop rbp
    ret
