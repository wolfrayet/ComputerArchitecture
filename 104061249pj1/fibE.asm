# Algorithm 5: Fast Doubling Method
.text
.globl main
main:
	li		$v0, 5				# read integer from the user
	syscall						# syscall 5
	move	$a0, $v0			# copy the input integer to $a0 forfunction call
	beq		$a0, $zero, case0	# n=0 case
	li		$t0, 1				# i=1	
	li		$t1, 2				# $t1=2
	li		$s1, 1				# f(i)
	li		$s2, 1				# f(i+1)
	div		$a0, $t1			# n/2
	mflo	$s0					# $s0=n/2
	blt		$t0, $a0, while 	# while loop	
case0:
	li		$s1, 0
	j		return
while:			
	bge		$t0, $a0, return	# if i>=n, return
	ble		$t0, $s0, half		# if i<=n/2, do half
	j		else 				# else
half:
	mul		$t2, $s1, $s1		# f(i) square
	mul		$t3, $s2, $s2		# f(i+1) square
	mul		$s2, $s2, $t1		# f(i+1)*2
	sub		$s2, $s2, $s1		# f(i+1)*2-f(i)
	add		$t4, $t2, $t3		# f(2i+1)=f(i)^2+f(i+1)^2
	mul		$t5, $s1, $s2		# f(2i)=f(i)*(f(i+1)*2-f(i))
	move	$s1, $t5			# f(i)=f(2i)
	move	$s2, $t4			# f(i+1)=f(2i+1)
	mul		$t0, $t0, $t1		# i=i*2
	j 		while				# back to while
else:
	add		$t4, $s1, $s2		# f(i+2)=f(i)+f(i+1)
	move	$s1, $s2			# f(i)=f(i+1)
	move	$s2, $t4			# f(i+1)=f(i+2)
	addi	$t0, $t0, 1			# i=i+1
	j		while				# back to while
return:			
	move	$a0, $s1			# copy the result to $a0
	li		$v0, 1				# print the integer
	syscall						# syscall 1
	li		$v0, 10				# finish 
	syscall
