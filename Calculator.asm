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
	






