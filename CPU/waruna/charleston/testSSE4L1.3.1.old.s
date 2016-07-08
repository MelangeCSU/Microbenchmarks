	.file	"testSSE4L1.3.1.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"WARNING: Thread: %d has not allocated 16 aligned memory!"
	.text
	.p2align 4,,15
	.globl	oneThread
	.type	oneThread, @function
oneThread:
.LFB659:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	%esi, %eax
	addl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movq	%rcx, 80(%rsp)
	movslq	%edx, %rcx
	leaq	104(%rsp), %rdi
	movq	%rcx, %rbx
	movl	%esi, 64(%rsp)
	movl	%edx, 48(%rsp)
	salq	$2, %rbx
	movl	$16, %esi
	movl	%eax, 24(%rsp)
	movq	%rbx, %rdx
	movq	%rcx, 88(%rsp)
	movdqa	%xmm10, (%rsp)
	call	posix_memalign
	testl	%eax, %eax
	movdqa	(%rsp), %xmm10
	jne	.L2
	movq	104(%rsp), %r8
	xorl	%esi, %esi
	movq	%rbx, %rdx
	movq	%r8, %rdi
	movq	%r8, 56(%rsp)
	call	memset
	testb	$15, 56(%rsp)
	movdqa	(%rsp), %xmm10
	je	.L3
	movl	%ebp, %esi
	movl	$.LC1, %edi
	xorl	%eax, %eax
	call	printf
	movdqa	(%rsp), %xmm10
.L3:
	movl	48(%rsp), %eax
	subl	64(%rsp), %eax
	movq	56(%rsp), %rdx
	movl	64(%rsp), %ecx
	movl	$4, 68(%rsp)
	subl	%ecx, 68(%rsp)
	movl	$8, 72(%rsp)
	subl	%ecx, 72(%rsp)
	cltq
	movl	$12, 76(%rsp)
	subl	%ecx, 76(%rsp)
	movq	$0, 40(%rsp)
	movdqa	(%rdx,%rax,4), %xmm7
	movl	68(%rsp), %eax
	addl	48(%rsp), %eax
	movdqa	.LC0(%rip), %xmm9
	cltq
	movdqa	(%rdx,%rax,4), %xmm6
	movl	72(%rsp), %eax
	addl	48(%rsp), %eax
	cltq
	movdqa	(%rdx,%rax,4), %xmm5
	movl	76(%rsp), %eax
	addl	48(%rsp), %eax
	cmpq	$0, 80(%rsp)
	cltq
	movdqa	(%rdx,%rax,4), %xmm4
	jle	.L5
	movl	%ecx, %r8d
	addl	24(%rsp), %r8d
	movl	$8, %edi
	subl	24(%rsp), %edi
	movslq	24(%rsp), %r9
	movl	$4, %r15d
	subl	%r8d, %r15d
	movl	%r8d, 52(%rsp)
	movslq	%edi, %rdi
	movslq	%r15d, %r15
	addq	%r9, %rdi
	addq	%r9, %r15
	.p2align 4,,10
	.p2align 3
.L19:
	movl	48(%rsp), %edx
	cmpl	%edx, 24(%rsp)
	jge	.L9
	movl	24(%rsp), %r8d
	movl	$12, %r14d
	movq	56(%rsp), %rdx
	movl	%r14d, %ecx
	movslq	52(%rsp), %r11
	movl	$4, %esi
	subl	24(%rsp), %ecx
	subl	24(%rsp), %esi
	movl	$8, %r10d
	negl	%r8d
	subl	52(%rsp), %r10d
	subl	52(%rsp), %r14d
	movslq	%r8d, %rax
	movl	%r8d, 28(%rsp)
	movslq	64(%rsp), %r8
	salq	$2, %rax
	movslq	68(%rsp), %r12
	movslq	72(%rsp), %rbp
	movq	%rax, 32(%rsp)
	movq	88(%rsp), %rax
	movq	%r9, %r13
	movslq	76(%rsp), %rbx
	movslq	%esi, %rsi
	movslq	%ecx, %rcx
	subq	%r8, %r13
	movq	%r9, %r8
	movslq	%r10d, %r10
	subq	%r9, %rax
	subq	%r11, %r8
	movslq	%r14d, %r14
	leaq	(%rdx,%rax,4), %rax
	movl	48(%rsp), %edx
	addq	%r9, %rsi
	addq	%r9, %rcx
	addq	%r9, %r12
	addq	%r9, %rbp
	addq	%r9, %rbx
	movq	%r8, %r11
	addq	%r9, %r10
	.p2align 4,,10
	.p2align 3
