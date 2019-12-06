.data

.balign 8

one: .double 1
three: .double 3

.text

.balign 4
.global bezier

@
@ double bezier(double t)
@ Computes: 3 * (1-t)^2 * t
@
bezier:
  stmfd sp!,{lr}
  
  vmov d1,d0    @ Save t

  ldr r0,=one
  vldr d2,[r0]  @ d2=1
  vsub.f64 d2,d2,d1   @ d2=1-t
  vmul.f64 d2,d2,d2   @ d2=(1-t)^2

  vmul.f64 d2,d2,d1   @ d2=(1-t)^2 * t

  ldr r0,=three
  vldr d0,[r0]

  vmul.f64 d0,d0,d2   @ d0=3 * (1-t)^2 * t
  
bezier_done:
  ldmfd sp!,{lr}
  bx lr
