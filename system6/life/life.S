.text
.global life

@
@ life iteration calculator
@ r0 - int *cells
@ r1 - int width in words
@ r2 - int height in rows
@

life:
    stmfd sp!,{r4-r10,lr}
    
    @Save variables
    mov r4, r0
    mov r5, r1
    mov r6, r2

    @Make cells2 r0
    mul r0, r6, r5
    
    mov r1, #4
    bl calloc
    @make r10 cells2
    mov r10, r0

    @make r7 width*height*32
    mov r7, #32
    mul r7, r7, r5
    mul r7, r7, r6

    @r9 is counter to det. set_bit
    mov r9, #0

    @i = r8
    mov r8, #0
    b loop

loop:
    @break if i >= width*height*32
    cmp r8, r7
    movge r8, #0
    bge copy_loop

    @get_bit returns 1 or 0 into r0
    @r0 is address of cells
    @r1 is width*height
    @r2 is third param depending on position

    @left = i-1
    mov r2, r8
    sub r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0  

    @right = i+1
    mov r2, r8
    add r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0

    @above = i-width*32
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    sub r2, r2, r0
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0

    @upper left = i-width*32-1
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    sub r2, r2, r0
    sub r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0

    @upper right = i-width*32+1
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    sub r2, r2, r0
    add r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0

    @lower left = i+width*32-1
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    add r2, r2, r0
    sub r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0

    @below = i+width*32
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    add r2, r2, r0
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0
    
    @lower right = i+width*32+1
    mov r2, r8
    mov r0, r5
    lsl r0, r0, #5
    add r2, r2, r0
    add r2, #1
    mov r0, r4
    mul r1, r5, r6
    bl get_bit
    add r9, r9, r0
    
    @r9 is number of neighbors
    @if less than 2 neighbors, set bit to 0
    cmp r9, #2
    blt zero

    @if 2 neighbors, dont change bit (still set but keep same)
    beq same

    @if more than 3 neighbors, set bit to 0
    cmp r9, #3
    bgt zero

    @if 3 neighbors, set bit to 1
    beq set_one

zero:
    @ro is cells2
    mov r0, r10
    @r1 is width*height
    mul r1, r5, r6
    @r2 is i
    mov r2, r8
    @r3 is what set bit to
    mov r3, #0
    bl set_bit
    
    b inc_i

set_one:
    @same params as zero but 1 for what set bit to
    mov r0, r10
    mul r1, r5, r6
    mov r2, r8
    mov r3, #1
    bl set_bit
    b inc_i

same:
    @first get bit at i in cells
    mov r0, r4
    mul r1, r5, r6
    mov r2, r8
    bl get_bit
    mov r3, r0

    @set bit at i in cells2 to be i in cells
    mov r0, r10
    mul r1, r5, r6
    mov r2, r8
    bl set_bit
    b inc_i

inc_i:
    @inc i and reset the counter
    mov r9, #0
    add r8, #1
    b loop

copy_loop:
    @loop to copy from cells2 to cells
    mul r7, r5, r6
    @r8 is counter, compare to w*h
    cmp r8, r7
    beq done

    @set r9 to bit*4
    lsl r9, r8, #2
    @load cells2 then store in cells
    ldr r0,[r10,r9]
    str r0,[r4,r9]
    @inc counter
    add r8, #1
    b copy_loop

done:
    @free cells2
    mov r0, r10
    bl free
    @mov cells
    mov r0, r4
    ldmfd sp!,{r4-r10,lr}
    bx lr
