# DOCUMENTATION 


	.data
einsKey: .space 32 #modulus

	.text
	.globl _main
_main: 

li $t1, 65537 		# 32bit prime 1
li $t2, 15907 		# 32bit prime 2
mul $t3, $t1, $t2 	# calculate modulus

# calculate length
sub $t4, $t1, 1
sub $t5, $t2, 1
mul $t4, $t4, $t5 	# length


