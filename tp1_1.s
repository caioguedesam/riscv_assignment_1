## Parity
# idea: remainder of division by 2. If 0 = even, if 1 = odd.
.data
	input:.word 16	# input data

.text
	lw a0, input	# arg. a0 receives data
	jal ra, parity
	jal zero, exit
parity:
	addi t0, zero, 2	# t0 = 2
	rem a0, a0, t0	# a0 = a0 % 2
	jalr zero, 0(ra)
exit:
