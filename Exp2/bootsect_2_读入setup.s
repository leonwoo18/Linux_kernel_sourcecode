!核心代码

SETUPLEN=2          !linux-0.11为4个扇区
SETUPSEG=0x07e0     !linux-0.11为0x9020

entry _start
_start:

!打印HongOS is Loading...
    mov ah,#0x03       ! 首先读入光标位置
    xor bh,bh
    int 0x10
    
    mov cx,#23          ! 要显示的字符串长度
    mov bx,#0x0007
    mov bp,#msg1
    
    mov ax,#0x07c0
    mov es,ax             !linux-0.11的es为0x9000
    
    mov ax,#0x1301
    int 0x10
  
!-------------把setup.s读进内存的核心代码-------------------------------------------------------------------------------
load_setup:                   
    mov dx,#0x0000  
    mov cx,#0x0002            !2号扇区开始读起
    mov bx,#0x0200            !es:bx,所以linux-0.11为0x90200，即setup.c放的开始位置
    mov ax,#0x0200+SETUPLEN   !读（02）+扇区个数（SETUPLEN）
    int 0x13
    jnc ok_load_setup         !正常读取后，跳转到ok_load_setup
    
    
    mov dx,#0x0000            !出错时，复位
    mov ax,#0x0000
    int 0x13
    jmp load_setup            !尝试重新读取
       
ok_load_setup:
    jmpi    0,SETUPSEG        !处我们没有搬移 bootsect，所以跳转到7e00; linux0.11有搬移，则需跳转到90200
!------------------------------------------------------------------------------------------------------

msg1:                   ! msg1 处放置字符串 
    .byte   13,10
    .ascii  "HongOS is Loading"
    .byte   13,10,13,10

.org 510                 ! boot_flag 必须在最后两个字节,即510地址处
boot_flag:
    .word   0xAA55       ! 设置引导扇区标记 0xAA55，必须有它，才能引导
