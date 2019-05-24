# DOCUMENTATION 



	.data
opA: .space 32
opB: .space 32

result: .space 32
temp2: .space 32
temp3: .space 32
temp4: .space 32

	.text
	.globl _main
	
_main:
	# load first operand
	la $t1, opA
	li $t0, 1		# first 32 bits
	sw $t0, 12($t1)
	li $t0, 1		# second 32 bits
	sw $t0, 8($t1)
	li $t0, 1		# third 32 bits
	sw $t0, 4($t1)
	li $t0, 1		# fourth 32 bits
	sw $t0, ($t1)
	
	# load second operand
	la $t2, opB
	li $t0, 2		# first 32 bits
	sw $t0, 12($t2)
	li $t0, 3		# second 32 bits
	sw $t0, 8($t2)
	li $t0, 4		# third 32 bits
	sw $t0, 4($t2)
	li $t0, 5		# fourth 32 bits
	sw $t0, ($t2)

	j _mul64		# multiply!
	
	# first operand t1 > second operand t2
_mul64:
	la $t9, result		# get storage address
	add $t9, $t9, 28	# offset storage (start from lsb)
	lw $t4, 12($t2)		# load 32 bits of operand B (Bi = B1)
	jal _mul64aux
	
	la $t9, temp2		# get storage address
	add $t9, $t9, 24	# offset storage
	lw $t4, 8($t2)		# load 32 bits of operand B (Bi = B2)
	jal _mul64aux
	
	la $t9, temp3		# get storage address
	add $t9, $t9, 20	# offset storage (start from lsb)
	lw $t4, 4($t2)		# load 32 bits of operand B (Bi = B3)
	jal _mul64aux
	
	la $t9, temp4		# get storage address
	add $t9, $t9, 16	# offset storage
	lw $t4, ($t2)		# load 32 bits of operand B (Bi = B4)
	jal _mul64aux
	
	# add parts of the multiplication
	li $t5, 0 # set initial overflow to 0
	la $t6, result 
	la $t7, temp2
	la $t8, temp3
	la $t9, temp4
	
	# offset to start from lsb
	add $t6, $t6, 28
	add $t7, $t7, 28
	add $t8, $t8, 28
	add $t9, $t9, 28
	
	# add parts of the multiplication
	li $t1, 8 # inititate iterator
	
_mad64aux:
	lw $t3, ($t6)		# 
	add $t3, $t3, $t5	# add previous overflow
	li $t5, 0		# forget previous overflow
	lw $t4, ($t7)		# 
	add $t3, $t3, $t4	# add 
	mfhi $t0		# catch overflow
	add $t5, $t5, $t0	# accumulate overflows
	lw $t4, ($t8)		#
	add $t3, $t3, $t4	# add 
	mfhi $t0		# catch overflow
	add $t5, $t5, $t0	# accumulate overflows
	lw $t4, ($t9)		#
	add $t3, $t3, $t4	# add 
	mfhi $t0		# catch overflow
	add $t5, $t5, $t0	# accumulate overflows
	
	sw $t3, ($t6)		# turns result into modulus
	
	# decrement address pointers
	sub $t6, $t6, 4
	sub $t7, $t7, 4
	sub $t8, $t8, 4
	sub $t9, $t9, 4
	
	sub $t1, $t1, 0		# decrement iterator
	bnez $t1, _mad64aux	# iterate 
	
	# at this point einskey = opA * secondKey
	
	#end program
	li $v0, 10		# load syscall: exit
	syscall	 		# terminate program
	
	
_mul64aux:
#top cap
	#calculate
	lw $t3, 12($t1)		# load 32 bits of operand A (A1)
	mul $t5, $t3, $t4	# multiply R = A1*Bi
	mfhi $t0		# catch overflow (V0)
	add $t6, $t6, $t0	# store overflow V0 somewhere else
	#store
	sw $t5, ($t9)		# store result
	sub $t9, $t9, 4		# shift storage
	
	#calculate
	lw $t3, 8($t1)		# load next 32 bits of operand (A2)
	mul $t5, $t3, $t4	# multiply R = A2*Bi
	mfhi $t0		# catch overflow (V1)
	add $t7, $t7, $t0	# store overflow V1 somewhere else
	#store
	add $t5, $t5, $t6	# add overflow from previous op (Res+=V0)
	mfhi $t0		# catch overflow from add
	add $t7, $t7, $t0	# add to overflow for next op 
	sw $t5, ($t9)		# store result
	sub $t9, $t9, 4		# shift storage
		
	#calculate
	lw $t3, 8($t1)		# load next 32 bits of operand (A3)
	mul $t5, $t3, $t4	# multiply R = A3*Bi
	mfhi $t0		# catch overflow (V2)
	add $t6, $t6, $t0	# store overflow V2 somewhere else
	#store
	add $t5, $t5, $t7	# add overflow from previous op (Res+=V1)
	mfhi $t0		# catch overflow from add
	add $t6, $t6, $t0	# add to overflow for next op 
	sw $t5, ($t9)		# store result
	sub $t9, $t9, 4		# shift storage	
		
	#calculate
	lw $t3, 8($t1)		# load next 32 bits of operand (A4)
	mul $t5, $t3, $t4	# multiply R = A4*Bi
	mfhi $t0		# catch overflow (V3)
	add $t6, $t6, $t0	# store overflow V3 somewhere else
	#store
	add $t5, $t5, $t7	# add overflow from previous op (Res+=V2)
	mfhi $t0		# catch overflow from add
	add $t6, $t6, $t0	# add to overflow for next op 
	sw $t5, ($t9)		# store result
	sub $t9, $t9, 4		# shift storage
	
#bottom cap
	sw $t7, ($t9)		# store extra overflow (V3, that is msb)
	jr $ra			# jump back
	
	
	
	

	
