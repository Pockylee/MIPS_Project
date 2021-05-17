.data
msg1:	.asciiz "Please input a number you want to check : "
msg2:	.asciiz "\nIt's a prime number!\n"
msg3: 	.asciiz "\nIt's not a prime number!\n"

.text
.globl main
#------------------------- main -----------------------------
main:
#print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
		
#read the input integer in $v0
		li		$v0, 5
		syscall
		move  $a0, $v0

#jump to procedure prime
		jal prime
		move $t0, $v0				#save output of the prime function to $t0
 		
#check the outpu of prime function
		beq $t0, 0, L3				#if output == 0, go to L3
		#else:
		li $v0, 4					#call system call : print integer
		la $a0, msg2				#output message 2 to the screen	
		syscall

#exut program 		
exit:
 		li		$v0, 10
 		syscall

#------procedure prime --------(load n in $a0 and return to $v0)
.text
prime:	addi $sp, $sp, -8			#adjust stack for 2 items 
		sw $ra, 4($sp)				#save return address at $ra
		sw $a0, 0($sp)				#save the argument n
		#if (n == 1)
		addi $t0, $zero, 1			#$t0 = 1
		beq $t0, $a0, L1			#if $a0(n) == 1 -> L1
		#else (n != 1), start for loop 
		addi $t1, $zero, 2			#t1 = 2 (for i in L2)
		sw $t1, 0($sp)				#save i in $sp+0

Loop:	lw $t1, 0($sp)				#load word $t1(i)
		mul $t0, $t1, $t1			#$t0 = i^2
		bgt $t0, $a0, L2			#if i^2 > n, go to L2
		
		div $a0, $t1				#n % i
		mfhi $t0					#get the remainder of n%i
		beq $t0, $zero, L1			#if remainder == 0, go to L1 which is return 0
		
		addi $t1, $t1, 1			#i++
		sw $t1, 0($sp)
		j Loop 



L1:		
		lw	$ra, 4($sp)				# restore the return address
		addi $v0 $zero, 0			#$v0 = 0, output return 0
		addi $sp $sp 8				#pop 2 items from the stack
		jr $ra 						#return to caller


L2:
		lw $ra, 4($sp)				#restore the return address
		addi $v0, $zero, 1			#return 1
		addi $sp, $sp, 8			#pop 2 items from the stack
		jr $ra 						#return to caller

L3:
		li $v0, 4					#call system call : print integer
		la $a0, msg3				#print message 3 on the screen
		syscall
		li $v0, 10					#call system call : exut program
		syscall
