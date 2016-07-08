	.file	"vecacc_malloc_main.c"
	.text
	.p2align 4,,15
	.type	_mm_malloc.constprop.1, @function
_mm_malloc.constprop.1:
.LFB660:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$3968, %edx
	movl	$16, %esi
	movq	%rsp, %rdi
	call	posix_memalign
	xorl	%edx, %edx
	testl	%eax, %eax
	cmove	(%rsp), %rdx
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	movq	%rdx, %rax
	ret
	.cfi_endproc
.LFE660:
	.size	_mm_malloc.constprop.1, .-_mm_malloc.constprop.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"sum: %d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB658:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	cmpl	$1, %edi
	movl	$1, reps(%rip)
	jle	.L5
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, reps(%rip)
.L5:
	movslq	tds(%rip), %rdi
	salq	$2, %rdi
	call	malloc
	movq	%rax, sum(%rip)
	call	_mm_malloc.constprop.1
	movq	%rax, %rbp
	call	_mm_malloc.constprop.1
	movq	%rax, %r12
	call	_mm_malloc.constprop.1
	testb	$1, %bpl
	movq	%rax, %rbx
	movq	%rbp, %rdi
	movl	$3968, %edx
	jne	.L34
.L6:
	testb	$2, %dil
	jne	.L35
.L7:
	testb	$4, %dil
	jne	.L36
.L8:
	movl	%edx, %ecx
	movabsq	$72340172838076673, %rax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L9
	movl	$16843009, (%rdi)
	addq	$4, %rdi
.L9:
	testb	$2, %dl
	je	.L10
	movw	$257, (%rdi)
	addq	$2, %rdi
.L10:
	andl	$1, %edx
	je	.L11
	movb	$1, (%rdi)
.L11:
	testb	$1, %r12b
	movq	%r12, %rdi
	movl	$3968, %edx
	jne	.L37
.L12:
	testb	$2, %dil
	jne	.L38
.L13:
	testb	$4, %dil
	jne	.L39
.L14:
	movl	%edx, %ecx
	movabsq	$144680345676153346, %rax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L15
	movl	$33686018, (%rdi)
	addq	$4, %rdi
.L15:
	testb	$2, %dl
	je	.L16
	movw	$514, (%rdi)
	addq	$2, %rdi
.L16:
	andl	$1, %edx
	je	.L17
	movb	$2, (%rdi)
.L17:
	testb	$1, %bl
	movq	%rbx, %rdi
	movl	$3968, %edx
	jne	.L40
.L18:
	testb	$2, %dil
	jne	.L41
.L19:
	testb	$4, %dil
	jne	.L42
.L20:
	movl	%edx, %ecx
	xorl	%eax, %eax
	shrl	$3, %ecx
	testb	$4, %dl
	rep stosq
	je	.L21
	movl	$0, (%rdi)
	addq	$4, %rdi
.L21:
	testb	$2, %dl
	je	.L22
	movw	$0, (%rdi)
	addq	$2, %rdi
.L22:
	andl	$1, %edx
	je	.L23
	movb	$0, (%rdi)
.L23:
	movl	reps(%rip), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	.L25
	.p2align 4,,10
	.p2align 3
.L29:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L26:
	movdqa	0(%rbp,%rax), %xmm7
	movdqa	16(%rbp,%rax), %xmm6
	paddd	(%r12,%rax), %xmm7
	movdqa	32(%rbp,%rax), %xmm5
	paddd	16(%r12,%rax), %xmm6
	movdqa	48(%rbp,%rax), %xmm4
	paddd	32(%r12,%rax), %xmm5
	movdqa	64(%rbp,%rax), %xmm3
	paddd	48(%r12,%rax), %xmm4
	movdqa	80(%rbp,%rax), %xmm2
	paddd	64(%r12,%rax), %xmm3
	movdqa	96(%rbp,%rax), %xmm1
	paddd	80(%r12,%rax), %xmm2
	movdqa	112(%rbp,%rax), %xmm0
	paddd	96(%r12,%rax), %xmm1
	paddd	112(%r12,%rax), %xmm0
	movdqa	%xmm7, (%rbx,%rax)
	movdqa	%xmm6, 16(%rbx,%rax)
	movdqa	%xmm5, 32(%rbx,%rax)
	movdqa	%xmm4, 48(%rbx,%rax)
	movdqa	%xmm3, 64(%rbx,%rax)
	movdqa	%xmm2, 80(%rbx,%rax)
	movdqa	%xmm1, 96(%rbx,%rax)
	movdqa	%xmm0, 112(%rbx,%rax)
	subq	$-128, %rax
	cmpq	$3968, %rax
	jne	.L26
	addl	$1, %edx
	cmpl	%edx, reps(%rip)
	jg	.L29
.L25:
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	.p2align 4,,10
	.p2align 3
.L27:
	addl	(%rbx,%rax), %r13d
	addq	$16, %rax
	cmpq	$3968, %rax
	jne	.L27
	movq	%rbp, %rdi
	call	free
	movq	%r12, %rdi
	call	free
	movq	%rbx, %rdi
	call	free
	movl	%r13d, %esi
	movl	$.LC0, %edi
	xorl	%eax, %eax
	call	printf
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L34:
	.cfi_restore_state
	movb	$1, 0(%rbp)
	leaq	1(%rbp), %rdi
	movb	$127, %dl
	jmp	.L6
.L35:
	movw	$257, (%rdi)
	subl	$2, %edx
	addq	$2, %rdi
	jmp	.L7
.L36:
	movl	$16843009, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L8
.L37:
	movb	$2, (%r12)
	leaq	1(%r12), %rdi
	movb	$127, %dl
	jmp	.L12
.L38:
	movw	$514, (%rdi)
	subl	$2, %edx
	addq	$2, %rdi
	jmp	.L13
.L39:
	movl	$33686018, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L14
.L40:
	movb	$0, (%rbx)
	leaq	1(%rbx), %rdi
	movb	$127, %dl
	jmp	.L18
.L41:
	movw	$0, (%rdi)
	subl	$2, %edx
	addq	$2, %rdi
	jmp	.L19
.L42:
	movl	$0, (%rdi)
	subl	$4, %edx
	addq	$4, %rdi
	jmp	.L20
	.cfi_endproc
.LFE658:
	.size	main, .-main
	.comm	reps,4,16
	.comm	tds,4,4
	.comm	sum,8,8
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
