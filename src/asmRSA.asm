# Intituto Tecnológico de Costa Rica
# Ingeniería en Computadores
# Arquitectura de Computadores I
#
# RSA encrypter and decrypter
# Key size: bits
#
# Josafat Vargas Gamboa
# 2013030892
#
# I 2019



	.data
prKey:		.space 16
puKey:		.space 16
message:	.space 16
buffer:		.space 16

puk_file:   	.asciiz "_publicKeys.txt"
prk_file:   	.asciiz "_privateKeys.txt"
src_file:   	.asciiz "_srcMessage.txt"
out_file:   	.asciiz "_outMessage.txt"

choose_msg:	.asciiz "Enter 1 for decryption or 0 for encryption\n"
startE_msg:    	.asciiz "Starting encryption\n"
startD_msg:     .asciiz "Starting decryption\n"
endE_msg:    	.asciiz "Encryption completed\n"
endD_msg:    	.asciiz "Decryption completed\n"
bad_msg:    	.asciiz "open file syscall failed\n"
ok_msg:     	.asciiz "open file succesful\n"

done:		.asciiz "not yet implemented\n"

	.text
	.globl _main
	
_main:
	# User Input
	la $a0, choose_msg	# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
		
	li $v0, 5		# load syscall: read_integer
	syscall			# execute syscall: read_integer
	move $t9, $v0		# capture user input
	
	beqz $t9, _encrypt	# jump to encryption algorithm (in = 0)
	j _decrypt		# jump to decryption algorithm (in = 1)
	
_encrypt:
	la $a0, startE_msg	# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	# set arguments to read public key	
	la $t0, puk_file	# Name of the file to open
	li $t1, 0		# Open for reading (flags are 0: read, 1: write) 
	la $t2, puKey          	# addr input buffer
	jal _readFile		# load public key to mem

	# set arguments to read message	
	la $t0, src_file	# Name of the file to open
	li $t1, 0		# Open for reading (flags are 0: read, 1: write) 
	la $t2, message        	# addr input buffer
	jal _readFile		# load message to mem
	
	j _encryption		# encrypt the file
	# store message (done by encryption)
	
_decrypt:
	la $a0, startE_msg	# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	# set arguments to read private key	
	la $t0, prk_file	# Name of the file to open
	li $t1, 0		# Open for reading (flags are 0: read, 1: write) 
	la $t2, prKey          	# addr input buffer
	jal _readFile		# load private key to mem
	
	# set arguments to read public key	
	la $t0, puk_file	# Name of the file to open
	li $t1, 0		# Open for reading (flags are 0: read, 1: write) 
	la $t2, puKey          	# addr input buffer
	jal _readFile		# load public key to mem

	# set arguments to read message	
	la $t0, src_file	# Name of the file to open
	li $t1, 0		# Open for reading (flags are 0: read, 1: write) 
	la $t2, message        	# addr input buffer
	jal _readFile		# load message to mem
	
	j _encryption		# encrypt the file
	# store message (done by encryption)
	
# Succesful exit
_exit:
	la $a0, done		# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	li $v0, 10		# load syscall: exit
	syscall
	
	
_error:
	li $a0, 1		# load generic error: 1
	li $v0, 17		# load syscall: exit2 with code
	syscall


# FILE MANAGER
#
# t0: file name
# t1: read or write
# t2: input buffer
# t3: max bytes 
#
# open data in files as it's ASCII values https://www.rapidtables.com/convert/number/ascii-hex-bin-dec-converter.html
#
_readFile:
	# OPEN
	move $a0, $t0		# load argument: file name
	move $a1, $t1		# load argument: 0 => read, 1 => write)
	li $a2, 0	        # was recommended for file permissions
	li $v0, 13		# load syscall: open_file
	syscall	 		# execute syscall: open_file
	
	move $t8, $v0			# catch file descriptor
	blt $t8, $zero, _errExit	# open file failed
	
	# READ
	move $a0, $t8		# Load file descriptor
	move $a1, $t2		# load argument: input buffer
	li $a2, 16		# max number of characters (bytes) to load
	li $v0, 14		# load syscall: read_from_file
	syscall	 		# execute syscall: open_file
	
	move $t0, $v0		# catch read status
	beqz $v0, _errExit	# read file failed
	
	#CLOSE
	move $a0, $t8		# Load file descriptor
	li $v0, 16		# load syscall: close_file
	syscall	 		# execute syscall: close_file
	
	jr $ra			# jump back
	
_writeFile:
	# OPEN
	move $a0, $t0		# load argument: file name
	move $a1, $t1		# load argument: 0 => read, 1 => write)
	li $a2, 0	        # was recommended for file permissions
	li $v0, 13		# load syscall: open_file
	syscall	 		# execute syscall: open_file
	
	move $t8, $v0			# catch file descriptor
	blt $t8, $zero, _errExit	# open file failed
	
	#WRITE
	move $a0, $t8		# Load file descriptor
	la $a1, out_file	# addr output buffer
	li $a2, 16		# max number of characters (bytes) to write
	li $v0, 15		# load syscall: write_to_file
	syscall	 		# execute syscall: write_to_file
	
	move $t0, $v0		# catch read status
	blt $v0, $zero _errExit	# write file failed
	
	#CLOSE
	move $a0, $t8		# Load file descriptor
	li $v0, 16		# load syscall: close_file
	syscall	 		# execute syscall: close_file
	
	jr $ra			# jump back
	
_errExit:
	la      $a0, bad_msg	# load bad message
	li      $v0, 4		# print error message
	syscall
	
	li $a0, 2		# load file error: 2
	li $v0, 17		# load syscall: exit2 with code
	syscall





	
	
	
# ENCRITPTION ALGORITHM
_encryption:
	
	j _exit
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
# DECRYPTION ALGORITHM	
_decryption:
	j _exit
	
	
	
	
	
