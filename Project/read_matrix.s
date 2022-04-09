.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

    # Prologue
	addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    
    mv s0 a0
    mv s1 a1
    mv s2 a2

    # Open the file
    mv a1 s0
    li a2 0 # read permission

    jal fopen

    # error check
    li t0 -1
    beq a0 t0 eof_or_error

    # store file pointer
    mv s3 a0

    # read num rows
    mv a1 s3
    mv a2 s1
    li a3 4

    jal fread

    # error check
    li t0 4
    bne a0 t0 eof_or_error

    # read num cols
    mv a1 s3
    mv a2 s2
    li a3 4

    jal fread

    # error check
    li t0 4
    bne a0 t0 eof_or_error

    # allocate memory for matrix
    lw t0 0(s1) 
    lw t1 0(s2)
    mul t2 t0 t1
    li t0 4
    mul t2 t2 t0
    mv a0 t2
    jal malloc

    # save matrix pointer
    mv s4 a0

    # read matrix from file
    mv a1 s3
    mv a2 s4
    lw t0 0(s1) 
    lw t1 0(s2)
    mul t2 t0 t1
    li t0 4
    mul t2 t2 t0
    mv a3 t2
    jal fread

    # error check
    lw t0 0(s1) 
    lw t1 0(s2)
    mul t2 t0 t1
    li t0 4
    mul t2 t2 t0
    bne a0 t2 eof_or_error

    # close file
    mv a1 s3
    jal fclose

    # error check
    li t0 -1
    beq a0 t0 eof_or_error

    # set return value
    mv a0 s4
    
    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24

    ret

eof_or_error:
    li a1 1
    jal exit2
    