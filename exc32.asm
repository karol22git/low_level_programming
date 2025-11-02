%include "64_library.asm"

section .data
  tab1 dd 4, -5, 91, 44, 104, 4
  tab2 dd -1, -2, -3, -5
;...
section .text
global _start 
_start:
  push tab2
  push 4
  call find_max    ; wynik = -1
  call print_int
  call print_newline
  mov rax, 60 
  mov rdi, 0 
  syscall 
