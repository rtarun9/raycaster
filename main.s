	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.file	"main.c"
	.def	sprintf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,sprintf
	.globl	sprintf                         # -- Begin function sprintf
	.p2align	4, 0x90
sprintf:                                # @sprintf
.seh_proc sprintf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 104(%rsp)
	movq	%r8, 96(%rsp)
	movq	%rdx, 64(%rsp)
	movq	%rcx, 56(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	40(%rsp), %r9
	movq	64(%rsp), %rdx
	movq	56(%rsp), %rcx
	xorl	%eax, %eax
	movl	%eax, %r8d
	callq	_vsprintf_l
	movl	%eax, 52(%rsp)
	movl	52(%rsp), %eax
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	vsprintf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,vsprintf
	.globl	vsprintf                        # -- Begin function vsprintf
	.p2align	4, 0x90
vsprintf:                               # @vsprintf
.seh_proc vsprintf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r8, 64(%rsp)
	movq	%rdx, 56(%rsp)
	movq	%rcx, 48(%rsp)
	movq	64(%rsp), %rax
	movq	56(%rsp), %r8
	movq	48(%rsp), %rcx
	movq	$-1, %rdx
	xorl	%r9d, %r9d
                                        # kill: def $r9 killed $r9d
	movq	%rax, 32(%rsp)
	callq	_vsnprintf_l
	nop
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	_snprintf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,_snprintf
	.globl	_snprintf                       # -- Begin function _snprintf
	.p2align	4, 0x90
_snprintf:                              # @_snprintf
.seh_proc _snprintf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 104(%rsp)
	movq	%r8, 64(%rsp)
	movq	%rdx, 56(%rsp)
	movq	%rcx, 48(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	32(%rsp), %r9
	movq	64(%rsp), %r8
	movq	56(%rsp), %rdx
	movq	48(%rsp), %rcx
	callq	_vsnprintf
	movl	%eax, 44(%rsp)
	movl	44(%rsp), %eax
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	_vsnprintf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,_vsnprintf
	.globl	_vsnprintf                      # -- Begin function _vsnprintf
	.p2align	4, 0x90
_vsnprintf:                             # @_vsnprintf
.seh_proc _vsnprintf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 64(%rsp)
	movq	%r8, 56(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%rcx, 40(%rsp)
	movq	64(%rsp), %rax
	movq	56(%rsp), %r8
	movq	48(%rsp), %rdx
	movq	40(%rsp), %rcx
	xorl	%r9d, %r9d
                                        # kill: def $r9 killed $r9d
	movq	%rax, 32(%rsp)
	callq	_vsnprintf_l
	nop
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	write_to_file;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	write_to_file                   # -- Begin function write_to_file
	.p2align	4, 0x90
write_to_file:                          # @write_to_file
.seh_proc write_to_file
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%rcx, 64(%rsp)
	leaq	56(%rsp), %rcx
	leaq	"??_C@_0L@PJKEJNGA@output?4ppm?$AA@"(%rip), %rdx
	leaq	"??_C@_02CHHAKFFB@w?$CL?$AA@"(%rip), %r8
	callq	fopen_s
	movl	%eax, 52(%rsp)
	cmpl	$0, 52(%rsp)
	je	.LBB4_2
# %bb.1:
	leaq	"??_C@_0CI@DNCLNCJD@Failed?5to?5open?5?1?5create?5file?5out@"(%rip), %rcx
	callq	printf
	jmp	.LBB4_11
.LBB4_2:
	movq	56(%rsp), %rcx
	movq	%rsp, %rax
	movl	$255, 32(%rax)
	leaq	"??_C@_0N@CBMMJBPB@P3?6?$CFu?5?$CFu?6?$CFu?6?$AA@"(%rip), %rdx
	movl	$256, %r9d                      # imm = 0x100
	movl	%r9d, %r8d
	callq	fprintf
	movw	$0, 50(%rsp)
.LBB4_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_5 Depth 2
	movzwl	50(%rsp), %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB4_10
# %bb.4:                                #   in Loop: Header=BB4_3 Depth=1
	movw	$0, 48(%rsp)
.LBB4_5:                                #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	48(%rsp), %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB4_8
# %bb.6:                                #   in Loop: Header=BB4_5 Depth=2
	movq	64(%rsp), %rax
	movzwl	50(%rsp), %ecx
	shll	$8, %ecx
	movzwl	48(%rsp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 44(%rsp)
	movl	44(%rsp), %edx
	andl	$255, %edx
	movl	44(%rsp), %r9d
	shrl	$8, %r9d
	andl	$255, %r9d
	movl	44(%rsp), %r8d
	shrl	$16, %r8d
	andl	$255, %r8d
	movq	56(%rsp), %rcx
	movq	%rsp, %rax
	movl	%edx, 32(%rax)
	leaq	"??_C@_09KBLKMPIJ@?$CFu?5?$CFu?5?$CFu?5?$AA@"(%rip), %rdx
	callq	fprintf
# %bb.7:                                #   in Loop: Header=BB4_5 Depth=2
	movw	48(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 48(%rsp)
	jmp	.LBB4_5
.LBB4_8:                                #   in Loop: Header=BB4_3 Depth=1
	movq	56(%rsp), %rcx
	leaq	"??_C@_01EEMJAFIK@?6?$AA@"(%rip), %rdx
	callq	fprintf
# %bb.9:                                #   in Loop: Header=BB4_3 Depth=1
	movw	50(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 50(%rsp)
	jmp	.LBB4_3
.LBB4_10:
	movq	56(%rsp), %rcx
	callq	fclose
.LBB4_11:
	nop
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	printf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,printf
	.globl	printf                          # -- Begin function printf
	.p2align	4, 0x90
printf:                                 # @printf
.seh_proc printf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 104(%rsp)
	movq	%r8, 96(%rsp)
	movq	%rdx, 88(%rsp)
	movq	%rcx, 64(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movl	$1, %ecx
	callq	__acrt_iob_func
	movq	32(%rsp), %rdx                  # 8-byte Reload
	movq	40(%rsp), %r9                   # 8-byte Reload
	movq	%rax, %rcx
	xorl	%eax, %eax
	movl	%eax, %r8d
	callq	_vfprintf_l
	movl	%eax, 60(%rsp)
	movl	60(%rsp), %eax
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	fprintf;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,fprintf
	.globl	fprintf                         # -- Begin function fprintf
	.p2align	4, 0x90
fprintf:                                # @fprintf
.seh_proc fprintf
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 104(%rsp)
	movq	%r8, 96(%rsp)
	movq	%rdx, 64(%rsp)
	movq	%rcx, 56(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	40(%rsp), %r9
	movq	64(%rsp), %rdx
	movq	56(%rsp), %rcx
	xorl	%eax, %eax
	movl	%eax, %r8d
	callq	_vfprintf_l
	movl	%eax, 52(%rsp)
	movl	52(%rsp), %eax
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.globl	__real@437f0000                 # -- Begin function main
	.section	.rdata,"dr",discard,__real@437f0000
	.p2align	2, 0x0
__real@437f0000:
	.long	0x437f0000                      # float 255
	.text
	.globl	main
	.p2align	4, 0x90
main:                                   # @main
.seh_proc main
# %bb.0:
	subq	$328, %rsp                      # imm = 0x148
	.seh_stackalloc 328
	.seh_endprologue
	movl	$0, 324(%rsp)
	movb	$8, 323(%rsp)
	movb	$8, 322(%rsp)
	leaq	64(%rsp), %rcx
	leaq	.L__const.main.game_map(%rip), %rdx
	movl	$256, %r8d                      # imm = 0x100
	callq	memcpy
	movl	$262144, %ecx                   # imm = 0x40000
	callq	malloc
	movq	%rax, 56(%rsp)
	movw	$0, 54(%rsp)
.LBB7_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_3 Depth 2
	movzwl	54(%rsp), %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB7_8
# %bb.2:                                #   in Loop: Header=BB7_1 Depth=1
	movw	$0, 52(%rsp)
.LBB7_3:                                #   Parent Loop BB7_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	52(%rsp), %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB7_6
# %bb.4:                                #   in Loop: Header=BB7_3 Depth=2
	movzwl	54(%rsp), %eax
	cvtsi2ss	%eax, %xmm0
	movss	__real@437f0000(%rip), %xmm1    # xmm1 = mem[0],zero,zero,zero
	divss	%xmm1, %xmm0
	mulss	%xmm1, %xmm0
	cvttss2si	%xmm0, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, 51(%rsp)
	movzwl	52(%rsp), %eax
	cvtsi2ss	%eax, %xmm0
	divss	%xmm1, %xmm0
	mulss	%xmm1, %xmm0
	cvttss2si	%xmm0, %rax
                                        # kill: def $eax killed $eax killed $rax
	movl	%eax, 44(%rsp)
	movzbl	51(%rsp), %edx
	shll	$16, %edx
	movl	44(%rsp), %eax
	shll	$8, %eax
	orl	%eax, %edx
	movq	56(%rsp), %rax
	movzwl	54(%rsp), %ecx
	shll	$8, %ecx
	movzwl	52(%rsp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.5:                                #   in Loop: Header=BB7_3 Depth=2
	movw	52(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 52(%rsp)
	jmp	.LBB7_3
.LBB7_6:                                #   in Loop: Header=BB7_1 Depth=1
	jmp	.LBB7_7
.LBB7_7:                                #   in Loop: Header=BB7_1 Depth=1
	movw	54(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 54(%rsp)
	jmp	.LBB7_1
.LBB7_8:
	movw	$0, 42(%rsp)
.LBB7_9:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_11 Depth 2
                                        #       Child Loop BB7_14 Depth 3
                                        #         Child Loop BB7_16 Depth 4
	movzwl	42(%rsp), %eax
	cmpl	$16, %eax
	jge	.LBB7_33
# %bb.10:                               #   in Loop: Header=BB7_9 Depth=1
	movw	$0, 40(%rsp)
.LBB7_11:                               #   Parent Loop BB7_9 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_14 Depth 3
                                        #         Child Loop BB7_16 Depth 4
	movzwl	40(%rsp), %eax
	cmpl	$16, %eax
	jge	.LBB7_31
# %bb.12:                               #   in Loop: Header=BB7_11 Depth=2
	movzwl	42(%rsp), %eax
	shll	$4, %eax
	movzwl	40(%rsp), %ecx
	addl	%ecx, %eax
	cltq
	movzbl	64(%rsp,%rax), %eax
	cmpl	$49, %eax
	jne	.LBB7_25
# %bb.13:                               #   in Loop: Header=BB7_11 Depth=2
	movw	$0, 38(%rsp)
.LBB7_14:                               #   Parent Loop BB7_9 Depth=1
                                        #     Parent Loop BB7_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB7_16 Depth 4
	movzwl	38(%rsp), %eax
	cmpl	$16, %eax
	jge	.LBB7_24
# %bb.15:                               #   in Loop: Header=BB7_14 Depth=3
	movw	$0, 36(%rsp)
.LBB7_16:                               #   Parent Loop BB7_9 Depth=1
                                        #     Parent Loop BB7_11 Depth=2
                                        #       Parent Loop BB7_14 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movzwl	36(%rsp), %eax
	cmpl	$16, %eax
	jge	.LBB7_22
# %bb.17:                               #   in Loop: Header=BB7_16 Depth=4
	movzwl	42(%rsp), %eax
	movzwl	38(%rsp), %ecx
	addl	%ecx, %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB7_20
# %bb.18:                               #   in Loop: Header=BB7_16 Depth=4
	movzwl	40(%rsp), %eax
	movzwl	36(%rsp), %ecx
	addl	%ecx, %eax
	cmpl	$256, %eax                      # imm = 0x100
	jge	.LBB7_20
# %bb.19:                               #   in Loop: Header=BB7_16 Depth=4
	movq	56(%rsp), %rax
	movzwl	42(%rsp), %ecx
	shll	$4, %ecx
	movzwl	38(%rsp), %edx
	addl	%edx, %ecx
	shll	$8, %ecx
	movzwl	40(%rsp), %edx
	shll	$4, %edx
	movzwl	36(%rsp), %r8d
	addl	%r8d, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movl	$0, (%rax,%rcx,4)
.LBB7_20:                               #   in Loop: Header=BB7_16 Depth=4
	jmp	.LBB7_21
.LBB7_21:                               #   in Loop: Header=BB7_16 Depth=4
	movw	36(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 36(%rsp)
	jmp	.LBB7_16
.LBB7_22:                               #   in Loop: Header=BB7_14 Depth=3
	jmp	.LBB7_23
.LBB7_23:                               #   in Loop: Header=BB7_14 Depth=3
	movw	38(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 38(%rsp)
	jmp	.LBB7_14
.LBB7_24:                               #   in Loop: Header=BB7_11 Depth=2
	jmp	.LBB7_29
.LBB7_25:                               #   in Loop: Header=BB7_11 Depth=2
	movzwl	40(%rsp), %eax
	cmpl	$8, %eax
	jne	.LBB7_28
# %bb.26:                               #   in Loop: Header=BB7_11 Depth=2
	movzwl	42(%rsp), %eax
	cmpl	$8, %eax
	jne	.LBB7_28
# %bb.27:                               #   in Loop: Header=BB7_11 Depth=2
	movq	56(%rsp), %rax
	movzwl	42(%rsp), %ecx
	shll	$4, %ecx
	shll	$8, %ecx
	movzwl	40(%rsp), %edx
	shll	$4, %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movl	$16777215, (%rax,%rcx,4)        # imm = 0xFFFFFF
.LBB7_28:                               #   in Loop: Header=BB7_11 Depth=2
	jmp	.LBB7_29
.LBB7_29:                               #   in Loop: Header=BB7_11 Depth=2
	jmp	.LBB7_30
.LBB7_30:                               #   in Loop: Header=BB7_11 Depth=2
	movw	40(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 40(%rsp)
	jmp	.LBB7_11
.LBB7_31:                               #   in Loop: Header=BB7_9 Depth=1
	jmp	.LBB7_32
.LBB7_32:                               #   in Loop: Header=BB7_9 Depth=1
	movw	42(%rsp), %ax
	addw	$1, %ax
	movw	%ax, 42(%rsp)
	jmp	.LBB7_9
.LBB7_33:
	movq	56(%rsp), %rcx
	callq	write_to_file
	movq	56(%rsp), %rcx
	callq	free
	xorl	%eax, %eax
	addq	$328, %rsp                      # imm = 0x148
	retq
	.seh_endproc
                                        # -- End function
	.def	_vsprintf_l;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,_vsprintf_l
	.globl	_vsprintf_l                     # -- Begin function _vsprintf_l
	.p2align	4, 0x90
_vsprintf_l:                            # @_vsprintf_l
.seh_proc _vsprintf_l
# %bb.0:
	subq	$72, %rsp
	.seh_stackalloc 72
	.seh_endprologue
	movq	%r9, 64(%rsp)
	movq	%r8, 56(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%rcx, 40(%rsp)
	movq	64(%rsp), %rax
	movq	56(%rsp), %r9
	movq	48(%rsp), %r8
	movq	40(%rsp), %rcx
	movq	$-1, %rdx
	movq	%rax, 32(%rsp)
	callq	_vsnprintf_l
	nop
	addq	$72, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	_vsnprintf_l;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,_vsnprintf_l
	.globl	_vsnprintf_l                    # -- Begin function _vsnprintf_l
	.p2align	4, 0x90
_vsnprintf_l:                           # @_vsnprintf_l
.seh_proc _vsnprintf_l
# %bb.0:
	subq	$136, %rsp
	.seh_stackalloc 136
	.seh_endprologue
	movq	176(%rsp), %rax
	movq	%r9, 128(%rsp)
	movq	%r8, 120(%rsp)
	movq	%rdx, 112(%rsp)
	movq	%rcx, 104(%rsp)
	movq	176(%rsp), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	128(%rsp), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	120(%rsp), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	112(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	104(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	callq	__local_stdio_printf_options
	movq	56(%rsp), %rdx                  # 8-byte Reload
	movq	64(%rsp), %r8                   # 8-byte Reload
	movq	72(%rsp), %r9                   # 8-byte Reload
	movq	80(%rsp), %r10                  # 8-byte Reload
	movq	%rax, %rcx
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	(%rcx), %rcx
	orq	$1, %rcx
	movq	%r10, 32(%rsp)
	movq	%rax, 40(%rsp)
	callq	__stdio_common_vsprintf
	movl	%eax, 100(%rsp)
	cmpl	$0, 100(%rsp)
	jge	.LBB9_2
# %bb.1:
	movl	$4294967295, %eax               # imm = 0xFFFFFFFF
	movl	%eax, 52(%rsp)                  # 4-byte Spill
	jmp	.LBB9_3
.LBB9_2:
	movl	100(%rsp), %eax
	movl	%eax, 52(%rsp)                  # 4-byte Spill
.LBB9_3:
	movl	52(%rsp), %eax                  # 4-byte Reload
	addq	$136, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.def	__local_stdio_printf_options;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,__local_stdio_printf_options
	.globl	__local_stdio_printf_options    # -- Begin function __local_stdio_printf_options
	.p2align	4, 0x90
__local_stdio_printf_options:           # @__local_stdio_printf_options
# %bb.0:
	leaq	__local_stdio_printf_options._OptionsStorage(%rip), %rax
	retq
                                        # -- End function
	.def	_vfprintf_l;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",discard,_vfprintf_l
	.globl	_vfprintf_l                     # -- Begin function _vfprintf_l
	.p2align	4, 0x90
_vfprintf_l:                            # @_vfprintf_l
.seh_proc _vfprintf_l
# %bb.0:
	subq	$104, %rsp
	.seh_stackalloc 104
	.seh_endprologue
	movq	%r9, 96(%rsp)
	movq	%r8, 88(%rsp)
	movq	%rdx, 80(%rsp)
	movq	%rcx, 72(%rsp)
	movq	96(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	80(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	callq	__local_stdio_printf_options
	movq	40(%rsp), %rdx                  # 8-byte Reload
	movq	48(%rsp), %r8                   # 8-byte Reload
	movq	56(%rsp), %r9                   # 8-byte Reload
	movq	%rax, %rcx
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	(%rcx), %rcx
	movq	%rax, 32(%rsp)
	callq	__stdio_common_vfprintf
	nop
	addq	$104, %rsp
	retq
	.seh_endproc
                                        # -- End function
	.section	.rdata,"dr"
	.globl	MAP_CELL_ENTRY_WIDTH            # @MAP_CELL_ENTRY_WIDTH
MAP_CELL_ENTRY_WIDTH:
	.byte	16                              # 0x10

	.globl	MAP_CELL_ENTRY_HEIGHT           # @MAP_CELL_ENTRY_HEIGHT
MAP_CELL_ENTRY_HEIGHT:
	.byte	16                              # 0x10

	.section	.rdata,"dr",discard,"??_C@_02CHHAKFFB@w?$CL?$AA@"
	.globl	"??_C@_02CHHAKFFB@w?$CL?$AA@"   # @"??_C@_02CHHAKFFB@w?$CL?$AA@"
"??_C@_02CHHAKFFB@w?$CL?$AA@":
	.asciz	"w+"

	.section	.rdata,"dr",discard,"??_C@_0L@PJKEJNGA@output?4ppm?$AA@"
	.globl	"??_C@_0L@PJKEJNGA@output?4ppm?$AA@" # @"??_C@_0L@PJKEJNGA@output?4ppm?$AA@"
"??_C@_0L@PJKEJNGA@output?4ppm?$AA@":
	.asciz	"output.ppm"

	.section	.rdata,"dr",discard,"??_C@_0CI@DNCLNCJD@Failed?5to?5open?5?1?5create?5file?5out@"
	.globl	"??_C@_0CI@DNCLNCJD@Failed?5to?5open?5?1?5create?5file?5out@" # @"??_C@_0CI@DNCLNCJD@Failed?5to?5open?5?1?5create?5file?5out@"
"??_C@_0CI@DNCLNCJD@Failed?5to?5open?5?1?5create?5file?5out@":
	.asciz	"Failed to open / create file output.ppm"

	.section	.rdata,"dr",discard,"??_C@_0N@CBMMJBPB@P3?6?$CFu?5?$CFu?6?$CFu?6?$AA@"
	.globl	"??_C@_0N@CBMMJBPB@P3?6?$CFu?5?$CFu?6?$CFu?6?$AA@" # @"??_C@_0N@CBMMJBPB@P3?6?$CFu?5?$CFu?6?$CFu?6?$AA@"
"??_C@_0N@CBMMJBPB@P3?6?$CFu?5?$CFu?6?$CFu?6?$AA@":
	.asciz	"P3\n%u %u\n%u\n"

	.section	.rdata,"dr",discard,"??_C@_09KBLKMPIJ@?$CFu?5?$CFu?5?$CFu?5?$AA@"
	.globl	"??_C@_09KBLKMPIJ@?$CFu?5?$CFu?5?$CFu?5?$AA@" # @"??_C@_09KBLKMPIJ@?$CFu?5?$CFu?5?$CFu?5?$AA@"
"??_C@_09KBLKMPIJ@?$CFu?5?$CFu?5?$CFu?5?$AA@":
	.asciz	"%u %u %u "

	.section	.rdata,"dr",discard,"??_C@_01EEMJAFIK@?6?$AA@"
	.globl	"??_C@_01EEMJAFIK@?6?$AA@"      # @"??_C@_01EEMJAFIK@?6?$AA@"
"??_C@_01EEMJAFIK@?6?$AA@":
	.asciz	"\n"

	.section	.rdata,"dr"
	.p2align	4, 0x0                          # @__const.main.game_map
.L__const.main.game_map:
	.ascii	"1000000000000000000000000000000000000000000000000000000000000000000000111110000000000010000000000000001000000000000000100000000000011110000000000000000000000000000000111110000000000010011000000000000001100000000000000110000000000000000000000000000000000001"

	.lcomm	__local_stdio_printf_options._OptionsStorage,8,8 # @__local_stdio_printf_options._OptionsStorage
	.addrsig
	.addrsig_sym _vsnprintf
	.addrsig_sym write_to_file
	.addrsig_sym fopen_s
	.addrsig_sym printf
	.addrsig_sym fprintf
	.addrsig_sym fclose
	.addrsig_sym malloc
	.addrsig_sym free
	.addrsig_sym _vsprintf_l
	.addrsig_sym _vsnprintf_l
	.addrsig_sym __stdio_common_vsprintf
	.addrsig_sym __local_stdio_printf_options
	.addrsig_sym _vfprintf_l
	.addrsig_sym __acrt_iob_func
	.addrsig_sym __stdio_common_vfprintf
	.addrsig_sym __local_stdio_printf_options._OptionsStorage
	.globl	_fltused
