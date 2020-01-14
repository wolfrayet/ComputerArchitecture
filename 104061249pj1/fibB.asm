# Algorithm 2: Recursion Method
.text
.globl main
main:
	li		$v0, 5				# read integer from the user
	syscall						# syscall 5
	move	$a0, $v0			# copy the input integer to $a0 forfunction call
	jal		recursive			# call "recursive" function and jump
	move	$a0, $v0			# copy the result to $a0
	li		$v0, 1				# print the integer
	syscall						# syscall 1
	li		$v0, 10				# finish main 
	syscall
recursive:
	addi	$t0, $zero, 1		# $t0=1
	beq		$a0, $zero, case0	# if $a0=0, return 0
	beq		$a0, $t0, case1		# if $a0=1, return 1
	
	addi	$sp, $sp, -12		# make room for stack
	sw		$s0, 0($sp)			# load input value into stack
	sw		$s1, 4($sp)
	sw		$ra, 8($sp)			# load resturn address into stack
	
	move	$s0, $a0			# copy $a0 to $s0
	addi	$a0, $s0, -1		# $a0=n-1
	jal		recursive			# do f(n-1)
	
	move	$s1, $v0			# store result f(n-1) to $s1
	addi	$a0, $s0, -2		# $a0=n-2
	jal		recursive			# do f(n-2)
	
	add		$v0, $v0, $s1		# f(n)=f(n-1)+f(n-2)
	
	lw		$s0, 0($sp)			# read reg. from the stack
	lw		$s1, 4($sp)
	lw		$ra, 8($sp)			# restore return address
	addi	$sp, $sp, 12		# restore the stack
	jr		$ra
case0:
	li		$v0, 0
	jr		$ra
case1:
	li		$v0, 1
	jr		$ra
