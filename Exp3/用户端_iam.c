#include <stdio.h>
#include <inputname.h>
int main(int argc, char *argv[])
{
    int r;
    if(argc!=2)
    {
        puts("please input your name."); //提醒用户执行文件时，带上名字参数
        r=-1;
    }
    else
    {
        iam(argv[1]);  //iam()会去调用封装在inputname.h中的接口函数
                       //argv[1]为用户输入的参数
        r=0;
    }
    return r;
}
