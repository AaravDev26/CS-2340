# Aarav Dev
# axd220001
# Section 002

.data
arr:    .space 40          # Array to store 10 integers (4 bytes each)
Size:   .word 0           # Variable to store the size of the array
prompt1: .asciiz "\n Please Enter Number of elements in an array  :    "
prompt2: .asciiz "\n Please Enter "
prompt3: .asciiz " elements of an Array \n"
prompt4: .asciiz "\n Final Array after Deleting Duplicate Array Elements is: \n"
space: .asciiz "\t"

.text
main:
    # Print prompt for the number of elements
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read the size of the array
    li $v0, 5
    syscall
    move $t0, $v0
    sw $v0, Size            # Store the size of the array
    lw $t0, Size      # Load the initial size of the array into $t0

    # Print prompt for array elements
    li $v0, 4
    la $a0, prompt2
    syscall
    
    # Print array size
    li $v0, 1          # syscall code for print_integer
    move $a0, $t0       # load the user_input variable
    syscall
    
    # Print prompt for array elements
    li $v0, 4
    la $a0, prompt3
    syscall

    # Read array elements
    la $a1, arr             # Load the base address of the array
    li $t1, 0         # Initialize loop counter
    

read_loop:
    beq $t1, $t0, function  # Exit loop if all elements are read
    li $v0, 5
    syscall
    sw $v0, 0($a1)           # Store the input integer in the array
    addi $a1, $a1, 4         # Move to the next element in the array
    addi $t1, $t1, 1         # Increment loop counter
    j read_loop
    
    
function:
    la $a0, arr      # Load array address into $a0
    lw $a1, Size      # Load the initial size of the array into $t0
    li $t0, 0        # Initialize i to 0
    
outer_loop:
    bge $t0, $a1, print_result  # if i >= Size, exit outer loop
    
    addi $t1, $t0, 1           # j = 0

inner_loop:
    bge $t1, $a1, next_outer # if j >= Size, go to next outer iteration

    # Calculate base addresses for arr[i] and arr[j]
    la $t2, arr          # load base address of arr into $t2
    mul $t3, $t0, 4      # calculate offset for arr[i] (4 bytes per element)
    add $t2, $t2, $t3    # add offset to base address
    lw $t2, 0($t2)       # load arr[i] into $t2

    la $t3, arr          # load base address of arr into $t3
    mul $t4, $t1, 4      # calculate offset for arr[j] (4 bytes per element)
    add $t3, $t3, $t4    # add offset to base address
    lw $t3, 0($t3)       # load arr[j] into $t3

    beq $t2, $t3, found_duplicate # if arr[i] == arr[j], jump to duplicate block

    j next_inner

found_duplicate:
    # Shift elements to the left starting from j
    move $t4, $t1         # k = j

inner_shift_loop:
    bge $t4, $a1, shift_done # if k >= Size, shift done

    la $t5, arr           # load base address of arr into $t5
    mul $t6, $t4, 4       # calculate offset for arr[k] (4 bytes per element)
    add $t5, $t5, $t6     # add offset to base address

    lw $t6, 4($t5)        # load arr[k+1] into $t6
    sw $t6, 0($t5)        # store arr[k+1] at arr[k]

    addi $t4, $t4, 1      # increment k
    j inner_shift_loop   # repeat inner shift loop

shift_done:
    subi $a1, $a1, 1      # decrement Size
    subi $t1, $t1, 1
    j inner_loop         # repeat inner loop

next_inner:
    addi $t1, $t1, 1     # increment j
    j inner_loop         # repeat inner loop

next_outer:
    addi $t0, $t0, 1     # increment i
    j outer_loop         # repeat outer loop


print_result:
    # Print prompt
    li $v0, 4
    la $a0, prompt4
    syscall
    
    la $a2, arr             # Load the base address of the array
    move $t1, $zero         # Initialize loop counter
    
print_loop:
    beq $t1, $a1, exit_program  # Exit loop if all elements are printed
    lw $a0, 0($a2)           # Load the current element to print
    li $v0, 1
    syscall

    # Print space between elements
    li $v0, 4
    la $a0, space
    syscall
    
    addi $a2, $a2, 4         # Move to the next element in the array
    addi $t1, $t1, 1         # Increment loop counter
    j print_loop

exit_program:
    # Exit the program
    li $v0, 10
    syscall
    
    
