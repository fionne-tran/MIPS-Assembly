# File Name: MIPS Read File.asm
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Procedures:
# main:		Calculates and prints the amount of uppercase, lowercase, numbers symbols, other symbols, lines, and signed numbers in a file
# loop:		Reads file
# end:		Prints and closes file
# fileRead:	Opens and reads file
# output:	Prints out counters and their headers
# checkUpper:	Counts how many uppercase characters in given file
# checkLower:	Counts how many lowercase characters in given file
# checkNum:	Counts how many number symbols in given file
# checkSym:	Counts how many other symbols in given file
# checkLine:	Counts how many lines in given file
# checkSignNum:	Counts how many signed numbers in given file
# fileClose:	Closes file

.data
	fin:	.asciiz ""
	msg1:	.asciiz "Please enter the input file name: "
	msg2:	.asciiz "Number of Uppercase Character: "
	msg3:   .asciiz "Number of Lowercase Character: "
	msg4:   .asciiz "Number of Number Symbols :     "
	msg5:   .asciiz "Number of Other Symbols:       "
	msg6:   .asciiz "Number of Lines:     	       "
	msg7:   .asciiz "Number of Signed Numbers:      "
	nline:  .asciiz "\n"
	buffer: .asciiz ""
	
.text

# main:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Calculates amount of uppercase, lowercase, numbers symbols, other symbols, lines, and signed numbers in a file
# Arguments:
# None
main:
	li $v0, 4	# Print string
	la $a0, msg1	# Load address of 'msg1'
	syscall		# Print msg1 prompt
  
	li $v0, 8	# Read sting
	la $a0, fin	# Load address of 'fin'
	li $a1, 50	# Load byte
	syscall		# Read string

	la $s0, fin	# s0 contains base address of str
	add $s2, $0, $0	# $s2 = 0
	addi $s3, $0, '\n'	# $s3 = '\n'
	
nameClean:
	lb   $s1, 0($s0)	# Load character into $s0
	beq   $s1, $s3, endClean	# Break if byte is newline
	
	addi   $s2, $s2, 1	# Increase counter
	addi   $s0, $s0, 1	# Increase str address
j   nameClean

endClean:
	sb   $0, 0($s0)	# Replace newline with 0

	jal fileRead	# Read from file

	move $s1, $v0	# $t0 = total number of bytes

	li $t0, 0	# Loop counter
	li $t1, 0	# Uppercase counter
	li $t2, 0	# Lowercase counter
	li $t3, 0	# Number counter
	li $t4, 0	# Symbol counter
	li $t5, 0	# Lines counter
	li $t6, 0	# Signed Numbers counter
	
# loop:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Reads file
# Arguments:
# None
loop:
	bge $t0, $s1, end           # If end of file reached OR if there is an error in the file
	lb $t9, buffer($t0)         # Load next byte from file

	jal checkUpper	# Check for uppercase characters
	jal checkLower	# Check for lowercase characters
	jal checkNum	# Check for numbers
	jal checkSym	# Check for symbols
	jal checkLine	# Check for lines
	jal checkSignNum	# Check for signed numbers
	
	addi $t0, $t0, 1	# Increase loop counter
j loop

# end:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Prints and closes file
# Arguments:
# None
end:
	jal output	# Prints out counters and their headers
	jal fileClose	# Closes file

	li $v0, 10
	syscall
	
	
	
	
	
# fileRead:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Opens and reads file
# Arguments:
# $a0 - File name
# $a1 - Flag to read file
# $a2 - File buffer length
fileRead:
	# Open file
	li   $v0, 13	# System call for open file
	la   $a0, fin	# Input file name
	li   $a1, 0	# Flag for reading
	li   $a2, 0	# Mode is ignored
	syscall		# Open a file 
	
	move $s0, $v0	# Save the file descriptor 

	# Reading from file
	li   $v0, 14	# System call for reading from file
	move $a0, $s0	# File descriptor 
	la   $a1, buffer	# Address of buffer from which to read
	li   $a2, 100000	# Hardcoded buffer length
	syscall		# Read from file
jr $ra

