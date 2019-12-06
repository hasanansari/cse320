.text

.global digitcounter

/**
 * unsigned int digitcounter(unsigned int value)
 * Returns the number of digits in the value
 */
digitcounter:
    stmfd sp!,{lr}

    @local variables
    .equ quotient, 0
    .equ remainder, 4
    .equ value, 8
    .equ counter, 12
    .equ size, 16

    sub sp, sp, #size   @Allocate space
    
    @Save value as local variable
    str r0,[sp,#value]

    @Variable we will compute the size in
    mov r1, #0
    str r1, [sp,#counter]

digitcounter_loop:
    ldr r0,[sp,#value]
    movs r0,r0
    beq digitcounter_done

    ldr r0,[sp,#counter]
    add r0, r0, #1
    str r0, [sp,#counter]

    add r0, sp, #quotient
    ldr r1, [sp,#value]
    mov r2, #10
    bl div

    ldr r0, [sp,#quotient]
    str r0, [sp,#value]
    b digitcounter_loop

digitcounter_done:
    ldr r0, [sp,#counter]
    add sp, sp, #size   @Free space
    ldmfd sp!,{lr}
    bx lr
