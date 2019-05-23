# DOCUMENTATION 
# http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html



	.data
inputB:		.space 4
outputB:	.space 4
buffer:		.space 12
FileName:   	.asciiz "_publicKeys.txt"
bad_msg:    	.asciiz "open syscall failed\n"
ok_msg:     	.asciiz "open was succesful\n"
#res:        	.byte   1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

	.text
	.globl _main
	
_main:
	#load test data to write
	la $t7, outputB	
	li $t8, 65537
	sw $t8, ($t7)
	
	li $t0, 0		#flag: read  (0 for read-only, 1 for write-only with create, and 9 for write-only with create and append)
     	j _openFile


# open data in files as it's ASCII values https://www.rapidtables.com/convert/number/ascii-hex-bin-dec-converter.html
_openFile:
	la $a0, FileName	# Name of the file to open
	move $a1, $t0           # Open for writing (flags are 0: read, 1: write) 
	li $a2, 0	        # was recommended for file permissions
	li $v0, 13		# load syscall: open_file
	syscall	 		# execute syscall: open_file
	
	move $t1, $v0			# catch file descriptor
	blt $t1, $zero, _errExit	# open file failed
	beqz $t0, _readFile		# read the file
	beq $t0, 1, _writeFile		# write the file
	j _closeFile			# uhm? you want to do what? Nevermind, close the file
	
_readFile:
	move $a0, $t1		# Load file descriptor
	la $a1, inputB          # addr input buffer
	la $a2, 4		# max number of characters (bytes) to load
	li $v0, 14		# load syscall: read_from_file
	syscall	 		# execute syscall: open_file
	
	move $t0, $v0		# catch read status
	beqz $v0, _errExit	# read file failed
	j _closeFile
	
_writeFile:
	move $a0, $t1		# Load file descriptor
	la $a1, outputB		# addr output buffer
	li $a2, 4		# max number of characters (bytes) to write
	li $v0, 15		# load syscall: write_to_file
	syscall	 		# execute syscall: write_to_file
	
	move $t0, $v0		# catch read status
	blt $v0, $zero _errExit	# write file failed
	j _closeFile
	
_closeFile:
	move $a0, $t1		# Load file descriptor
	li $v0, 16		# load syscall: close_file
	syscall	 		# execute syscall: close_file
	
	li $v0, 10		# load syscall: exit
	syscall
	
_errExit:
	la      $a0, bad_msg	# load bad message
	li      $v0, 4		# print error message
	syscall	
	li      $v0,10		# load syscall: exit
	syscall

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
