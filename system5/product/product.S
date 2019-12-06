@
@ Data section
@
.data
@
@ Messages
@

firstprint:
  .asciz "Enter first number : \n"

secondprint:
  .asciz "Enter second number : \n"

thirdprint:
  .asciz "Sorry, positive numbers only! %d\n"

productprint:
  .asciz "The product is %d\n"

@
@ Input buffer
@
.set BUFFERSIZE, 20

buffer:
    .space BUFFERSIZE,0

@ 
@ Text section
@
.text
.global main
.global product

@
@ main
@

main: 
  stmfd sp!,{r4-r8, lr}  @Save lr on the stack

  @prompt for first num
  ldr r0, =firstprint
  bl printf

  @fgets(buffer, sizeof(buffer), stdin)
  ldr r0,=buffer      @ Argument 1: buffer address
  ldr r1,=BUFFERSIZE  @ Argument 2: size of the buffer
  ldr r2,=stdin       @ Address of stdin variable in memory
  ldr r2,[r2]         @ Argument 3: value of stdin
  bl fgets
  
  @a = atoi(buffer)
  ldr r0, =buffer
  bl atoi
  mov r4, r0

  @prompt for second num
  ldr r0, =secondprint
  bl printf

  @fgets(buffer, sizeof(buffer), stdin)
  ldr r0,=buffer      @ Argument 1: buffer address
  ldr r1,=BUFFERSIZE  @ Argument 2: size of the buffer
  ldr r2,=stdin       @ Address of stdin variable in memory
  ldr r2,[r2]         @ Argument 3: value of stdin
  bl fgets
  
  @b = atoi(buffer)
  ldr r0, =buffer
  bl atoi
  mov r5, r0
  
  @a<0
  cmp r4, #0
  blt logic_if_a

  @|| b<0 inclusive or
  cmp r5, #0
  blt logic_if_b

  mov r0, r4
  mov r1, r5
  
  bl product

  @r0 is return of product
  mov r1, r0
  ldr r0, =productprint
  bl printf
  
  b main_return

logic_if_a:
  @if a<0
  @print message then return 1

  mov r1, r4
  ldr r0, =thirdprint
  bl printf
  mov r0, #1
  b main_return

logic_if_b:
  @if b<0
  @print message then return 1

  mov r1, r5
  ldr r0, =thirdprint
  bl printf
  mov r0, #1
  b main_return

main_return:
  ldmfd sp!,{r4-r8,lr}  @Restore lr from the stack
  bx lr

@
@ Product
@

product:
  stmfd sp!,{r4-r8,lr}  @save lr on the stack
  mov r7, r0
  mov r8, r1

  @if b == 0
  cmp r1, #0
  beq b_zero

  @if b%2 == 0
  and r4, r1, #1  @b&1
  cmp r4, #0      @if b&1==0
  beq first_p

  @else
  cmp r4, #1
  beq second_p

first_p:
  @have new a be a+a
  @have new b be b/2
  add r0,r7,r7

  @b/2 same as shift right 1 bit
  lsr r1, r8, #1    

  @recursion
  bl product
  b product_done

second_p:
  @return product(a+a, b/2) + a
  @make a be a+a
  @make b be b/2

  add r0,r7,r7  @r7 is for adding a
  lsr r1,r8,#1

  @recursion
  bl product
  add r0,r0,r7
  b product_done

b_zero:
  @Restore lr from the stack
  ldmfd sp!,{r4-r8,lr}
  mov r0,#0
  bx lr

product_done:
  @Restore lr from the stack
  ldmfd sp!,{r4-r8,lr}
  bx lr

