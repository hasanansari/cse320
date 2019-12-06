@
@ Data section
@
.data

intro: .asciz "\nAll Perfect numbers from 1 to 10000:\n\n"

perfect_num: .asciz "Perfect: %d\n"

@
@ Text section
@

.text

.global main

@
@ main(argc, argv)
@ r0: The number of arguments
@ r1: Pointer to an array of string pointers
@
main:
  stmfd sp!,{lr}

  @ Print intro statement
  ldr r0,=intro
  bl printf

  .equ number, 0
  .equ divisor, 4
  .equ sum, 8
  .equ quotient, 12
  .equ remainder, 16
  .equ size, 20

  @ Allocate space
  sub sp, sp, #size

  str r0,[sp,#number]
  str r1,[sp,#divisor]

  @ Set number to = 1
  ldr r0,[sp,#number]
  mov r0, #1
  str r0,[sp,#number]

first_loop:
  ldr r0,[sp,#number]
  ldr r1, =10000
  cmp r0, r1
  @ Loop until number > 10000
  bgt perfect_done

  @ set sum = 0
  ldr r0,[sp,#sum]
  mov r0, #0
  str r0,[sp, #sum]

  @ Set divisor = 1
  ldr r0,[sp,#divisor]
  mov r0, #1
  str r0,[sp,#divisor]

second_loop:
  ldr r0,[sp,#divisor]
  ldr r1,[sp,#number]
  cmp r0, r1
  @ Loop until divisor >= number
  bge if_two

  @ Calculate % using div
  add r0, sp, #quotient
  ldr r1, [sp,#number]
  ldr r2,[sp,#divisor]
  bl div

  @ number%divisor
  ldr r0, [sp,#remainder]

  @ if true, branch to if_one
  cmp r0, #0
  beq if_one

  @ divisor++
  ldr r0, [sp,#divisor]
  add r0, #1
  str r0,[sp,#divisor]

  b second_loop

if_one:
  @ sum += divisor
  @ divisor++

  ldr r0,[sp,#sum]
  ldr r1,[sp,#divisor]
  add r0, r0, r1
  add r1, #1
  str r0,[sp,#sum]
  str r1,[sp,#divisor]
  b second_loop

if_two:
  ldr r0,[sp,#sum]
  ldr r1,[sp,#number]
  
  @ If sum and number not equal, no if statement
  cmp r0, r1
  bne not_equal

  @ if statement

  ldr r0,=perfect_num
  ldr r1,[sp,#number]
  bl printf
  
  @number++
  ldr r1,[sp,#number]
  add r1, #1
  str r1,[sp,#number]

  b first_loop
  
not_equal:
  @number++ and go back to first_loop
  ldr r1,[sp,#number]
  add r1, #1
  str r1,[sp,#number]
  b first_loop

perfect_done:
  @ return 0
  @ Free space
  add sp, sp, #size
  ldmfd sp!,{lr}
  bx lr
