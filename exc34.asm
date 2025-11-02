%include "64_library.asm"

section .data
    szyfr db "ga","de","ry","po","lu","ki", " -", 0, 0
    msg db "12356gug-mg-iptg-ipt-mg-osg", 0ah
    msg_l equ $ - msg
; upper po lewej, lower po prawej
section .text
global _start 
_start:
    mov rax, msg
    mov rbx, msg_l
    call simple_print
    push msg
    push szyfr
    call encription
    mov rax, msg
    mov rbx, msg_l
    call simple_print
    mov rax, 60
    mov rdi, 0
    syscall 
