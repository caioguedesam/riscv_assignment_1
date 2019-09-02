## Permutation
# idea: get additional array filled with 0.
# for each element of array1, check all elements
# of array2. if found a match, mark array3 with
# a 1 on same position of array2 element.
# In the end, if there's any 0 on array3, it's not
# a permutation, if there isn't, it is.
.data
	# Array data
    size:.word 4
    size2:.word 4
    p1:.word 1, 2, 3, 5	# First array
    p2:.word 4, 3, 1, 2	# Second array
    pm:.word 0, 0, 0, 0 # checking array (has to be same size)
    
.text
	lw a0, size	# a0 = size1
    lw a4, size2	# a4 = size2
    bne a0, a4, fail	# if sizes are different, no permut.
    la a1, p1	# a1 = first array
    la a2, p2	# a2 = second array
    addi sp, sp, -4
    sw s1, 0(sp)	# s1 will be checking array
	la s1, pm
    
    mv t1, a1	# t1 = current position of array1
    li t2, 0	# t2 = current index of array1
    beq zero, zero, loop1	# begin array processing
    
loop1:
	# This loop iterates over first array elements
    lw t0, 0(t1)	# t0 = array1[i] (i = index1)
    mv t3, a2	# t3 = current position of array2
    li t4, 0	# current index of array2
    jal ra, loop2
    
    # end of loop1 iteration:
    addi t2, t2, 1	# next index
    beq t2, a0, verify	# if hits array size, stop and check.
    slli t2, t2, 2	# *4 for word size
    add t1, a1, t2	# t1 = array1[i]
    srli t2, t2, 2	# /4 back to normal index
	beq zero, zero, loop1
    
loop2:
	# This loop iterates over second array elements
    lw t5, 0(t3)	# t5 = array2[j] (j = index2)
    beq t0, t5, foundelement	# found if
    							# array1[i]=array2[j]
	# end of loop2 iteration:
    addi t4, t4, 1	# next index
    beq t4, a0, exitloop	# if hits array size, stop
    slli t4, t4, 2	# *4 for word size
    add t3, a2, t4	# t3 = array2[j]
    srli t4, t4, 2	# /4 back to normal index
	beq zero, zero, loop2
    
foundelement:
	# If element is found, go to checking array
    # then fill position array3[i] with 1
    
    slli t4, t4, 2	# *4 for word size
    add t6, s1, t4	# t6 = array3[j]
    lw t5, 0(t6)
    bne t5, zero, exitloop	# if position isnt empty, go back
    						# (if there are 2+ equal elements)
	li t5, 1
	sw t5, 0(t6)	# marks position
    srli t4, t4, 2	# /4 back to normal index
    beq zero, zero, exitloop	# back to loop1
    
exitloop:
	# Standard return procedure
	jalr zero, 0(ra)

verify:
	mv t1, s1	# t1 = current position of array3
    li t2, 0	# t2 = current index of array3
    jal ra, loop3
    
    beq zero, zero, success	# if loop ends, success.
loop3:
	# This loop iterates over checking array
    # If it finds a 0, it's not a permutation
    # if not, it is a permutation
    
    lw t6, 0(t1)	# t6 = array3[k] (k = index3)
    beq t6, zero, fail	# found a 0
    
    # end of loop3 iteration:
    addi t2, t2, 1	# go to next index
    beq t2, a0, exitloop	# if hits array size, stop
    slli t2, t2, 2	# *4 for word size
    add t1, s1, t2	# t1 = array3[k]
    srli t2, t2, 2	# /4 back to normal index
    beq zero, zero, loop3
    
success:
	# If succeeded, a0 = 1.
	li a0, 1
    beq zero, zero, exit
fail:
	# If failed, a0 = 0.
	li a0, 0
exit:
	lw s1, 0(sp)	# restoring used register s1
    addi sp, sp, 4
