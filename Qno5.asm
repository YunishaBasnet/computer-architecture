.data
prompt:     .asciiz "Enter an amount (1 to 99): "
newline:    .asciiz "\n"

q_text:     .asciiz " quarter(s), "
d_text:     .asciiz " dime(s), "
n_text:     .asciiz " nickel(s), and "
p_text:     .asciiz " penny(pennies)\n"

.text
.globl main

main:
    # Ask user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read amount
    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = total cents

    # Compute quarters
    li $t1, 25
    div $t0, $t1
    mflo $t2            # $t2 = num of quarters
    mfhi $t0            # remainder

    # Compute dimes
    li $t1, 10
    div $t0, $t1
    mflo $t3            # $t3 = num of dimes
    mfhi $t0

    # Compute nickels
    li $t1, 5
    div $t0, $t1
    mflo $t4            # $t4 = num of nickels
    mfhi $t5            # $t5 = num of pennies

    # Print quarters
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, q_text
    syscall

    # Print dimes
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, d_text
    syscall

    # Print nickels
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, n_text
    syscall

    # Print pennies
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, p_text
    syscall

    li $v0, 10
    syscall
