.data
prompt:     .asciiz "Enter an integer to multiply by 10: "
result1:    .asciiz "Result using shift and add: "
result2:    .asciiz "\nResult using mult and mflo: "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $t0, $v0        # Store input in $t0

    ###### Method 1: Multiply using shift and add ######
    sll $t1, $t0, 3      # $t1 = input * 8
    sll $t2, $t0, 1      # $t2 = input * 2
    add $t3, $t1, $t2    # $t3 = input * 10

    # Print result1
    li $v0, 4
    la $a0, result1
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    ###### Method 2: Multiply using mult and mflo ######
    li $t5, 10           # Load 10 into register
    mult $t0, $t5        # Multiply input * 10
    mflo $t4             # Store result in $t4

    # Print result2
    li $v0, 4
    la $a0, result2
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
