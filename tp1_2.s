## Factorial
# idea: keep two numbers after input n:
# t1 starts with n and keeps progressive factorial
# a0 keeps the next number to multiply by
# (n, n-1, ..., 2, 1)
.data
	input:.word 4 # input data
    
.text
	lw a0, input	# arg. a0 receives data
    beq a0, zero, zerofact	# if a0 is 0, go to zerofact
    blt a0, zero, exit	# no factorial for neg. numbers
	mv t1, a0	# t1 = a0
loop:
	addi a0, a0, -1	# a0 = a0 - 1
    beq a0, zero, exit	# if a0 = 0, loop ended, exit.
    mul t1, t1, a0	# t1 = t1 * a0
    beq zero, zero, loop	# keep looping
zerofact:
	li a0, 1	# fact. of 0 is 1
exit:
	mv a0, t1	# a0 = t1, so a0 has return value.
