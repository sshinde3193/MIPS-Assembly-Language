.data
str1:	.asciiz "Enter year: "
str2:	.asciiz "Is a leap year!"
str3:	.asciiz "Is not a leap year"
year:	.word 0
test1:	.word 4
test2:	.word 100
test3:	.word 400
isLeap:	.asciiz "Is a leap year"
notLeap: .asciiz "Is not a leap year"
.text

# Load prompt and ask for user input
la $a0, str1
add $v0, $0, 4
syscall
add $v0, $0, 5
syscall

#save user input in variable
sw $v0, year

# if year%4 == 0:
if: 
lw $s1, year
lw $s2, test1
div $s1, $s2
mfhi $t0
beq $t0, $0, printIs
bne $t0,$0, elif

# elif year%100 == 0
elif:
lw $s1, year
lw $s2, test2
div $s1, $s2
mfhi $t0
beq $t0, $0, printIsNot
bne $t0, $0, elif1

# elif year%400 == 0
elif1:
lw $s1, year
lw $s2, test3
div $s1, $s2
mfhi $t0
beq $t0, $0, printIs
bne $t0, $0, printIsNot

#print("Is a leap year")
printIs:
la $a0, isLeap
add $v0, $0, 4
syscall
j exit

#print("Is not a leap year")
printIsNot:	
la $a0, notLeap
add $v0, $0, 4
syscall

#exit()
exit:
add $v0, $0, 10
syscall	  
