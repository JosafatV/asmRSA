# Intituto Tecnológico de Costa Rica
# Ingeniería en Computadores
# Arquitectura de Computadores I
#
# Test state of a bitin position i
#
# Josafat Vargas Gamboa
# 2013030892
#
# I 2019


	.data
prKey:		.space 16	# decryptor



	.text
	.globl _main
_main:
	li $t0, 4		# test 5th bit, bit 4
	li $t1, 220		# int tested: 204 = True, 220 = False
	li $t2, 1		# create mask
	srlv $t1, $t1, $t0	# shift to isolate bit
	and $t3, $t1, $t2	# and to isolate: if bit == 1: 1, else 0
	
	beqz $t3, _0bit		# i bit is 0
	j _1bit			# i bit is 1
	
	
	li $v0, 10
	syscall