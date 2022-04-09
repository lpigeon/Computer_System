.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi t1, x0, 1
    add t2, a0, x0
    bne t2, x0, square
    add a0, x0, t1
    jr ra
        
square:
    mul t1, t1, t2
    addi t2, t2, -1
    bne t2, x0, square
    add a0, x0, t1
    jr ra

