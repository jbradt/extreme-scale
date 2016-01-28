	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI0_0:
	.quad	4627135668626128896     ## double 22.88818359375
LCPI0_1:
	.quad	4582099672352423936     ## double 0.022351741790771484
LCPI0_2:
	.quad	4634532255144869888     ## double 68.66455078125
LCPI0_3:
	.quad	4589496258871164928     ## double 0.067055225372314453
LCPI0_4:
	.quad	4607182418800017408     ## double 1
LCPI0_5:
	.quad	4517329193108106637     ## double 9.9999999999999995E-7
LCPI0_6:
	.quad	4696837146684686336     ## double 1.0E+6
LCPI0_8:
	.quad	4621256167635550208     ## double 9
LCPI0_9:
	.quad	4631952216750555136     ## double 48
LCPI0_10:
	.quad	4634766966517661696     ## double 72
	.section	__TEXT,__literal16,16byte_literals
	.align	4
LCPI0_7:
	.quad	4613937818241073152     ## double 3.000000e+00
	.quad	4613937818241073152     ## double 3.000000e+00
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$392, %rsp              ## imm = 0x188
Ltmp3:
	.cfi_offset %rbx, -56
Ltmp4:
	.cfi_offset %r12, -48
Ltmp5:
	.cfi_offset %r13, -40
Ltmp6:
	.cfi_offset %r14, -32
