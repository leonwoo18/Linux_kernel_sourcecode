/* 实现 sys_iam() 和 sys_whoami() */

#include <string.h>
#include <errno.h>
#include <asm/segment.h>

char username[24]=""; //用来赋值从用户态拿到的数据
int sys_iam(const char * name)
{
        //printk("congratulations! system call successfully\n");此句供测试用

	int len=0;   //用于记录用户输入的字符串长度
	char tmp[30];  //临时的内核态字符串数组，用来放从用户态拿到的数据
	
	//复制用户态内存的数组到内核态的临时数组
	for(int i=0; i<30; i++)
	{
	    tmp[i] = get_fs_byte(&name[i]); //关键的get_fs_byte(用户态的地址)，就能拿到用户态的数据了
	    if(temp[i]!='\0')
                len++;
            else
                break;   //字符串复制结束，并算出用户输入的长度len
	}
	if(len<24)
            strcpy(username, temp);
        else
	    int n=-EINVAL;
	return n;     //-(EINVAL)即-22，存入到EAX寄存器
	              //调用返回后，从 EAX 取出返回值，存入 __res，__res来自unistd.h中的_syscalln宏展开
	              //即此时__res=-22,宏展开的代码通过对 __res 的判断决定传给 API 的调用者什么样的返回值
	              //errno = -__res，即errno=22，调用者就可以通过errno的值定位错误了
	              //最后真正的返回值return -1;
}

int sys_whoami(char* name, unsigned int size)
{
    int n=strlen(username);
    if(n<size)
    {
        for(int i=0;i<n;i++)
        {
            put_fs_byte(username[i], &name[i]);  //关键的put_fs_byte(内核态数据,用户态的地址)
        }
    }
    else
        n=-EINVAL;
    return n;
}
