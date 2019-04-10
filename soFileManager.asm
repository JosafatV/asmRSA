    .data
FileName:   .asciiz "primeNumbers.vig"
bad_msg:    .asciiz "open syscall failed\n"
ok_msg:     .asciiz "open was okay\n"
res:        .byte   1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

    .text
    .globl  main
main:
    li      $a1,577                 # Open for writing (flags are 0: read, 1: write)
    li      $a2,0x1ff               # was recommended for file permissions

main_retry:
    li      $v0,13                  # system call for open file
    la      $a0,FileName            # output file name

    syscall                         # open a file (descriptor returned in $v0)
    move    $s6,$v0                 # save the file descriptor
    bltz    $s6 main_fail           # did open fail? fly if yes

    la      $a0,ok_msg
    li      $v0,4
    syscall

    # Write to file just opened
    li      $v0,15                  # system call for write to file
    move    $a0,$s6                 # file descriptor
    la      $a1,res                 # address of buffer from which to write
    li      $a2,15                  # hardcoded buffer length
    syscall

    move    $a0,$s6
    li      $v0,16                  # close
    syscall

main_exit:
    li      $v0,10
    syscall

main_fail:
    la      $a0,bad_msg
    li      $v0,4
    syscall

    li      $a1,1                   # correct write mode (O_WRONLY)
    li      $a2,0                   # file permissions are ignored by mars
    j       main_retry
