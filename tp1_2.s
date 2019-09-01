main:
	.text
	addi a0, zero, 4			# Load number for desired factorial on arg. a0
	beq a0, zero, zerofact		# If number is 0, go straight to zerofact
	add t1, zero, a0			# Temporary t1 stores value of factorial each iteration
loop:
	addi a0, a0, -1				# Decrements a0 each iteration
	beq a0, zero, exit			# if a0 reaches 0, factorial was calculated, exit
	mul t1, t1, a0				# Multiplies t1 by current a0 (n, n-1, ..., 2, 1)
	beq zero, zero, loop		# Keep looping
zerofact:
	addi t1, zero, 1			# Factorial of zero is 1
exit:

