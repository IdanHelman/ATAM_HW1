.global _start

.section .text
_start:
#your code here

movb $1, %r8b #r8b will hold the return value
lea (series), %r15 #r15 is a pointer to the beggining of the series
movl (size), %r14d #rq14 is the size of the series
cmp $1, %r14d
jle end_HW1 #checking that size > 1
movb $0, %r8b

#checking case 1 - diff + diff
movl $0, %edi

loop1_HW1:
movl 0(%r15, %rdi, 4), %eax #rax holds the cur integer
inc %edi
cmp %edi, %r14d
je end1_HW1 #finished if the series reached its end
movl 0(%r15, %rdi, 4), %ebx #rbx holds the next integer

sub %eax, %ebx
cmp $1, %rdi
jne notFirst1_HW1
movl %ebx, %r13d #r13 keeps the prev val of the difference series
jmp contMainLoop1_HW1

notFirst1_HW1:
movl %ebx, %r12d #r12 keeps the cur val of the difference series
movl %ebx, %r11d #r11 keeps a copy of the cur val of the difference series
sub %r13d, %r12d #r12 now has the difference of the difference series
movl %r11d, %r13d #r13 now has the cur value of the diff series

cmp $2, %rdi
jne notSec1_HW1
movl %r12d, %r10d #r10d holds the difference of the series
jmp contMainLoop1_HW1

notSec1_HW1:
cmp %r12d, %r10d #checking that the diff of the diff series is legal
jne seriesError1_HW1

contMainLoop1_HW1:
jmp loop1_HW1

end1_HW1:
movb $1, %r8b
jmp end_HW1

seriesError1_HW1:

#checking case 2 - diff + quot
movl $0, %edi

loop2_HW1:
movl 0(%r15, %rdi, 4), %eax #rax holds the cur integer
inc %edi
cmp %edi, %r14d
je end2_HW1 #finished if the series reached its end
movl 0(%r15, %rdi, 4), %ebx #rbx holds the next integer

sub %eax, %ebx
testl %ebx, %ebx
je seriesError2_HW1 #checking that the diff is not 0, if 0 then error...

cmp $1, %rdi
jne notFirst2_HW1
movl %ebx, %r13d #r13 keeps the prev val of the difference series
jmp contMainLoop2_HW1

notFirst2_HW1:
movl %ebx, %eax #eax keeps the cur val of the difference series
cdq
idivl %r13d #eax now has the quot of the difference series
testl %edx, %edx
jne seriesError2_HW1
movl %ebx, %r13d #r13 now has the cur value of the diff series

cmp $2, %rdi
jne notSec2_HW1
movl %eax, %r10d #r10d holds the quot of the series
jmp contMainLoop2_HW1

notSec2_HW1:
cmp %eax, %r10d #checking that the quot of the diff series is legal
jne seriesError2_HW1

contMainLoop2_HW1:
jmp loop2_HW1

end2_HW1:
movb $1, %r8b
jmp end_HW1

seriesError2_HW1:

#checking case 3 - quot + diff
movl $0, %edi

loop3_HW1:
movl 0(%r15, %rdi, 4), %ebx #rbx holds the cur integer
testl %ebx, %ebx #number is zero so no geo series
je seriesError3_HW1
inc %edi
cmp %edi, %r14d
je end3_HW1 #finished if the series reached its end
movl 0(%r15, %rdi, 4), %eax #rax holds the next integer
#testl %eax, %eax number is zero so no geo series
#je seriesError3_HW1
cdq
idivl %ebx #rax has the quot of the two values
testl %edx, %edx
jne seriesError3_HW1
cmp $1, %rdi
jne notFirst3_HW1
movl %eax, %r13d #r13 keeps the prev val of the quot series
jmp contMainLoop3_HW1

notFirst3_HW1:
movl %eax, %r12d #r12 keeps the cur val of the quot series
movl %eax, %r11d #r11 keeps a copy of the cur val of the quot series
sub %r13d, %r12d #r12 now has the difference of the quot series
movl %r11d, %r13d #r13 now has the cur value of the quot series

cmp $2, %rdi
jne notSec3_HW1
movl %r12d, %r10d #r10d holds the difference of the series
jmp contMainLoop3_HW1

notSec3_HW1:
cmp %r12d, %r10d #checking that the diff of the quot series is legal
jne seriesError3_HW1

contMainLoop3_HW1:
jmp loop3_HW1

end3_HW1:
movb $1, %r8b
jmp end_HW1

seriesError3_HW1:

#checking case 4 - quot + quot
movl $0, %edi

loop4_HW1:
movl 0(%r15, %rdi, 4), %ebx #rbx holds the cur integer
testl %ebx, %ebx #number is zero so no geo series
je seriesError4_HW1
inc %edi
cmp %edi, %r14d
je end4_HW1 #finished if the series reached its end
movl 0(%r15, %rdi, 4), %eax #rax holds the next integer
#testl %eax, %eax number is zero so no geo series
#je seriesError4_HW1
cdq
idivl %ebx #rax has the quot of the two values
testl %edx, %edx
jne seriesError4_HW1
cmp $1, %rdi
jne notFirst4_HW1
movl %eax, %r13d #r13 keeps the prev val of the quot series
jmp contMainLoop4_HW1

notFirst4_HW1:
movl %eax, %r12d #r12 keeps the cur val of the quot series
cdq
idiv %r13d #eax has the quot of the series
testl %edx, %edx
jne seriesError4_HW1
movl %r12d, %r13d #r13 now has the cur value of the quot series

cmp $2, %rdi
jne notSec4_HW1
movl %eax, %r10d #r10d holds the quot of the series
jmp contMainLoop4_HW1

notSec4_HW1:
cmp %eax, %r10d #checking that the diff of the quot series is legal
jne seriesError4_HW1

contMainLoop4_HW1:
jmp loop4_HW1

end4_HW1:
movb $1, %r8b
jmp end_HW1

seriesError4_HW1:

end_HW1:
movb %r8b, seconddegree
xorq %rax, %rax
