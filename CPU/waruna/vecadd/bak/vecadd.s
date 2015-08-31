	.file	"vecadd.c"
	.text
	.p2align 4,,15
	.globl	oneThread
	.type	oneThread, @function
oneThread:
.LFB660:
	.cfi_startproc
	subq	$6032, %rsp
	.cfi_def_cfa_offset 6040
	movl	$256, %r9d
	movabsq	$72340172838076673, %rax
	leaq	-120(%rsp), %r8
	movq	%r9, %rcx
	leaq	1928(%rsp), %rsi
	movl	reps(%rip), %r11d
	leaq	3976(%rsp), %rdx
	xorl	%r10d, %r10d
	movq	%r8, %rdi
	rep stosq
	movabsq	$144680345676153346, %rax
	movq	%rsi, %rdi
	testl	%r11d, %r11d
	movq	%rcx, %r9
	movw	$256, %cx
	rep stosq
	movq	%rdx, %rdi
	movq	%r9, %rax
	movw	$256, %cx
	rep stosq
	jle	.L3
	.p2align 4,,10
	.p2align 3
.L7:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	leaq	4(%rax), %r9
	leaq	8(%rax), %rdi
	leaq	12(%rax), %rcx
	movdqa	(%r8,%rax,4), %xmm3
	movdqa	(%r8,%r9,4), %xmm2
	paddd	(%rsi,%rax,4), %xmm3
	movdqa	(%r8,%rdi,4), %xmm1
	paddd	(%rsi,%r9,4), %xmm2
	movdqa	%xmm3, (%rdx,%rax,4)
	paddd	(%rsi,%rdi,4), %xmm1
	addq	$16, %rax
	cmpq	$512, %rax
	movdqa	%xmm2, (%rdx,%r9,4)
	movdqa	%xmm1, (%rdx,%rdi,4)
	movdqa	(%r8,%rcx,4), %xmm0
	paddd	(%rsi,%rcx,4), %xmm0
	movdqa	%xmm0, (%rdx,%rcx,4)
	jne	.L4
	addl	$1, %r10d
	cmpl	%r11d, %r10d
	jne	.L7
.L3:
	leaq	6024(%rsp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L5:
	addl	(%rdx), %eax
	addq	$16, %rdx
	cmpq	%rcx, %rdx
	jne	.L5
	addq	$6032, %rsp
	.cfi_def_cfa_offset 8
	ret
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
.LC2:
	.string	"Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f REPS: %d\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
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
	jle	.L14
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	cmpl	$2, %ebx
	movl	%eax, tds(%rip)
	je	.L14
	movq	16(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, reps(%rip)
.L14:
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
	movl	tds(%rip), %edx
	movsd	(%rsp), %xmm4
	movsd	.LC1(%rip), %xmm5
	movl	reps(%rip), %r8d
	movq	stdout(%rip), %rdi
	movapd	%xmm0, %xmm2
	cvtsi2sd	%edx, %xmm1
	movl	$.LC2, %esi
	movl	$512, %ecx
	movl	$4, %eax
	mulsd	.LC0(%rip), %xmm1
	movapd	%xmm1, %xmm3
	divsd	%xmm4, %xmm1
	divsd	%xmm0, %xmm3
	movapd	%xmm4, %xmm0
	divsd	%xmm5, %xmm1
	divsd	%xmm5, %xmm3
	call	fprintf
	movl	$mykernel, %edi
	call	my_papi_profile
	movl	tds(%rip), %edi
	xorl	%esi, %esi
	testl	%edi, %edi
	jle	.L15
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
	je	.L24
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L17:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%ecx, %eax
	jb	.L17
	cmpl	%ecx, %edi
	je	.L15
.L16:
	movl	%edi, %r11d
	subl	%ecx, %r11d
	movl	%r11d, %r8d
	shrl	$2, %r8d
	leal	0(,%r8,4), %r10d
	testl	%r10d, %r10d
	je	.L19
	pxor	%xmm0, %xmm0
	leaq	(%r9,%rbx,4), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L20:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%r8d, %edx
	jb	.L20
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
	je	.L15
.L19:
	movslq	%eax, %rdx
	leaq	(%r9,%rdx,4), %rdx
	.p2align 4,,10
	.p2align 3
.L22:
	addl	$1, %eax
	addl	(%rdx), %esi
	addq	$4, %rdx
	cmpl	%eax, %edi
	jg	.L22
.L15:
	movl	$.LC3, %edi
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
.L24:
	.cfi_restore_state
	movl	%ecx, %esi
	xorl	%eax, %eax
	jmp	.L16
	.cfi_endproc
.LFE658:
	.size	main, .-main
	.comm	reps,4,4
	.comm	tds,4,16
	.comm	sum,8,16
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	2952790016
	.long	1116467342
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
