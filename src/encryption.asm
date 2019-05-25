# Intituto Tecnológico de Costa Rica
# Ingeniería en Computadores
# Arquitectura de Computadores I
#
# RSA encryption algorithm
# Key size: bits
#
# Josafat Vargas Gamboa
# 2013030892
#
# I 2019


	.data
prKey:		.space 16	# decryptor
puKey:		.space 16	# modulus
message:	.space 16	# input
buffer:		.space 16	# output

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

temp:		.space 16	# result of multiplication
temp2:		.space 8	# temp space for multiplication

done:		.asciiz "not yet implemented\n"



	.text
	.globl _main
	
_main:
	la $t0, message 	# 
	li $t1, 1624		# load message "go"
	sw $t1, 12($t0)

	la $t0, puKey 		# 
	li $t1, 565129		# load modulus
	sw $t1, 12($t0)
	
	#prkey 375723
	
_encryption:
	la $t0, message
	lw $t1, 12($t0)		# load 1st 32 bits
	move $t3, $t1		# set 1st iteration
	li $t2, 2		# hard coded encryptor 
_pow:
	mul $t3, $t3, $t1	# a**n = a**(n-1) * a
	sub, $t2, $t2, 1	# decrement iterator
	bnez $t2, _pow		# iterate
	
	la $t0, puKey		# 
	lw $t1, 12($t0)		# 
	
	div $t3, $t3, $t1	# 
	mfhi $t3		# 
	
	la $t0, buffer		# 
	sw $t3, 12($t0)		# 


