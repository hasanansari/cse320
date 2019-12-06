.text
.global get_bit

@
@ r0 - Array of integers
@ r1 - Size of the array
@ r2 - Desired bit
@
get_bit:
    stmfd sp!,{r4-r8,lr}
    
    @cmp r2, (r1*32-1)
    lsl r3, r1, #5
    sub r3, #1

    cmp r2, r3
    bgt zero

    cmp r2, #0
    blt zero

    @make r4 = r2/32 (the word)
    lsr r4, r2, #5
    add r4, r4, r4
    add r4, r4, r4
    add r0, r0, r4
    @load array
    ldr r4, [r0]

    @make r5 = r2 % 32 (the bit)
    and r5, r2, #31

    @shift the array
    rsb r7, r5, #31
    lsr r4, r4, r7

    @AND with 1 then return
    and r4, r4, #1
    mov r0, r4
    b done

zero: 
    mov r0, #0
    b done

done:
    ldmfd sp!,{r4-r8,lr}
    bx lr
