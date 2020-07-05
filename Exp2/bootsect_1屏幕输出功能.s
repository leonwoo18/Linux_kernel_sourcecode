
!核心代码

entry _start
_start:

!打印HongOS is Loading...
    mov ah,#0x03       ! 首先读入光标位置
    xor bh,bh
    int 0x10
    
    mov cx,#26          ! 将显示的字符串长度改为26
    mov bx,#0x0007
    mov bp,#msg1        !标号为msg1
 
 !---------这两行是自己添加进去的---------------------
    mov ax,#0x07c0      !相比与 linux-0.11 中的代码，需要增加对 es 的处理
    mov es,ax           !因为linux-0.11有把bootsect.c从07c0搬运到了9000位置
 !-------------------------------------------------
 
    mov ax,#0x1301
    int 0x10
    
inf_loop:               ! 设置一个无限循环，使得光标停在这里，不用继续执行下去
    jmp inf_loop

msg1:                   ! msg1 处放置字符串 
    .byte   13,10
    .ascii  "HongOS is Loading..."    ！利洪的洪，字符长度为26
    .byte   13,10,13,10

.org 510                 ! boot_flag 必须在最后两个字节,即510地址处
boot_flag:
    .word   0xAA55       ! 设置引导扇区标记 0xAA55，必须有它，才能引导