Ltmp7:
	.cfi_offset %r15, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	leaq	L_str49(%rip), %r12
	movq	%r12, %rdi
	callq	_puts
	leaq	L_str33(%rip), %rdi
	callq	_puts
	movq	%r12, %rdi
	callq	_puts
	leaq	L_.str2(%rip), %rdi
	movl	$8, %esi
	xorl	%eax, %eax
	callq	_printf
	movq	%r12, %rdi
	callq	_puts
	leaq	L_.str3(%rip), %rdi
	movl	$3000000, %esi          ## imm = 0x2DC6C0
	xorl	%edx, %edx
	xorl	%eax, %eax
	callq	_printf
	leaq	L_.str4(%rip), %rdi
	movsd	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	LCPI0_1(%rip), %xmm1    ## xmm1 = mem[0],zero
	movb	$2, %al
	callq	_printf
	leaq	L_.str5(%rip), %rdi
	movsd	LCPI0_2(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	LCPI0_3(%rip), %xmm1    ## xmm1 = mem[0],zero
	movb	$2, %al
	callq	_printf
	leaq	L_.str6(%rip), %rdi
	movl	$10, %esi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_str36(%rip), %rdi
	callq	_puts
	leaq	L_str37(%rip), %rdi
	callq	_puts
	leaq	_a(%rip), %r14
	leaq	_.memset_pattern(%rip), %rsi
	movl	$24000000, %edx         ## imm = 0x16E3600
	movq	%r14, %rdi
	callq	_memset_pattern16
	leaq	_b(%rip), %r15
	leaq	_.memset_pattern50(%rip), %rsi
	movl	$24000000, %edx         ## imm = 0x16E3600
	movq	%r15, %rdi
	callq	_memset_pattern16
	leaq	_c(%rip), %rbx
	movl	$24000000, %esi         ## imm = 0x16E3600
	movq	%rbx, %rdi
	callq	___bzero
	movq	%r12, %rdi
	callq	_puts
	callq	_checktick
	movl	%eax, %r12d
	testl	%r12d, %r12d
	jle	LBB0_2
## BB#1:
	leaq	L_.str9(%rip), %rdi
	xorl	%eax, %eax
	movl	%r12d, %esi
	callq	_printf
	cvtsi2sdl	%r12d, %xmm0
	jmp	LBB0_3
LBB0_2:
	leaq	L_str39(%rip), %rdi
	callq	_puts
	movsd	LCPI0_4(%rip), %xmm0    ## xmm0 = mem[0],zero
LBB0_3:                                 ## %overflow.checked
	movsd	%xmm0, -400(%rbp)       ## 8-byte Spill
	leaq	-384(%rbp), %rdi
	leaq	-392(%rbp), %rsi
	callq	_gettimeofday
	movq	-384(%rbp), %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdl	-376(%rbp), %xmm0
	mulsd	LCPI0_5(%rip), %xmm0
	movl	$6, %ecx
	.align	4, 0x90
LBB0_4:                                 ## %vector.body
                                        ## =>This Inner Loop Header: Depth=1
	movapd	-48(%r14,%rcx,8), %xmm1
	movapd	-32(%r14,%rcx,8), %xmm2
	addpd	%xmm1, %xmm1
	addpd	%xmm2, %xmm2
	movapd	%xmm1, -48(%r14,%rcx,8)
	movapd	%xmm2, -32(%r14,%rcx,8)
	movapd	-16(%r14,%rcx,8), %xmm1
	movapd	(%r14,%rcx,8), %xmm2
	addpd	%xmm1, %xmm1
	addpd	%xmm2, %xmm2
	movapd	%xmm1, -16(%r14,%rcx,8)
	movapd	%xmm2, (%r14,%rcx,8)
	addq	$8, %rcx
	cmpq	$3000006, %rcx          ## imm = 0x2DC6C6
	jne	LBB0_4
## BB#5:                                ## %middle.block
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	leaq	-384(%rbp), %rdi
	leaq	-392(%rbp), %r12
	movq	%r12, %rsi
	callq	_gettimeofday
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	subsd	-408(%rbp), %xmm1       ## 8-byte Folded Reload
	mulsd	LCPI0_6(%rip), %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	cvttsd2si	%xmm1, %esi
	leaq	L_.str11(%rip), %rdi
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	callq	_printf
	movsd	-408(%rbp), %xmm0       ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	divsd	-400(%rbp), %xmm0       ## 8-byte Folded Reload
	cvttsd2si	%xmm0, %esi
	leaq	L_.str12(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_str40(%rip), %rdi
	callq	_puts
	leaq	L_str41(%rip), %rdi
	callq	_puts
	leaq	L_str49(%rip), %rdi
	callq	_puts
	leaq	L_str43(%rip), %rdi
	callq	_puts
	leaq	L_str44(%rip), %rdi
	callq	_puts
	leaq	L_str45(%rip), %rdi
	callq	_puts
	leaq	L_str49(%rip), %rdi
	callq	_puts
	.align	4, 0x90
LBB0_6:                                 ## %overflow.checked120
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_7 Depth 2
                                        ##     Child Loop BB0_9 Depth 2
                                        ##     Child Loop BB0_11 Depth 2
	movq	%r13, -400(%rbp)        ## 8-byte Spill
	movq	%r12, %rsi
	leaq	-384(%rbp), %r12
	movq	%r12, %rdi
	callq	_gettimeofday
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	movl	$24000000, %edx         ## imm = 0x16E3600
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_memcpy
	movq	%r12, %rdi
	leaq	-392(%rbp), %r12
	movq	%r12, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	subsd	-408(%rbp), %xmm1       ## 8-byte Folded Reload
	movsd	%xmm1, -368(%rbp,%r13,8)
	leaq	-384(%rbp), %rdi
	movq	%r12, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	movsd	%xmm1, -288(%rbp,%r13,8)
	movl	$6, %eax
	movapd	LCPI0_7(%rip), %xmm2    ## xmm2 = [3.000000e+00,3.000000e+00]
	.align	4, 0x90
LBB0_7:                                 ## %vector.body116
                                        ##   Parent Loop BB0_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movapd	-48(%rbx,%rax,8), %xmm0
	mulpd	%xmm2, %xmm0
	movapd	-32(%rbx,%rax,8), %xmm1
	mulpd	%xmm2, %xmm1
	movapd	%xmm0, -48(%r15,%rax,8)
	movapd	%xmm1, -32(%r15,%rax,8)
	movapd	-16(%rbx,%rax,8), %xmm0
	mulpd	%xmm2, %xmm0
	movapd	(%rbx,%rax,8), %xmm1
	mulpd	%xmm2, %xmm1
	movapd	%xmm0, -16(%r15,%rax,8)
	movapd	%xmm1, (%r15,%rax,8)
	addq	$8, %rax
	cmpq	$3000006, %rax          ## imm = 0x2DC6C6
	jne	LBB0_7
## BB#8:                                ## %middle.block117
                                        ##   in Loop: Header=BB0_6 Depth=1
	leaq	-384(%rbp), %r13
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	movsd	LCPI0_5(%rip), %xmm2    ## xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	subsd	-408(%rbp), %xmm1       ## 8-byte Folded Reload
	movq	-400(%rbp), %r12        ## 8-byte Reload
	movsd	%xmm1, -288(%rbp,%r12,8)
	movq	%r13, %rdi
	leaq	-392(%rbp), %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	movsd	%xmm1, -208(%rbp,%r12,8)
	movl	$2, %eax
	.align	4, 0x90
LBB0_9:                                 ## %vector.body94
                                        ##   Parent Loop BB0_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movapd	-16(%r14,%rax,8), %xmm0
	movapd	(%r14,%rax,8), %xmm1
	addpd	-16(%r15,%rax,8), %xmm0
	addpd	(%r15,%rax,8), %xmm1
	movapd	%xmm0, -16(%rbx,%rax,8)
	movapd	%xmm1, (%rbx,%rax,8)
	addq	$4, %rax
	cmpq	$3000002, %rax          ## imm = 0x2DC6C2
	jne	LBB0_9
## BB#10:                               ## %middle.block95
                                        ##   in Loop: Header=BB0_6 Depth=1
	movq	%r13, %rdi
	leaq	-392(%rbp), %r12
	movq	%r12, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	movsd	LCPI0_5(%rip), %xmm2    ## xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	subsd	-408(%rbp), %xmm1       ## 8-byte Folded Reload
	movq	-400(%rbp), %r12        ## 8-byte Reload
	movsd	%xmm1, -208(%rbp,%r12,8)
	movq	%r13, %rdi
	leaq	-392(%rbp), %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	mulsd	LCPI0_5(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, -408(%rbp)       ## 8-byte Spill
	movsd	%xmm1, -128(%rbp,%r12,8)
	movl	$2, %eax
	movapd	LCPI0_7(%rip), %xmm2    ## xmm2 = [3.000000e+00,3.000000e+00]
	.align	4, 0x90
LBB0_11:                                ## %vector.body72
                                        ##   Parent Loop BB0_6 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movapd	-16(%rbx,%rax,8), %xmm0
	mulpd	%xmm2, %xmm0
	movapd	(%rbx,%rax,8), %xmm1
	mulpd	%xmm2, %xmm1
	addpd	-16(%r15,%rax,8), %xmm0
	addpd	(%r15,%rax,8), %xmm1
	movapd	%xmm0, -16(%r14,%rax,8)
	movapd	%xmm1, (%r14,%rax,8)
	addq	$4, %rax
	cmpq	$3000002, %rax          ## imm = 0x2DC6C2
	jne	LBB0_11
## BB#12:                               ## %middle.block73
                                        ##   in Loop: Header=BB0_6 Depth=1
	movq	%r13, %rdi
	leaq	-392(%rbp), %r12
	movq	%r12, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-384(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	cvtsi2sdl	-376(%rbp), %xmm1
	movsd	LCPI0_5(%rip), %xmm2    ## xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	subsd	-408(%rbp), %xmm1       ## 8-byte Folded Reload
	movq	-400(%rbp), %r13        ## 8-byte Reload
	movsd	%xmm1, -128(%rbp,%r13,8)
	incq	%r13
	cmpq	$10, %r13
	jne	LBB0_6
## BB#13:                               ## %.preheader36
	movsd	_mintime(%rip), %xmm8   ## xmm8 = mem[0],zero
	movsd	_maxtime(%rip), %xmm9   ## xmm9 = mem[0],zero
	movapd	_avgtime(%rip), %xmm10
	movsd	_mintime+8(%rip), %xmm11 ## xmm11 = mem[0],zero
	movsd	_maxtime+8(%rip), %xmm4 ## xmm4 = mem[0],zero
	movsd	_mintime+16(%rip), %xmm5 ## xmm5 = mem[0],zero
	movsd	_maxtime+16(%rip), %xmm6 ## xmm6 = mem[0],zero
	movapd	_avgtime+16(%rip), %xmm7
	movsd	_mintime+24(%rip), %xmm0 ## xmm0 = mem[0],zero
	movq	$-9, %rax
	movsd	_maxtime+24(%rip), %xmm1 ## xmm1 = mem[0],zero
	.align	4, 0x90
LBB0_14:                                ## %.preheader
                                        ## =>This Inner Loop Header: Depth=1
	movsd	-288(%rbp,%rax,8), %xmm2 ## xmm2 = mem[0],zero
	minsd	%xmm2, %xmm8
	movsd	%xmm8, _mintime(%rip)
	maxsd	%xmm2, %xmm9
	movsd	%xmm9, _maxtime(%rip)
	movsd	-208(%rbp,%rax,8), %xmm3 ## xmm3 = mem[0],zero
	unpcklpd	%xmm3, %xmm2    ## xmm2 = xmm2[0],xmm3[0]
	addpd	%xmm2, %xmm10
	movapd	%xmm10, _avgtime(%rip)
	minsd	%xmm3, %xmm11
	movsd	%xmm11, _mintime+8(%rip)
	maxsd	%xmm3, %xmm4
	movsd	%xmm4, _maxtime+8(%rip)
	movsd	-128(%rbp,%rax,8), %xmm2 ## xmm2 = mem[0],zero
	minsd	%xmm2, %xmm5
	movsd	%xmm5, _mintime+16(%rip)
	maxsd	%xmm2, %xmm6
	movsd	%xmm6, _maxtime+16(%rip)
	movsd	-48(%rbp,%rax,8), %xmm3 ## xmm3 = mem[0],zero
	unpcklpd	%xmm3, %xmm2    ## xmm2 = xmm2[0],xmm3[0]
	addpd	%xmm2, %xmm7
	movapd	%xmm7, _avgtime+16(%rip)
	minsd	%xmm3, %xmm0
	movsd	%xmm0, _mintime+24(%rip)
	maxsd	%xmm3, %xmm1
	movsd	%xmm1, _maxtime+24(%rip)
	incq	%rax
	jne	LBB0_14
## BB#15:
	leaq	L_str47(%rip), %rdi
	callq	_puts
	movsd	_avgtime(%rip), %xmm1   ## xmm1 = mem[0],zero
	divsd	LCPI0_8(%rip), %xmm1
	movsd	%xmm1, _avgtime(%rip)
	movsd	_mintime(%rip), %xmm2   ## xmm2 = mem[0],zero
	movsd	LCPI0_9(%rip), %xmm0    ## xmm0 = mem[0],zero
	divsd	%xmm2, %xmm0
	movsd	_maxtime(%rip), %xmm3   ## xmm3 = mem[0],zero
	leaq	L_.str19(%rip), %rbx
	leaq	L_.str29(%rip), %rsi
	movb	$4, %al
	movq	%rbx, %rdi
	callq	_printf
	movsd	_avgtime+8(%rip), %xmm1 ## xmm1 = mem[0],zero
	divsd	LCPI0_8(%rip), %xmm1
	movsd	%xmm1, _avgtime+8(%rip)
	movsd	_mintime+8(%rip), %xmm2 ## xmm2 = mem[0],zero
	movsd	LCPI0_9(%rip), %xmm0    ## xmm0 = mem[0],zero
	divsd	%xmm2, %xmm0
	movsd	_maxtime+8(%rip), %xmm3 ## xmm3 = mem[0],zero
	leaq	L_.str30(%rip), %rsi
	movb	$4, %al
	movq	%rbx, %rdi
	callq	_printf
	movsd	_avgtime+16(%rip), %xmm1 ## xmm1 = mem[0],zero
	divsd	LCPI0_8(%rip), %xmm1
	movsd	%xmm1, _avgtime+16(%rip)
	movsd	_mintime+16(%rip), %xmm2 ## xmm2 = mem[0],zero
	movsd	LCPI0_10(%rip), %xmm0   ## xmm0 = mem[0],zero
	divsd	%xmm2, %xmm0
	movsd	_maxtime+16(%rip), %xmm3 ## xmm3 = mem[0],zero
	leaq	L_.str31(%rip), %rsi
	movb	$4, %al
	movq	%rbx, %rdi
	callq	_printf
	movsd	_avgtime+24(%rip), %xmm1 ## xmm1 = mem[0],zero
	divsd	LCPI0_8(%rip), %xmm1
	movsd	%xmm1, _avgtime+24(%rip)
	movsd	_mintime+24(%rip), %xmm2 ## xmm2 = mem[0],zero
	movsd	LCPI0_10(%rip), %xmm0   ## xmm0 = mem[0],zero
	divsd	%xmm2, %xmm0
	movsd	_maxtime+24(%rip), %xmm3 ## xmm3 = mem[0],zero
	leaq	L_.str32(%rip), %rsi
	movb	$4, %al
	movq	%rbx, %rdi
	callq	_printf
	leaq	L_str49(%rip), %rbx
	movq	%rbx, %rdi
	callq	_puts
	callq	_checkSTREAMresults
	movq	%rbx, %rdi
	callq	_puts
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-48(%rbp), %rax
	jne	LBB0_17
## BB#16:
	xorl	%eax, %eax
	addq	$392, %rsp              ## imm = 0x188
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB0_17:
	callq	___stack_chk_fail
	.cfi_endproc

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI1_0:
	.quad	4517329193108106637     ## double 9.9999999999999995E-7
LCPI1_1:
	.quad	4696837146684686336     ## double 1.0E+6
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_checktick
	.align	4, 0x90
_checktick:                             ## @checktick
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp8:
	.cfi_def_cfa_offset 16
Ltmp9:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp10:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$224, %rsp
Ltmp11:
	.cfi_offset %rbx, -48
Ltmp12:
	.cfi_offset %r12, -40
Ltmp13:
	.cfi_offset %r14, -32
Ltmp14:
	.cfi_offset %r15, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %r15
	movq	(%r15), %r15
	movq	%r15, -40(%rbp)
	xorl	%r12d, %r12d
	leaq	-224(%rbp), %r14
	leaq	-232(%rbp), %rbx
	.align	4, 0x90
LBB1_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB1_2 Depth 2
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_gettimeofday
	xorps	%xmm0, %xmm0
	cvtsi2sdq	-224(%rbp), %xmm0
	xorps	%xmm2, %xmm2
	cvtsi2sdl	-216(%rbp), %xmm2
	movsd	LCPI1_0(%rip), %xmm1    ## xmm1 = mem[0],zero
	mulsd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	movsd	%xmm2, -240(%rbp)       ## 8-byte Spill
	.align	4, 0x90
LBB1_2:                                 ##   Parent Loop BB1_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_gettimeofday
	xorps	%xmm1, %xmm1
	cvtsi2sdq	-224(%rbp), %xmm1
	xorps	%xmm0, %xmm0
	cvtsi2sdl	-216(%rbp), %xmm0
	movsd	LCPI1_0(%rip), %xmm2    ## xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	subsd	-240(%rbp), %xmm1       ## 8-byte Folded Reload
	ucomisd	%xmm1, %xmm2
	ja	LBB1_2
## BB#3:                                ##   in Loop: Header=BB1_1 Depth=1
	movsd	%xmm0, -208(%rbp,%r12,8)
	incq	%r12
	cmpq	$20, %r12
	jne	LBB1_1
## BB#4:                                ## %.preheader
	movl	$1000000, %eax          ## imm = 0xF4240
	movsd	-208(%rbp), %xmm1       ## xmm1 = mem[0],zero
	movl	$1, %ecx
	movsd	LCPI1_1(%rip), %xmm0    ## xmm0 = mem[0],zero
	xorl	%edx, %edx
	.align	4, 0x90
LBB1_5:                                 ## =>This Inner Loop Header: Depth=1
	movl	%eax, %esi
	movsd	-208(%rbp,%rcx,8), %xmm2 ## xmm2 = mem[0],zero
	movapd	%xmm2, %xmm3
	subsd	%xmm1, %xmm3
	mulsd	%xmm0, %xmm3
	cvttsd2si	%xmm3, %eax
	testl	%eax, %eax
	cmovsl	%edx, %eax
	cmpl	%eax, %esi
	cmovlel	%esi, %eax
	incq	%rcx
	cmpq	$20, %rcx
	movapd	%xmm2, %xmm1
	jne	LBB1_5
## BB#6:
	cmpq	-40(%rbp), %r15
	jne	LBB1_8
## BB#7:
	addq	$224, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB1_8:
	callq	___stack_chk_fail
	.cfi_endproc

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI2_0:
	.quad	4517329193108106637     ## double 9.9999999999999995E-7
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_mysecond
	.align	4, 0x90
_mysecond:                              ## @mysecond
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp15:
	.cfi_def_cfa_offset 16
Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp17:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	-16(%rbp), %rdi
	leaq	-24(%rbp), %rsi
	callq	_gettimeofday
	cvtsi2sdq	-16(%rbp), %xmm1
	cvtsi2sdl	-8(%rbp), %xmm0
	mulsd	LCPI2_0(%rip), %xmm0
	addsd	%xmm1, %xmm0
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI3_0:
	.quad	-4435825312587309056    ## double -1153300781250
LCPI3_2:
	.quad	-4446501759469420544    ## double -230660156250
LCPI3_3:
	.quad	-4444517583842050048    ## double -307546875000
LCPI3_4:
	.quad	4703696862291427328     ## double 3.0E+6
LCPI3_5:
	.quad	4787546724267466752     ## double 1153300781250
LCPI3_6:
	.quad	4412443251819771522     ## double 1.0E-13
LCPI3_11:
	.quad	4776870277385355264     ## double 230660156250
LCPI3_13:
	.quad	4778854453012725760     ## double 307546875000
	.section	__TEXT,__literal16,16byte_literals
	.align	4
LCPI3_1:
	.quad	-9223372036854775808    ## 0x8000000000000000
	.quad	-9223372036854775808    ## 0x8000000000000000
LCPI3_7:
	.quad	4787546724267466752     ## double 1.153301e+12
	.quad	4787546724267466752     ## double 1.153301e+12
LCPI3_8:
	.quad	-4616189618054758400    ## double -1.000000e+00
	.quad	-4616189618054758400    ## double -1.000000e+00
LCPI3_9:
	.quad	4412443251819771522     ## double 1.000000e-13
	.quad	4412443251819771522     ## double 1.000000e-13
LCPI3_10:
	.quad	1                       ## 0x1
	.quad	1                       ## 0x1
LCPI3_12:
	.quad	4776870277385355264     ## double 2.306602e+11
	.quad	4776870277385355264     ## double 2.306602e+11
LCPI3_14:
	.quad	4778854453012725760     ## double 3.075469e+11
	.quad	4778854453012725760     ## double 3.075469e+11
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_checkSTREAMresults
	.align	4, 0x90
_checkSTREAMresults:                    ## @checkSTREAMresults
	.cfi_startproc
## BB#0:                                ## %.preheader22
	pushq	%rbp
Ltmp18:
	.cfi_def_cfa_offset 16
Ltmp19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp20:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
Ltmp21:
	.cfi_offset %rbx, -48
Ltmp22:
	.cfi_offset %r12, -40
Ltmp23:
	.cfi_offset %r14, -32
Ltmp24:
	.cfi_offset %r15, -24
	xorpd	%xmm1, %xmm1
	xorl	%eax, %eax
	leaq	_a(%rip), %rbx
	movsd	LCPI3_0(%rip), %xmm8    ## xmm8 = mem[0],zero
	movsd	LCPI3_1(%rip), %xmm4    ## xmm4 = mem[0],zero
	leaq	_b(%rip), %r12
	movsd	LCPI3_2(%rip), %xmm9    ## xmm9 = mem[0],zero
	leaq	_c(%rip), %r14
	movsd	LCPI3_3(%rip), %xmm10   ## xmm10 = mem[0],zero
	xorps	%xmm3, %xmm3
	xorps	%xmm0, %xmm0
	xorps	%xmm2, %xmm2
	.align	4, 0x90
LBB3_1:                                 ## =>This Inner Loop Header: Depth=1
	movsd	(%rax,%rbx), %xmm5      ## xmm5 = mem[0],zero
	addsd	%xmm8, %xmm5
	ucomisd	%xmm1, %xmm5
	jae	LBB3_3
## BB#2:                                ##   in Loop: Header=BB3_1 Depth=1
	xorpd	%xmm4, %xmm5
LBB3_3:                                 ##   in Loop: Header=BB3_1 Depth=1
	movsd	(%rax,%r12), %xmm6      ## xmm6 = mem[0],zero
	addsd	%xmm9, %xmm6
	ucomisd	%xmm1, %xmm6
	jae	LBB3_5
## BB#4:                                ##   in Loop: Header=BB3_1 Depth=1
	xorpd	%xmm4, %xmm6
LBB3_5:                                 ##   in Loop: Header=BB3_1 Depth=1
	movsd	(%rax,%r14), %xmm7      ## xmm7 = mem[0],zero
	addsd	%xmm10, %xmm7
	ucomisd	%xmm1, %xmm7
	jae	LBB3_7
## BB#6:                                ##   in Loop: Header=BB3_1 Depth=1
	xorpd	%xmm4, %xmm7
LBB3_7:                                 ##   in Loop: Header=BB3_1 Depth=1
	addsd	%xmm5, %xmm3
	addsd	%xmm6, %xmm2
	addsd	%xmm7, %xmm0
	addq	$8, %rax
	cmpq	$24000000, %rax         ## imm = 0x16E3600
	jne	LBB3_1
## BB#8:
	movsd	LCPI3_4(%rip), %xmm4    ## xmm4 = mem[0],zero
	divsd	%xmm4, %xmm3
	movapd	%xmm3, %xmm5
	divsd	LCPI3_5(%rip), %xmm5
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm5
	jae	LBB3_9
## BB#10:
	movsd	%xmm3, -56(%rbp)        ## 8-byte Spill
	xorpd	LCPI3_1(%rip), %xmm5
	jmp	LBB3_11
LBB3_9:
	movsd	%xmm3, -56(%rbp)        ## 8-byte Spill
LBB3_11:
	divsd	%xmm4, %xmm2
	xorl	%r15d, %r15d
	ucomisd	LCPI3_6(%rip), %xmm5
	jbe	LBB3_17
## BB#12:
	movsd	%xmm2, -48(%rbp)        ## 8-byte Spill
	movsd	%xmm0, -40(%rbp)        ## 8-byte Spill
	leaq	L_.str20(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	callq	_printf
	xorpd	%xmm0, %xmm0
	movsd	-56(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	movapd	%xmm1, %xmm2
	jae	LBB3_14
## BB#13:
	movsd	LCPI3_1(%rip), %xmm2    ## xmm2 = mem[0],zero
	xorpd	%xmm1, %xmm2
LBB3_14:                                ## %overflow.checked
	movsd	LCPI3_5(%rip), %xmm0    ## xmm0 = mem[0],zero
	divsd	%xmm0, %xmm2
	leaq	L_.str21(%rip), %rdi
	movb	$3, %al
	callq	_printf
	xorpd	%xmm7, %xmm7
	movl	$2, %eax
	movapd	LCPI3_7(%rip), %xmm8    ## xmm8 = [1.153301e+12,1.153301e+12]
	movapd	LCPI3_8(%rip), %xmm9    ## xmm9 = [-1.000000e+00,-1.000000e+00]
	movapd	LCPI3_1(%rip), %xmm10   ## xmm10 = [9223372036854775808,9223372036854775808]
	movapd	LCPI3_9(%rip), %xmm11   ## xmm11 = [1.000000e-13,1.000000e-13]
	movapd	LCPI3_10(%rip), %xmm4   ## xmm4 = [1,1]
	xorpd	%xmm3, %xmm3
	.align	4, 0x90
LBB3_15:                                ## %vector.body
                                        ## =>This Inner Loop Header: Depth=1
	movapd	%xmm3, %xmm5
	movapd	%xmm7, %xmm6
	movapd	-16(%rbx,%rax,8), %xmm3
	movapd	(%rbx,%rax,8), %xmm0
	divpd	%xmm8, %xmm3
	divpd	%xmm8, %xmm0
	addpd	%xmm9, %xmm3
	addpd	%xmm9, %xmm0
	xorpd	%xmm7, %xmm7
	cmpnlepd	%xmm3, %xmm7
	xorpd	%xmm2, %xmm2
	cmpnlepd	%xmm0, %xmm2
	movapd	%xmm7, %xmm1
	andnpd	%xmm3, %xmm1
	xorpd	%xmm10, %xmm3
	andpd	%xmm7, %xmm3
	orpd	%xmm1, %xmm3
	movapd	%xmm2, %xmm1
	andnpd	%xmm0, %xmm1
	xorpd	%xmm10, %xmm0
	andpd	%xmm2, %xmm0
	orpd	%xmm1, %xmm0
	movapd	%xmm11, %xmm7
	cmpltpd	%xmm3, %xmm7
	andpd	%xmm4, %xmm7
	movapd	%xmm11, %xmm3
	cmpltpd	%xmm0, %xmm3
	andpd	%xmm4, %xmm3
	paddq	%xmm6, %xmm7
	paddq	%xmm5, %xmm3
	addq	$4, %rax
	cmpq	$3000002, %rax          ## imm = 0x2DC6C2
	jne	LBB3_15
## BB#16:                               ## %middle.block
	paddq	%xmm7, %xmm3
	pshufd	$78, %xmm3, %xmm0       ## xmm0 = xmm3[2,3,0,1]
	paddq	%xmm3, %xmm0
	movd	%xmm0, %esi
	leaq	L_.str22(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %r15d
	movsd	-40(%rbp), %xmm0        ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	movsd	-48(%rbp), %xmm2        ## 8-byte Reload
                                        ## xmm2 = mem[0],zero
	movsd	LCPI3_4(%rip), %xmm4    ## xmm4 = mem[0],zero
LBB3_17:
	movapd	%xmm2, %xmm3
	divsd	LCPI3_11(%rip), %xmm3
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm3
	jae	LBB3_18
## BB#19:
	movsd	%xmm2, -48(%rbp)        ## 8-byte Spill
	xorpd	LCPI3_1(%rip), %xmm3
	jmp	LBB3_20
LBB3_18:
	movsd	%xmm2, -48(%rbp)        ## 8-byte Spill
LBB3_20:
	divsd	%xmm4, %xmm0
	ucomisd	LCPI3_6(%rip), %xmm3
	jbe	LBB3_26
## BB#21:
	movsd	%xmm0, -40(%rbp)        ## 8-byte Spill
	leaq	L_.str23(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	callq	_printf
	xorpd	%xmm0, %xmm0
	movsd	-48(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	movapd	%xmm1, %xmm2
	jae	LBB3_23
## BB#22:
	movsd	LCPI3_1(%rip), %xmm2    ## xmm2 = mem[0],zero
	xorpd	%xmm1, %xmm2
LBB3_23:                                ## %overflow.checked38
	incl	%r15d
	movsd	LCPI3_11(%rip), %xmm0   ## xmm0 = mem[0],zero
	divsd	%xmm0, %xmm2
	leaq	L_.str21(%rip), %rdi
	movb	$3, %al
	callq	_printf
	leaq	L_.str24(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	callq	_printf
	xorpd	%xmm7, %xmm7
	movl	$2, %eax
	movapd	LCPI3_12(%rip), %xmm8   ## xmm8 = [2.306602e+11,2.306602e+11]
	movapd	LCPI3_8(%rip), %xmm9    ## xmm9 = [-1.000000e+00,-1.000000e+00]
	movapd	LCPI3_1(%rip), %xmm10   ## xmm10 = [9223372036854775808,9223372036854775808]
	movapd	LCPI3_9(%rip), %xmm11   ## xmm11 = [1.000000e-13,1.000000e-13]
	movapd	LCPI3_10(%rip), %xmm4   ## xmm4 = [1,1]
	xorpd	%xmm3, %xmm3
	.align	4, 0x90
LBB3_24:                                ## %vector.body34
                                        ## =>This Inner Loop Header: Depth=1
	movapd	%xmm3, %xmm5
	movapd	%xmm7, %xmm6
	movapd	-16(%r12,%rax,8), %xmm3
	movapd	(%r12,%rax,8), %xmm0
	divpd	%xmm8, %xmm3
	divpd	%xmm8, %xmm0
	addpd	%xmm9, %xmm3
	addpd	%xmm9, %xmm0
	xorpd	%xmm7, %xmm7
	cmpnlepd	%xmm3, %xmm7
	xorpd	%xmm2, %xmm2
	cmpnlepd	%xmm0, %xmm2
	movapd	%xmm7, %xmm1
	andnpd	%xmm3, %xmm1
	xorpd	%xmm10, %xmm3
	andpd	%xmm7, %xmm3
	orpd	%xmm1, %xmm3
	movapd	%xmm2, %xmm1
	andnpd	%xmm0, %xmm1
	xorpd	%xmm10, %xmm0
	andpd	%xmm2, %xmm0
	orpd	%xmm1, %xmm0
	movapd	%xmm11, %xmm7
	cmpltpd	%xmm3, %xmm7
	andpd	%xmm4, %xmm7
	movapd	%xmm11, %xmm3
	cmpltpd	%xmm0, %xmm3
	andpd	%xmm4, %xmm3
	paddq	%xmm6, %xmm7
	paddq	%xmm5, %xmm3
	addq	$4, %rax
	cmpq	$3000002, %rax          ## imm = 0x2DC6C2
	jne	LBB3_24
## BB#25:                               ## %middle.block35
	paddq	%xmm7, %xmm3
	pshufd	$78, %xmm3, %xmm0       ## xmm0 = xmm3[2,3,0,1]
	paddq	%xmm3, %xmm0
	movd	%xmm0, %esi
	leaq	L_.str25(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movsd	-40(%rbp), %xmm0        ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
LBB3_26:
	movapd	%xmm0, %xmm2
	divsd	LCPI3_13(%rip), %xmm2
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm2
	jae	LBB3_27
## BB#28:
	movsd	%xmm0, -40(%rbp)        ## 8-byte Spill
	xorpd	LCPI3_1(%rip), %xmm2
	jmp	LBB3_29
LBB3_27:
	movsd	%xmm0, -40(%rbp)        ## 8-byte Spill
LBB3_29:
	ucomisd	LCPI3_6(%rip), %xmm2
	jbe	LBB3_35
## BB#30:
	leaq	L_.str26(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	callq	_printf
	xorpd	%xmm0, %xmm0
	movsd	-40(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	movapd	%xmm1, %xmm2
	jae	LBB3_32
## BB#31:
	movsd	LCPI3_1(%rip), %xmm2    ## xmm2 = mem[0],zero
	xorpd	%xmm1, %xmm2
LBB3_32:                                ## %overflow.checked68
	incl	%r15d
	movsd	LCPI3_13(%rip), %xmm0   ## xmm0 = mem[0],zero
	divsd	%xmm0, %xmm2
	leaq	L_.str21(%rip), %rdi
	movb	$3, %al
	callq	_printf
	leaq	L_.str24(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	callq	_printf
	pxor	%xmm7, %xmm7
	movl	$2, %eax
	movapd	LCPI3_14(%rip), %xmm8   ## xmm8 = [3.075469e+11,3.075469e+11]
	movapd	LCPI3_8(%rip), %xmm9    ## xmm9 = [-1.000000e+00,-1.000000e+00]
	movapd	LCPI3_1(%rip), %xmm10   ## xmm10 = [9223372036854775808,9223372036854775808]
	movapd	LCPI3_9(%rip), %xmm11   ## xmm11 = [1.000000e-13,1.000000e-13]
	movapd	LCPI3_10(%rip), %xmm4   ## xmm4 = [1,1]
	pxor	%xmm3, %xmm3
	.align	4, 0x90
LBB3_33:                                ## %vector.body64
                                        ## =>This Inner Loop Header: Depth=1
	movdqa	%xmm3, %xmm5
	movdqa	%xmm7, %xmm6
	movapd	-16(%r14,%rax,8), %xmm3
	movapd	(%r14,%rax,8), %xmm0
	divpd	%xmm8, %xmm3
	divpd	%xmm8, %xmm0
	addpd	%xmm9, %xmm3
	addpd	%xmm9, %xmm0
	pxor	%xmm7, %xmm7
	cmpnlepd	%xmm3, %xmm7
	xorpd	%xmm2, %xmm2
	cmpnlepd	%xmm0, %xmm2
	movapd	%xmm7, %xmm1
	andnpd	%xmm3, %xmm1
	xorpd	%xmm10, %xmm3
	andpd	%xmm7, %xmm3
	orpd	%xmm1, %xmm3
	movapd	%xmm2, %xmm1
	andnpd	%xmm0, %xmm1
	xorpd	%xmm10, %xmm0
	andpd	%xmm2, %xmm0
	orpd	%xmm1, %xmm0
	movapd	%xmm11, %xmm7
	cmpltpd	%xmm3, %xmm7
	andpd	%xmm4, %xmm7
	movapd	%xmm11, %xmm3
	cmpltpd	%xmm0, %xmm3
	andpd	%xmm4, %xmm3
	paddq	%xmm6, %xmm7
	paddq	%xmm5, %xmm3
	addq	$4, %rax
	cmpq	$3000002, %rax          ## imm = 0x2DC6C2
	jne	LBB3_33
## BB#34:                               ## %middle.block65
	paddq	%xmm7, %xmm3
	pshufd	$78, %xmm3, %xmm0       ## xmm0 = xmm3[2,3,0,1]
	paddq	%xmm3, %xmm0
	movd	%xmm0, %esi
	leaq	L_.str27(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
LBB3_35:
	testl	%r15d, %r15d
	je	LBB3_37
## BB#36:
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB3_37:
	leaq	L_.str28(%rip), %rdi
	movsd	LCPI3_6(%rip), %xmm0    ## xmm0 = mem[0],zero
	movb	$1, %al
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_printf                 ## TAILCALL
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str2:                                ## @.str2
	.asciz	"This system uses %d bytes per array element.\n"

L_.str3:                                ## @.str3
	.asciz	"Array size = %llu (elements), Offset = %d (elements)\n"

L_.str4:                                ## @.str4
	.asciz	"Memory per array = %.1f MiB (= %.1f GiB).\n"

L_.str5:                                ## @.str5
	.asciz	"Total memory required = %.1f MiB (= %.1f GiB).\n"

L_.str6:                                ## @.str6
	.asciz	"Each kernel will be executed %d times.\n"

.zerofill __DATA,__bss,_a,24000000,4    ## @a
.zerofill __DATA,__bss,_b,24000000,4    ## @b
.zerofill __DATA,__bss,_c,24000000,4    ## @c
L_.str9:                                ## @.str9
	.asciz	"Your clock granularity/precision appears to be %d microseconds.\n"

L_.str11:                               ## @.str11
	.asciz	"Each test below will take on the order of %d microseconds.\n"

L_.str12:                               ## @.str12
	.asciz	"   (= %d clock ticks)\n"

.zerofill __DATA,__bss,_avgtime,32,4    ## @avgtime
	.section	__DATA,__data
	.align	4                       ## @mintime
_mintime:
	.quad	5183643170566569984     ## double 3.402823e+38
	.quad	5183643170566569984     ## double 3.402823e+38
	.quad	5183643170566569984     ## double 3.402823e+38
	.quad	5183643170566569984     ## double 3.402823e+38

.zerofill __DATA,__bss,_maxtime,32,4    ## @maxtime
	.section	__TEXT,__cstring,cstring_literals
L_.str19:                               ## @.str19
	.asciz	"%s%12.1f  %11.6f  %11.6f  %11.6f\n"

L_.str20:                               ## @.str20
	.asciz	"Failed Validation on array a[], AvgRelAbsErr > epsilon (%e)\n"

L_.str21:                               ## @.str21
	.asciz	"     Expected Value: %e, AvgAbsErr: %e, AvgRelAbsErr: %e\n"

L_.str22:                               ## @.str22
	.asciz	"     For array a[], %d errors were found.\n"

L_.str23:                               ## @.str23
	.asciz	"Failed Validation on array b[], AvgRelAbsErr > epsilon (%e)\n"

L_.str24:                               ## @.str24
	.asciz	"     AvgRelAbsErr > Epsilon (%e)\n"

L_.str25:                               ## @.str25
	.asciz	"     For array b[], %d errors were found.\n"

L_.str26:                               ## @.str26
	.asciz	"Failed Validation on array c[], AvgRelAbsErr > epsilon (%e)\n"

L_.str27:                               ## @.str27
	.asciz	"     For array c[], %d errors were found.\n"

L_.str28:                               ## @.str28
	.asciz	"Solution Validates: avg error less than %e on all three arrays\n"

L_.str29:                               ## @.str29
	.asciz	"Copy:      "

L_.str30:                               ## @.str30
	.asciz	"Scale:     "

L_.str31:                               ## @.str31
	.asciz	"Add:       "

L_.str32:                               ## @.str32
	.asciz	"Triad:     "

	.align	4                       ## @str33
L_str33:
	.asciz	"STREAM version $Revision: 5.10 $"

	.align	4                       ## @str36
L_str36:
	.asciz	" The *best* time for each kernel (excluding the first iteration)"

	.align	4                       ## @str37
L_str37:
	.asciz	" will be used to compute the reported bandwidth."

	.align	4                       ## @str39
L_str39:
	.asciz	"Your clock granularity appears to be less than one microsecond."

	.align	4                       ## @str40
L_str40:
	.asciz	"Increase the size of the arrays if this shows that"

	.align	4                       ## @str41
L_str41:
	.asciz	"you are not getting at least 20 clock ticks per test."

	.align	4                       ## @str43
L_str43:
	.asciz	"WARNING -- The above is only a rough guideline."

	.align	4                       ## @str44
L_str44:
	.asciz	"For best results, please be sure you know the"

	.align	4                       ## @str45
L_str45:
	.asciz	"precision of your system timer."

	.align	4                       ## @str47
L_str47:
	.asciz	"Function    Best Rate MB/s  Avg time     Min time     Max time"

	.align	4                       ## @str49
L_str49:
	.asciz	"-------------------------------------------------------------"

	.section	__TEXT,__const
	.align	4                       ## @.memset_pattern
_.memset_pattern:
	.quad	4607182418800017408     ## double 1.000000e+00
	.quad	4607182418800017408     ## double 1.000000e+00

	.align	4                       ## @.memset_pattern50
_.memset_pattern50:
	.quad	4611686018427387904     ## double 2.000000e+00
	.quad	4611686018427387904     ## double 2.000000e+00


.subsections_via_symbols
