.data
prompt_x:   .asciiz "Enter value for x: "
prompt_y:   .asciiz "Enter value for y: "
prompt_z:   .asciiz "Enter value for z: "
result:     .asciiz "Result of 5x + 3y + z = "
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

    # Prompt y
    li $v0, 4
    la $a0, prompt_y
    syscall
    li $v0, 5
    syscall
    move $t1, $v0     # y in $t1

    # Prompt z
    li $v0, 4
    la $a0, prompt_z
    syscall
    li $v0, 5
    syscall
    move $t2, $v0     # z in $t2

    # Compute 5x → 5 * $t0
    li $t3, 5
    mul $t4, $t3, $t0  # $t4 = 5x

    # Compute 3y → 3 * $t1
    li $t5, 3
    mul $t6, $t5, $t1  # $t6 = 3y

    # Add: 5x + 3y
    add $t7, $t4, $t6

    # Add z: 5x + 3y + z
    add $t8, $t7, $t2

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t8
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
