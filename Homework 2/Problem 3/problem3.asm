# Aarav Dev
# axd220001
# Section 002


.text
main:
# Prompt user for non-negative number input
la $a0,prompt   
li $v0,4
syscall

li $v0,5    #Read the number(n)
syscall

move $t2,$v0    # n to $t2

# Call function to get MyFun #n
move $a0,$t2
move $v0,$t2
jal MyFun     #call MyFun (n)
move $t3,$v0    #result is in $t3

# Output message and n
la $a0,result   #Print
li $v0,4
syscall

move $a0,$t2    #Print
li $v0,1
syscall

la $a0,result2  #Print
li $v0,4
syscall

move $a0,$t3    #Print the answer
li $v0,1
syscall

la $a0,endl #Print
li $v0,4
syscall

# End program
li $v0,10
syscall

MyFun:
# Compute and return MyFun number
beqz $a0,zero   #if n=0 return 0
beq $a0,1,one   #if n=1 return 1

#Calling MyFun(n-1)
sub $sp,$sp,4   #storing return address on stack
sw $ra,0($sp)

sub $a0,$a0,1   #n-1
jal MyFun     #MyFun(n-1)
add $a0,$a0,1

lw $ra,0($sp)   #restoring return address from stack
add $sp,$sp,4


sub $sp,$sp,4   #Push return value to stack
sw $v0,0($sp)
#Calling MyFun(n-2)
sub $sp,$sp,4   #storing return address on stack
sw $ra,0($sp)

sub $a0,$a0,2   #n-2
jal MyFun     #MyFun(n-2)
add $a0,$a0,2

lw $ra,0($sp)   #restoring return address from stack
add $sp,$sp,4
#---------------
lw $s7,0($sp)   #Pop return value from stack
add $sp,$sp,4

add $v0,$v0,$s7 # MyFun(n - 2) + MyFun(n-1)
jr $ra # decrement/next in stack

zero:
li $v0,0
jr $ra
one:
li $v0,1
jr $ra

.data
prompt: .asciiz "Enter a non-negative number: "
result: .asciiz "MyFun ("
result2: .asciiz ") returns "
endl: .asciiz "\n"
