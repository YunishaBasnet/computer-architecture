.data
prompt:     .asciiz "Enter a number n (>= 3) to find all primes from 3 to n: "
newline:    .asciiz "\n"
space:      .asciiz " "
heading:    .asciiz "Prime numbers from 3 to n: "

.text
.globl main

main:
    # Ask for user input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer n
    li $v0, 5
    syscall
    move $s0, $v0        # $s0 = n

    # Print heading
    li $v0, 4
    la $a0, heading
    syscall

    li $t0, 3            # $t0 = i = 3

loop_i:
    bgt $t0, $s0, end    # if i > n, end
    move $t1, $t0        # $t1 = number to check (i)
    li $t2, 2            # $t2 = divisor
    li $t3, 0            # $t3 = is_not_prime flag (0 = prime)

check_divisor:
    beq $t2, $t1, check_done   # if divisor == number, done checking
    div $t1, $t2
    mfhi $t4                   # remainder in $t4
    beqz $t4, not_prime        # if remainder == 0 → not prime
    addi $t2, $t2, 1
    j check_divisor

not_prime:
    li $t3, 1                  # set not-prime flag

check_done:
    bne $t3, 0, next_i         # if not prime, skip printing

    # Print the prime number
    li $v0, 1
    move $a0, $t1
    syscall

    # Print a space
    li $v0, 4
    la $a0, space
    syscall

next_i:
    addi $t0, $t0, 1
    j loop_i

end:
    # Print newline at the end
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
