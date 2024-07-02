.global _start

.section .text
_start:
#your code here
movq $0, %rdi
movq (size), %r15
movq $data, %r13
movb $4, %r8b

sub $1, %r15
movb 0(%r13, %r15, 1), %al
testb %al, %al
jne case3_HW1

case1_HW1:
cmp %rdi, %r15
je end1_HW1
movb 0(%r13, %rdi, 1), %al

# Check letter
cmp $'A', %al
jl not_letter1_HW1
cmp $'Z', %al
jle is_valid1_HW1
cmp $'a', %al
jl not_letter1_HW1
cmp $'z', %al
jle is_valid1_HW1

not_letter1_HW1:
# Check if the letter is a number
cmp $'0', %al
jl not_number1_HW1
cmp $'9', %al
jle is_valid1_HW1

not_number1_HW1:
# Check for '.', ',', ' ', '?', '!'
cmp $'.', %al
je is_valid1_HW1
cmp $',', %al
je is_valid1_HW1
cmp $' ', %al
je is_valid1_HW1
cmp $'?', %al
je is_valid1_HW1
cmp $'!', %al
je is_valid1_HW1

# If none of the above, the letter is not valid
jmp not_valid1_HW1

is_valid1_HW1:
inc %rdi
jmp case1_HW1

end1_HW1:
movb $1, %r8b
jmp end_HW1

not_valid1_HW1:
movq $0, %rdi

case2_HW1:
cmp %rdi, %r15
je end2_HW1
movb 0(%r13, %rdi, 1), %al

# Check if the letter is greater than or equal to 32
cmp $32, %al
jl not_valid2_HW1

# Check if the letter is less than or equal to 126
cmp $126, %al
jle is_valid2_HW1

# If the character is not within the range, it is invalid
jmp not_valid2_HW1

is_valid2_HW1:
inc %rdi
jmp case2_HW1

end2_HW1:
movb $2, %r8b
jmp end_HW1

not_valid2_HW1:
jmp end_HW1

case3_HW1:
#check that is divisible by 8
add $1, %r15
movq %r15, %rax
movq $8, %rbx
xor %rdx, %rdx
div %rbx
testq %rdx, %rdx
jne end_HW1 #not divisible by 8

case3_loop_HW1:
cmp %rdi, %rax
je end3_HW1

movq 0(%r13, %rdi, 8), %rbx
testq %rbx, %rbx #if rbx is zero then not good
je end_HW1

inc %rdi
jmp case3_loop_HW1


end3_HW1:
movb $3, %r8b

end_HW1:

movb %r8b, type