.L6:
	movdqa	(%rax), %xmm1
	paddd	%xmm9, %xmm7
	paddd	%xmm9, %xmm6
	paddd	%xmm9, %xmm5
	paddd	%xmm9, %xmm4
	leaq	(%r9,%r14), %r8
	movdqa	(%rax,%rsi,4), %xmm3
	pmaxsd	%xmm1, %xmm7
	movdqa	%xmm9, %xmm0
	addl	28(%rsp), %edx
	paddd	%xmm9, %xmm1
	movdqa	(%rax,%rdi,4), %xmm2
	pmaxsd	%xmm3, %xmm6
	paddd	%xmm9, %xmm3
	movdqa	(%rax,%rcx,4), %xmm8
	pmaxsd	%xmm2, %xmm5
	paddd	%xmm9, %xmm2
	movdqa	%xmm7, (%rax,%r13,4)
	pmaxsd	%xmm8, %xmm4
	paddd	%xmm8, %xmm0
	movdqa	%xmm6, (%rax,%r12,4)
	movdqa	%xmm5, (%rax,%rbp,4)
	movdqa	%xmm4, (%rax,%rbx,4)
	movdqa	(%rax,%r11,4), %xmm7
	movdqa	(%rax,%r15,4), %xmm6
	pmaxsd	%xmm7, %xmm1
	movdqa	%xmm1, %xmm10
	movdqa	(%rax,%r10,4), %xmm5
	pmaxsd	%xmm6, %xmm3
	movdqa	(%rax,%r8,4), %xmm4
	pmaxsd	%xmm5, %xmm2
	movdqa	%xmm1, (%rax)
	pmaxsd	%xmm4, %xmm0
	movdqa	%xmm3, (%rax,%rsi,4)
	movdqa	%xmm2, (%rax,%rdi,4)
	movdqa	%xmm0, (%rax,%rcx,4)
	addq	32(%rsp), %rax
	cmpl	%edx, 24(%rsp)
	jl	.L6
.L9:
	addq	$1, 40(%rsp)
	movq	80(%rsp), %rcx
	pminsd	%xmm10, %xmm9
	cmpq	%rcx, 40(%rsp)
	jne	.L19
.L5:
	movl	48(%rsp), %eax
	xorl	%ebx, %ebx
	testl	%eax, %eax
	jle	.L8
	movq	56(%rsp), %rdx
	movl	48(%rsp), %ecx
	movq	%rdx, %rax
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	48(%rsp), %eax
	cmovbe	%eax, %ecx
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	movl	%ecx, %r9d
	je	.L10
	.p2align 4,,10
	.p2align 3
.L11:
	addl	$1, %eax
	addl	(%rdx), %ebx
	addq	$4, %rdx
	cmpl	%ecx, %eax
	jb	.L11
	cmpl	%ecx, 48(%rsp)
	je	.L8
.L10:
	movl	48(%rsp), %r8d
	subl	%ecx, %r8d
	movl	%r8d, %esi
	shrl	$2, %esi
	leal	0(,%rsi,4), %edi
	testl	%edi, %edi
	je	.L13
	movq	56(%rsp), %rdx
	pxor	%xmm0, %xmm0
	leaq	(%rdx,%r9,4), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L14:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%esi, %edx
	jb	.L14
	movdqa	%xmm0, %xmm1
	addl	%edi, %eax
	psrldq	$8, %xmm1
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	pextrd	$0, %xmm0, %edx
	addl	%edx, %ebx
	cmpl	%edi, %r8d
	je	.L8
