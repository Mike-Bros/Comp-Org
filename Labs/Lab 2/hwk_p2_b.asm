#convert human age to dog age - Michael Bros
# Homework 2, 2. b
.data
prompt1:	.asciiz"Enter dog age: "
msg1:	.asciiz "The age in human years is: "
msg2:	.asciiz " and "

.text
main:
	li $t0,15

	li $v0,4	 # display the first prompt
	la $a0, prompt1
	syscall
	
	li $v0, 5	# read input 
	syscall		
	move $s0, $v0	
	
	mult $s0,$t0	# x15
	mflo $s0
	
	li $v0,4	 # display the msg1 prompt
	la $a0, msg1
	syscall
	
	li $v0,1	# display the result
	addi $a0,$s0,0
	syscall
	
	#exit
	li $v0,10
	syscall