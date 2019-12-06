	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"letter.c"
	.section	.rodata
	.align	2
.LC46:
	.ascii	"Your name: \000"
	.align	2
.LC47:
	.ascii	"Recipient name: \000"
	.align	2
.LC48:
	.ascii	"\012Dear %s,\012\012\000"
	.align	2
.LC49:
	.ascii	"\012\012Love,\012%s\012\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	str	r0, [fp, #-112]
	str	r1, [fp, #-116]
	mov	r0, #0
	bl	time
	mov	r3, r0
	mov	r0, r3
	bl	srand
	ldr	r0, .L3
	bl	printf
	ldr	r3, .L3+4
	ldr	r2, [r3]
	sub	r3, fp, #56
	mov	r1, #50
	mov	r0, r3
	bl	fgets
	sub	r3, fp, #56
	mov	r0, r3
	bl	trim_newline
	ldr	r0, .L3+8
	bl	printf
	ldr	r3, .L3+4
	ldr	r2, [r3]
	sub	r3, fp, #108
	mov	r1, #50
	mov	r0, r3
	bl	fgets
	sub	r3, fp, #108
	mov	r0, r3
	bl	trim_newline
	sub	r3, fp, #108
	mov	r1, r3
	ldr	r0, .L3+12
	bl	printf
	mov	r0, #10
	bl	generate_letter
	sub	r3, fp, #56
	mov	r1, r3
	ldr	r0, .L3+16
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L4:
	.align	2
.L3:
	.word	.LC46
	.word	stdin
	.word	.LC47
	.word	.LC48
	.word	.LC49
	.size	main, .-main
	.align	2
	.global	trim_newline
	.syntax unified
	.arm
	.fpu vfp
	.type	trim_newline, %function
trim_newline:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r0, [fp, #-16]
	bl	strlen
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	beq	.L8
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #10
	bne	.L5
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	ldr	r2, [fp, #-16]
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3]
	b	.L5
.L8:
	nop
.L5:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	trim_newline, .-trim_newline
	.global	__aeabi_idivmod
	.section	.rodata
	.align	2
.LC51:
	.ascii	" \000"
	.align	2
.LC52:
	.ascii	"%s \000"
	.align	2
.LC0:
	.ascii	"I love you with all my heart.\000"
	.align	2
.LC1:
	.ascii	"If I don't see you again soon I'm a gonna die!\000"
	.align	2
.LC2:
	.ascii	"Just as Darth Vader, an evil Sith Lord, could not l"
	.ascii	"eave his son to die, nor shall I ever leave you.\000"
	.align	2
.LC3:
	.ascii	"I love you more than Sparty.\000"
	.align	2
.LC4:
	.ascii	"When you are away, my toes ache.\000"
	.align	2
.LC5:
	.ascii	"I would rob a convenience store for you.\000"
	.align	2
.LC6:
	.ascii	"Every minute you are away seems like 17.53 hours.\000"
	.align	2
.LC7:
	.ascii	"You are the hamster to my wheel.\000"
	.align	2
.LC8:
	.ascii	"You are the Style to my Gangnum.\000"
	.align	2
.LC9:
	.ascii	"When I smell flowers, I think of you, but only if t"
	.ascii	"he flowers smell really good.\000"
	.align	2
.LC10:
	.ascii	"Every day we are apart an angel loses a wing.\000"
	.align	2
.LC11:
	.ascii	"I love you more than Tony loved Elvira.\000"
	.align	2
.LC12:
	.ascii	"Would you kiss me if I wear the hat?\000"
	.align	2
.LC13:
	.ascii	"Where've you been? It's 10:00, honey, I'm starving!"
	.ascii	"\000"
	.align	2
.LC14:
	.ascii	"I like you better than better.\000"
	.align	2
.LC15:
	.ascii	"When I look at you the ice melts in my drink.\000"
	.align	2
.LC16:
	.ascii	"Our love will last longer than a cell phone contrac"
	.ascii	"t.\000"
	.align	2
.LC17:
	.ascii	"You are the cheese on my pepperoni pizza.\000"
	.align	2
.LC18:
	.ascii	"Roses are red, violets are blue, Sparty is awesome,"
	.ascii	" and so are you.\000"
	.align	2
.LC19:
	.ascii	"When I saw you had ears, I knew you would be mine.\000"
	.align	2
.LC20:
	.ascii	"If I was in one of those movies, I would saw off a "
	.ascii	"foot for you.\000"
	.align	2
.LC21:
	.ascii	"Love means never having to say that love means neve"
	.ascii	"r having to say you're sorry.\000"
	.align	2
.LC22:
	.ascii	"I love you so much it's creepy sometimes.\000"
	.align	2
.LC23:
	.ascii	"I dream every day of your beautiful <insert color h"
	.ascii	"ere> eyes.\000"
	.align	2
.LC24:
	.ascii	"I will stand by you even when you smell really bad."
	.ascii	"\000"
	.align	2
.LC25:
	.ascii	"I am the minion to your villianry.\000"
	.align	2
.LC26:
	.ascii	"Together we are like Luke and Leia, before they fou"
	.ascii	"nd out they are brother and sister and it got creep"
	.ascii	"y.\000"
	.align	2
.LC27:
	.ascii	"You make me sing like a caged bird.\000"
	.align	2
.LC28:
	.ascii	"You are my Neo in the matrix of life.\000"
	.align	2
.LC29:
	.ascii	"We are like Norman and Marion, except for the ones "
	.ascii	"in Psycho.\000"
	.align	2
.LC30:
	.ascii	"You had me at hello.\000"
	.align	2
.LC31:
	.ascii	"I would go to sea and fight Jaws with some really a"
	.ascii	"nnoying people if you asked me to.\000"
	.align	2
.LC32:
	.ascii	"You are my monolyth.\000"
	.align	2
.LC33:
	.ascii	"You'll always be a T1000 model to my lowly T800.\000"
	.align	2
.LC34:
	.ascii	"I would chop off the black knights arm just for you"
	.ascii	".\000"
	.align	2
.LC35:
	.ascii	"Our love will survive, even after I've been turned "
	.ascii	"into a newt.\000"
	.align	2
.LC36:
	.ascii	"My broken heart is only a flesh wound.\000"
	.align	2
.LC37:
	.ascii	"I would walk the desert while the Lawrence of Arabi"
	.ascii	"a soundtrack loudly plays if you asked.\000"
	.align	2
.LC38:
	.ascii	"Let us grow old together as prisoners on Devil's is"
	.ascii	"land until we can escape on bags of coconuts.\000"
	.align	2
.LC39:
	.ascii	"Let me be the Muriel to your Macon, but can we plea"
	.ascii	"se leave Sarah out of this?\000"
	.align	2
.LC40:
	.ascii	"My face in thine eye, thine in mine appears, and tr"
	.ascii	"ue plain hearts do in three faces rest.\000"
	.align	2
.LC41:
	.ascii	"You have a face like Vulnavia, at least before the "
	.ascii	"acid messed it up.\000"
	.align	2
.LC42:
	.ascii	"Is this real life?\000"
	.align	2
.LC43:
	.ascii	"I wish you were a Cylon so there could be even more"
	.ascii	" copies of you out there.\000"
	.align	2
.LC44:
	.ascii	"I will make you an offer you can't refuse.\000"
	.align	2
.LC50:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC43
	.word	.LC44
	.text
	.align	2
	.global	generate_letter
	.syntax unified
	.arm
	.fpu vfp
	.type	generate_letter, %function
generate_letter:
	@ args = 0, pretend = 0, frame = 416
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #416
	str	r0, [fp, #-416]
	ldr	r2, .L19
	sub	r3, fp, #212
	mov	r1, r2
	mov	r2, #180
	mov	r0, r3
	bl	memcpy
	mov	r3, #0
	strb	r3, [fp, #-213]
	mov	r3, #45
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-20]
	mov	r1, #4
	mov	r0, r3
	bl	calloc
	mov	r3, r0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L10
.L11:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [fp, #-8]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L10:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	blt	.L11
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L12
.L13:
	bl	rand
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-8]
	sub	r3, r2, r3
	sub	r3, r3, #1
	mov	r1, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	mov	r2, r3
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	add	r3, r3, #1
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [fp, #-28]
	lsl	r2, r2, #2
	ldr	r1, [fp, #-24]
	add	r2, r1, r2
	ldr	r2, [r2]
	str	r2, [r3]
	ldr	r3, [fp, #-28]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r2, [fp, #-32]
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L12:
	ldr	r3, [fp, #-20]
	sub	r2, r3, #1
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bgt	.L13
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L14
.L18:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-24]
	add	r3, r2, r3
	ldr	r3, [r3]
	lsl	r3, r3, #2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldr	r1, [r3, #-208]
	sub	r3, fp, #412
	mov	r2, #199
	mov	r0, r3
	bl	strncpy
	sub	r3, fp, #412
	ldr	r1, .L19+4
	mov	r0, r3
	bl	strtok
	str	r0, [fp, #-16]
	b	.L15
.L17:
	ldr	r1, [fp, #-16]
	ldr	r0, .L19+8
	bl	printf
	ldr	r0, [fp, #-16]
	bl	strlen
	mov	r2, r0
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	add	r3, r3, #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #60
	ble	.L16
	mov	r0, #10
	bl	putchar
	mov	r3, #0
	str	r3, [fp, #-12]
.L16:
	ldr	r1, .L19+4
	mov	r0, #0
	bl	strtok
	str	r0, [fp, #-16]
.L15:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L17
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L14:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-416]
	cmp	r2, r3
	blt	.L18
	ldr	r0, [fp, #-24]
	bl	free
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L20:
	.align	2
.L19:
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.size	generate_letter, .-generate_letter
	.ident	"GCC: (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",%progbits
