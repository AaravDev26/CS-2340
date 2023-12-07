# Aarav Dev
# axd220001
# Section 002

.data
n: .space 40      # Array to store 10 integers (10 * 4 bytes)

.text
main:
    # Initialize variables
    li $t0, 0            # int i
    li $t1, 0		 # int j
    li $t2, 0		 # int k
    li $t3, 0		 # int sum = 0
    la $t4, n        # Load the base address of the array

init_loop:
    # Calculate the value for the current array element (index + 100)
    addi $t5, $t0, 100

    # Store the value in the array
    sw $t5, 0($t4)

    # Increment the loop counter
    addi $t0, $t0, 1

    # Move to the next array element
    addi $t4, $t4, 4

    # Check if we've initialized all elements
    bne $t0, 10, init_loop
    
    # Print array elements
    la $t4, n        # Reload the base address of the array

print_loop:
    # Load the current array element into $t5
    lw $t5, 0($t4)

    # Print the array element in the format "Element[index] = value"
    li $v0, 4            # Print string
    la $a0, element_str  # Load the "Element" string
    syscall

    # Print the array index in the format "[index]"
    li $v0, 4            # Print string
    la $a0, left_bracket_str  # Load the "[" string
    syscall

    # Print the array index
    li $v0, 1            # Print integer
    move $a0, $t0        # Load the array index
    syscall

    # Print the " = " string
    li $v0, 4            # Print string
    la $a0, equals_str   # Load the " = " string
    syscall

    # Print the array element value
    li $v0, 1            # Print integer
    move $a0, $t5        # Load the integer value
    syscall

    # Print a closing bracket and a newline
    li $v0, 4            # Print string
    la $a0, newline_str  # Load the newline string
    syscall

    # Increment the loop counter
    addi $t1, $t1, 1

    # Move to the next array element
    addi $t4, $t4, 4

    # Check if we've printed all elements
    bne $t1, 10, print_loop
    
    la $t4, n        # Reload the base address of the array

    
    
sum_loop:
    # Load the current array element into $t5
    lw $t5, 0($t4)
    
    add $t3, $t3, $t5
    
    # Increment the loop counter
    addi $t2, $t2, 1

    # Move to the next array element
    addi $t4, $t4, 4

    # Check if we've printed all elements
    bne $t2, 10, sum_loop
    
    
    
print_sum:
    # Print the array element value
    li $v0, 1            # Print integer
    move $a0, $t3        # Load the integer value
    syscall
    
    # Exit the program
    li $v0, 10           # Exit
    syscall
    
.data
element_str: .asciiz "Element "
left_bracket_str: .asciiz "["
equals_str: .asciiz "] = "
newline_str: .asciiz "\n"
