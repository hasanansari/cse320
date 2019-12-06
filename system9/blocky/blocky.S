.data

.balign 8
zero: .double 0

.text
.balign 4

.global blocky
@
@ void *blocky(void *src)
@
blocky:
	push {r4-r12, lr}
  .equ row, 0
  .equ col, 4
  .equ size, 8

  sub sp, sp, #size
  mov r7, #0  @ row counter
  mov r8, #0   @ col counter
  mov r1, #0
  mov r2, #0
  str r1,[sp,#row]
  str r2,[sp,#col]

  mov r4, r0  @image pointer

  bl get_height
  mov r6, r0  @ height

  mov r0, r4
  bl get_width
  mov r5, r0  @ width
 
  mov r0, r5
  mov r1, r6
  bl create_image
  mov r11, r0 @ new image

first_loop:
  sub r0, r6, r7 @ width - col
  cmp r0, #7
  ble blocky_done @ sub > 7

  ldr r0, =zero
  vldr d4,[r0]  @ color to avg
  mov r9, #0     @ inner row
  mov r10, #0   @ inner col

average:
  mul r0, r9, r10 @ inner row * inner col
  cmp r0, #56     
  bge average_done

  add r0, r7, r9  @ row + inner row
  str r0,[sp,#row]

  cmp r6, r0
  suble r0, r6, #1  @ change row based on where in image
  str r0, [sp,#row]

  add r1, r8, r10   @ col + inner col
  str r1,[sp,#col]

  cmp r5, r1
  suble r1, r5, #1  @ change col based on where in image
  str r1,[sp,#col]

  mov r0, r4
  ldr r1,[sp,#row]
  ldr r2,[sp,#col]
  bl get_pixel   
  vadd.f64 d4, d4, d0 @ color to average = color to average + cell color

  cmp r10,#7
  addne r10,#1  @ add 1 to inner col if inner col != 7
  addeq r9,#1  @ add 1 to inner row if inner col == 7
  moveq r10,#0    @ inner col is zero if col == 7

  b average

average_done:
  mov r9,#0           @ reset inner row and inner col to zero
  mov r10,#0
  mov r3, #64
  vmov s4,r3
  vcvt.f64.s32 d2,s4
  vdiv.f64 d4,d4,d2   @ color to avg / 64

pixel:
  mul r0, r9, r10   @ inner row * inner col
  cmp r0,#56
  bgt inc_block
  
  add r0, r7, r9    @ row + inner row
  str r0,[sp,#row]

  cmp r6, r0
  suble r0, r6, #1  @ change row based on where in image
  str r0,[sp,#row]

  add r1, r8, r10   @ col + inner col
  str r1,[sp,#col]

  cmp r5, r1
  suble r1, r5, #1  @ change col based on where in image
  str r1,[sp,#col]

  mov r0, r11
  ldr r1,[sp,#row]
  ldr r2,[sp,#col]
  vmov d0, d4
  bl set_pixel

  cmp r10,#7
  addne r10, #1  @ add 1 to inner col if inner col != 7
  addeq r9, #1  @ add 1 to inner row if inner col == 7
  moveq r10,#0      @ inner col == 0 if inner col == 7

  b pixel

inc_block:
  sub r0, r5, r8    @ actual width - col
  cmp r0, #7
  addge r8, #8  @ add 8 to col if width - col >= 7
  addlt r7, #8    @ add 8 to row if width - col < 7
  movlt r8, #0       @ col = 0 if width - col < 7
  b first_loop

blocky_done:
  mov r0, r11
  add sp,sp,#size
  pop {r4-r12,lr}
  bx lr

