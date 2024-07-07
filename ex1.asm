.global _start

.section .text
_start:

movq Adress(%rip), %rbx
cmpq $0, %rbx
je end_HW1 #check if array address is 0
movzx Index(%rip), %rcx
movb $0, Legal(%rip)
cmpl length(%rip), %ecx #index-length
jl IndexInRange_HW1 #if index>=size, go to end of program with legal value=0
movb $0, Legal
jmp end_HW1

IndexInRange_HW1:
lea 0(%rcx, %rcx, 2), %rax
addq %rcx, %rax
addq %rax, %rbx
jc end_HW1 # checking if arr[index] address is crossing legal bound of memory
movzx length(%rip), %r9
lea 0(%r9, %r9, 2), %rdx
addq %r9, %rdx
addq Adress(%rip), %rdx
jc checkOverflow_HW1 #check if array is crossing legal bound of memory
jmp numCalc_HW1

numCalc_HW1:
movl (%rbx), %eax
movl %eax, num(%rip)
movb $1, Legal(%rip)
jmp end_HW1

checkOverflow_HW1: 
cmpq $0, %rdx
je numCalc_HW1 #if the end of the array is at the highest address, count it as a legal move
jmp end_HW1

end_HW1:
