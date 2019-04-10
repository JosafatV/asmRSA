# Intituto Tecnológico de Costa Rica
# Ingeniería en Computadores
# Arquitectura de Computadores I
#
# Algoritmo para generar números primos
#
# Josafat Vargas Gamboa
# 2013030892
#
# I 2019

	.data
primeStorage: .space 10000 


	.text
	.globl _main

_main:
	la $t0, primeStorage	# primeStorage reference pointer pSrp
	la $t1, primeStorage	# primeStorage offset pointer pSop
	add $t1, $t1, 4		# offset pSop by 4 bytes (int)
	li $t2, 2		# first prime number
	sw $t2, ($t0)		# store first prime
	li $t2, 1		# next number in iteration, start loop at 1+2=3
	li $t3, 1000		# generate n=100 prime numbers
	b _generatePrime	# starting values set, begin iteration

_generatePrime:
	add $t2, $t2, 2		# next number to be tested for prime, always odd
	move $t4, $t1		# iterator, mem pointer for checkPrime
	b _checkPrime		# test number against known primes


_checkPrime:
	sub $t4, $t4, 4			# make t4 point to last known prime
	beq $t4, $t0, _storePrime	# reached 1st known prime, since all #s are odd, t2 is prime
	lw $t5, ($t4)			# else, load latest known prime
	div $t6, $t2, $t5		# divide to check divisibility
	mfhi $t6			# get remainder of division
	beqz $t6, _generatePrime	# if divisible by known prime, try next number
	b _checkPrime			# else, try again with previous known prime

_storePrime:.
	sub $t3, $t3, 1		# prime found! one less to go
	sw $t2, ($t1)		# store prime in mem
	add $t1, $t1, 4		# offset pSop
	beqz $t3, _return	# all prime numbers found!
	b _generatePrime	# else, generate more

_return:
	li $v0,10
	syscall
