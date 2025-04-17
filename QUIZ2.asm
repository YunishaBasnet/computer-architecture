.data
    prompt:     .asciiz "Enter an integer: "
    max_label:  .asciiz "\nMaximum value: "
    min_label:  .asciiz "\nMinimum value: "

.text
    .globl main

main:
    li $t0, 0              # i = 0 (counter)
    li $t1, 5              # total numbers = 5

    # Reading the first number
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5              
    syscall
    move $t2, $v0          # max = first number
    move $t3, $v0          # min = first number

    addi $t0, $t0, 1       # i = 1

loop:
    beq $t0, $t1, done     # if i == 5, exit loop of the integer

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5              # reading the  integer
    syscall
    move $t4, $v0          # current number

    #  value is checked
    bgt $t4, $t2, update_max
    j check_min

update_max:
    move $t2, $t4          # max = current
    j check_min

check_min:
    blt $t4, $t3, update_min
    j continue

update_min:
    move $t3, $t4          # min = current

continue:
    addi $t0, $t0, 1       # i++
    j loop

done:
    # Printing the output
    li $v0, 4
    la $a0, max_label
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Print min
    li $v0, 4
    la $a0, min_label
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    # Exit
    li $v0, 10
    syscall
