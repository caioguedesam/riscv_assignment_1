## Permutation
## idea: have an empty array 3 for checking.
## for each array 1 element, compare to all array 2 elements
## if they are the same, fill array 3 with a 1 on given array 1 index.
## at the end, check if there is a 0 in array 3 (if there was an unchecked element)
## if there is, then not a permutation. Otherwise, it is a permutation.
main:
	.data
    # Array data
    p1: .word 1, 2, 3, 5	# first array
    p2: .word 4, 3, 1, 2	# second array
    pm: .word 0, 0, 0, 0	# permutation checking
    
    .text
    addi a0, a0, 4			# Loading size to a0 (ex.: 4)
    la a1, p1				# Loading array 1 to a1
    la a2, p2				# Loading array 2 to a2
    la a3, pm				# Loading check array to a3
    
	add t1, zero, a1		# Temporary t1 to store mem address of array 1
    addi t2, zero, 0		# Temporary t2 to store index of array 1
    beq zero, zero, loop1	# Goes to loop 1 to process arrays
    
loop1:
    lw t0, 0(t1)			# t0 gets element of array 1 at given index for each iteration
    add t3, zero, a2		# Temporary t3 to store mem address of array 2
    addi t4, zero, 0		# Temporary t4 to store index of array 2
    jal ra, loop2
    
    # end of loop1 iteration:
    addi t2, t2, 1			# Going to next index
    beq t2, a0, verify		# if next index = array size, the loop is over. Go to next step.
    
    slli t2, t2, 2			# *4 for word size
    add t1, a1, t2			# Getting new address for position t2 in array 1
    srli t2, t2, 2			# /4 to go back to regular indexing	
    beq zero, zero, loop1	# Keep looping
    
loop2:
	lw t5, 0(t3)				# t5 gets element of array 2 at given index for each iteration
    beq t0, t5, foundelement	# if elements in both arrays are equal, go to foundelement.
    
    # end of loop2 iteration: (same logic as end of loop1, so no comments)
    addi t4, t4, 1
    beq t4, a0, exitloop		# if next index = array size, loop2 is over. Go back to loop1.
    slli t4, t4, 2
    add t3, a2, t4
    srli t4, t4, 2
    beq zero, zero, loop2
    
exitloop:
	jalr zero, 0(ra)
    
foundelement:
	slli t2, t2, 2			# *4 for word size	
    add t6, a3, t2			# Temporary t3 to store mem address of array 2 + index stored on t2
    srli t2, t2, 2			# /4 to go back to regular indexing
    addi t5, zero, 1		# Temporary t5 stores value 1
    sw t5, 0(t6)			# Stores 1 on position t2 of verification array (marking element as found).
    jal zero, exitloop		# Go back to loop1.
    
verify:
	addi t0, zero, 0		# Storing 0/1 based on is or isn't permutation (starts at 0)
	add t1, zero, a3		# Temporary t1 to store mem address of array 3
    addi t2, zero, 0		# Temporary t2 to store index of array 3
    jal ra, loop3			# Goes to loop 3 to process array 3
    
    addi t0, zero, 1		# If it returns here, that means it is a permutation.
    beq zero, zero, exit	# Go to exit
    
loop3:
	lw t6, 0(t1)			# t6 gets element of array 3 at given index for each iteration
    beq t6, zero, exit		# If found a 0 in array 3, then it's not a permutation, exit
    
	addi t2, t2, 1			# Going to next index
    beq t2, a0, exitloop	# If next index = array size, loop3 has ended. Go back to verify.
    slli t2, t2, 2			# *4 for word size
    add t1, a3, t2			# Getting new address for position t2 in array 1
    srli t2, t2, 2			# /4 to go back to regular indexing	
    beq zero, zero, loop3	# Keep looping
    
exit:
	add a0, zero, t0		# Load the permutation boolean to the return reg. a0. The End.
