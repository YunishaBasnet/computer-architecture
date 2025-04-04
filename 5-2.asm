.data
prompt:     .asciiz "Enter a number: "
result_msg: .asciiz "The square is: "

.text
.globl main

main:
 
    li $v0, 4
    la $a0, prompt
    syscall

    # Reading the  integer input
    li $v0, 5
    syscall
    move $a0, $v0   # $a0 = n
    move $s0, $v0   # save original n in $s0

    # Calling the  recursive function: result = square(n)
    jal square

    # Printing the result label
    li $v0, 4
    la $a0, result_msg
    syscall

    # Printing the  result
    li $v0, 1
    move $a0, $v1    # $v1 holds return value
    syscall

    # Exit
    li $v0, 10
    syscall


square:
    # Base case: if n == 0, return 0
    beq $a0, $zero, base_case

    # Recursive case
    addi $sp, $sp, -8      # allocate stack
    sw $ra, 4($sp)         # save return address
    sw $a0, 0($sp)         # save current counter

    addi $a0, $a0, -1      # n = n - 1
    jal square             # recursive call

    lw $a0, 0($sp)         # restore counter
    lw $ra, 4($sp)         # restore return address
    addi $sp, $sp, 8       # deallocate stack

    add $v1, $v1, $s0      # v1 = v1 + n
    jr $ra

base_case:
    li $v1, 0              # return 0
    jr $ra
