@
@ Data section
@
.data

@
@ Messages
@
usagemsg:
  .asciz "Usage: guess [number]\n"
splash:
  .asciz "We are guessing the number %d\n"

lowmsg:
  .asciz "Guess was too low\n"
highmsg:
  .asciz "Guess was too high\n"

correctmsg:
  .asciz "You guessed the number %d\n"
@
@ Input buffer
@
.set BUFFERSIZE, 100

buffer:
    .space BUFFERSIZE,0
  
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
  stmfd sp!,{r4-r8,lr}  @Save r4, lr on the stack
  
  @Did the user provide an argument?
  cmp r0,#2
  blt usage
  
  @ Determine the number to guess
  add r1, #4  @Move to the second string
  ldr r0,[r1] @Get the pointer to the actual string
  bl atoi     @convert to an integer
  mov r4, r0

  @
  @ Splash
  @
  mov r1, r0
  ldr r0,=splash
  bl printf

loop:
  @fgets(buffer, sizeof(buffer), stdin)
  ldr r0,=buffer      @Argument 1: buffer address
  ldr r1,=BUFFERSIZE  @Argument 2: size of the buffer
  ldr r2,=stdin       @Address of stdin variable in memory
  ldr r2, [r2]        @Argument 3: value of stdin
  bl fgets

  @
  @ Convert to an integer
  @
  ldr r0, =buffer
  bl atoi

  @Test it
  cmp r0, r4
  blt toolow
  bgt toohigh
  beq correct

  mov r0,#0

main_return:
  ldmfd sp!,{r4-r8, lr}  @Restore r4, lr from the stack
  bx lr

@If guess the number
correct:
  mov r1, r0
  ldr r0,=correctmsg
  bl printf
  b main_return

@The usage of this code
usage:
  ldr r0,=usagemsg
  bl printf  

  @return 1
  mov r0, #1
  b main_return

@Guess was too low
toolow:
  ldr r0, =lowmsg
  bl printf
  b loop

@Guess was too high
toohigh:
  ldr r0, =highmsg
  bl printf
  b loop
