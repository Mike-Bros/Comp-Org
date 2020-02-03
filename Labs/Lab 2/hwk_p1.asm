#convert F to C - Michael Bros
# Homework 2, 1. a
.data
prompt1:	.asciiz"Enter temp in F: "
msg1:	.asciiz "The temp in C is: "

.text
main:
	li $t0,5
	li $t1,9

	li $v0,4	 # display the first prompt
	la $a0, prompt1
	syscall
	
	li $v0, 5	# read input 
	syscall		
	move $s0, $v0	
	
	subi $s0,$s0,32	#subract 32
	
	mult $s0,$t0	# x5
	mflo $s0
	
	div $s0,$t1	# /9
	mflo $s0
	
	li $v0,4	 # display the msg1 prompt
	la $a0, msg1
	syscall
	
	li $v0,1	#display the result
	addi $a0,$s0,0
	syscall
	
	#exit
	li $v0,10
	syscall