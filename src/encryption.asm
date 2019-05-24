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
	# hard code data for encrypting
	j _encryption
	
	
	
_encryption:
	#encrypt, save to file and exit