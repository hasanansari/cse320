.text

.global gethex

@
@ int gethex(data, size, index)
@ Get's a 4 bit value, where index is assumed
@ to be an index to hex values in a string of 
@ data bytes. index=0 is the first 4 bits (most 
@ significant) and index=1 is the next 4 bits
@ (least significant)
@
gethex:
	stmfd sp!,{r4-r10,lr}
	
	@
	@ Save off parameters into safe registers
	@
	data .req r4
	mov data, r0
	size .req r5
	mov size, r1
	index .req r6
	movs index, r2
  bmi get_hex_zero
	
	@ Compute the byte 
	byte .req r7
	lsr byte, index, #1	@ index/2

  @ Ensure we are in range
  cmp byte, size
  bge get_hex_zero

	@ Load the byte
	ldrb r0,[data, byte]
	
	@ High or low?
	tst index,#1
	bne get_hex_low
	
	@ Get high part
	lsr r0,r0,#4	
	b get_hex_done
	
get_hex_low:
	and r0,r0,#0xf
  b get_hex_done

get_hex_zero:
	mov r0,#0
	
get_hex_done:
	ldmfd sp!,{r4-r10,lr}
	bx lr


