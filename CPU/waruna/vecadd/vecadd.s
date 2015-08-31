	.file	"vecadd_malloc.c"
	.text
	.p2align 4,,15
	.globl	oneThread
	.type	oneThread, @function
oneThread:
.LFB660:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$3840, %edx
	movl	$16, %esi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsp, %rdi
	call	posix_memalign
	testl	%eax, %eax
	cmove	(%rsp), %rbx
	movl	$3840, %edx
	movl	$16, %esi
	movq	%rsp, %rdi
	xorl	%ebp, %ebp
	call	posix_memalign
	movl	$3840, %edx
	movq	%rsp, %rdi
	movl	$16, %esi
	testl	%eax, %eax
	cmove	(%rsp), %rbp
	xorl	%r12d, %r12d
	call	posix_memalign
	testl	%eax, %eax
	cmove	(%rsp), %r12
	testb	$1, %bl
	movq	%rbx, %rdi
	movl	$3840, %edx
	jne	.L36
	testb	$2, %dil
	jne	.L37
.L6:
	testb	$4, %dil
	jne	.L38
.L7:
	movl	%edx, %ecx
	movabsq	$72340172838076673, %rax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L8
	movl	$16843009, (%rdi)
	addq	$4, %rdi
.L8:
	testb	$2, %dl
	je	.L9
	movw	$257, (%rdi)
	addq	$2, %rdi
.L9:
	andl	$1, %edx
	je	.L10
	movb	$1, (%rdi)
.L10:
	testb	$1, %bpl
	movq	%rbp, %rdi
	movl	$3840, %edx
	jne	.L39
	testb	$2, %dil
	jne	.L40
.L12:
	testb	$4, %dil
	jne	.L41
.L13:
	movl	%edx, %ecx
	movabsq	$144680345676153346, %rax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L14
	movl	$33686018, (%rdi)
	addq	$4, %rdi
.L14:
	testb	$2, %dl
	je	.L15
	movw	$514, (%rdi)
	addq	$2, %rdi
.L15:
	andl	$1, %edx
	je	.L16
	movb	$2, (%rdi)
.L16:
	testb	$1, %r12b
	movq	%r12, %rdi
	movl	$3840, %edx
	jne	.L42
	testb	$2, %dil
	jne	.L43
.L18:
	testb	$4, %dil
	jne	.L44
.L19:
	movl	%edx, %ecx
	xorl	%eax, %eax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L20
	movl	$0, (%rdi)
	addq	$4, %rdi
.L20:
	testb	$2, %dl
	je	.L21
	movw	$0, (%rdi)
	addq	$2, %rdi
.L21:
	andl	$1, %edx
	je	.L22
	movb	$0, (%rdi)
.L22:
	movl	reps(%rip), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	.L24
	.p2align 4,,10
	.p2align 3
.L31:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L25:
	movdqa	(%rbx,%rax), %xmm7
	movdqa	16(%rbx,%rax), %xmm6
	paddd	0(%rbp,%rax), %xmm7
	movdqa	32(%rbx,%rax), %xmm5
	paddd	16(%rbp,%rax), %xmm6
	movdqa	48(%rbx,%rax), %xmm4
	paddd	32(%rbp,%rax), %xmm5
	movdqa	64(%rbx,%rax), %xmm3
	paddd	48(%rbp,%rax), %xmm4
	movdqa	80(%rbx,%rax), %xmm2
	paddd	64(%rbp,%rax), %xmm3
	movdqa	96(%rbx,%rax), %xmm1
	paddd	80(%rbp,%rax), %xmm2
	movdqa	112(%rbx,%rax), %xmm0
	paddd	96(%rbp,%rax), %xmm1
	paddd	112(%rbp,%rax), %xmm0
	movdqa	%xmm7, (%r12,%rax)
	movdqa	%xmm6, 16(%r12,%rax)
	movdqa	%xmm5, 32(%r12,%rax)
	movdqa	%xmm4, 48(%r12,%rax)
	movdqa	%xmm3, 64(%r12,%rax)
	movdqa	%xmm2, 80(%r12,%rax)
	movdqa	%xmm1, 96(%r12,%rax)
	movdqa	%xmm0, 112(%r12,%rax)
	subq	$-128, %rax
	cmpq	$3840, %rax
	jne	.L25
	addl	$1, %edx
	cmpl	%edx, reps(%rip)
	jg	.L31
.L24:
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	.p2align 4,,10
	.p2align 3
.L26:
	addl	(%r12,%rax), %r13d
	addq	$16, %rax
	cmpq	$3840, %rax
	jne	.L26
	movq	%rbx, %rdi
	call	free
	movq	%rbp, %rdi
	call	free
	movq	%r12, %rdi
	call	free
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	%r13d, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L36:
	.cfi_restore_state
	leaq	1(%rbx), %rdi
	movb	$1, (%rbx)
	movw	$3839, %dx
	testb	$2, %dil
	je	.L6
.L37:
	movw	$257, (%rdi)
	addq	$2, %rdi
	subl	$2, %edx
	testb	$4, %dil
	je	.L7
.L38:
	movl	$16843009, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L7
