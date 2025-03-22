.data
prompt_x:   .asciiz "Enter value for x: "
prompt_y:   .asciiz "Enter value for y: "
result:     .asciiz "Result of ((4x) / 3) * y = "
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

    # 4x
    li $t2, 4
    mul $t3, $t2, $t0     # $t3 = 4x

    # (4x) / 3
    li $t4, 3
    div $t3, $t4
    mflo $t5              # $t5 = (4x) / 3

    # * y
    mul $t6, $t5, $t1     # $t6 = ((4x) / 3) * y

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t6
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
