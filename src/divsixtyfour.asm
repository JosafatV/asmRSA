# DOCUMENTATION 


	.data
modulus: .space 32	# modulus = prime1*prime2
length: .space 32	# length = (prime1-1)*(prime2-1)
multi: .space 32	# decryptor

	.text
	.globl _main
_main: 
	li $t1, 65537		# 4th fermat number
	li $t2, 1688489		# modulus
	
	mul $t0, $t1, $t2	# multiplicate
	mfhi $t1		# catch overflow
	
	la $t8, multi		# load mem address
	sw $t0, 4($t8)		# store 1st part of result
	sw $t1, ($t8)		# store 2nd part of result	
	
	#div two mem positions 
	#div $t0, $t0, $t3
	#mfhi $t0
	#subiu $t0, $t0, 1
	
	#end program
	li $v0, 10		# load syscall: exit
	syscall	 		# terminate program