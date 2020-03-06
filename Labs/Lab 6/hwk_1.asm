#Homework 6-1 Michael Bros

.data
prompt:	.asciiz "Please enter an integer greater than 1: "
comma:	.asciiz ", "
newLine:	.asciiz "\n"

.text
main:
	li $v0, 4	#print prompt
	la $a0, prompt
	syscall
	
	li $v0, 5	#get user input put into $s0
	syscall
	move $s0,$v0
	
	li $t1, 1	#init 1 for comparison and counter
	
	beqz $t0, While
	
	j While	
While:
	addi $s1, $s0, 1	#add one to input
	slt $t0, $t1, $s1	#check counter < input+1
	beqz $t0, Exit		#if true exit
	
	li $v0, 1	#print counter
	add $a0, $t1, $0
	syscall
	
	li $v0, 4	#print comma
	la $a0, comma
	syscall
	
	addi $t1, $t1, 1	#increment counter
	j While

Exit:	
	li $v0, 10
	syscall