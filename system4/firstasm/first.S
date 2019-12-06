@
@ My first assembly language program
@ Name: Gabby Kelsch Bledsoe
@

.text
.global first

first:
  mov r1, #0 @ cnt
  @ initialization / i=0
  mov r2, #0 @i

forloop:
  @ the test / i != 32
  subs r3, r2, #32 @r3 = i-32
  beq loopend   @if i==32

  adds r3, r0, #1 @r0 & 1
  addne r1, r1, #1  @ cnt++

  lsr r0, r0, #1  @value >>= 1

  @ increment / i++
  add r2, r2, #1  @i++
  b forloop

loopend:
  mov r0, r1
  bx lr
