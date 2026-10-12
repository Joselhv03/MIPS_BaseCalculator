.data
msg: .asciiz "CALCULADORA DE SISTEMAS NUMÉRICOS\n"
sn: .asciiz "Ingrese el sistema numérico de entrada\n"
opt1: .asciiz "1- Binario (2)\n"
opt2: .asciiz "2- Decimal (10)\n"
opt3: .asciiz "3- Octal (8)\n"
opt4: .asciiz "4- Hexadecimal (16)\n"
exitM: .asciiz "5- SALIR\n"
jump: .asciiz "\n"
wrt: .asciiz "Ingresa la opción (1-5): "

bnrNum: .asciiz "Ingresa el número binario: "
decmNum: .asciiz "Ingresa el número decimal: "
octNum: .asciiz "Ingresa el número octal: "
hxdNum: .asciiz "Ingresa el número hexadecimal: "

ansB: .asciiz "El número en binario es: "
ansD: .asciiz "El número en decimal es: "
ansO: .asciiz "El número en octal es: "
ansH: .asciiz "El número en hexadecimal es: "

numH:	.space 9  #Caben 8 dígitos hexadecimales en MIPS R2000 + 1 byte de borrado

.text
	
#Print welcome message
	la $a0 msg
	li $v0 4
	syscall
	la $a0 sn
	syscall

#Print main menu
	la $a0 opt1
	syscall
	la $a0 opt2
	syscall
	la $a0 opt3
	syscall
	la $a0 opt4
	syscall
	la $a0 exitM
	syscall
	
#Read user input
	la $a0 wrt
	syscall
	li $v0 5
	syscall
	beq $v0, 1, bnr
	beq $v0, 2, decm
	beq $v0, 3, oct
	beq $v0, 4, hxd
	beq $v0, 5, exit
	
#Binary input
bnr:	li $v0 4
	la $a0 bnrNum
	syscall
	li $v0 8
	syscall
#Decimal input
decm:	li $v0 4
	la $a0 decmNum
	syscall
	li $v0 5
	syscall
	move $s1 $v0 #$s1 tiene el valor decimal que ingresó el usuario
	j dTb
#Octal input
oct:	li $v0 4
	la $a0 octNum
	syscall
	li $v0 8
	syscall
#Hexadecimal input
hxd:	li $v0 4
	la $a0 hxdNum
	syscall
	li $v0 8
	syscall
	
#Exit the program
exit:	li $v0 10
	syscall
	
##DECIMAL TO BINARY##
dTb:	li $v0 4
	la $a0 ansB
	syscall
	li $t2 31
dcTbn:	bltz $t2 dTh
	move $t1 $s1 #Copia del número original
	srlv $t1 $t1 $t2
	and $t1 $t1 1
	#Print the bit
	li $v0 1
	move $a0 $t1
	syscall
	addi $t2 $t2 -1
	j dcTbn
	
##DECIMAL TO HEXADECIMAL##
dTh:	li $t2 28 #Para el desplazamiento (shift)
	#li $t3 15 #0000...0000 1111
	li $t9 0 #Para apuntar al espacio de memoria
dcThx:	beq $t9 8 ansDtH
	move $t1 $s1
	srlv $t1 $t1 $t2
	and $t1 $t1 15 #¿O 15 directo?
	bgt $t1 9 alphaH
	j nroH
alphaH:	addi $t1 $t1 55
	j upByte
nroH: 	addi $t1 $t1 48
	j upByte
upByte:
	sb $t1 numH($t9)
	addi $t2 $t2 -4
	addi $t9 $t9 1
	j dcThx
ansDtH:	li $v0 4
	la $a0 jump
	syscall
	la $a0 ansH
	syscall
	la $a0 numH
	syscall
	j exit