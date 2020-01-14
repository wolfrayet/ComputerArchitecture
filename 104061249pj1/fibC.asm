# Algorithm 3: Tail Recursion
.text
.globl main
main:
	li		$v0, 5				# read integer from the user
	syscall						# syscall 5
	move	$a0, $v0			# copy the input integer to $a0 forfunction call
	li		$a1, 0				# set a=0
	li		$a2, 1				# set b=0
	jal		tail				# call "tail" function and jump
	move	$a0, $v0			# copy the result to $a0
	li		$v0, 1				# print the integer
	syscall						# syscall 1
	li		$v0, 10				# finish main 
	syscall
tail:
	beq		$a0, $zero, case0	# branch if $a0=0
	
	addi	$sp, $sp, -16		# create space for stack
	sw		$a0, 0($sp)			# store the values and return address
	sw		$a1, 4($sp)
	sw		$a2, 8($sp)
	sw		$ra, 12($sp)
	
	move	$s0, $a2			# $s0=b
	add		$a2, $a1, $a2		# $a2=a+b
	move	$a1, $s0			# $a1=b
	addi	$a0, $a0, -1		# $a0=$a0-1 for next recursion
	jal		tail
	
	lw		$a0, 0($sp)			# read reg. from the stack
	lw		$s1, 4($sp)
	lw		$s2, 8($sp)
	lw		$ra, 12($sp)		# restore return address
	addi	$sp, $sp, 16		# restore the stack
	jr		$ra
	
case0:
	move	$v0, $a1			# return $a1
	jr		$ra
