!核心代码

entry start
start:

! 打印"NOW we are in SETUP"
       mov ah,#0x03        ! 首先读入光标位置
       xor bh,bh
       int 0x10
    
       mov cx,#25          ! 显示的字符串长度为25
       mov bx,#0x0007
       mov bp,#msg2        !msg2
    
       mov ax,cs     !这个时候需要修改es的值，可以使用cs的值
       mov es,ax           
    
       mov ax,#0x1301
       int 0x10


!------------以下是linux0.11自带的代码---------------------------------------
! ok, the read went well so we get current cursor position and save it for
! posterity.

	mov	ax,#INITSEG	    ! this is done in bootsect already, but...
	mov	ds,ax           !将ds置成0x9000,也可省略不写

!读光标位置
	mov	ah,#0x03	! 功能号ah=0x03
	xor	bh,bh         
	int	0x10		! 调用BIOS中断0x10
	mov	[0],dx		! 光标信息存放在0x90000.

!读内存大小（扩展内存，kb）
! Get memory size (extended mem, kB)

	mov	ah,#0x88         ! 功能号ah=0x88
	int	0x15             ! 调用BIOS中断0x15
	mov	[2],ax           ! 内存信息存放在0x90002.
!读第一个硬盘参数表
	mov	ax,#0x0000
	mov	ds,ax
	lds	si,[4*0x41]     !取中断向量0x41的值，即第一个硬盘参数表的地址
	mov	ax,#INITSEG
	mov	es,ax
	mov	di,#0x0080
	mov	cx,#0x10
	rep
	movsb
!－－－－－－－－－－----------－－－－－－－－－－－－－－----－


! 准备打印
    mov ax,#INITSEG    
    mov ds,ax             !前面修改了ds寄存器，这里将其设置为0x9000
    mov ax,#SETUPSEG
    mov es,ax             !前面修改了es寄存器，这里将其设置为0x9020

! 显示光标位置
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#18            
    mov bx,#0x0007
    mov bp,#msg_cursor
    mov ax,#0x1301
    int 0x10

    mov dx,[0]
    call    print_hex     !调用 print_hex 显示具体信息
    call    print_nl      !换行

! 显示内存大小
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#14
    mov bx,#0x0007
    mov bp,#msg_memory
    mov ax,#0x1301
    int 0x10

    mov dx,[2]
    call    print_hex     !调用 print_hex 显示具体信息
! 添加内存大小单位：KB
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#2             !长度
    mov bx,#0x0007
    mov bp,#msg_kb
    mov ax,#0x1301
    int 0x10

! cylinders
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#7             !长度
    mov bx,#0x0007
    mov bp,#msg_cyles
    mov ax,#0x1301
    int 0x10

    mov dx,[0x80]          !cylinders的参数我们没有获取放到90000处，所以默认放在0x80处
    call    print_hex      !调用 print_hex 显示具体信息
    call    print_nl       !换行

! Heads
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#8
    mov bx,#0x0007
    mov bp,#msg_heads
    mov ax,#0x1301
    int 0x10

    mov dx,[0x80+0x02]     !Heads的参数我们没有获取放到90000处，所以默认放在0x80+0x02处
    call    print_hex      !调用 print_hex 显示具体信息
    call    print_nl       !换行

! Secotrs
    mov ah,#0x03
    xor bh,bh
    int 0x10
    mov cx,#10
    mov bx,#0x0007
    mov bp,#msg_sectors
    mov ax,#0x1301
    int 0x10

    mov dx,[0x80+0x0e]     ! Secotrs的参数我们没有获取放到90000处，所以默认放在0x80+0x0e处
    call    print_hex      !调用 print_hex 显示具体信息
    call    print_nl       !换行


inf_loop:               ! 设置一个无限循环，使得光标停在这里，不用继续执行下去
    jmp inf_loop



!-----以下函数放在文档末，供调用--------------------------
print_hex:
    mov    cx,#4
print_digit:
    rol    dx,#4
    mov    ax,#0xe0f
    and    al,dl
    add    al,#0x30
    cmp    al,#0x3a
    jl     outp
    add    al,#0x07
outp:
    int    0x10
    loop   print_digit
    ret
print_nl:
    mov    ax,#0xe0d     ! CR
    int    0x10
    mov    al,#0xa     ! LF
    int    0x10
    ret

msg2:
    .byte 13,10
    .ascii "NOW we are in SETUP"
    .byte 13,10,13,10
msg_cursor:
    .byte 13,10
    .ascii "Cursor position:"
msg_memory:
    .byte 13,10
    .ascii "Memory Size:"
msg_cyles:
    .byte 13,10
    .ascii "Cyls:"
msg_heads:
    .byte 13,10
    .ascii "Heads:"
msg_sectors:
    .byte 13,10
    .ascii "Sectors:"
msg_kb:
    .ascii "KB"
