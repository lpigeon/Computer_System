.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is the pointer to the start of the matrix in memory
#   a2 is the number of rows in the matrix
#   a3 is the number of columns in the matrix
# Returns:
#   None
# ==============================================================================
write_matrix:

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
    mv s3 a3

    # Open the file
    mv a1 s0
    li a2 1 # write permission

    jal fopen

    # error check
    li t0 -1
    beq a0 t0 eof_or_error

    # store file descriptor
    mv s4 a0

    # create buffer for rows/cols
    li a0 8
    jal malloc

    # store buffer pointer
    mv a2 a0

    # store row/col in buffer
    sw s2 0(a2)
    sw s3 4(a2)

    # write row/col to file
    mv a1 s4
    li a3 2
    li a4 4
    jal fwrite

    # error check
    li t0 2
    bne a0 t0 eof_or_error

    # write matrix to file
    mv a1 s4
    mv a2 s1
    mul t0 s2 s3
    mv a3 t0
    li a4 4
    jal fwrite

    # error check
    mul t0 s2 s3
    bne a0 t0 eof_or_error

    # close file
    mv a1 s4
    jal fclose

    # error check
    li t0 -1
    beq a0 t0 eof_or_error



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
    