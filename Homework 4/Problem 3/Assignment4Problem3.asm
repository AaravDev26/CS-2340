# Aarav Dev
# axd220001
# Section 002

.data
arr: .space 100 # creating array

.text

main:
  la $s0, arr # load address of array
  li $s1, 4 # Number of rows
  li $s2, 4 # Number of columns
  li $s3, 0 # initialize sum = 0
  li $s4, 1 # initialize x = 1

# Initialize i (outer loop index) to 0
li $t0, 0
outerLoop:
  # Check if i >= number of rows
  bge $t0, $s1, calculate_sum

  # Initialize j (inner loop index) to 0
  li $t1, 0
  innerLoop:
    # Check if j >= number of columns
    bge $t1, $s2, exitInner
    
    # Calculate the effective address of array[i][j]
    mul $t2, $t0, $s2
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s0
    
    sw $s4, ($t2) # Store the value in the array
    addi $s4, $s4, 1 # x++
    
    add $t1, $t1, 1 # Increment j
    j innerLoop
  exitInner:
    add $t0, $t0, 1 # Increment i
    j outerLoop
    
calculate_sum:
# Initialize i (outer loop index) to 0
li $t0, 0
outerLoop1:
  # Check if i >= number of cities
  bge $t0, $s1, print_sum

  # Initialize j (inner loop index) to 0
  li $t1, 0
  innerLoop1:
    # Check if j >= number of weeks
    bge $t1, $s2, exitInner1

    # Calculate the effective address of array[i][j]
    mul $t2, $t0, $s2
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s0

    lw $t2, ($t2) # Load the value from array[i][j]
    add $s3, $s3, $t2 # add to sum

    add $t1, $t1, 1 # Increment j
    j innerLoop1
    
  exitInner1:
    add $t0, $t0, 1 # Increment i
    j outerLoop1
    
print_sum:
    # print out the sum of all the elements in the array
    li $v0, 1
    move $a0, $s3
    syscall
    
exit_program:
    li $v0, 10         # exit
    syscall




