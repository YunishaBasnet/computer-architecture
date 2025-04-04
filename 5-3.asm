.data
prompt:     .asciiz "Enter a number: "
result_msg: .asciiz "The factorial is: "

.text
.globl main

main:

    li $v0, 4
    la $a0, prompt
    syscall

    # Reading the input number
    li $v0, 5
    syscall
    move $a0, $v0    # Pass input in $a0

    # Calling recursive factorial function
    jal factorial

    # Printing the  result label
    li $v0, 4
    la $a0, result_msg
    syscall

    # Printing the  factorial result
    li $v0, 1
    move $a0, $v1     # Result is in $v1
    syscall

    # Exit
    li $v0, 10
    syscall



factorial:
    # Base case: if n == 0, return 1
    beq $a0, $zero, base_case

    # Recursive case:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    addi $a0, $a0, -1
    jal factorial

    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    mul $v1, $a0, $v1
    jr $ra

base_case:
    li $v1, 1
    jr $ra
