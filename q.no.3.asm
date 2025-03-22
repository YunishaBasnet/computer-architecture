.data
prompt_a:   .asciiz "Enter first number (a): "
prompt_b:   .asciiz "Enter second number (b): "
before:     .asciiz "\nBefore swapping: a = "
and_b:      .asciiz ", b = "
after:      .asciiz "\nAfter swapping: a = "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Prompt for a
    li $v0, 4
    la $a0, prompt_a
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # a in $t0

    # Prompt for b
    li $v0, 4
    la $a0, prompt_b
    syscall

    li $v0, 5
    syscall
    move $t1, $v0      # b in $t1

    ###### Print BEFORE swap ######
    li $v0, 4
    la $a0, before
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, and_b
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    ###### XOR Swap ######
    xor $t0, $t0, $t1   # a = a ^ b
    xor $t1, $t0, $t1   # b = a ^ b → original a
    xor $t0, $t0, $t1   # a = a ^ b → original b

    ###### Print AFTER swap ######
    li $v0, 4
    la $a0, after
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, and_b
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    # Newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall
