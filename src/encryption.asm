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
	# for test. Values should exist in mem
	la $t0, message 	# 
	li $t1, 1624		# load message "go"
	sw $t1, 12($t0)

	la $t0, puKey 		# 
	li $t1, 565129		# load modulus
	sw $t1, 12($t0)
	
	#prkey 375723
	
_encryption:
# Load values
	la $t0, message 	#load value
	lw $t1, 12($t0)		# value for a: message
	li $t2, 3		# hard-code k: encryptor
	la $t0, puKey		# load value
	li $t3, 1234		# value for n: modulus
	la $t0, buffer		# position in mem to store value
	
# A pow K mod (N)			
	move $t4, $t1		# A = a
	
	# test bit 0
	li $t5, 1		# create mask
	li $t6, 1		# t6: output: b = 1
	and $t5, $t2, $t5	# AND to isolate: if bit == 1: 1, else 0
	beqz $t5, _aaa		# bit is 0
	move $t6, $t1		# if k[0] == 1: b = a
_aaa:
	li $t7, 1		# set iterator and bit to test
_while:
	mul $t4, $t4, $t4	# A = A * A
	mfhi $t8		# catch overflow
	bnez $t8, _errorV	# oVerflow error
	
	div $t4, $t4, $t3	# A = A % n
	mfhi $t4		# get modulus
	
	# test bit i
	li $t5, 1		# create mask
	srlv $t8, $t2, $t7	# shift to isolate $t7th bit
	and $t5, $t5, $t8	# and to isolate: if bit == 1: 1, else 0
	beqz $t5, _aab		# i bit is 0
	
	mul $t6, $t6, $t4	# b = b * A
	mfhi $t8		# catch overflow
	bnez $t8, _errorV	# oVerflow error
	div $t6, $t6, $t3	# b = b % n
	mfhi $t6		# get modulus
_aab:
	add $t7, $t7, 1		# increment iterator
	bne $t7, 10, _while	# must know exact number of bits + 1 
	sw $t6, 12($t0)		# store value in memory
	j _writeFile
	
_errorV:
	li $a0, 4		# load error: 4
	li $v0, 17		# load syscall: exit2 with code
	syscall

_writeFile:
	la $a0, done		# load msg address
	li $v0, 4		# load syscall: print_string
	syscall			# execute syscall: print_string
	
	li $v0, 10		# load syscall: exit
	syscall
	
	
