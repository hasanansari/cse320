.data

.equ image_wid, 0
.equ image_hit, 4
.equ image_array, 8
.equ image_size, 12

.equ pixel_actual, 0
.equ pixel_size, 8

.text
 
.global create_image
@
@ void *create_image(int wid, int hit)
@ Create an image ADT and return it.
@
create_image:
	push {r4-r8, lr}
  mov r4, r0
  mov r5, r1

  @ Allocate
  mov r0, #1  @ Because zero-based array
  mov r1, #image_size
  bl calloc

  @ Set init values
  str r4,[r0,#image_wid]
  str r5,[r0,#image_hit]

  mov r6, r0  @ image pointer

  @ Allocate array
  mul r0, r4, r5
  mov r1, #image_size
  bl calloc

  str r0,[r6,#image_array]
  mov r0, r6

create_image_done:
  pop {r4-r8, lr}
  bx lr

.global destroy_image	
@
@ void destroy_image(void *image)
@ Destroy image, freeing memory
@
destroy_image:
	push {r4, lr}
  mov r4, r0
  ldr r0,[r0,#image_array]
  bl free
  mov r0, r4
  bl free
  pop {r4, lr}
  bx lr

.global get_width
@
@ int get_width(void *image)
@ Get the width of the image
@
get_width:
	push {lr}
  ldr r0,[r0, #image_wid]
  pop {lr}
	bx lr
	
.global get_height
@
@ int get_height(void *height)
@ Get the height of the image
@
get_height:
  push {lr}
  ldr r0,[r0, #image_hit]
  pop {lr}
	bx lr
	
.global set_pixel
@
@ void set_pixel(void *image, int row, int col, double value)
@
set_pixel:
	push {r4-r8, lr}
  
  bl img_index
  vstr d0,[r0]
 
  pop {r4-r8, lr}
  bx lr

.global get_pixel
@
@ double get_pixel(void *image, int row, int col)
@
get_pixel:
	push {r4-r8, lr}
  bl img_index
  add r0, r0, #pixel_actual
  vldr d0,[r0]
  pop {r4-r8,lr}
  bx lr

.global img_index
@ 
@ int *img_index(void *image, int row, int col)
@ Get address. Based on game_index
@
img_index:
  push {r4, lr}
  mov r4, r0
  ldr r0, [r4, #image_wid]
  mul r0, r0, r1
  add r0, r0, r2
  mov r3, #pixel_size
  mul r0, r0, r3
  ldr r3, [r4, #image_array]
  add r0, r0, r3
  pop {r4, lr}
  bx lr
