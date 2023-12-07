# Aarav Dev
# axd220001
# Section 002

.data
temperature: .space 100 # Create space for 25 temperatures
prompt: .asciiz "Enter all temperatures for a week of the first city and then the second city.\n"
city: .asciiz "City "
day: .asciiz ", Day "
colon: .asciiz " : "
display: .asciiz "\n\nDisplaying Values:\n"
equals : .asciiz " = "

.text

main:

  # Print prompt
  li $v0, 4
  la $a0, prompt
  syscall

  # Load address of the array
  la $s0, temperature
  li $s1, 2 # Number of cities
  li $s2, 7 # Number of weeks

  # Initialize i (outer loop index) to 0
  li $t0, 0
outerLoop:
  # Check if i >= number of cities
  bge $t0, $s1, exitOuter

  # Initialize j (inner loop index) to 0
  li $t1, 0
  innerLoop:
    # Check if j >= number of weeks
    bge $t1, $s2, exitInner

    # Print "City i, Day j : "
    li $v0, 4
    la $a0, city
    syscall
    add $a0, $t0, 1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, day
    syscall
    add $a0, $t1, 1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, colon
    syscall

    # Calculate the effective address of array[i][j]
    mul $t2, $t0, $s2
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s0

    # Read an integer and store it in array[i][j]
    li $v0, 5
    syscall
    sw $v0, ($t2) # Store the value in the array
    

    add $t1, $t1, 1 # Increment j
    j innerLoop
  exitInner:

  

  add $t0, $t0, 1 # Increment i
  j outerLoop
exitOuter:

# Print the display prompt
li $v0, 4
la $a0, display
syscall

# Initialize i (outer loop index) to 0
li $t0, 0
outerLoop1:
  # Check if i >= number of cities
  bge $t0, $s1, exitOuter1

  # Initialize j (inner loop index) to 0
  li $t1, 0
  innerLoop1:
    # Check if j >= number of weeks
    bge $t1, $s2, exitInner1

    # Print "City i, Day j = "
    li $v0, 4
    la $a0, city
    syscall
    add $a0, $t0, 1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, day
    syscall
    add $a0, $t1, 1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, equals
    syscall

    # Calculate the effective address of array[i][j]
    mul $t2, $t0, $s2
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $t2, $t2, $s0

    # Load the value from array[i][j]
    lw $t2, ($t2)
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 11
    li $a0, '\n'
    syscall

    add $t1, $t1, 1 # Increment j
    j innerLoop1
  exitInner1:


  add $t0, $t0, 1 # Increment i
  j outerLoop1
exitOuter1:
  li $v0, 10         # exit
  syscall