.L13:
	movq	56(%rsp), %rcx
	movslq	%eax, %rdx
	leaq	(%rcx,%rdx,4), %rdx
	movl	48(%rsp), %ecx
	.p2align 4,,10
	.p2align 3
.L16:
	addl	$1, %eax
	addl	(%rdx), %ebx
	addq	$4, %rdx
	cmpl	%eax, %ecx
	jg	.L16
.L8:
	movq	56(%rsp), %rdi
	call	free
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L2:
	.cfi_restore_state
	movq	%rbx, %rdx
	xorl	%esi, %esi
	xorl	%edi, %edi
	movdqa	%xmm10, (%rsp)
	call	memset
	movq	$0, 56(%rsp)
	movdqa	(%rsp), %xmm10
	jmp	.L3
	.cfi_endproc
.LFE659:
	.size	oneThread, .-oneThread
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"Error: Array size: %d is not a multiple of 2*weight: %d!\n"
	.align 8
.LC6:
	.string	"Threads: %d ArraySize: %d W: %d Reps: %ld time: %.2f s GOPS: %.2f\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC7:
	.string	"sum: %d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB658:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$1, %edi
	jle	.L41
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	cmpl	$2, %ebp
	movl	%eax, %ebx
	je	.L27
	movq	16(%r14), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	call	strtol
	cmpl	$3, %ebp
	movl	%eax, %r13d
	je	.L47
	movq	24(%r14), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	call	strtol
	cmpl	$4, %ebp
	movl	%eax, %r12d
	je	.L48
	movq	32(%r14), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	leal	(%r13,%r13), %r15d
	call	strtol
	movl	%r12d, %edx
	movq	%rax, %r14
	movl	%r12d, %eax
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, 12(%rsp)
	jmp	.L31
.L41:
	movl	$1, %ebx
.L27:
	movl	$0, 12(%rsp)
	movl	$32, %r15d
	movl	$16, %r13d
.L29:
	movl	$320, %r12d
	movl	$200000000, %r14d
.L31:
	movl	12(%rsp), %edx
	testl	%edx, %edx
	jne	.L49
	movslq	%ebx, %rdi
	salq	$2, %rdi
	call	malloc
	movq	%rax, %rbp
	call	initialize_timer
	call	start_timer
	xorl	%edi, %edi
	movq	%r14, %rcx
	movl	%r12d, %edx
	movl	%r13d, %esi
	call	oneThread
	movl	%eax, 0(%rbp)
	call	stop_timer
	call	elapsed_time
	cvtsi2sd	%r15d, %xmm3
	movq	stdout(%rip), %rdi
	cvtsi2sd	%r12d, %xmm2
	movl	$.LC6, %esi
	cvtsi2sdq	%r14, %xmm1
	movq	%r14, %r9
	movl	%r13d, %r8d
	movl	%r12d, %ecx
	movl	%ebx, %edx
	movl	$2, %eax
	divsd	%xmm3, %xmm2
	mulsd	.LC3(%rip), %xmm1
	subsd	.LC4(%rip), %xmm2
	mulsd	%xmm2, %xmm1
	cvtsi2sd	%ebx, %xmm2
	mulsd	%xmm2, %xmm1
	divsd	%xmm0, %xmm1
	divsd	.LC5(%rip), %xmm1
	call	fprintf
	xorl	%esi, %esi
	testl	%ebx, %ebx
	jle	.L33
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
	je	.L43
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L35:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%ecx, %eax
	jb	.L35
	cmpl	%ecx, %ebx
	je	.L33
