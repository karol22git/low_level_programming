
section .text

extern printf, scanf
global main  
main:
enter 0, 0
push b
push a
push question
call scanf
mov eax, [a]
mov ebx, [b]
xor edx, edx
cdq
idiv ebx
push  eax
push   dword napis
call   printf
add    esp, 2*4
xor    eax, eax
leave
ret
section .data
napis: db "%d", 10, 0
question: db "%d %d"
section .bss
    a RESD 1
    b RESD 1