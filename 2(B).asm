.data
prompt_x:   .asciiz "Enter value for x: "
prompt_y:   .asciiz "Enter value for y: "
prompt_z:   .asciiz "Enter value for z: "
result:     .asciiz "Result of ((5x + 3y + z)/2) * 3 = "
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
    move $t0, $v0     # x

    # Prompt y
    li $v0, 4
    la $a0, prompt_y
    syscall
    li $v0, 5
    syscall
    move $t1, $v0     # y

    # Prompt z
    li $v0, 4
    la $a0, prompt_z
    syscall
    li $v0, 5
    syscall
    move $t2, $v0     # z

    # 5x
    li $t3, 5
    mul $t4, $t3, $t0     # $t4 = 5x

    # 3y
    li $t5, 3
    mul $t6, $t5, $t1     # $t6 = 3y

    # sum = 5x + 3y
    add $t7, $t4, $t6

    # sum = sum + z
    add $t7, $t7, $t2     # $t7 = 5x + 3y + z

    # Divide by 2
    li $t8, 2
    div $t7, $t8
    mflo $t9              # $t9 = (5x + 3y + z) / 2

    # Multiply by 3
    li $t3, 3
    mul $s0, $t9, $t3     # $s0 = final result

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
