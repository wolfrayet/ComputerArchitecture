# Algorithm 4: Q Matrix
.data
Q1:			.word 1, 1, 1, 0
.text
.globl main
main:
	li		$v0, 5				# read integer from the user
	syscall						# syscall 5
	move	$a0, $v0			# copy the input integer to $a0 forfunction call
	beq		$a0, $zero, case0
	jal		FindQ				# call "FindQ" function and jump
	#move	$a0, $v0			# copy the result to $a0
	lw		$a0, 4($v0)
	li		$v0, 1				# print the integer
	syscall						# syscall 1
	li		$v0, 10				# finish main 
	syscall
case0:							# case for n=0
	move	$v0, $zero			# return 0
	jr		$ra
case1:							# n=1, load address of Q1
	la		$v0, Q1
	jr		$ra
FindQ:							# find Q-matrix for n
	addi	$t0, $zero, 1		# $t0=1
	beq		$a0, $t0, case1		# if n=1, go to case1
	
	addi	$sp, $sp, -16		# create space for stack
	sw		$s0, 0($sp)			# store the input values into stack
	sw		$s1, 4($sp)
	sw		$s2, 8($sp)
	sw		$ra, 12($sp)		# store the return address
	
	li		$t1, 2				# $t1=2
	move	$s0, $a0			# copy $a0 to $ s0
	div		$a0, $t1			# $a0=n/2
	mflo	$a0
	jal		FindQ				# find Q(n/2)
	
	move	$s1, $v0			# store the address of Q(n/2)
	li		$t1, 2				# $t1=2
	move	$a0, $s0
	div		$a0, $t1
	mflo	$a0
	sub		$a0, $s0, $a0		# $a0=n-n/2
	jal		FindQ				# find Q(n-n/2)
	
	move	$s2, $v0			# store the address of Q(n-n/2)
	move	$s3, $a0			# store $a0
	jal		ml					# do Q(n/2)*Q(n-n/2)
	
	move	$a0, $s3			# restore $a0
	
	lw		$s0, 0($sp)			# load the value from the stack
	lw		$s1, 4($sp)
	lw		$s2, 8($sp)
	lw		$ra, 12($sp)		# restore the return address
	addi	$sp, $sp, 16		# restore the stack
	jr		$ra					 
ml:								# 2D matrix multiplication
	li		$a0, 16				# request for 16 byte location for the resulting matrix
	li		$v0, 9				# malloc system call
	syscall						

	lw		$t0, 0($s1)			# calculate Q[0][0]
	lw		$t1, 4($s1)
	lw		$t2, 0($s2)
	lw		$t3, 8($s2)
	mul		$t4, $t0, $t2
	mul		$t5, $t1, $t3
	add		$t4, $t4, $t5
	sw		$t4, 0($v0)

	lw		$t2, 4($s2)			# calculate Q[0][1]
	lw		$t3, 12($s2)
	mul		$t4, $t0, $t2
	mul		$t5, $t1, $t3
	add		$t4, $t4, $t5
	sw		$t4, 4($v0)

	lw		$t0, 8($s1)			# calculate Q[1][1]
	lw		$t1, 12($s1)
	mul		$t4, $t0, $t2
	mul		$t5, $t1, $t3
	add		$t4, $t4, $t5
	sw		$t4, 12($v0)

	lw		$t2, 0($s2)			# calculate Q[1][0]
	lw		$t3, 8($s2)
	mul		$t4, $t0, $t2
	mul		$t5, $t1, $t3
	add		$t4, $t4, $t5
	sw		$t4, 8($v0)

	jr		$ra
