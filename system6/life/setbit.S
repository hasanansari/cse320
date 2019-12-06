.text
.global set_bit

@
@ r0 - Array of integers
@ r1 - Size of the array
@ r2 - Desired bit
@ r3 - Non-zero to set
@
set_bit:
    stmfd sp!,{r4-r8,lr}
    @dont overwrite r3
    mov r4, r3

    @r3 is (32*r1)-1
    lsl r3, r1, #5
    sub r3, #1

    cmp r2, r3
    bgt done

    cmp r2, #0
    blt done

    @get the word and load it into r3
    lsr r3, r2, #5
    add r3, r3, r3
    add r3, r3, r3
    add r3, r0, r3
    ldr r6, [r3]

    @get bit
    and r2, r2, #31

    @31-bit
    rsb r2, r2, #31

    cmp r4, #0
    bne not_equal
    b equal

equal:
    mov r1, #1
    lsl r1, r1, r2
    bic r7, r6, r1
    str r7, [r3]
    b done

not_equal:
    mov r1, #1
    lsl r1, r1, r2
    orr r7, r6, r1
    str r7, [r3]
    b done

done:
    ldmfd sp!,{r4-r8,lr}
    bx lr
    
