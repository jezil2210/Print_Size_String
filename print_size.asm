global _start

section .data

test_string: db "salveGaleraBlz", 0 ; define the test_string "variable", and specific the delimeter '0' as the end of the string.

section .text

strlen:
push r15 ; the content of r15 is saved because this register is a callee-saved register 
xor r15, r15 ; now i can put the value 0 into the register because the real content of r15 is saved at the top of the stack

.loop:
cmp byte [rdi+r15], 0 ; compare each character of the string, that starts in rdi(contains the memory address of the string) and
je .end               ; jumps to the .end routine if the value is equal to 0(the delimeter for the end of the string)
inc r15               ; if not, will increase the value of r15, the register to save the size of the string, and jump to .loop again
jmp .loop

.end:
mov rax, r15 ; save the value of r15(size of the string) into rax, because 'ret' returns the value of rax for default
pop r15 ; restore the initial value of r15 that was pushed into the stack
ret ; returns the value of rax(size of the string)

_start:

mov rdi, test_string
call strlen

mov rdi, rax ; the size of the string stored in rax is goig to the rdi register
mov rax, 60  ; and when syscall is called with the ID of 60(sys_exit) the content of rdi(size of the string)
syscall      ; is stored as exit status, that for default is 0 when run without problems. So to see the result
             ; just use 'echo $?' to print the exit status of the last process.
