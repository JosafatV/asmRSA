# DOCUMENTATION 


	.data
modulus: .space 32	# modulus = prime1*prime2
length: .space 32	# length = (prime1-1)*(prime2-1)
decryptor: .space 32	# decryptor

	.text
	.globl _main
_main: 
	# load modulus data
	li $t0, 1934929
	la $t1, modulus
	sw $t0, ($t1)
	# load length data
	li $t3, 1932084
	la $t1, length
	sw $t3, ($t1)
	# load encryptor
	li $t1, 65537
	#initialize d
	subiu $t2, $t3, 1		# length - 1 ; d = t2
	
findDecryptor:
	li $t2, 1209185			# known result (debug)
	mul $t0, $t1, $t2		# encryptor*d
	div $t0, $t3, $t0		# (encryptor*d) % length
	mfhi $t4			# get the modulus
	subiu $t4, $t4, 1		# (encryptor*d % length) - 1
	beqz $t4, decFound		# exit if found
	subiu $t2, $t2, 1		# if not found test next d
	bgt $t2, 1, findDecryptor	# branch if no decryptor is found
	
notFound:
	la $t8, decryptor
	li $t2, 1
	sw $t2, ($t8)
	
	#end program
	li $a0, 1		# terminate with code 1
	li $v0, 10		# load syscall: exit
	syscall	 		# terminate program	
	
decFound:
	la $t8, decryptor
	sw $t2, ($t8)
	
	#end program
	li $v0, 10		# load syscall: exit
	syscall	 		# terminate program
	


# decryptor expected: 489473
