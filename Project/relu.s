.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#       a0 is the pointer to the array
#       a1 is the # of elements in the array
# Returns:
#       None
# ==============================================================================
relu:
    # Prologue
	addi sp, sp, -8
	sw ra, 0(sp)
	sw s0, 4(sp)
	
	li s0, 0
	mv t0, a0
        li t1, 4
	li t2, 0
	li t3, 0
	li t4, 0
	
loop_start:
	beq s0, a1, loop_end
	mul t2, t1, s0 # 4i
	add t3, a0, t2
	lw t4, 0(t3)
	bge t4, x0, loop_continue
	mul t4, t4, x0
	sw t4, 0(t3)
		
loop_continue:
	addi s0, s0, 1
	j loop_start
		
loop_end:
	mv a0, t3
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp, sp, 8
    ret
