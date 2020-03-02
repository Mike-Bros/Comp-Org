#Quiz 5 Question - Michael Bros
# Write the function that will continuosly add numbers to the stack until user inputs 0.
# When user inputs zero exit the function.

Function:
	li $v0, 5		#get number
	syscall		
	
	move $t0,$v0		#put user input in t0
	beq $t0,$0, Exit	#branch to print if user input=0
	
	addi $sp, $sp, -4	#incremember stack
	sw $t0, ($sp)		#store in stack
	
	j Function		#get next number