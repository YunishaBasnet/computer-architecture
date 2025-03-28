.data
prompt:     .asciiz "Enter a number from 3 to 100: "
newline:    .asciiz "\n"
space:      .asciiz " "
resultMsg:  .asciiz "Prime factors: "

.text
.globl main

main:
    # Ask user for a number
    li $v0, 4
    la $a0, prompt
    syscall

    # Read number
    li $v0, 5
    syscall
    move $s0, $v0        # $s0 = input number (n)
    
    # Print message
    li $v0, 4
    la $a0, resultMsg
    syscall

    li $t0, 2            # Start checking from 2

factor_loop:
    bgt $t0, $s0, end    # if factor > n, end

    # Check if $t0 divides $s0
    move $t1, $s0
    div $t1, $t0
    mfhi $t2             # remainder in $t2
    bnez $t2, next       # if not divisible, skip

    # Check if $t0 is prime
    li $t3, 2
    li $t4, 0            # flag: 0 = prime, 1 = not prime

prime_check_loop:
    beq $t3, $t0, prime_check_done
    div $t0, $t3
    mfhi $t5
    beqz $t5, not_prime
    addi $t3, $t3, 1
    j prime_check_loop

not_prime:
    li $t4, 1            # flag = not prime

prime_check_done:
    bnez $t4, next       # if not prime, skip

    # Print the prime factor
    li $v0, 1
    move $a0, $t0
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

next:
    addi $t0, $t0, 1
    j factor_loop

end:
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
