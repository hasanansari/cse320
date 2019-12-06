.data

item: .asciz "  %c"
column: .asciz " %2d"
row: .asciz " %2d"
newline: .asciz "\n"
tab: .asciz "   "

@
@ The Game description data struture
@
.equ  game_rows, 0
.equ  game_cols, 4
.equ  game_array, 8
.equ  game_size, 12

@
@ The Game cell data struture
@ This is the contents of a location in the array
@
.equ cell_expected, 0
.equ cell_actual, 4
.equ cell_size, 8

.text

.global create_game
@
@ Create the game abstract data type
@ void *create_game(int rows, int cols)
@
create_game:
	push {r4-r8, lr}
  
  mov r4, r0    @ rows
  mov r5, r1    @ cols
	
  mov r0, #1
  mov r1, #game_size
  bl calloc     @ allocate

  @
  @ Set the data structure initial values
  @
  str r4,[r0,#game_rows]
  str r5,[r0,#game_cols]

  @ Save game pointer in a safe register
  mov r6, r0  @ game pointer

  @
  @ Allocate the game array
  @
  mul r0, r4, r5  @ row * cols
  mov r1,#cell_size @ Cell size
  bl calloc

  str r0,[r6,#game_array]

  mov r0,r6

create_game_done:
	pop {r4-r8, lr}
	bx lr
	
	
.global destroy_game
@
@ void destroy_game(void *game)
@ Destroy the game, freeing all memory
@
destroy_game:
	push {r4, lr}
	mov r4, r0
  ldr r0,[r0,#game_array]
  bl free
  mov r0, r4
  bl free
  pop {r4, lr}
	bx lr
	
.global get_rows
@
@ Get the number of rows in the game
@ int get_rows(void *game)
@
get_rows:
  push {lr}
  ldr r0,[r0,#game_rows]
  pop {lr}
  bx lr

.global get_cols
@
@ Get the number of columns in the game
@ int get_cols(void *game)
@
get_cols:
  push {lr}
  ldr r0,[r0,#game_cols]
  pop {lr}
  bx lr

.global display_game
@
@ Display the game
@
display_game:
	push {r4-r10,lr}
  mov r4, r0
  @ print the tab
  ldr r0,=tab
  bl printf

  ldr r9,[r4,#game_array]
  ldr r5,[r4,#game_rows]
  ldr r6,[r4,#game_cols]
  mov r7, #1 @row
  mov r8, #1 @col

col_num:
  @ Display the first row of col numbers
  cmp r8,r6
  movgt r8, #1  @reset col for inner_loop
  bgt print_newline  @ go to outer_loop once display all col nums
  ldr r0,=column
  mov r1, r8
  bl printf   @ print number
  add r8,#1   @ inc col num
  b col_num

print_newline:
  ldr r0,=newline
  bl printf
  b outer_loop

outer_loop:
  @ display the row nums
  cmp r7,r5
  bgt display_game_done @go to done once display whole grid
  ldr r0,=row
  mov r1,r7
  bl printf @ print row num

inner_loop:
  cmp r8,r6
  bgt reset @ if done all cols in row, reset vals
  mov r0, r4  
  mov r1, r7
  mov r2, r8
  bl game_index
  ldr r1,[r0,#cell_actual]    
  ldr r0,=item
  bl printf   @ print char in that cell
  add r8, #1
  b inner_loop  @ keep displaying each cell in the row

reset:
  ldr r0, =newline
  bl printf
  mov r8, #1  @Reset cell and row to go to next row
  add r7, #1
  b outer_loop

display_game_done:
	pop {r4-r10,lr}
	bx lr

.global set_cell_actual
@
@ int set_cell_actual(void *game, int row, int col, char ch);
@ Returns: 1 if the answer value is correct
@
set_cell_actual:
	push {r4-r8,lr}
  mov r4,r3
  bl game_index
  str r4, [r0,#cell_actual]
  ldr r5,[r0,#cell_expected]

  cmp r4,r5   
	moveq r0,#1
  movne r0,#0

set_cell_actual_done:
	pop {r4-r8,lr}
	bx lr

.global set_cell_expected
@
@ void set_cell_expected(void *game, int row, int col, char ch);
@
set_cell_expected:
	push {r4-r8,lr}
  mov r4, r3  @save ch in r4
  bl game_index
  str r4,[r0,#cell_expected]  @save ch in game  
	
	pop {r4-r8,lr}
	bx lr


.global game_win
@
@ int game_win(void *game)
@ Returns true when the game is done/won
@
game_win:
	push {r4-r10,lr}
  mov r4, r0
  ldr r5,[r4,#game_rows]
  ldr r6,[r4,#game_cols]
  mov r7, #1 @row
  mov r8, #1 @col

row_loop:
  cmp r7, r5  @ cmp row num w/ num of rows in game
  movgt r0,#1 @ if row num > then loop thru game, return true
  bgt game_win_done

col_loop:   
  cmp r8, r6  @ cmp col num w/ num of cols in game
  addgt r7, #1  @ if col num > then loop thru row, need to inc row
  movgt r8, #1  @ reset col num to 1
  bgt row_loop

  mov r0, r4
  mov r1, r7
  mov r2, r8
  bl game_index

  ldr r9,[r0,#cell_expected]
  ldr r10,[r0,#cell_actual]
  cmp r9,r10   @ compare cell actual and expected
  movne r0,#0 @ if not equal, return false
  bne game_win_done
  addeq r8, #1    @ if equal, inc col num and return to col loop
  beq col_loop
	
game_win_done:
	pop {r4-r10,lr}
	bx lr

.global game_index
@
@ int *game_index(void *game, int row, int col)
@ Get the address of a row and column in the cells
@	
game_index:
  @ array_address + (r*cols+c)*cell_size
  push {r4-r8, lr}
  @r3 is cols. r1 is r. r2 is c
  ldr r3,[r0,#game_cols]
  ldr r4,[r0,#game_array]

  @ Make zero offset
  sub r1, r1, #1
  sub r2, r2, #1
  
  @ Multiply row and col by cell_size
  mov r5,#cell_size
  mul r1, r1, r3
  add r1, r1, r2
  mul r1, r1, r5

  @ Add to address
  add r0, r1, r4

  pop {r4-r8, lr}
  bx lr
	
	
