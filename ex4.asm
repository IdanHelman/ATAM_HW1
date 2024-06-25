.global _start

.section .text
_start:
#your code here

movb $0, %r8b #this is for summing all good series's
movq $0, %rsi #rsi holds the counter for the series's


startNode:
lea (nodes), %rdi
leaq 0(%rdi , %rsi, 8), %rdi #loading the address of the cur node
movq (%rdi), %rdi #going to cur node
movb $1, %r15b #if r15 has 1 it means that the sequence is good, if not it will hold 0
movl $0, %edx # we use rdx to check if we are decreasing or increasing, we start with zero because we start with equal

startDownLoop:
movq 0(%rdi), %rdi #go to rdi -> prev
testq %rdi, %rdi #checking that rdi is not null
je endDownLoop

movq 0(%rdi), %rax #putting in rax rdi->prev
testq %rax, %rax #checking that rax is not null
je endDownLoop

movl 8(%rdi), %ebx # putting in rbx rdi->val
movl 8(%rax), %ecx # putting in rcx rax->val

cmpl %ebx, %ecx
jg  caseGreaterDown
jl caseSmallerDown
jmp startDownLoop #starting loop again if rbx  == rax

caseGreaterDown:
cmpl $-1, %edx
je loopError #if the series is decreasing this is an error
movl $1, %edx #updating series to increasing
jmp startDownLoop

caseSmallerDown:
cmpl $1, %edx
je loopError #if the series is decreasing this is an error
movl $-1, %edx #updating series to decreasing
jmp startDownLoop

endDownLoop:
lea (nodes), %rdi
leaq 0(%rdi , %rsi, 8), %rdi
movq (%rdi), %rdi
movl $0, %edx # we use rdx to check if we are decreasing or increasing, we start with zero because we start with equal

startUpLoop:
movq 12(%rdi), %rdi #go to rdi -> next
testq %rdi, %rdi #checking that rdi is not null
je endIt

movq 12(%rdi), %rax #putting in rax rdi->next
testq %rax, %rax #checking that rax is not null
je endIt

movl 8(%rdi), %ebx # putting in rbx rdi->val
movl 8(%rax), %ecx # putting in rcx rax->val

cmpl %ebx, %ecx
jg caseGreaterUp
jl caseSmallerUp
jmp startDownLoop #starting loop again if rbx  == rax

caseGreaterUp:
cmpl $-1, %edx
je loopError #if the series is decreasing this is an error
movl $1, %edx #updating series to increasing
jmp startUpLoop

caseSmallerUp:
cmpl $1, %edx
je loopError #if the series is decreasing this is an error
movl $-1, %edx #updating series to decreasing
jmp startUpLoop

loopError: 
movb $0, %r15b # we had an error with one of the iterations 

endIt:
addb %r15b, %r8b #adding one to r8 if the series was good
addq $1, %rsi #going to the next node
cmpq $3, %rsi
jne startNode
movb %r8b, result