.L39:
	leaq	1(%rbp), %rdi
	movb	$2, 0(%rbp)
	movw	$3839, %dx
	testb	$2, %dil
	je	.L12
.L40:
	movw	$514, (%rdi)
	addq	$2, %rdi
	subl	$2, %edx
	testb	$4, %dil
	je	.L13
.L41:
	movl	$33686018, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L13
.L42:
	leaq	1(%r12), %rdi
	movb	$0, (%r12)
	movw	$3839, %dx
	testb	$2, %dil
	je	.L18
.L43:
	movw	$0, (%rdi)
	addq	$2, %rdi
	subl	$2, %edx
	testb	$4, %dil
	je	.L19
.L44:
	movl	$0, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L19
	.cfi_endproc
.LFE660:
	.size	oneThread, .-oneThread
	.p2align 4,,15
	.globl	mykernel
	.type	mykernel, @function
mykernel:
.LFB659:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%edi, %edi
	call	oneThread
	movq	sum(%rip), %rdx
	movl	%eax, (%rdx)
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE659:
	.size	mykernel, .-mykernel
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f REPS: %d BW: %.2f BW1: %.2f\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"sum: %d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB658:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	cmpl	$1, %edi
	movl	$1, tds(%rip)
	jle	.L47
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	cmpl	$2, %ebx
	movl	%eax, tds(%rip)
	je	.L47
	movq	16(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, reps(%rip)
.L47:
	movslq	tds(%rip), %rdi
	salq	$2, %rdi
	call	malloc
	movq	%rax, sum(%rip)
	call	initialize_timer
	call	start_timer
	xorl	%edi, %edi
	call	mykernel
	call	stop_timer
	call	elapsed_time
	movsd	%xmm0, (%rsp)
	call	reset_timer
	call	start_timer
	xorl	%edi, %edi
	call	mykernel
	call	stop_timer
	call	elapsed_time
	movl	reps(%rip), %r8d
	movl	tds(%rip), %edx
	movl	$.LC4, %esi
	movapd	%xmm0, %xmm2
	movq	stdout(%rip), %rdi
	movsd	(%rsp), %xmm6
	movl	$960, %ecx
	cvtsi2sd	%r8d, %xmm4
	movl	$6, %eax
	cvtsi2sd	%edx, %xmm0
	movsd	.LC3(%rip), %xmm7
	mulsd	.LC0(%rip), %xmm4
	movapd	%xmm4, %xmm1
	mulsd	.LC1(%rip), %xmm4
	mulsd	%xmm0, %xmm1
	mulsd	.LC2(%rip), %xmm4
	movapd	%xmm1, %xmm3
	divsd	%xmm6, %xmm1
	mulsd	%xmm0, %xmm4
	movapd	%xmm6, %xmm0
	divsd	%xmm2, %xmm3
	movapd	%xmm4, %xmm5
	divsd	%xmm6, %xmm4
	divsd	%xmm2, %xmm5
	divsd	%xmm7, %xmm4
	divsd	%xmm7, %xmm5
	divsd	%xmm7, %xmm3
	divsd	%xmm7, %xmm1
	call	fprintf
	movl	$mykernel, %edi
	call	my_papi_profile
	movl	tds(%rip), %edi
	xorl	%esi, %esi
	testl	%edi, %edi
	jle	.L48
	movq	sum(%rip), %r9
	movq	%r9, %rcx
	movq	%r9, %rdx
	andl	$15, %ecx
	shrq	$2, %rcx
	negq	%rcx
	andl	$3, %ecx
	cmpl	%edi, %ecx
	cmova	%edi, %ecx
	testl	%ecx, %ecx
	movl	%ecx, %ebx
	je	.L57
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L50:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%ecx, %eax
	jb	.L50
	cmpl	%ecx, %edi
	je	.L48
.L49:
	movl	%edi, %r11d
	subl	%ecx, %r11d
	movl	%r11d, %r8d
	shrl	$2, %r8d
	leal	0(,%r8,4), %r10d
	testl	%r10d, %r10d
	je	.L52
	pxor	%xmm0, %xmm0
	leaq	(%r9,%rbx,4), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L53:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%r8d, %edx
	jb	.L53
	movdqa	%xmm0, %xmm1
	addl	%r10d, %eax
	psrldq	$8, %xmm1
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	pextrd	$0, %xmm0, %edx
	addl	%edx, %esi
	cmpl	%r10d, %r11d
	je	.L48
.L52:
	movslq	%eax, %rdx
	leaq	(%r9,%rdx,4), %rdx
	.p2align 4,,10
	.p2align 3
.L55:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%eax, %edi
	jg	.L55
.L48:
	movl	$.LC5, %edi
	xorl	%eax, %eax
	call	printf
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L57:
	.cfi_restore_state
	movl	%ecx, %esi
	xorl	%eax, %eax
	jmp	.L49
	.cfi_endproc
.LFE658:
	.size	main, .-main
	.comm	reps,4,16
	.comm	tds,4,16
	.comm	sum,8,16
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1083047936
	.align 8
.LC1:
	.long	0
	.long	1074266112
	.align 8
.LC2:
	.long	0
	.long	1074790400
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
