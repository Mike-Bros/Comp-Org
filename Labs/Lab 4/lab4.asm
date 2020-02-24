#Lab 4 Michael Bros

.data
prompt1:	.asciiz"Please enter numbers, press (0) to exit: \n"
msg1:	.asciiz "Your numbers were:\n"
newLine:	.asciiz "\n"

.text
main:
	li $v0, 4	#ask user to input numbers
	la $a0, prompt1
	syscall
	
	la $s0, ($sp)
	
	li $t1, 0
	li $t2, 0
	
	j While
	
While:
	li $v0, 5	#get number
	syscall		
	
	move $t0,$v0	#put user input in t0
	beq $t0,$0, L1	#branch to print if user input=0
	
	addi $sp, $sp, -4	#incremember stack
	sw $t0, ($sp)		#store in stack
	addi $t1,$t1,1		#increment counter
	
	j While		#get next number
	
L1:
	li $v0, 4	#Print user numbers
	la $a0, msg1
	syscall
	j Print
	
Print:
	addi $s0, $s0, -4	#increment stack
	addi $t2,$t2,1		#increment counter
	
	lw $a0, ($s0)	#retrieve number for printing
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	beq $t1,$t2, Exit	#if counters are equal exit
	j Print
	
Exit:	
	li $v0, 10
	syscall
