.global _start

.section .text
_start:
#your code here

movl $0, %r8d #this is for summing all good series's
movq $0, %rsi #rsi holds the counter for the series's

startNode_HW1:
lea (nodes), %rdi
leaq 0(%rdi , %rsi, 8), %rdi #loading the address of the cur node
movq (%rdi), %rdi #going to cur node
movl $1, %r15d #if r15 has 1 it means that the sequence is good, if not it will hold 0
movl $0, %edx # we use rdx to check if we are decreasing or increasing, we start with zero because we start with equal

startDownLoop_HW1:
movq 0(%rdi), %rdi #go to rdi -> prev
testq %rdi, %rdi #checking that rdi is not null
je endDownLoop_HW1

movq 0(%rdi), %rax #putting in rax rdi->prev
testq %rax, %rax #checking that rax is not null
je endDownLoop_HW1

movl 8(%rdi), %ebx # putting in rbx rdi->val
movl 8(%rax), %ecx # putting in rcx rax->val

cmpl %ebx, %ecx
jg  caseGreaterDown_HW1
jl caseSmallerDown_HW1
jmp startDownLoop_HW1 #starting loop again if rbx  == rax

caseGreaterDown_HW1:
cmpl $-1, %edx
je loopError_HW1 #if the series is decreasing this is an error
movl $1, %edx #updating series to increasing
jmp startDownLoop_HW1

caseSmallerDown_HW1:
cmpl $1, %edx
je loopError_HW1 #if the series is decreasing this is an error
movl $-1, %edx #updating series to decreasing
jmp startDownLoop_HW1

endDownLoop_HW1:
lea (nodes), %rdi
leaq 0(%rdi , %rsi, 8), %rdi
movq (%rdi), %rdi
movl $0, %edx # we use rdx to check if we are decreasing or increasing, we start with zero because we start with equal

startUpLoop_HW1:
movq 12(%rdi), %rdi #go to rdi -> next
testq %rdi, %rdi #checking that rdi is not null
je endIt_HW1

movq 12(%rdi), %rax #putting in rax rdi->next
testq %rax, %rax #checking that rax is not null
je endIt_HW1

movl 8(%rdi), %ebx # putting in rbx rdi->val
movl 8(%rax), %ecx # putting in rcx rax->val

cmpl %ebx, %ecx
jg caseGreaterUp_HW1
jl caseSmallerUp_HW1
jmp startUpLoop_HW1 #starting loop again if rbx  == rax

caseGreaterUp_HW1:
cmpl $-1, %edx
je loopError_HW1 #if the series is decreasing this is an error
movl $1, %edx #updating series to increasing
jmp startUpLoop_HW1

caseSmallerUp_HW1:
cmpl $1, %edx
je loopError_HW1 #if the series is decreasing this is an error
movl $-1, %edx #updating series to decreasing
jmp startUpLoop_HW1

loopError_HW1: 
movl $0, %r15d # we had an error with one of the iterations 

endIt_HW1:
addl %r15d, %r8d #adding one to r8 if the series was good
addq $1, %rsi #going to the next node
cmpq $3, %rsi
jne startNode_HW1
movl %r8d, result
