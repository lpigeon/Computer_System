.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s

.globl main

.data
m0_path: .asciiz "m0.bin"
m1_path: .asciiz "m1.bin"
input_path: .asciiz "input0.bin"
output_path: .asciiz "output.bin"

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # li a0 16
    # jal malloc
    # mv a1 a0
    # la t0 m0_path
    # sw t0 0(a1)
    # la t0 m1_path
    # sw t0 4(a1)
    # la t0 input_path
    # sw t0 8(a1)
    # la t0 output_path
    # sw t0 12(a1)
    # li a0 5

    # Exit if incorrect number of command line args
    li t0 5
    bne a0 t0 incorrect_num_args

    mv s0 a1        # save pointer to command line args in s0

	# =====================================
    # LOAD MATRICES
    # =====================================
    




    # Load pretrained m0
    lw a0 4(s0)
    addi sp sp -4
    mv a1 sp
    addi sp sp -4
    mv a2 sp
    jal read_matrix

    mv s1 a0        # save pointer to m0 in s1
    lw s2 4(sp)     # save num rows of m0 in s2
    lw s3 0(sp)     # save num cols of m0 in s3

    addi sp sp 4    # reset stack

    # Load pretrained m1
    lw a0 8(s0)
    addi sp sp -4
    mv a1 sp
    addi sp sp -4
    mv a2 sp
    jal read_matrix

    mv s4 a0        # save pointer to m1 in s4
    lw s5 4(sp)     # save num rows of m1 in s5
    lw s6 0(sp)     # save num cols of m1 in s6

    addi sp sp 4    # reset stack



    # Load input matrix
    lw a0 12(s0)
    addi sp sp -4
    mv a1 sp
    addi sp sp -4
    mv a2 sp
    jal read_matrix

    mv s7 a0        # save pointer to input in s7
    lw s8 4(sp)     # save num rows of input in s8
    lw s9 0(sp)     # save num cols of input in s9

    addi sp sp 4    # reset stack


    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    # allocate memory for first layer result
    # need (num rows of m0) * (num cols of input) * 4 bytes
    li t0 4
    mul a0 s2 s9
    mul a0 a0 t0
    jal malloc  
    mv s10 a0

    # setup the call to matmul for first layer
    mv a0 s1
    mv a1 s2
    mv a2 s3
    mv a3 s7
    mv a4 s8
    mv a5 s9
    mv a6 s10

    jal matmul      # no return value


    # call ReLU on result of first layer
    mv a0 s10
    mul a1 s2 s9

    jal relu        # no return value

    # call matmul on m1 and result of second layer
    # first allocate memory for the result of this layer
    # need (num rows of m1) * (num cols of second layer) * 4 bytes
    li t0 4
    mul a0 s5 s9
    mul a0 a0 t0
    jal malloc  
    mv s11 a0

    # setup call to matmul for third layer
    mv a0 s4
    mv a1 s5
    mv a2 s6
    mv a3 s10
    mv a4 s2
    mv a5 s9
    mv a6 s11

    jal matmul      # no return value
   

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0 16(s0)    # Load pointer to output filename
    mv a1 s11
    mv a2 s5
    mv a3 s9
    jal write_matrix





    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0 s11
    mul a1 s5 s9
    jal argmax
    mv s0 a0

    # Print classification
    mv a1 s0
    jal print_int



    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    jal exit

incorrect_num_args:
    li a1 3
    jal exit2
