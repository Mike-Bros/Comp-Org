#Homework 7 Michael Bros

.data
prompt1:	.asciiz "Transaction Amount($): "
prompt2:	.asciiz "Cash($): "
disp:	.asciiz "\nCash dispensed($"
disp2:	.asciiz "):\n"

error:	.asciiz "I'm sorry something went wrong. Make sure you have enough cash and try again\n"

notes:	.asciiz "\nNotes:"
nArrNum: .float 50, 20, 10, 5, 1
nArr:	.asciiz "x $50\n", "x $20\n" ,"x $10\n" ,"x $5\n", "x $1\n"

coins:	.asciiz "\nCoins:"
carray: .float .25, .10, .05, .01
c25:	.asciiz "x Quarter\n"
c10:	.asciiz "x Dime\n"
c5:	.asciiz "x Nickel\n"
c1:	.asciiz "x Penny\n"

z:	.float 0.0
rounder:	.float 100.0
newLine:	.asciiz "\n"

.text
main:
	li $v0, 4	#Transaction amount in $f1
	la $a0, prompt1
	syscall
	
	li $v0, 6	
	syscall
	mov.s $f1,$f0
	
	li $v0, 4	#Cash amount in $f2
	la $a0, prompt2
	syscall
	
	li $v0, 6	
	syscall
	mov.s $f2,$f0
	
	l.s $f31, z
	l.s $f30, rounder
	
	#if $f2 < $f1 error
	c.lt.s $f2,$f1
	bc1t  Error
	#if $f1 < 0 error
	c.lt.s $f1,$f31
	bc1t Error
	#if $f2 <0 error
	c.lt.s $f2,$f31
	bc1t Error
	
	j Output
Output:
	#Calculate cash dispensed
	sub.s $f12,$f2,$f1
	
	#round to 2 decimal places
	jal Round
	
	#print cash dispensed
	li $v0, 4
	la $a0, disp
	syscall
	
	li $v0, 2
	syscall
	
	li $v0, 4	
	la $a0, disp2
	syscall
	
	mov.s $f3,$f12	#move cash into $f3
	#print notes
	li $t3, 0	#init bill counter
	li $t6, 0	#init arr counter
	
	#Print notes
	li $v0, 4	
	la $a0, notes
	syscall
	j Notes
	
	j Exit
Notes:
	#get array index
	la $s2, nArrNum
	la $s3, nArr
	
	#if nArrNum can subract from $f3
	l.s $f5, ($s2)
	c.lt.s $f5,$f3
	bc1t NotesW
	
	#if 0 < counter print
	slt $t0, $0, $t3
	beqz $t0, NotesNext
	
	#Print counter then note
	li $v0, 1
	move $a0, $t3
	syscall
	
	lw $a0, ($s3)	#printing note value
	li $v0, 4
	syscall
	
	#if at end of array jump to coins, else repeat
	#if $t6 < 5 continue
	slti $t0, $t6, 5
	bnez $t0 NotesNext
	
	j Coins
NotesW:
	#subract and round
	sub.s $f3, $f3,$f5
	jal Round
	
	#increment counter and return
	addi $t3, $t3, 1
	j Notes
		
NotesNext:
	#reset bill counter, increase array counter
	addi $t6, $t6, 1
	li $t3, 0
	#increment both arrays
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	
	j Notes
Coins:
	j Exit
	#calculate and print coins
Round:
	#Rounds float in f12 to 2 decimal places
	mul.s $f12, $f12, $f30
	round.w.s $f12,$f12
	mfc1 $t1,$f12
	mtc1 $t1,$f12
	cvt.s.w $f12, $f12
	div.s $f12,$f12,$f30
	
	jr $ra
Error:
	li $v0, 4	#Print error message
	la $a0, error
	syscall
	
	j main
Exit:	
	li $v0, 10
	syscall
