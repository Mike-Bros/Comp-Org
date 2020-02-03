#Lab 2 Michael Bros

.data
prompt1:	.asciiz"Input a number:\n"
loop:	.asciiz "for loop "
newLine:	.asciiz "\n"
.text

main:
	li $v0,4	 # display the first prompt
	la $a0, prompt1
	syscall
	
	li $v0, 5	# call for an input read
	syscall		# input is read and stored back into $v0
	move $s0, $v0	# move the input to a saved register
	
	j myLoop

myLoop:
	li $v0,4	 # display the loop text
	la $a0, loop
	syscall
	
	#print i
	li $v0, 1
	addi $a0,$s0,0	# copy i to $a0 	
	syscall		# display value of i
	
	#print newline
	li $v0,4
	la $a0, newLine
	syscall
	
	#decrement i
	subi $s0,$s0,1
	
	#if i=0 jump exit, else myLoop
	beqz $s0, exit
	j myLoop

exit:
	li $v0,10
	syscall