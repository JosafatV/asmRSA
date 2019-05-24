# DOCUMENTATION 
# http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
#
# OUTDATED AND OBSOLETE


	.data
startE_msg:    	.asciiz "Starting encryption\n"
startD_msg:     	.asciiz "Starting decryption\n"


	.text
	.globl _main
	
_main:
	# UI
	li $v0, 5		# load syscall: read_integer
	syscall			# execute syscall: read_integer
	move $t0, $v0		# capture user input	
	beqz $t0, _encrypt	# jump to encryption algorithm
	j _decrypt		# jump to decryption algorithm
	
_encrypt:
	la $a0, startE_msg	# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	# laod key
	# load message
	
	# encrypt
	
	# store message
	
	li $v0, 10		# load syscall: exit
	syscall


_decrypt:
	la $a0, startD_msg	# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	# laod key
	# load message
	
	# decrypt
	
	# store message
		
	li $v0, 10		# load syscall: exit
	syscall