.L34:
	movl	%ebx, %r9d
	subl	%ecx, %r9d
	movl	%r9d, %edi
	shrl	$2, %edi
	leal	0(,%rdi,4), %r8d
	testl	%r8d, %r8d
	je	.L37
	pxor	%xmm0, %xmm0
	leaq	0(%rbp,%r10,4), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L38:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%edi, %edx
	jb	.L38
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
	je	.L33
.L37:
	movslq	%eax, %rdx
	leaq	0(%rbp,%rdx,4), %rdx
	.p2align 4,,10
	.p2align 3
.L40:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%eax, %ebx
	jg	.L40
.L33:
	movl	$.LC7, %edi
	xorl	%eax, %eax
	call	printf
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L47:
	.cfi_restore_state
	movl	$320, %eax
	leal	(%r13,%r13), %r15d
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, 12(%rsp)
	jmp	.L29
.L48:
	movl	%eax, %edx
	leal	(%r13,%r13), %r15d
	movl	$200000000, %r14d
	sarl	$31, %edx
	idivl	%r15d
	movl	%edx, 12(%rsp)
	jmp	.L31
.L43:
	movl	12(%rsp), %esi
	xorl	%eax, %eax
	jmp	.L34
.L49:
	movl	$.LC2, %edi
	movl	%r15d, %edx
	movl	%r12d, %esi
	xorl	%eax, %eax
	call	printf
	orl	$-1, %edi
	call	exit
	.cfi_endproc
.LFE658:
	.size	main, .-main
	.text
	.p2align 4,,15
	.globl	compute
	.type	compute, @function
compute:
.LFB660:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	%xmm0, %xmm0
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$32, %rsp
	.cfi_def_cfa_offset 88
	testq	%r9, %r9
	movq	%rdi, -64(%rsp)
	movq	%rsi, -56(%rsp)
	movq	%rdx, -48(%rsp)
	movq	%r9, -72(%rsp)
	movdqa	%xmm0, -40(%rsp)
	movdqa	%xmm0, -24(%rsp)
	movdqa	%xmm0, -8(%rsp)
	movdqa	%xmm0, 8(%rsp)
	jle	.L50
	movl	4(%rsp), %eax
	movl	8(%rsp), %r15d
	sarl	$4, %r8d
	movl	%r8d, -84(%rsp)
	movl	-40(%rsp), %r14d
	movl	-36(%rsp), %r13d
	movl	-32(%rsp), %r12d
	movl	%eax, -108(%rsp)
	movl	12(%rsp), %eax
	movl	%r15d, -104(%rsp)
	movl	16(%rsp), %r15d
	movl	-28(%rsp), %ebp
	movl	-24(%rsp), %ebx
	movl	%eax, -100(%rsp)
	movl	20(%rsp), %eax
	movl	-20(%rsp), %r11d
	movl	-16(%rsp), %r10d
	movl	-12(%rsp), %r9d
	movl	-8(%rsp), %r8d
	movl	-4(%rsp), %edi
	movl	(%rsp), %esi
	movl	%r15d, -96(%rsp)
	movl	%eax, -88(%rsp)
	movq	$0, -80(%rsp)
	.p2align 4,,10
	.p2align 3
.L52:
	movl	-84(%rsp), %ecx
	testl	%ecx, %ecx
	jle	.L54
	movq	-56(%rsp), %rcx
	movq	-48(%rsp), %rax
	movq	-64(%rsp), %rdx
	movl	$0, -92(%rsp)
	.p2align 4,,10
	.p2align 3
