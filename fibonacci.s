.data
msg1:		.asciiz "Please input a number: "

.text
.globl main
#------------------------- main -----------------------------
main:
		li			$v0,	4
		la			$a0, msg1
		syscall
		
		li			$v0,	5
		syscall
		move	$a1,	$v0
		move $a3, $a1
		addi $t0, $zero, 0
		addi $t1, $zero, 1
		jal fabonaccis
		#move $t0, $v0

exit:
 		li		$v0, 10
 		syscall
	

.text
fabonaccis:    
			sw $ra, 0($sp)
			addi $sp, $sp, -4
			addi $t6, $zero, 1
			beq $a1, $t6, L1				#if n == 1 go to L1
			beq $a1, $zero, L2

			add $t2, $t0, $t1
			move	$t0, $t1
			move    $t1, $t2
			addi $a3, $a3, -1
			addi $t5, $zero, 1
			beq $a3, $t5, L3
			j fabonaccis   
			
			
L1:
		#lw $ra, 0($sp)
		addi $a0, $zero, 1				#return 1
		#addi $sp, $sp, 12
		#move $a0, $v0
		li $v0, 1					#call system call : print integer
		#la $a0, msg2				#output message 2 to the screen	
		syscall
		addi $sp, $sp, 4
		#jr $ra
		li		$v0, 10
 		syscall
L2:
		#lw $ra, 0($sp)
		addi $a0, $zero, 0				#return 0
		#addi $sp, $sp, 12
		#move $a0, $v0
		li $v0, 1					#call system call : print integer
		#la $a0, msg2				#output message 2 to the screen	
		syscall
		addi $sp, $sp, 4
		#jr $ra
		li		$v0, 10
 		syscall

L3:
		#lw $ra, 0($sp)
		move $a0, $t1
		li $v0, 1					#call system call : print integer
		#la $a0, msg2				#output message 2 to the screen	
		syscall
		addi $sp, $sp, 4
		#jr $ra
		li		$v0, 10
 		syscall
			
		
