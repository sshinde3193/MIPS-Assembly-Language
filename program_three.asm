.data
str1:	.asciiz "Enter array size: "
str2:	.asciiz "Enter number: "
size:	.word 0
sum:	.word 0
the_list: .word 0
counter: .word 0
.text

# Prompt message and save user input in size variable
la $a0, str1
add $v0,$0, 4
syscall

add $v0, $0, 5
syscall
sw $v0, size

# Allocate space for list
lw $t0, size
addi $t1, $0, 4
mul $t2, $t1, $t0

add $a0, $t2, $t1
add $v0, $0, 9
syscall

# save list address in the_list variable
sw $v0, the_list

#  while counter < size:
#	the_list[counter] = int(input("Enter number: "))
while:
lw $t0, counter
lw $t1, size
bge $t0, $t1, endWhile

la $a0, str2
add $v0, $0, 4
syscall
add $v0, $0, 5
syscall

lw $t2, the_list
add $t3, $0, 4
mul $t4, $t3, $t0
add $t4, $t4, $t3
add $t4, $t4, $t2
sw $v0, ($t4)
add $t0, $t0, 1
sw $t0, counter
j while

endWhile:
addi $t0, $0, 0

# while counter < size:
#	sum  = sum + the_list[counter]
avg:
lw $s2, sum
lw $t1, the_list
lw $s1, size
bge $t0, $s1, avgEnd
add $t3, $0, 4 
mul $t4, $t3, $t0
add $t4, $t4, $t3
add $t4, $t4, $t1
lw $t5, ($t4)
add $s3, $s2, $t5
sw $s3, sum
add $t0, $t0, 1
j avg

# avg = sum//size
avgEnd:
lw $s1, size
lw $s2, sum
div $s3, $s2, $s1

move $a0, $s3
add $v0, $0, 1
syscall
