#Homework 5-1 Michael Bros

.data
prompt1:	.asciiz"Please enter an Integer for terms to be added to Fibonacci Series(-1 to exit): "
msg1:	.asciiz "\nFibonacci Series: "
msg2:	.asciiz "\nThe sum of the Fibonacci sequence is: "
error:	.asciiz "Please enter an integer greater than 1\n"
comma:	.asciiz ", "
space:	.asciiz " "
newLine:	.asciiz "\n"

.text
main:
	li $s1, 0	#term 1
	li $s2, 1	#term 2
	li $s3, 0	#next term
	li $s4, 0	#sum
	li $s5, 3	#init i
	
	li $v0, 4	#ask user to input number
	la $a0, prompt1
	syscall
	
	li $v0, 5	#get number and store in $s0
	syscall
	move $s0,$v0
	
	li $t0, -1
	beq $t0, $s0, Exit
	
	li $t0,1
	beq $t0, $s0, Error
	slt $t1, $s0, $t0	#if number < 1
	bnez $t1, Error	#number < 1 branch to numCheck
	
	li $v0, 4	#print msg1
	la $a0, msg1
	syscall
	
	li $v0, 1	#print term 1
	addi $a0, $s1, 0
	syscall
	add $s4, $s4, $s1	#add to sum
	
	li $v0, 4	#print comma
	la $a0, comma
	syscall
	
	li $v0, 1	#print term 2
	addi $a0, $s2, 0
	syscall	
	add $s4, $s4, $s2	#add to sum
	
	j For
	
For:
	li $t0, 2
	beq $t0, $s0, Sum
	
	add $s3, $s1, $s2
	move $s1, $s2
	move $s2, $s3
	
	li $v0, 4	#print comma
	la $a0, comma
	syscall
	
	li $v0, 1	#print next term
	addi $a0, $s3, 0
	syscall	
	add $s4, $s4, $s3	#add to sum
	
	addi $s5, $s5, 1	#i++
	beq $s5, $s0, For	# i == n
	slt $t1, $s5, $s0	# i < n
	bnez $t1, For
	
	j Sum
Sum:
	#print sum
	li $v0, 4	#print msg2
	la $a0, msg2
	syscall
	
	li $v0, 1	#print sum
	addi $a0, $s4, 0
	syscall
	
	li $v0, 4	#print newLine
	la $a0, newLine
	syscall
	syscall
	j main
Error:
	li $v0, 4	#print error
	la $a0, error
	syscall
	
	j main
Exit:	
	li $v0, 10
	syscall
