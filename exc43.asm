BITS 32
section .text
global sortuj
sortuj:
enter 0, 0     ;  tworzymy ramkę stosu na początku funkcji
;ENTER 0,0 = PUSH EBP / MOV EPB, ESP
;po wykonaniu enter 0,0
;w [ebp]    znajduje się stary EBP
;w [ebp+4]  znajduje się adres powrotny z procedury
;w [ebp+8]  znajduje się pierwszy parametr,
;w [ebp+12] znajduje się drugi parametr
;itd.
   push ebx
   push ecx
   push edx
   mov eax, [ebp+8]
   mov eax, [eax]
   mov ebx, [ebp+12]
   mov ebx, [ebx]
   mov ecx, [ebp+16]
   mov ecx, [ecx]

   call min
   mov edx, ebx
   mov ebx, ecx
   mov ecx, edx
   call min
   
   mov edx, [ebp+8]
   mov [edx], eax

   mov eax, ebx
   mov ebx, ecx
   call min
   mov edx, [ebp+12]
   mov [edx], eax
   mov edx, [ebp+16]
   mov [edx],ebx

   done:
   pop edx
   pop ecx
   pop ebx
leave
ret

min:
push ecx
cmp eax, ebx
jl .min_step
jmp .min_done
.min_step:
mov ecx, eax
mov eax, ebx
mov ebx, ecx

.min_done:
pop ecx
ret