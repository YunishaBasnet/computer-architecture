.data
prompt_x:   .asciiz "Enter value for x: "
result:     .asciiz "Result of x^3 + 2x^2 + 3x + 4 = "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt x
    li $v0, 4
    la $a0, prompt_x
    syscall
    li $v0, 5
    syscall
    move $t0, $v0     # x in $t0

    # x^2 = x * x
    mul $t1, $t0, $t0     # $t1 = x^2

    # x^3 = x^2 * x
    mul $t2, $t1, $t0     # $t2 = x^3

    # 2x^2 = 2 * x^2
    li $t3, 2
    mul $t4, $t3, $t1     # $t4 = 2x^2

    # 3x = 3 * x
    li $t5, 3
    mul $t6, $t5, $t0     # $t6 = 3x

    # Add all: x^3 + 2x^2 + 3x + 4
    add $t7, $t2, $t4     # x^3 + 2x^2
    add $t7, $t7, $t6     # + 3x
    li $t8, 4
    add $t9, $t7, $t8     # + 4 → final result

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t9
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
