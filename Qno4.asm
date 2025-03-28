.data
prompt:     .asciiz "Enter a number: "
evenMsg:    .asciiz "The number is even\n"
oddMsg:     .asciiz "The number is odd\n"

.text
.globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $a0, $v0      # $a0 = user input

    # Isolate last bit using only sll and srl
    sll $t1, $a0, 31   # shift left 31 bits
    srl $t1, $t1, 31   # shift right 31 bits (now $t1 = 0 or 1)

    # if $t1 == 0 → even
    beqz $t1, print_even

    # else it's odd
    li $v0, 4
    la $a0, oddMsg
    syscall
    j end

print_even:
    li $v0, 4
    la $a0, evenMsg
    syscall

end:
    li $v0, 10
    syscall
