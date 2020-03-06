#Homework 6-3 Michael Bros

.data
prompt:	.asciiz "Please enter an integer greater than 1: "
comma:	.asciiz ", "
newLine:	.asciiz "\n"

.text
main:
	li $t1, 5	#init i
	
	j For	
For:
	slt $t0, $0, $t1	#check 0 < i
	beqz $t0, Exit		#if false exit
	
	li $v0, 1	#print i
	add $a0, $t1, $0
	syscall
	
	li $v0, 4	#print comma
	la $a0, comma
	syscall
	
	addi $t1, $t1, -1	#decrement counter
	j For

Exit:	
	li $v0, 10
	syscall