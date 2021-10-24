# File Name: MIPS-Operations.asm
# Author: Fionne Tran
# Modification History
# This code was last modified on September 14, 2021 by Fionne Tran.
# Procedures:
# main:		Computes and prints addition, subtraction, multiplication,
#		and division of two given integers.
.data
	prompt1: .asciiz "Enter integer A: "
	prompt2: .asciiz "Enter integer B: "
	sum: .asciiz "A + B = "
	difference1: .asciiz "\nA - B = "
	difference2: .asciiz "\nB - A = "
	product: .asciiz "\nA * B = "
	quotient1: .asciiz "\nA/B = "
	quotient2: .asciiz "\nB/A = "
	remainder: .asciiz " Remainder: "
.text
main:
	# Prompt the user to enter integer A
	li $v0, 4		# Print string
	la $a0, prompt1		# Load address of 'prompt1'
	syscall			# Print integer A prompt
	
	# Read user input of integer A
	li $v0, 5		# Read integer
	syscall			# Read user input
	
	# Store input from user into $t0
	move $t0, $v0		# Move value stored in $v0 to $t0
	
	# Prompt the user to enter integer B
	li $v0, 4		# Print string
	la $a0, prompt2		# Load addess of 'prompt2'
	syscall			# Print integer B prompt
	
	# Read user input of integer B
	li $v0, 5		# Read integer
	syscall			# Read user input
	
	# Store input from user into $t1
	move $t1, $v0		# Move value stored in $v0 to $t1
	
	# Add integer A and B
	add $t3, $t1, $t0	# Adds values stored in $t0 and $t1 to $t3
	
	# Display sum message
	li $v0, 4		# Print string
	la $a0, sum		# Load address of 'sum'
	syscall			# Print sum message
	
	# Display sum
	li $v0, 1		# Print integer
	la $a0, ($t3)		# Load address of sum
	syscall			# Print sum
	
	# Subtract integer B from A
	sub $t4, $t0, $t1	# Subtract values stored in $t1 and $t0 to $t4
	
	# Display diference message
	li $v0, 4		# Print string
	la $a0, difference1	# Load address of 'difference1'
	syscall			# Print difference1 message
	
	# Display difference (A - B)
	li $v0, 1		# Print integer
	la $a0, ($t4)		# Load address of difference
	syscall			# Print difference
	
	# Subtract integer A from B
	sub $t5, $t1, $t0	# Subtract values stored in $t0 andn $t1 to $t5
	
	# Display difference message
	li $v0, 4		# Print string
	la $a0, difference2	# Load address of 'difference2'
	syscall			# Print difference2 message
	
	# Display difference (B - A)
	li $v0, 1		# Print integer
	la $a0, ($t5)		# Load address of difference
	syscall			# Print difference
	
	# Multiply integer A and B
	mul $t6, $t0, $t1	# Multiply values stored in $t1 and $t0 to $t6
	
	# Display product message
	li $v0, 4		# Print string
	la $a0, product		# Load address of 'product'
	syscall			# Print product message
	
	# Display product
	li $v0, 1		# Print integer
	la $a0, ($t6)		# Load address of product
	syscall			# Print product
	
	# Divide integer A and B
	div $t0, $t1		# Divide $t0 by $t1
	
	# Display quotient message
	li $v0, 4		# Print string
	la $a0, quotient1	# Load address of 'quotient1'
	syscall			# Print quotient message
	
	# Display quotient of A divided by B
	li $v0, 1		# Print integer
	mflo $a0		# Get quotient
	syscall			# Print quotient
	
	# Display remainder message
	li $v0, 4		# Print string
	la $a0, remainder	# Load address of 'remainder'
	syscall			# Print remainder message
	
	# Display remainder
	li $v0, 1		# Print integer
	mfhi $a0		# Get remainder
	syscall			# Print remainder
	
	# Divide integer B and A
	div $t1, $t0		# Divide $t1 by $t0
	
	# Display quotient message
	li $v0, 4		# Print string
	la $a0, quotient2	# Load address of 'quotient2'
	syscall			# Print quotient2 message
	
	# Display quotient of B divided by A
	li $v0, 1		# Read integer
	mflo $a0		# Get quotient
	syscall			# Print quotient
	
	# Display remainder message
	li $v0, 4		# Print string
	la $a0, remainder	# Load address of 'remainder'
	syscall			# Print remainder message
	
	# Display remainder
	li $v0, 1		# Read integer
	mfhi $a0		# Get remainder
	syscall			# Print remainder
