	.file	"testSSE4L1.2.c"
	.text
	.p2align 4,,15
	.globl	oneThread
	.type	oneThread, @function
oneThread:
.LFB659:
	.cfi_startproc
	subq	$44296, %rsp
	.cfi_def_cfa_offset 44304
	movl	$44288, %edx
	xorl	%esi, %esi
	movq	%rsp, %rdi
	call	memset
	pxor	%xmm5, %xmm5
	movl	$5780346, %r8d
	movdqa	.LC0(%rip), %xmm0
	movdqa	%xmm5, %xmm6
	movdqa	%xmm5, %xmm7
	movdqa	%xmm5, %xmm8
	.p2align 4,,10
	.p2align 3
.L2:
	movl	$11040, %eax
	.p2align 4,,10
	.p2align 3
.L3:
	leaq	(%rsp,%rax,4), %rdi
	leaq	16(%rsp,%rax,4), %rsi
	leaq	32(%rsp,%rax,4), %rcx
	leaq	48(%rsp,%rax,4), %rdx
	paddd	%xmm0, %xmm8
	paddd	%xmm0, %xmm7
	movdqa	(%rdi), %xmm1
	paddd	%xmm0, %xmm6
	paddd	%xmm0, %xmm5
	movdqa	(%rsi), %xmm4
	pmaxsd	%xmm1, %xmm8
	paddd	%xmm0, %xmm1
	movdqa	(%rcx), %xmm3
	pmaxsd	%xmm4, %xmm7
	paddd	%xmm0, %xmm4
	movdqa	(%rdx), %xmm2
	pmaxsd	%xmm3, %xmm6
	paddd	%xmm0, %xmm3
	movdqa	%xmm8, 64(%rsp,%rax,4)
	pmaxsd	%xmm2, %xmm5
	paddd	%xmm0, %xmm2
	movdqa	%xmm7, 80(%rsp,%rax,4)
	movdqa	%xmm6, 96(%rsp,%rax,4)
	movdqa	%xmm5, 112(%rsp,%rax,4)
	movdqa	-64(%rsp,%rax,4), %xmm8
	movdqa	-48(%rsp,%rax,4), %xmm7
	pmaxsd	%xmm8, %xmm1
	movdqa	-32(%rsp,%rax,4), %xmm6
	pmaxsd	%xmm7, %xmm4
	movdqa	-16(%rsp,%rax,4), %xmm5
	subq	$32, %rax
	pmaxsd	%xmm6, %xmm3
	movdqa	%xmm1, (%rdi)
	pmaxsd	%xmm5, %xmm2
	movdqa	%xmm4, (%rsi)
	movdqa	%xmm3, (%rcx)
	movdqa	%xmm2, (%rdx)
	jne	.L3
	subl	$1, %r8d
	pminsd	%xmm1, %xmm0
	jne	.L2
	pxor	%xmm0, %xmm0
	leaq	44288(%rsp), %rdx
	movq	%rsp, %rax
	.p2align 4,,10
	.p2align 3
.L5:
	paddd	(%rax), %xmm0
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L5
	movdqa	%xmm0, %xmm1
	addq	$44296, %rsp
	.cfi_def_cfa_offset 8
	psrldq	$8, %xmm1
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	pextrd	$0, %xmm0, %eax
	ret
	.cfi_endproc
.LFE659:
	.size	oneThread, .-oneThread
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
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
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	$1, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	cmpl	$1, %edi
	jle	.L10
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, %ebx
.L10:
	movslq	%ebx, %rdi
	salq	$2, %rdi
	call	malloc
	movq	%rax, %rbp
	call	initialize_timer
	call	start_timer
	xorl	%edi, %edi
	call	oneThread
	movl	%eax, 0(%rbp)
	call	stop_timer
	call	elapsed_time
	cvtsi2sd	%ebx, %xmm1
	movq	stdout(%rip), %rdi
	movl	$.LC3, %esi
	movl	$11072, %ecx
	movl	%ebx, %edx
	movl	$2, %eax
	mulsd	.LC1(%rip), %xmm1
	divsd	%xmm0, %xmm1
	divsd	.LC2(%rip), %xmm1
	call	fprintf
	xorl	%esi, %esi
	testl	%ebx, %ebx
	jle	.L11
	movq	%rbp, %rcx
	movq	%rbp, %rdx
	andl	$15, %ecx
	shrq	$2, %rcx
	negq	%rcx
	andl	$3, %ecx
	cmpl	%ebx, %ecx
	cmova	%ebx, %ecx
	testl	%ecx, %ecx
	movl	%ecx, %r10d
	je	.L21
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L13:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%ecx, %eax
	jb	.L13
	cmpl	%ecx, %ebx
	je	.L11
.L12:
	movl	%ebx, %r9d
	subl	%ecx, %r9d
	movl	%r9d, %edi
	shrl	$2, %edi
	leal	0(,%rdi,4), %r8d
	testl	%r8d, %r8d
	je	.L15
	pxor	%xmm0, %xmm0
	leaq	0(%rbp,%r10,4), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L16:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%edi, %edx
	jb	.L16
	movdqa	%xmm0, %xmm1
	addl	%r8d, %eax
	psrldq	$8, %xmm1
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	pextrd	$0, %xmm0, %edx
	addl	%edx, %esi
	cmpl	%r8d, %r9d
	je	.L11
.L15:
	movslq	%eax, %rdx
	leaq	0(%rbp,%rdx,4), %rdx
	.p2align 4,,10
	.p2align 3
.L18:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%eax, %ebx
	jg	.L18
.L11:
	movl	$.LC4, %edi
	xorl	%eax, %eax
	call	printf
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	movl	%ecx, %esi
	xorl	%eax, %eax
	jmp	.L12
	.cfi_endproc
.LFE658:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	8589934593
	.quad	4294967298
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	3665821696
	.long	1109243735
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
