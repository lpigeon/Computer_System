.import ../argmax.s
.import ../utils.s

.data
v0: .word 9 1 2 300 4 5 6 7 8 19 # MAKE CHANGES HERE

.text
main:
    # Load address of v0
    la s0 v0
    
    # Set length of v0
    addi s1 x0 10 # MAKE CHANGES HERE

    # Call argmax
    mv a0 s0
    mv a1 s1
    jal ra argmax

    # Print the output of argmax
    mv a1 a0
    jal ra print_int

    # Print newline
    li a1 '\n'
    jal ra print_char

    # Exit program
    jal exit
