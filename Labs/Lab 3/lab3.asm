#Lab 3 Michael Bros

.data
prompt1:	.asciiz"Input a number:\n"
msg1:	.asciiz "result of (a*b+b*3): "
newLine:	.asciiz "\n"
.text

main:
	jal getNum
	move $s0,$v0	# Store a
	
	jal getNum
	move $s1,$v0	# Store b
	
	jal doCalc
	
	li $v0,4	 # display result
	la $a0, msg1
	syscall
	li $v0,1
	move $a0,$s2
	syscall
	
	j Exit
	
	
getNum:
	li $v0,4	 # display the first prompt
	la $a0, prompt1
	syscall
	
	li $v0, 5	# call for an input read
	syscall	
	
	jr $ra

doCalc:
	li $t0,3	# Init 3
	mult $s0,$s1	# a*b = $t1
	mflo $t1
	
	mult $s1,$t0	#b*c
	mflo $t2
	
	add $s2,$t1,$t2	# a*b + b*3= $s2
	
	jr $ra
	
Exit:
	li $v0,10
	syscall