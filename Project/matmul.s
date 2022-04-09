.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#       d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
#       a0 is the pointer to the start of m0
#       a1 is the # of rows (height) of m0
#       a2 is the # of columns (width) of m0
#       a3 is the pointer to the start of m1
#       a4 is the # of rows (height) of m1
#       a5 is the # of columns (width) of m1
#       a6 is the pointer to the the start of d
# Returns:
#       None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    # Error if mismatched dimensions
	bne a2, a4, mismatched_dimensions
	
	# Prologue
	addi sp, sp, -52
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	sw s4, 20(sp)
	sw s5, 24(sp)
	sw s6, 28(sp)
	sw s7, 32(sp)
	sw s8, 36(sp)
	sw s9, 40(sp)
	sw s10, 44(sp)
	sw s11, 48(sp)
	
	li s0, 0 #i
	li s1, 0
	li s2, 0
	li s3, 0 #j
	li s4, 0 
	mv s5, a0
	mv s6, a1	
	mv s7, a2
	mv s8, a3
	mv s9, a4
	mv s10, a5
	mv s11, a6
	
outer_loop_start:
	beq s0, s6, outer_loop_end
	slli s1, s0, 2 # 4i
	mul s2, s1, s7 # width*4i
	add s2, s5, s2 # m0 + width*4i	
	
inner_loop_start:
	beq s3, s10, inner_loop_end
	slli s4, s3, 2 # 4j
	add s4, s8, s4 # m1 + 4j
	
	mv a0, s2
	mv a1, s4
	mv a2, s9
        li a3, 1
	mv a4, s10
	jal dot
	sw a0, 0(s11)	
	
	addi s3, s3, 1
	addi s11, s11, 4
	j inner_loop_start	
	
inner_loop_end:
	li s3, 0
	addi s0, s0, 1
	j outer_loop_start	
	
outer_loop_end:
   
    # Epilogue
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	lw s4, 20(sp)
	lw s5, 24(sp)
	lw s6, 28(sp)
	lw s7, 32(sp)
	lw s8, 36(sp)
	lw s9, 40(sp)
	lw s10, 44(sp)
	lw s11, 48(sp)
	addi sp, sp, 52
	ret
		
mismatched_dimensions:
    li a1, 2
    jal exit2	
	
	
	
	
	
	
	
	
	
	
