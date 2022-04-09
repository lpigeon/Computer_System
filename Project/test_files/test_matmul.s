.import ../matmul.s
.import ../utils.s
.import ../dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9
m1: .word 1 2 3 4 5 6 7 8 9
d: .word 0 0 0 0 0 0 0 0 0 # allocate static space for output

.text
main:
	# Load addresses of input matrices (which are in static memory), and 
	# set their dimensions

	la s0 m0
	addi s1 x0 3
	addi s2 x0 3
	la s3 m1
	addi s4 x0 3
	addi s5 x0 3
	la s6 d

	# Call matrix multiply, m0 * m1

	mv a0 s0
	mv a1 s1
	mv a2 s2
	mv a3 s3
	mv a4 s4
	mv a5 s5
	mv a6 s6
	jal ra matmul

	# Print the output (use print_int_array in utils.s)

	mv a0 s6
	mv a1 s1
	mv a2 s5
	jal ra print_int_array

	# Exit the program
	jal exit
