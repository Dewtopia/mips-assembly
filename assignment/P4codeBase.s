.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3
main:

li $s0, 0               	#int sum = 0;
li $t2, 10              	#int size = 10;
la $s1, sumarr         		#int sumarr[] = {1,3,44,66,88,90,9,232,4325,2321};

bge $t0, $t2, sumArrayEnd			#for(int i = 0; i < size; i++){
sumArrayStart:
	lw $t1, ($s1)
	add $s0, $s0, $t1 			#sum = sum + sumarr[i];
	addi $s1, $s1, 4
	addi $t0, $t0, 1
	blt $t0, $t2, sumArrayStart
sumArrayEnd:      
                                                
   
 li $s3, 45689          	#int num = 45689;
 li $s2, 0              	#int rev = 0;
 li $t1, -1             	#int d = -1;

blez $s3, palindromeLoopEnd
palindromeLoop:             		#while loop while( num > 0){
    rem $t1, $s3, $t2		 	#d = num % 10;
    mul $s2, $s2, $t2          		#rev = rev*10 + d; #rev = rev*10
    add $s2, $s2, $t1           	#rev = rev + d
    div $s3, $s3, $t2 		    	#num = num / 10;
    bgtz $s3, palindromeLoop    
palindromeLoopEnd:
			
    
la $s5, arr         		#int arr[] = {1,2,3,4,5,4,3,2,1};
li $s6, 0           		#int beg = 0;
li $s7, 8           		#int end = 8;
li $s4, -1          		#int isPalindrome = 1;

bge $s6, $s7, checkPalindromeEnd               			#while(beg < end){
checkPalindromeStart:	
        sll $t4, $s6, 1
        add $t4, $t4, $s5              
        lw $t4, ($t4)
        srl $t5, $s7, 1
        add $t5, $t5, $s5
        lw $t5, ($s5)
        #addi $t5, $t5, 36

        #add $t5, $t5, $s5
        beq $t4, $t5, checkPalindromeMiddle		                #if (arr[beg] != arr[end]){
	li $s4, -1							#isPalindrome = -1;
	j checkPalindromeEnd			                	#break;
						
checkPalindromeMiddle:    
	addi $s6, $s6, 1						#beg++;
	addi $s7, $s7, -1    						#end--;
	blt $s6, $s7, checkPalindromeStart 
					
checkPalindromeEnd:
	#cout << "Sum: " << sum << endl;
	#cout << "Reversed Number: " << rev << endl;
	#cout << "Is Palindrome: " << isPalindrome << endl;

addi $s1,$s2,0      # move rev to s1 as required by the cout below

addi $s3,$s4,0      # move isPalindrome to s3 as required by the cout below
exit:
  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s0       # puts sum into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string
  syscall             # make a syscall to system

  move $a0, $s2       # puts rev into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall


  addi $v0,$0, 10
  syscall
