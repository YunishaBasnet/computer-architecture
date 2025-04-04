.data
hexArray:   .asciiz "0x0"
            .asciiz "0x1"
            .asciiz "0x2"
            .asciiz "0x3"
            .asciiz "0x4"
            .asciiz "0x5"
            .asciiz "0x6"
            .asciiz "0x7"
            .asciiz "0x8"
            .asciiz "0x9"
            .asciiz "0xa"
            .asciiz "0xb"
            .asciiz "0xc"
            .asciiz "0xd"
            .asciiz "0xe"
            .asciiz "0xf"

prompt:     .asciiz "Enter a number from 0 to 15: "
result_msg: .asciiz "Your number is: "

.text
.globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read input number
    li $v0, 5
    syscall
    move $t0, $v0     # $t0 = user input (index)

    # Computing the offset into hex array
    li $t1, 4         # Each .asciiz string is 4 bytes ("0x0", "0xa", etc.)
    mul $t2, $t0, $t1 # $t2 = index * 4

    la $t3, hexArray  # base address of hexArray
    add $a0, $t3, $t2 # $a0 = address of a[t0]

    # Printing the  result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Printing the  hex string from array
    li $v0, 4
    add $a0, $t3, $t2
    syscall

    # Exit
    li $v0, 10
    syscall
