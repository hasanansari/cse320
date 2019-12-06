
.text

.global sethex

@
@ int sethex(data, size, index, value)
@ Set's a 4 bit value, where index is assumed
@ to be an index to hex values in a string of 
@ data bytes. index=0 is the first 4 bits (most 
@ significant) and index=1 is the next 4 bits
@ (least significant)
@
sethex:
	stmfd sp!,{r4-r10,lr}
	
	@
	@ Save off parameters into safe registers
	@
	data .req r4
	mov data, r0
	size .req r5
	mov size, r1
	index .req r6
	mov index, r2
	value .req r7
	and value,r3,#0xf		@ Just to be sure!
	
	@ Compute the byte 
	byte .req r8
	lsr byte, index, #1	@ index/2
	
	@ Ensure index is valid
	cmp byte, size
	bge set_hex_done
	
	@ Load the byte
	ldrb r0,[data, byte]
	
	@ High or low?
	tst index,#1
	bne set_hex_low
	
	@ Set high part
  and r0,r0,#0xf
  lsl value, value, #4
	orr r0,r0,value
	strb r0,[data, byte]
	b set_hex_done
	
set_hex_low:
	and r0,r0,#0xf0
	orr r0,r0,value
	strb r0,[data, byte]
	b set_hex_done
	
set_hex_done:
	ldmfd sp!,{r4-r10,lr}
	bx lr