# output:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: routine to print the numbers on one line
# Arguments: Prints out counters and their headers
# $a0 - Address of message and/or counter
output:
	# Display uppercase prompt
	li $v0, 4	# Print string
	la $a0, msg2	# Load address of 'msg2'
	syscall		# Print uppercase prompt

	# Display uppercase counter
	li $v0, 1	# Print integer
	move $a0, $t1	# Load address of uppercase counter
	syscall		# Print uppercase counter

	# Display new line
	li $v0, 4	# Print string
	la $a0, nline	# Load address of 'nline'
	syscall		# Print new line

	# Display lowercase prompt
	li $v0, 4	# Print string
	la $a0, msg3	# Load address of 'msg3'
	syscall		# Print lowercase prompt

	# Display lowercase counter
	li $v0, 1	# Print integer
	move $a0, $t2	# Load address of lowercase counter
	syscall		# Print lowercase counter

	# Display new line
	li $v0, 4	# Print string
	la $a0, nline	# Load address of 'nline'
	syscall		# Print new line

	# Display number symbol prompt
	li $v0, 4	# Print string
	la $a0, msg4	# Load address of 'msg4'
	syscall		# Print number symbol prompt

	# Display number symbol counter
	li $v0, 1	# Print integer
	move $a0, $t3	# Load address of number symbol counter
	syscall		# Print number symbol counter

	# Display new line
	li $v0, 4	# Print string
	la $a0, nline	# Load address of 'nline'
	syscall		# Print new line

	# Display other symbol prompt
	li $v0, 4	# Print string
	la $a0, msg5	# Load address of 'msg5'
	syscall		# Print other symbol prompt

	# Display other symbol counter
	li $v0, 1	# Print integer
	move $a0, $t4	# Load address of other symbol counter
	syscall		# Print other symbol counter

	# Display new line	
	li $v0, 4	# Print string
	la $a0, nline	# Load address of 'nline'
	syscall		# Print new line
	
	# Display line prompt
	li $v0, 4	# Print string
	la $a0, msg6	# Load address of 'msg6'
	syscall		# Print line prompt

	# Display line counter
	li $v0, 1	# Print integer
	move $a0, $t5	# Load address of line counter
	syscall		# Print line counter

	# Display new line	
	li $v0, 4	# Print string
	la $a0, nline	# Load address of 'nline'
	syscall		# Print new line

	# Display signed number prompt
	li $v0, 4	# Print string
	la $a0, msg7	# Load address of 'msg7'
	syscall		# Print signed number prompt

	# Display signed number counter
	li $v0, 1	# Print integer
	move $a0, $t6	# Load address of signed number counter
	syscall		# Print signed number counter
jr $ra

# checkUpper:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many uppercase characters in given file
# Arguments:
# None
checkUpper:
	# Check for uppercase
	blt $t9, 0x41, L1	# If $t9 is less than 'A'
	bgt $t9, 0x5a, L1	# If $t9 is greater than 'Z'
	addi $t1, $t1, 1	# Increase uppercase counter

	L1:
jr $ra

# checkLower:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many lowercase characters in given file
# Arguments:
# None
checkLower:
	# Check for lowercase
	blt $t9, 0x61, L2	# If $t9 is less than 'a'
	bgt $t9, 0x7a, L2	# If $t9 is greater than 'z'
	addi $t2, $t2, 1	# Increase lowercase counter

	L2:
jr $ra

# checkNum:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many numbers symbols in given file
# Arguments:
# None
checkNum:
	# Check for numbers symbols
	blt $t9, 0x30, L3	# If $t9 is less than '0'
	bgt $t9, 0x39, L3	# If $t9 is greater than '9'
	addi $t3, $t3, 1	# Increase number symbol counter

    L3:
jr $ra

# checkSym:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many other symbols in given file
# Arguments:
# None
checkSym:
	blt $t9, 0x21, L4	# If $t9 is less than '!'
	bgt $t9, 0x2f, H	# If $t9 is greater than '/'
	addi $t4, $t4, 1	# Increase other symbol counter
	
	H:
	blt $t9, 0x3a, L4	# If $t9 is less than ':'
	bgt $t9, 0x40, H2	# If $t9 is greater than '@'
	addi $t4, $t4, 1	# Increase other symbol counter
	
	H2:
	blt $t9, 0x5b, L4	# If $t9 is less than '['
	bgt $t9, 0x60, H3	# If $t9 is greater than '''
	addi $t4, $t4, 1	# Increase other symbol counter
	
	H3:
	blt $t9, 0x7b, L4	# If $t9 is less than '{'
	bgt $t9, 0x7e, L4	# If $t9 is greater than '~'
	addi $t4, $t4, 1	# Increase other symbol counter
	
	L4:
jr $ra

# checkLine:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many lines in given file
# Arguments:
# None
checkLine:
	# Check for lines
	bne $t9, '\n', L5           # If $t9 is not equal to '\n'
	addi $t5, $t5, 1            # Increase lines counter

	L5:
jr $ra

# checkSignNum:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Counts how many signed numbers in given file
# Arguments:
# None
checkSignNum:
	
	# Check for signed numbers
	bne $t9, 0x2b, L6           # If $t9 is less than '+'
	bgt $t9, 0x2d, L6           # If $t9 is greater than '-'
	beq $t9, 0x2c, L6	    # If $59 is equal to ',' 
	addi $t6, $t6, 1            # Increase signed numbers counter

	L6:
jr $ra

# fileClose:
# Author: Fionne Tran
# Modification History:
# This code was last modified on 22 October 2021. Any changes before that time are undocumented.
# Description: Closes file
# Arguments:
# $a0 - Contains addresse for file descriptor
fileClose:
	# Close the file 
	li   $v0, 16	# System call for close file
	move $a0, $s0	# File descriptor to close
	syscall		# Close file
jr $ra
