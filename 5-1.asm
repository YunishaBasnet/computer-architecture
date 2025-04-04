.data
prompt1: .asciiz "Enter first number: "
prompt2: .asciiz "Enter second number: "
prompt3: .asciiz "Enter third number: "
output:  .asciiz "The median is: "

.text
.globl main

main:
    # --- Read the number 1 ---
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    # --- Read the  number 2 ---
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    # --- Read the  number 3 ---
    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    # --- Sorting logic: Make t0 <= t1 <= t2 ---

    # If t0 > t1: swap
    bgt $t0, $t1, swap01
skip01:

    # If t1 > t2: swap
    bgt $t1, $t2, swap12
skip12:

    # If t0 > t1 again: swap
    bgt $t0, $t1, swap01_2
skip01_2:

    # --- Print Result ---
    li $v0, 4
    la $a0, output
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 10
    syscall

# --- Swaps ---
swap01:
    move $t3, $t0
    move $t0, $t1
    move $t1, $t3
    j skip01

swap12:
    move $t3, $t1
    move $t1, $t2
    move $t2, $t3
    j skip12

swap01_2:
    move $t3, $t0
    move $t0, $t1
    move $t1, $t3
    j skip01_2
