.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#       element. If there are multiple, return the one
#       with the smallest index.
# Arguments:
#       a0 is the pointer to the start of the vector
#       a1 is the # of elements in the vector
# Returns:
#       a0 is the first index of the largest element
# =================================================================
argmax:
	# Prologue
	addi sp, sp, -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	li s0, 0
	li t1, 4 
	li t2, 0
	li t3, 0
	lw t4, 0(a0) #max
	li t5, 0 #max num
	li t6, 0 
	
loop_start:
	beq s0, a1, loop_end
	mul t2, t1, s0
	add t3, t2, a0
	lw t6, 0(t3)
	ble t6, t4, loop_continue
	mv t4, t6
	mv t5, s0
	
loop_continue:
	addi s0, s0, 1
	j loop_start
		
loop_end:
	mv a0, t5
	
	# Epilogue
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp, sp, 8
    ret
