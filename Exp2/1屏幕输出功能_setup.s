!核心代码

entry _start
_start:

!打印"Now we are in SETUP"
    mov ah,#0x03            ! 首先读入光标位置
    xor bh,bh
    int 0x10
    mov cx,#25              ! 显示的字符串长度为25
    mov bx,#0x0007
    mov bp,#msg2            !标号msg2
    
    mov ax,cs               !这个时候需要修改es的值，可以使用cs的值
    mov es,ax
    
    mov ax,#0x1301
    int 0x10
    
inf_loop:                   ! 设置一个无限循环，使得光标停在这里，不用继续执行下去
    jmp inf_loop 
    
msg2:                       !msg2
    .byte   13,10
    .ascii  "Now we are in SETUP"
    .byte   13,10,13,10
.org 510
boot_flag:
    .word   0xAA55
