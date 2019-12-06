@
@ Data section
@
.data

usage:  .asciz "Usage: sieve <size>\n";

minsize: .asciz "Sieve size must be at least 2\n"

primes: .asciz "Primes:"

return: .asciz "\n"

number: .asciz " %d"

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
    stmfd sp!,{r4-r8,lr}
    
    @if(argc<2)
    cmp r0,#2       @ Compare argc to 2
    bge args_ok     @ Branch if argc >= 2
    
    ldr r0,=usage   @ Get address of message
    bl printf       @ printf
    
    mov r0,#1       @ Return value: 1
    b main_return   @ return
    
args_ok:      
    ldr r0,[r1,#4]  @ Get argv[1]
    bl atoi         @ Convert to integer

    @if (size<2)    
    cmp r0, #2
    bge size_ok

    ldr r0,=minsize @"Sieve size must be at least 2\n";
    bl printf       @printf

    mov r0, #1      @Return value: 1
    b main_return   @return

size_ok:
    @make alias of size for r4
    size .req r4    @use r4 for size
    mov size, r0    @size

    @Allocate memory for the sieve
    @int *sieve = (int *)calloc(size+1, sizeof(int));
    add r0, size, #1    @r0 <- size+1
    mov r1, #4          @size of an int
    bl calloc           @calloc

    sieve .req r5
    mov r5, r0          @Save the result

    mov r0, sieve
    mov r1, size
    bl initialize       @initialize (sieve, size);
    
    mov r0, sieve
    mov r1, size
    bl sieve_it         @sieve_it(sieve, size);
    
    mov r0, sieve
    mov r1, size
    bl display          @display(sieve, size)

    @free memory
    @free(sieve);
    mov r0, sieve
    bl free             @free
    
    mov r0,#0

main_return:
    ldmfd sp!,{r4-r8,lr}
    bx lr

    @undo every .req for memory leak
    .unreq sieve
    .unreq size

@
@ display(int *sieve, int size)
@
display:
  stmfd sp!,{r4-r8,lr}

  size .req r4    @use r4 for size
  sieve .req r5   @use r5 for sieve

  mov sieve, r0
  mov size, r1

  ldr r0, =primes
  bl printf

  i .req r6       @i for loop
  mov i, #2

display_loop:
  cmp i, size
  bgt display_loop_end  @loop while i<=size

  lsl r7, i, #2   @i*4
  ldr r0, [sieve, r7] @sieve[i]
  cmp r0,#0       @ ==0?
  beq display_skip  @yes, skip

  @printf if sieve[i] != 0
  @printf(" %d", number)
  ldr r0,=number  @print i
  mov r1, i
  bl printf

display_skip:
  add i,#1        @i++
  b display_loop

display_loop_end:

  ldr r0,=return  @after for loop print "\n"
  bl printf

display_return:
  ldmfd sp!,{r4-r8,lr}
  bx lr

  .unreq sieve
  .unreq size
  .unreq i

@
@ Initialize(int *sieve, int size)
@

initialize:
  stmfd sp!,{r4-r8,lr}

  size .req r4    @use r4 for size
  sieve .req r5   @use r5 for sieve

  mov sieve, r0
  mov size, r1

  i .req r6       @i for loop
  mov i, #2

initialize_loop:
  cmp i, size
  bgt initialize_return  @loop while i<=size

  @sieve[i] = 1
  mov r0,#1
  lsl r7, i, #2   @i*4
  str r0, [sieve,r7]  
  
  add i,#1        @i++
  b initialize_loop

initialize_return:
  ldmfd sp!,{r4-r8,lr}
  bx lr

  .unreq sieve
  .unreq size
  .unreq i

@
@ Sieve_it(int *sieve, int size)
@
sieve_it:
  stmfd sp!,{r4-r8,lr}

  size .req r4    @use r4 for size
  sieve .req r5   @use r5 for sieve

  mov sieve, r0
  mov size, r1

  i .req r6       @i for loop
  mov i, #2

  j .req r7       @j for loop

sieve_loop:
  lsr r8, size, #1  @r8 is size/2
  cmp i,r8
  bgt sieve_return  @loop while i<= size/2

  mov j, i
  add j,j     @j = 2*1

  b j_loop

j_loop:
  cmp j, size
  bgt inc_i  @loop while j<=size

  @sieve[j]=0
  mov r0,#0
  lsl r8, j, #2     @j*4
  str r0, [sieve,r8]
  
  add j,j,i          @j+= 1
  b j_loop

inc_i:
  add i,#1    @i++
  b sieve_loop

sieve_return:
  ldmfd sp!,{r4-r8,lr}
  bx lr

  .unreq sieve
  .unreq size
  .unreq i
  .unreq j
