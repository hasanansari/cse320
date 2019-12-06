

.text
.global dumb_multiply
.global dumb_sqrt
.global efficient_sqrt


@
@ Multiply two numbers together by brute force
@ r0 - First unsigned value
@ r1 - Second unsigned value
@ Returns r0 * r1
@
dumb_multiply:
  @initialize r2 and r3
  mov r2, #0  @sum
  mov r3, r0 @count

forloop:  
  @execute while count != 0
  add r2, r2, r1

  subs r3, r3, #1 @count-1
  beq loopend   @ if r3 == 0
  b forloop

loopend:
  @return sum
  mov r0, r2
  bx lr


@
@ Dumb, inefficient square root computation
@ r0 - Passed in value: num
@ Returns sqrt(r0)
@
dumb_sqrt:
  @initialize
  mov r1, #1  @n_sqr
  mov r3, #1  @n, counter
  @r2 is scratch work
  @r0 is num

ds_forloop:
  cmp r1, r0
  beq ds_loopend   @break if r1 == r0

  mov r2, r0
  subs r2, r2, r1 @num-n_sqr
  bmi secbreak @break if r2 is neg, n_sqr>num
  
  mov r2, r3 @r2 is now n
  add r2, r2, r2 @n*2
  add r2, r2, #1  @n*2+1
  add r1, r1, r2 @n_sqr += n*2+1
  add r3, r3, #1 @n++ for the for loop
  cmp r3,#32768  @compares if counter has reached 32768
  beq ds_loopend

  b ds_forloop

secbreak:
  sub r3, r3, #1  @n--
  mov r0, r3  @return n
  bx lr

ds_loopend:
  mov r0, r3 @return n
  bx lr

@
@ Efficient integer square root computation
@ r0 - Passed in value: num
@ Returns sqrt(r0)
@
efficient_sqrt:
  mov r1, #1  @r1 = bit, set to 1
  lsl r1, r1, #30   @set bit = 1 << 30
  mov r2, #0  @r2 = res

find4:  @first while loop
  cmp r1, r0  @ bit <= num?
  ble not_zero
  lsrs r1, r1, #2  @bit >>= 2
  b find4   @keep looping

not_zero: @second while loop
  movs r1, r1
  beq got_bit   @bit == 0

  @if statement
  mov r3, r2  
  add r3, r3, r1   @r3 = res + bit
  cmp r0, r3       @num < res + bit?
  blt inc
  sub r0, r0, r3    @num -= res+bit
  mov r3, r1  @mov bit to r3
  lsl r3, r3, #1  @bit << 1 ??
  add r2, r2, r3
  b inc

inc:
  lsr r2, r2, #1   @res >>= 1
  lsr r1, r1, #2   @bit >>= 2
  b not_zero

got_bit:  @return res
  mov r0, r2
  bx lr