.L53:
	addl	(%rcx), %r14d
	movl	(%rax), %r15d
	cmpl	%r15d, %r14d
	cmovl	%r15d, %r14d
	movl	%r14d, (%rdx)
	addl	4(%rcx), %r13d
	movl	4(%rax), %r15d
	cmpl	%r15d, %r13d
	cmovl	%r15d, %r13d
	movl	%r13d, 4(%rdx)
	addl	8(%rcx), %r12d
	movl	8(%rax), %r15d
	cmpl	%r15d, %r12d
	cmovl	%r15d, %r12d
	movl	%r12d, 8(%rdx)
	addl	12(%rcx), %ebp
	movl	12(%rax), %r15d
	cmpl	%r15d, %ebp
	cmovl	%r15d, %ebp
	movl	%ebp, 12(%rdx)
	addl	(%rcx), %ebx
	movl	(%rax), %r15d
	cmpl	%r15d, %ebx
	cmovl	%r15d, %ebx
	movl	%ebx, 16(%rdx)
	addl	4(%rcx), %r11d
	movl	4(%rax), %r15d
	cmpl	%r15d, %r11d
	cmovl	%r15d, %r11d
	movl	%r11d, 20(%rdx)
	addl	8(%rcx), %r10d
	movl	8(%rax), %r15d
	cmpl	%r15d, %r10d
	cmovl	%r15d, %r10d
	movl	%r10d, 24(%rdx)
	addl	12(%rcx), %r9d
	movl	12(%rax), %r15d
	cmpl	%r15d, %r9d
	cmovl	%r15d, %r9d
	movl	%r9d, 28(%rdx)
	addl	(%rcx), %r8d
	movl	(%rax), %r15d
	cmpl	%r15d, %r8d
	cmovl	%r15d, %r8d
	movl	%r8d, 32(%rdx)
	addl	4(%rcx), %edi
	movl	4(%rax), %r15d
	cmpl	%r15d, %edi
	cmovl	%r15d, %edi
	movl	%edi, 36(%rdx)
	addl	8(%rcx), %esi
	movl	8(%rax), %r15d
	cmpl	%r15d, %esi
	cmovl	%r15d, %esi
	movl	-108(%rsp), %r15d
	movl	%esi, 40(%rdx)
	addl	12(%rcx), %r15d
	movl	%r15d, -108(%rsp)
	movl	12(%rax), %r15d
	cmpl	%r15d, -108(%rsp)
	cmovge	-108(%rsp), %r15d
	movl	%r15d, 44(%rdx)
	movl	%r15d, -108(%rsp)
	movl	-104(%rsp), %r15d
	addl	(%rcx), %r15d
	movl	%r15d, -104(%rsp)
	movl	(%rax), %r15d
	cmpl	%r15d, -104(%rsp)
	cmovge	-104(%rsp), %r15d
	movl	%r15d, 48(%rdx)
	movl	%r15d, -104(%rsp)
	movl	-100(%rsp), %r15d
	addl	4(%rcx), %r15d
	movl	%r15d, -100(%rsp)
	movl	4(%rax), %r15d
	cmpl	%r15d, -100(%rsp)
	cmovge	-100(%rsp), %r15d
	movl	%r15d, 52(%rdx)
	movl	%r15d, -100(%rsp)
	movl	-96(%rsp), %r15d
	addl	8(%rcx), %r15d
	movl	%r15d, -96(%rsp)
	movl	8(%rax), %r15d
	cmpl	%r15d, -96(%rsp)
	cmovge	-96(%rsp), %r15d
	movl	%r15d, 56(%rdx)
	movl	%r15d, -96(%rsp)
	movl	-88(%rsp), %r15d
	addl	12(%rcx), %r15d
	cmpl	%r15d, 12(%rax)
	cmovge	12(%rax), %r15d
	addq	$16, %rcx
	addq	$16, %rax
	movl	%r15d, -88(%rsp)
	addl	$1, -92(%rsp)
	movl	%r15d, 60(%rdx)
	addq	$64, %rdx
	movl	-84(%rsp), %r15d
	cmpl	%r15d, -92(%rsp)
	jne	.L53
.L54:
	addq	$1, -80(%rsp)
	movq	-72(%rsp), %rax
	cmpq	%rax, -80(%rsp)
	jne	.L52
.L50:
	addq	$32, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE660:
	.size	compute, .-compute
	.p2align 4,,15
	.globl	t_add__m128i
	.type	t_add__m128i, @function
t_add__m128i:
.LFB661:
	.cfi_startproc
	paddd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE661:
	.size	t_add__m128i, .-t_add__m128i
	.section	.rodata.str1.1
