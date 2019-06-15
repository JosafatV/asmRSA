# Intituto Tecnológico de Costa Rica
# Ingeniería en Computadores
# Arquitectura de Computadores I
#
# Handbook of Applied Cryptography by A. Menezes, P. van Oorschot and S. Vanstone.
# Page 71. 2.143 Algorithm: Repeated square-and-multiply algorithm for exponentiation in Zn
#
# Josafat Vargas Gamboa
# 2013030892
#
# I 2019


	.data
result:		.space 8



	.text
	.globl _main
_main:
	li $t1, 5	# test value for a
	li $t2, 596	# test value for k
	li $t3, 1234	# test value for n
	la $t0, result  # position in mem to store value
	
	beqz $t1, _trivial	# trivial
	
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
	bne $t7, 12, _while	# must know exact number of bits
	sw $t6, ($t0)		# store value in memory
	

_trivial:
	li $v0, 10		# load syscall: exit
	syscall			# exit program
	
	
_errorV:
_error:
	li $a0, 4		# load generic error: 1
	li $v0, 17		# load syscall: exit2 with code
	syscall
