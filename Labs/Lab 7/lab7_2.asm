#Homework 7 Michael Bros

.data
prompt1:	.asciiz "Transaction Amount($): "
prompt2:	.asciiz "Cash($): "
disp:	.asciiz "\nCash dispensed($"
disp2:	.asciiz "):\n"

error:	.asciiz "I'm sorry something went wrong. Make sure you have enough cash and try again\n"

notes:	.asciiz "\nNotes:\n"
nArrNum: .float 50, 20, 10, 5, 1
nArr:	.asciiz "x $50\n", "x $20\n" ,"x $10\n" ,"x $5\n", "x $1\n"

coins:	.asciiz "\nCoins:\n"
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
	
	la $s2, nArrNum	#get array indexes
	la $s3, nArr
	j Notes
	
Notes:
	#while can subract, subract and incremement bill counter and loop
	l.s $f5, ($s2)
	c.lt.s $f5,$f3
	bc1t NotesSub
	
	#if bill 0 < bill counter print current count
	bnez $t3, NotesPrint
	
	
	

NotesSub: 
	#cash displensed - dollar value in f12 for rounding
	sub.s $f12,$f3,$f5
	jal Round
	mov.s $f3,$f12	#put amount back in $f3
	#bill counter++
	addi $t3,$t3, 1
	j Notes
	
NotesPrint:
	#print current bill amount
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, ($s3)	#printing note value
	syscall
	
	#if arr counter < 5 increment ptrs, arr counter, and reset bill counter
	slti $t0, $t5, 5
	bnez $t0, NotesInc
	
	li $t3, 0	#init coin counter
	li $t6, 0	#init arr counter
	li $v0, 4	#Print coins
	la $a0, coins
	syscall
	j Coins
NotesInc:
	#increment ptrs, arr counter, and reset bill counter
	addi $s2, $s2, 4
	addi $s3, $s4, 4
	addi $t6, $t6, 1
	li $t3, 0
	
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
