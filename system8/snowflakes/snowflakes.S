.data

.balign 8


xn: .double 0
yn: .double 0
four: .double 4
two: .double 2

.text
.global snowflakes

@
@ int snowflakes(double x, double y)
@ d0 = x
@ d1 = y
@

snowflakes:
  stmfd sp!,{r4-r8,lr}
  mov r3, #0 @iteration 

  ldr r6,=xn
  vldr d2, [r6]
  ldr r7,=yn
  vldr d3, [r7]

loop:
  cmp r3, #255   
  movge r0, r3
  bge snowflakes_done   @iteration < max_colors-1

  vmul.f64 d4, d2, d2 @xn * xn
  vmul.f64 d5, d3, d3 @yn * yn
  vadd.f64 d6, d4, d5 @ xn*xn + yn*yn
  
  ldr r4, =four
  vldr d7,[r4]
  vcmp.f64 d6, d7 
  vmrs APSR_nzcv, fpscr @ move to CPSR
  movgt r0, r3
  bgt snowflakes_done 

  @ Compute z_n+1

  @ Compute xn1
  vsub.f64 d6, d4, d5 @ xn*xn - yn*yn
  vadd.f64 d6, d6, d2 @ xn*xn - yn*yn + xn
  vadd.f64 d6, d6, d0 @ xn*xn - yn*yn + xn + x
  
  @ Compute yn1
  ldr r5,=two
  vldr d4,[r5]
  vmul.f64 d7, d2, d3 @ xn * yn
  vmul.f64 d7, d7, d4  @ 2*xn*yn
  vadd.f64 d7, d7, d3   @ 2*xn*yn + yn
  vadd.f64 d7, d7, d1   @ 2*xn*yn + yn + y

  @ update xn and yn
  vmov d2, d6
  vmov d3, d7

  add r3, #1  @ inc iteration
  b loop 

snowflakes_done:
  ldmfd sp!,{r4-r8,lr}
  bx lr
