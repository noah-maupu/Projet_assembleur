.data
clear:  .byte   0x1B,0x5B,0x33,0x3B,0x4A,0x1B,0x5B,0x48,0x1B,0x5B,0x32,0x4A
fout:   .asciiz "test.txt"      # filename for output
buffer: .space 10
        .text

main:
  # Open (for reading) a file
  li $v0, 13       # system call for open file
  la $a0, fout     # output file name
  li $a1, 0        # flags
  syscall          # open a file (file descriptor returned in $v0)

  move $t0, $v0    # save file descriptor in $t0

  # Read to file just opened
  li $v0, 14       # system call for read to file
  la $a1, buffer   # address of buffer from which to write
  li $a2, 10       # hardcoded buffer length
  move $a0, $t0    # put the file descriptor in $a0
  syscall          # write to file

  # Get the value from certain address

  la $a0, buffer #load the address into $a0

  li $v0, 4        # print the string out
  syscall

	
  # clear the screen
    la      $a0,clear
    li      $v0,4
    syscall


  # Close the file 
  li $v0, 16       # system call for close file
  move $a0, $t0    # Restore fd
  syscall          # close file

  li $v0, 10         # end the file
  syscall
