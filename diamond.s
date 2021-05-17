.data
msg1:	.asciiz "Please input your diamond's size: "
blank:	.asciiz " "
star: 	.asciiz "*"
enter:	.asciiz "\n"

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
		move  $a1, $v0				#move input number to $a1

#start printing diamond on the screen
		addi $t0, $zero, 0			#i = 1
#for (int i = 1; i <= n; i++) 
Loop_up:							
		addi $t0, $t0, 1			#i++
		addi $t2, $zero, 0 			#j = 1
Loop_up_1:
		addi $t2, $t2, 1			#j++
		li 	$v0, 4
		la $a0, blank				#print " "
		syscall

		sub $t3, $a1, $t0			#$t3 = n - i
		ble $t2, $t3, Loop_up_1		#j <= n - i, go to Loop_up_1 again

#end loop up 1 , preparation for Loop up mid (star)
		sub $t2, $a1, $t0			#j = n - i
		addi $t2, $t2, 1			#j++
Loop_up_mid:
		addi $t2, $t2, 1			#j++
		li 	$v0, 4
		la $a0, star				#print "*"
		syscall
		add $t3, $a1, $t0			#j = n +i
		#addi $t2, $t2, 1			#j++
		blt $t2, $t3, Loop_up_mid
		
		li $v0, 4
		la $a0, enter
		syscall
		blt $t0, $a1, Loop_up
		
		addi $t5, $zero, 1
		move $t0, $a1			#i = n
		#addi $t0, $t0, -1		#i = i - 1
Loop_down:
		addi $t0, $t0, -1		#i = i - 1
		addi $t2, $zero, 0		#j = 0
		
Loop_down_1:
		addi $t2, $t2, 1			#j++
		li 	$v0, 4
		la $a0, blank				#print " "
		syscall

		sub $t3, $a1, $t0			#$t3 = n - i
		ble $t2, $t3, Loop_down_1		#j <= n - i, go to Loop_up_1 again

Loop_down_mid:
		addi $t2, $t2, 1			#j++
		li 	$v0, 4
		la $a0, star				#print "*"
		syscall
		add $t3, $a1, $t0			#j = n +i
		#addi $t2, $t2, 1			#j++
		blt $t2, $t3, Loop_down_mid
		
		li $v0, 4
		la $a0, enter
		syscall
		bgt $t0, $t5, Loop_down

#exit program 		
exit:
 		li		$v0, 10
 		syscall


