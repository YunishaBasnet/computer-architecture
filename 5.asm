.data
prompt_a:   .asciiz "Enter the main number: "
prompt_b:   .asciiz "Enter a prime number: "
result:     .asciiz "Result: "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt for first number
    li $v0, 4
    la $a0, prompt_a
    syscall

    li $v0, 5
    syscall
    move $t0, $v0     # $t0 = number

    # Prompt for prime number
    li $v0, 4
    la $a0, prompt_b
    syscall

    li $v0, 5
    syscall
    move $t1, $v0     # $t1 = supposed prime

    # Divide number by prime
    div $t0, $t1
    mfhi $t2          # remainder in $t2

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2     # if remainder is 0 → it's a factor
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
