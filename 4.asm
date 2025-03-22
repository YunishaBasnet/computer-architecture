.data
prompt:     .asciiz "Enter a number to check even (0) or odd (1): "
result_msg: .asciiz "Result: "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $t0, $v0    # store number in $t0

    # Isolate least significant bit using only shifts
    sll $t1, $t0, 31     # move LSB to MSB
    srl $t2, $t1, 31     # move it back → now $t2 = 0 or 1

    # Print result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print 0 (even) or 1 (odd)
    li $v0, 1
    move $a0, $t2
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
