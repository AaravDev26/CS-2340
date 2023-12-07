# Aarav Dev
# axd220001
# Section 002

.data
str1: .asciiz "Geeks"
str2: .asciiz "World"
str3: .space 200   # Allocate space for str3

.text
.globl main
main:
    # Initialize the pointers to str1, str2, and str3
    la $t0, str1         # Load the address of str1 into $a0
    la $t1, str2         # Load the address of str2 into $a1
    la $t2, str3         # Load the address of str3 into $a2

    # Initialize the loop counters (i and j)
    li $t3, 0            # Initialize i to 0
    li $t4, 0            # Initialize j to 0
    
    # Print the label for the first string
    li $v0, 4            # syscall code for printing a string
    la $a0, first         
    syscall

    # Print the first string
    li $v0, 4            # syscall code for printing a string
    la $a0, str1         # Load the address of str1 into $a0
    syscall

    # Print the label for the second string
    li $v0, 4            # syscall code for printing a string
    la $a0, second         
    syscall

    # Print the second string
    li $v0, 4            # syscall code for printing a string
    la $a0, str2         # Load the address of str2 into $a0
    syscall

copy_loop1:
    # Load a character from str1[i] into $t5
    lb $t5, 0($t0)

    # Check if the character is null ('\0')
    beqz $t5, copy_loop2_end

    # Store the character in str3[j]
    sb $t5, 0($t2)

    # Increment i and j
    addi $t3, $t3, 1     # Increment i
    addi $t4, $t4, 1     # Increment j

    # Move to the next character in str1
    addi $t0, $t0, 1

    # Move to the next character in str3
    addi $t2, $t2, 1

    # Repeat the loop
    j copy_loop1

copy_loop2_end:
    # Reset i to 0
    li $t3, 0

copy_loop2:
    # Load a character from str2[i] into $t5
    lb $t5, 0($t1)

    # Check if the character is null ('\0')
    beqz $t5, copy_loop2_end2

    # Store the character in str3[j]
    sb $t5, 0($t2)

    # Increment i and j
    addi $t3, $t3, 1     # Increment i
    addi $t4, $t4, 1     # Increment j

    # Move to the next character in str2
    addi $t1, $t1, 1

    # Move to the next character in str3
    addi $t2, $t2, 1

    # Repeat the loop
    j copy_loop2

copy_loop2_end2:
    # Null-terminate str3
    sb $zero, 0($t2)
    
    # Print the label for concatenated string
    li $v0, 4            # syscall code for printing a string
    la $a0, concatenated         
    syscall

    # Print the concatenated string (str3)
    li $v0, 4            # syscall code for printing a string
    la $a0, str3         # Load the address of str3 into $a0
    syscall

    # Exit the program
    li $v0, 10           # syscall code for program exit
    syscall
    
.data
first: .asciiz "\nFirst string: "
second: .asciiz "\nSecond string: "
concatenated: .asciiz "\nConcatenated string: "
