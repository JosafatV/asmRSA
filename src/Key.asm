	.data
keySpace: .space 32	# create space to store the key
decryptors: .space 32	# create space to stroe possible decryptors
pukString: .text "Public Key"
prkString: .text "Private Key"

	.text
	.globl _main
_main: 
	li $t0, 65537	# chosen encryptor
	li $t1, 8837	# first prime number
	li $t2, 15907	# second prime number
	
	# Get Modulus
	mul $t3, $t1, $t2
	
	# Get length
	sub $t4, $t1, 1		# First prime - 1
	sub $t5, $t2, 1 	# Second prime - 1
	mul $t4, $t4, $t5 	# Calculate length
	
	# Get Decryptor ($t1, $t4)
	move $t5, $t4		# define max lambda iterations
	move $t6, $zero		# set iterator as length of list 
	sub $t5, $t5, 100	# improve performance by not checking all posibilities
	b _findDecryptor
	
_findDecryptor:
	beqz $t5, _next		# branch afer testing range
	
	# formula
	mul $t7, $t0, $t5	# encryptor * d
	sub $t7, $t7, 1		# (encryptor * d) - 1 
	div $t8, $t7, $t4	# ((encryptor * d) - 1) % length
	mfhi $t8		# get remainder
	beqz $t8, _decFound	# if t5 = d fulfills equation, branch
	
	
	
	
	
_next:
	syscall
