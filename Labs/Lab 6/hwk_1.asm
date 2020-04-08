#Homework 7 Michael Bros

.data
prompt1:	.asciiz "Transaction Amount($): "
prompt2:	.asciiz "Cash($): "
disp:	.asciiz "Cash dispensed($"
disp2:	.asciiz "):\n"

notes:	.asciiz "Notes:\n"
n50:	.asciiz "x $50\n"
n20:	.asciiz "x $20\n"
n10:	.asciiz "x $10\n"
n5:	.asciiz "x $5\n"
n1:	.asciiz "x $1\n"

coins:	.asciiz "Coins:\n"
c25:	.asciiz "x Quarter\n"
c10:	.asciiz "x Dime\n"
c5:	.asciiz "x Nickel\n"
c1:	.asciiz "x Penny\n"

newLine:	.asciiz "\n"

.text
main:
	li $v0, 4	#Transaction amount in $s0
	la $a0, prompt
	syscall
	
	li $v0, 5	
	syscall
	move $s0,$v0
	
	li $v0, 4	#Cash amount in $s1
	la $a0, prompt
	syscall
	
	li $v0, 5	
	syscall
	move $s1,$v0
	
	


Exit:	
	li $v0, 10
	syscall
