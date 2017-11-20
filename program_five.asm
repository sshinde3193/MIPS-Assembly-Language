.data

str1: .asciiz "Enter size of list: "
str2: .asciiz "Enter temperature: "
str3: .asciiz "Enter temperature to search: "
found: .asciiz "Temp found"
notFound: .asciiz "Temp not found"
.text

main:
jal createList
move $t0, $v0  #list address

add $sp, $sp, -4
sw $t0, 0($sp)
jal search_list
add $sp, $sp, 4
add $v0, $0, 10
syscall

# Takes in user input for list size and allocates space 
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

# Takes input for the list
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

# Deallocate and return to main
endWhile:
lw $v0, -4($fp)
add $sp, $sp, 12
lw $ra, 4($sp)
lw $fp, ($sp)
add $sp, $sp, 8

jr $ra

# Ask user for item to search for
search_list:
add $sp, $sp, -8
sw $fp, ($sp)
sw $ra, 4($sp)

add $fp, $sp, 0
add $sp, $sp, -12

sw $0, -12($fp)	#search item
sw $0, -8($fp)	#counter
sw $0, -4($fp)	#result
lw $t9, 8($fp)	#size
lw $s5, ($t9)

la $a0, str3
add $v0, $0, 4
syscall
add $v0, $0, 5
syscall
sw $v0, -12($fp)

la $t0, notFound
sw $t0, -4($fp)

# Search list for item 
whileSearch:
lw $t0, -8($fp)
bge $t0, $s5, whileEnd
lw $t9, 8($fp)
lw $t8, -8($fp)
add $t3, $0, 4 
mul $t4, $t8, $t3
add $t4, $t4, $t3
add $t4, $t4, $t9
lw $t5, ($t4)

lw $s0, -12($fp)
beq $t5, $s0, Found
lw $t8, -8($fp)
add $t8, $t8, 1
sw $t8, -8($fp)
j whileSearch

# If found change result to "Temp found"
Found:
la $a0, found
sw $a0, -4($fp)

# prints result
whileEnd:
lw $a0, -4($fp)
add $v0, $0, 4
syscall

add $sp, $sp, 12
lw $fp , 0($sp)
lw $ra, 4($sp)
add $sp, $sp, 8
jr $ra


