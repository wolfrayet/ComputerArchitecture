# Algorithm 1: Iterative Method
.text
.globl main
main:
	li		$v0, 5				# read integer from the user
	syscall						# syscall 5
	move	$a0, $v0			# copy the input integer to $a0 forfunction call
	jal		iterative			# call "iterative" function and jump
	move	$a0, $v0			# copy the result to $a0
	li		$v0, 1				# print the integer
	syscall						# syscall 1
	li		$v0, 10				# finish main 
	syscall
iterative:
	bne		$a0, $zero, loophead	# if input is zero, return 0. Otherwise, go to loop
	li		$v0, 1				
	jr		$ra
loophead:
	li		$t0, 0				# temporal values $t0, $t1 for iterative 
	li		$t1, 1
	addi	$t2, $v0, -1		# loop termination condition
	li		$a0, 1
loopbody:
	addi	$a0, $a0, 1
	add		$v0, $t0, $t1
	move	$t0, $t1
	move	$t1, $v0
	bne		$a0, $t2, loopbody	# if $a0 != n-1, keep iteration
	add		$v0, $v0, $t0
	jr		$ra
	
