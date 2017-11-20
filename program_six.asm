.data
str1: .asciiz "Enter size of list: "
str2: .asciiz "Enter temperature: "
.text

main:
jal createList
move $t0, $v0 

add $sp, $sp, -4
sw $t0, 0($sp)
jal search_list
add $sp, $sp, 4
add $v0, $0, 10
syscall

createList:
add $sp, $sp, -8
sw $fp, ($sp)
sw $ra, 4($sp)

add $fp, $sp, 0
add $sp, $sp, -12

sw $0, -12($fp) #size
sw $0, -8($fp)	#counter
sw $0, -4($fp)	#list

la $a0, str1
add $v0, $0, 4
syscall
add $v0, $0, 5
syscall
sw $v0, -12($fp)

lw $t0, -12($fp)
addi $t1, $0, 4
mul $t2, $t1, $t0
add $a0, $t2, $t1
add $v0, $0, 9
syscall
sw $v0, -4($fp)

whileLoop:
lw $t0, -8($fp)
lw $t1, -12($fp)
bge $t0, $t1, endWhile

la $a0, str2
add $v0, $0, 4
syscall
add $v0, $0, 5
syscall

lw $t0, -8($fp)
lw $t2, -4($fp)
add $t3, $0, 4
mul $t4, $t3, $t0
add $t4, $t4, $t3
add $t4, $t4, $t2
sw $v0, ($t4)
lw $t0, -8($fp)
add $t0, $t0, 1
sw $t0, -8($fp)
j whileLoop

endWhile:
lw $v0, -4($fp)
add $sp, $sp, 12
lw $ra, 4($sp)
lw $fp, ($sp)
add $sp, $sp, 8

jr $ra

sortList:
