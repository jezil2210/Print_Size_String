global _start

section .data

test_string: db "salveGaleraBlz", 0

section .text

strlen:
push r15
xor r15, r15

.loop:
cmp byte [rdi+r15], 0
je .end
inc r15
jmp .loop

.end:
mov rax, r15
pop r15
ret

_start:

mov rdi, test_string
call strlen
mov rdi, rax

mov rax, 60
syscall
