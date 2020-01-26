# SimpleInput.asm
	.globlmain
	
	.data
msg1:	.asciiz"Input a number:\n"
msg2:	.asciiz "The number was "
	
	.text
main:
	li $v0,4	 # display the first message
	la $a0, msg1
	syscall
	
	li $v0, 5	# call for an input read
	syscall		# input is read and stored back into $v0
	
	move $t0, $v0	# move the input to a temporary register
	
	#display the second message here
	li $v0,4	 # display the second message
	la $a0, msg2
	syscall
	
	#show output here
	move $a0,$t0
	li $v0,1
	syscall
	
	li $v0,10	# load the "exit" number into register $v0
	syscall