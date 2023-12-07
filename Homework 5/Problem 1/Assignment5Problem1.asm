# Aarav Dev
# axd220001
# Section 002

.data
   PAY_RATE: .float 22.55          # Hourly pay rate
   BASE_HOURS: .float 40.50        # Maximum non-overtime hours
   OT_MULTIPLIER: .float 1.5       # Overtime multiplier
   zero: .float 0.0                # Zero float value
   input1: .asciiz "How many hours did you work? "  # Input prompt
   output1: .asciiz "Base pay: $"                    # Output messages
   output2: .asciiz "Overtime pay: $"
   output3: .asciiz "Total pay: $"
   
# Program starts here, main
.globl main
.text
main:
   # Prompt for hours worked
   la $a0, input1
   li $v0, 4
   syscall
   
   # Read hours worked from user
   li $v0, 6
   syscall
   
   # Store f12 for parameter passing
   mov.s $f12, $f0
   
   # Call function to calculate base pay
   jal getBasePay
   # Store base in f4
   mov.s $f4, $f0
   
   # Compare hours worked with base hours
   l.s $f6, zero            # Overtime default
   l.s $f2, BASE_HOURS
   # If less, no function call
   bc1t next
   # If greater, call overtime
   jal getOverTimePay
   # Overtime result in f6
   mov.s $f6, $f0

# Calculate total pay
next:
   add.s $f2, $f4, $f6
   
   # Display result of base pay
   la $a0, output1
   li $v0, 4
   syscall
   mov.s $f12, $f4
   li $v0, 2
   syscall
   
   # Display newline
   li $a0, 10
   li $v0, 11
   syscall
   
   # Display overtime details
   la $a0, output2
   li $v0, 4
   syscall
   mov.s $f12, $f6
   li $v0, 2
   syscall
   
   # Display newline
   li $a0, 10
   li $v0, 11
   syscall
   
   # Display total pay
   la $a0, output3
   li $v0, 4
   syscall
   mov.s $f12, $f2
   li $v0, 2
   syscall
   
   # End of the program
   li $v0, 10
   syscall

# Implementation of getBasePay function
getBasePay:
   # Load values for calculation
   l.s $f2, BASE_HOURS
   l.s $f1, PAY_RATE
   # Compare base hours and hours worked
   c.le.s $f12, $f2
   # If greater, jump into 1.5 times
   bc1f  basepay
   # Otherwise
   mul.s $f0, $f12, $f1   # Calculate base pay
   jr $ra

# 1.5 times calculation
basepay:
   mul.s $f0, $f2, $f1   # Calculate base pay with overtime multiplier
   jr $ra

# Implementation of overtime
getOverTimePay:
   # Load constants
   l.s $f2, BASE_HOURS
   l.s $f3, OT_MULTIPLIER
   l.s $f1, PAY_RATE
   # Compare with hours
   c.le.s $f12, $f2
   # Go to overtime calculation
   bc1f overtime
   # Otherwise, no overtime
   l.s $f0, zero
   jr $ra

# Overtime calculation result
overtime:
   sub.s $f12, $f12, $f2  # Calculate overtime hours
   mul.s $f0, $f12, $f1   # Calculate overtime pay
   mul.s $f0, $f0, $f3    # Apply overtime multiplier
   jr $ra
