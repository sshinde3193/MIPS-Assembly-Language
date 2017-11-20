.data
str1:	.asciiz "Enter array size: "
str2:	.asciiz "Enter number: "
size:	.word 0
sum:	.word 0
the_list: .word 0
counter: .word 0
.text

# Print promt for user input
la $a0, str1
add $v0,$0, 4
syscall

add $v0, $0, 5
syscall

# Save user input in size
sw $v0, size

# allocate space for list
lw $t0, size
addi $t1, $0, 4
mul $t2, $t1, $t0

add $a0, $t2, $t1
add $v0, $0, 9
syscall

#save list address in variable
sw $v0, the_list

# while counter < size:
#    the_list[counter] = int(input("Enter number: "))
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
lw $t0, size
sub $t0, $t0, 1

# print list 
print:
lw $t1, the_list
lw $t2, size
blt $t0, $0, printEnd
addi $t3, $0, 4
mult $t3, $t0
mflo $t4
add $t4, $t4, $t3 
add $t4, $t4, $t1
lw $a0, ($t4) 
addi $v0, $0, 1
syscall
addi $a0, $0, 32 
addi $v0, $0, 11
syscall
sub $t0, $t0, 1
j print
 
printEnd:
 