.LC8:
	.string	"%d = %d\n"
	.text
	.p2align 4,,15
	.globl	t_print__m128i
	.type	t_print__m128i, @function
t_print__m128i:
.LFB662:
	.cfi_startproc
	pextrd	$0, %xmm0, %edx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	xorl	%esi, %esi
	movl	$.LC8, %edi
	xorl	%eax, %eax
	movdqa	%xmm0, (%rsp)
	call	printf
	movl	$1, %esi
	movl	$.LC8, %edi
	xorl	%eax, %eax
	movdqa	(%rsp), %xmm0
	pextrd	$1, %xmm0, %edx
	call	printf
	movdqa	(%rsp), %xmm0
	movl	$2, %esi
	movl	$.LC8, %edi
	xorl	%eax, %eax
	pextrd	$2, %xmm0, %edx
	call	printf
	movdqa	(%rsp), %xmm0
	movl	$.LC8, %edi
	movl	$3, %esi
	xorl	%eax, %eax
	pextrd	$3, %xmm0, %edx
	call	printf
	movl	$10, %edi
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	putchar
	.cfi_endproc
.LFE662:
	.size	t_print__m128i, .-t_print__m128i
	.section	.rodata.str1.1
.LC9:
	.string	"[%d]=%d\n"
	.text
	.p2align 4,,15
	.globl	printArray
	.type	printArray, @function
printArray:
.LFB663:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	testl	%esi, %esi
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	jle	.L58
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L60:
	movl	(%r12,%rbx,4), %edx
	movl	%ebx, %esi
	xorl	%eax, %eax
	movl	$.LC9, %edi
	addq	$1, %rbx
	call	printf
	cmpl	%ebx, %ebp
	jg	.L60
.L58:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE663:
	.size	printArray, .-printArray
	.section	.rodata.str1.1
.LC10:
	.string	"cc[%d]:%d != cc_i[%d]:%d\n"
	.text
	.p2align 4,,15
	.globl	t_test
	.type	t_test, @function
t_test:
.LFB664:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	%edx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testl	%edx, %edx
	jle	.L62
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L65:
	movl	(%r12,%rbx,4), %edx
	movl	0(%rbp,%rbx,4), %r8d
	cmpl	%r8d, %edx
	je	.L64
	movl	%ebx, %ecx
	movl	%ebx, %esi
	movl	$.LC10, %edi
	xorl	%eax, %eax
	call	printf
.L64:
	addq	$1, %rbx
	cmpl	%ebx, %r13d
	jg	.L65
.L62:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE664:
	.size	t_test, .-t_test
	.section	.rodata.str1.1
.LC11:
	.string	"cc[%d]:%d :: cc_i[%d]:%d"
.LC12:
	.string	" *"
	.text
	.p2align 4,,15
	.globl	print_diff
	.type	print_diff, @function
print_diff:
.LFB665:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	%edx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testl	%edx, %edx
	jle	.L67
	xorl	%ebx, %ebx
	jmp	.L71
	.p2align 4,,10
	.p2align 3
.L73:
	movl	$.LC12, %edi
	addq	$1, %rbx
	call	puts
	cmpl	%ebx, %r13d
	jle	.L67
.L71:
	movl	(%r12,%rbx,4), %edx
	movl	0(%rbp,%rbx,4), %r8d
	xorl	%eax, %eax
	movl	%ebx, %ecx
	movl	%ebx, %esi
	movl	$.LC11, %edi
	call	printf
	movl	0(%rbp,%rbx,4), %eax
	cmpl	%eax, (%r12,%rbx,4)
	jne	.L73
	movl	$10, %edi
	addq	$1, %rbx
	call	putchar
	cmpl	%ebx, %r13d
	jg	.L71
.L67:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE665:
	.size	print_diff, .-print_diff
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	8589934593
	.quad	4294967298
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	0
	.long	1076887552
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
