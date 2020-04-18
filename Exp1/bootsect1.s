！核心代码

entry _start
_start:
    mov ah,#0x03       ! 首先读入光标位置
    xor bh,bh
    int 0x10
    
    mov cx,#36          ! 要显示的字符串长度
    mov bx,#0x0007
    mov bp,#msg1
    
    mov ax,#0x07c0
    mov es,ax
    mov ax,#0x1301
    int 0x10
    
inf_loop:               ! 设置一个无限循环
    jmp inf_loop

msg1:                   ! msg1 处放置字符串 
    .byte   13,10
    .ascii  "Hello OS world, my name is LZJ"
    .byte   13,10,13,10

.org 510                 ! boot_flag 必须在最后两个字节,即510地址处
boot_flag:
    .word   0xAA55       ! 设置引导扇区标记 0xAA55，必须有它，才能引导
