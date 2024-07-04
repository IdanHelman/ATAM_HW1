.global _start

.section .text
_start:

movq Adress(%rip), %rbx
movb $0, Legal
cmpq $0, %rbx #checks if received address is 0
je end_HW1 #if so, end the program
movzx Index(%rip), %rcx
movb $1, Legal(%rip)
cmpl length(%rip), %ecx #index-length
jl IndexInRange_HW1 #if index>=size, go to end of program with legal value=0
movb $0, Legal(%rip)
jmp end_HW1

IndexInRange_HW1:
movl 0(%rbx, %rcx, 4), %eax
movl %eax, num(%rip)
jmp end_HW1

end_HW1:
