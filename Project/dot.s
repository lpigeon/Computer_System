.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0 
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
	# Prologue
	li t0, 0 # i
	li t1, 4
	li t2, 0
	li t3, 0
	li t4, 0
	li t5, 0
	li t6, 0
	
	
loop_start:
	beq t0, a2, loop_end
	mul t1, t0, t1 # 4i
	mul t1, a3, t1 # 4i*s.v0
	mul t2, a4, t1 # 4i*s.v1
	add t1, a0, t1
	add t2, a1, t2
	lw t3, 0(t1)
	lw t4, 0(t2)
	mul t5, t3, t4
	add t6, t5, t6
	addi t0, t0, 1
	li t1, 4
	j loop_start
	
loop_end:
	mv a0, t6
	
	# Epilogue

	ret
