.global _start

.section .text
_start:
#your code here

#setting up the stack
mov $0, %r15
mov $0, %r14
mov $0, %r13
mov $0, %r12
mov $0, %r11
mov $0, %r10

movq $0, %rdi #rdi will count the nodes
movq $0, %rsi #rsi will count the leaves

#making sure we reach the end after finishing
#movq $end_HW1, %rax
#movq $firstIt_HW1, %rbx
#jmp stackPush_HW1

firstIt_HW1:
movq $root, %rax
#lea startNode_HW1(%rip), %rbx
#jmp stackPush_HW1

startNode_HW1:
inc %rdi
movq (%rax), %rcx
testq %rcx, %rcx
jne notLeaf_HW1
inc %rsi
jmp finishedNode_HW1

notLeaf_HW1:
lea notLeafCont_HW1(%rip), %rbx
jmp stackPush_HW1

notLeafCont_HW1:
movq %rcx, %rax
jmp startNode_HW1

contNode_HW1:
add $8, %rax
movq (%rax), %rcx
testq %rcx, %rcx
je finishedNode_HW1
jmp notLeaf_HW1

finishedNode_HW1:
lea afterPop_HW1(%rip), %rbx
jmp stackPop_HW1

afterPop_HW1:
testq %rax, %rax
je end_HW1

jmp contNode_HW1

#stack push
stackPush_HW1:
mov %r14, %r15
mov %r13, %r14
mov %r12, %r13
mov %r11, %r12
mov %r10, %r11
mov %rax, %r10
jmp *%rbx

#stack pop
stackPop_HW1:
mov %r10, %rax
mov %r11, %r10
mov %r12, %r11
mov %r13, %r12
mov %r14, %r13
mov %r15, %r14
xor %r15, %r15 
jmp *%rbx

end_HW1:
movq %rdi, %rax
xor %rdx, %rdx
div %rsi

cmp $3, %rax
jl goodTree_HW1
je equalTree_HW1
jmp badTree_HW1

equalTree_HW1:
test %rdx, %rdx
je goodTree_HW1
jmp badTree_HW1

goodTree_HW1:
movb $1, rich
jmp finished_HW1

badTree_HW1:
movb $0, rich

finished_HW1:
