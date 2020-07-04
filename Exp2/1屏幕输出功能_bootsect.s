！完成 bootsect.s 的屏幕输出功能
！核心代码

entry _start
_start:
    mov ah,#0x03       ! 首先读入光标位置
    xor bh,bh
    int 0x10
    
    mov cx,#26          ! 将显示的字符串长度改为26
    mov bx,#0x0007
    mov bp,#msg1
    
    mov ax,#0x07c0      ！这两行是自己添加进去的
    mov es,ax           ! 相比与 linux-0.11 中的代码，需要增加对 es 的处理，因为原代码中在输出之前已经处理了 es
    
    mov ax,#0x1301
    int 0x10
    
inf_loop:               ! 设置一个无限循环，使得光标停在这里，不用继续执行下去
    jmp inf_loop

msg1:                   ! msg1 处放置字符串 
    .byte   13,10
    .ascii  "HongOS is Loading..."    ！利洪的洪
    .byte   13,10,13,10

.org 510                 ! boot_flag 必须在最后两个字节,即510地址处
boot_flag:
    .word   0xAA55       ! 设置引导扇区标记 0xAA55，必须有它，才能引导
