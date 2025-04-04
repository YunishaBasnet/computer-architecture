.data
prompt:     .asciiz "Enter a max Fibonacci number to calc: "
space:      .asciiz " "
array:      .space 400         # Reserve space for 100 integers (4 bytes * 100)

.text
.globl main

main:
 
    li $v0, 4
    la $a0, prompt
    syscall

    # Reading the input
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 = size

    la $t1, array        # $t1 = base address of array
    andi $t1, $t1, 0xFFFFFFFC  # align to 4-byte boundary

    # array[0] = 0
    sw $zero, 0($t1)

    # array[1] = 1
    li $t2, 1
    sw $t2, 4($t1)

    li $t3, 2            # $t3 = i = 2

fib_loop:
    bge $t3, $t0, fib_done       # if i >= size, exit loop

    # Calculating the  offsets
    mul $t4, $t3, 4              # offset = i * 4
    sub $t5, $t4, 4              # offset for i-1
    sub $t6, $t4, 8              # offset for i-2

    # Loading the  Fibonacci[i-1]
    add $s1, $t1, $t5
    lw $s2, 0($s1)

    # Loading Fibonacci[i-2]
    add $s3, $t1, $t6
    lw $s4, 0($s3)

    # Computing and storing Fibonacci[i]
    add $t9, $s2, $s4
    add $s0, $t1, $t4
    sw $t9, 0($s0)

    addi $t3, $t3, 1
    j fib_loop

fib_done:
    # Print the array
    move $a0, $t1          # base address
    move $a1, $t0          # size
    jal PrintIntArray

    li $v0, 10
    syscall

PrintIntArray:
    andi $a0, $a0, 0xFFFFFFFC   # ensure word alignment
    li $t0, 0                   # i = 0

print_loop:
    bge $t0, $a1, print_done

    mul $t1, $t0, 4
    add $t2, $a0, $t1
    andi $t2, $t2, 0xFFFFFFFC

    lw $a0, 0($t2)

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j print_loop

print_done:
    jr $ra
