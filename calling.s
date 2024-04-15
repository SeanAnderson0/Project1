	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"calling.c"
	.text
	.syntax divided
	


@ ============================
@ Bill's glue logic for ARMsim
@ ============================
swi_open:        swi   0x66
                 mov   pc, lr

swi_close:       swi   0x68
                 mov   pc, lr

swi_read:        swi   0x6a
                 mov   pc, lr

swi_write:       swi   0x69	@ Write string to stdout
                 mov   pc, lr


	.arm
	.syntax unified
	.comm	data,43,4
	.comm	expanded,161,4
	.comm	outstring,42,4
	.section	.rodata
	.align	2
.LC0:
	.ascii	"\\Users\\Student\\Desktop\\T2DATA.TXT\000"
	.text
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r1, #0
	ldr	r0, .L7
	bl	swi_open
	str	r0, [fp, #-12]
	b	.L2
.L5:
	ldr	r1, .L7+4
	ldr	r0, .L7+8
	bl	expand
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L3
.L4:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r1, .L7+4
	mov	r0, r3
	bl	byte_at
	mov	r3, r0
	mov	r1, r3
	ldr	r2, .L7+12
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	mov	r2, r1
	strb	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L3:
	ldr	r3, [fp, #-8]
	cmp	r3, #38
	ble	.L4
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	ldr	r2, .L7+12
	mov	r1, #10
	strb	r1, [r2, r3]
	ldr	r3, [fp, #-8]
	add	r2, r3, #1
	str	r2, [fp, #-8]
	ldr	r2, .L7+12
	mov	r1, #0
	strb	r1, [r2, r3]
	ldr	r1, .L7+12
	mov	r0, #1
	bl	swi_write
.L2:
	mov	r2, #43
	ldr	r1, .L7+8
	ldr	r0, [fp, #-12]
	bl	swi_read
	mov	r3, r0
	cmp	r3, #39
	bgt	.L5
	ldr	r0, [fp, #-12]
	bl	swi_close
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.word	expanded
	.word	data
	.word	outstring
	.size	main, .-main
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 8-2018-q4-major) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
