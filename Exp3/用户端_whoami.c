#include <inputname.h>
#include <stdio.h>
int main(void)
{
    char name[24];   /*在用户态申请一个name数组空间*/
	
    whoami(name, 24);      /*iam()会去调用封装在inputname.h中的接口函数*/
	                   /*传入用户态name数组地址，和size要求*/
    printf("MY name is %s\n",name);
    return 0;
}
