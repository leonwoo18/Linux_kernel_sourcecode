### 1:修改linux-0.11/include/unistd.h
插入这两行</br>
#define __NR_iam        72</br>
#define __NR_whoami   	73</br>
### 2:查看linux-0.11/kernel/system_call.s

修改系统调用的总数</br>
nr_system_calls = 74</br>
</br>
.globl system_call</br>
system_call:</br>
</br>
call sys_call_table(,%eax,4)    #关键语句，eax 中放的是系统调用号，sys_call_table 一定是一个函数指针数组的起始地址，定义在 include/linux/sys.h 中</br>
### 3:修改linux-0.11/inclue/linux/sys.h
插入这两行</br>
extern int sys_iam();     </br> 
extern int sys_whoami(); </br>
</br>
在sys_call_table[]数组后面加上sys_iam,sys_whoami  </br>
### 4:编写一个函数who.c，放在linux-0.11/kernel/下
函数主要实现 sys_iam() 和 sys_whoami()
### 5: 修改linux-0.11/kernel/Makefile
在OBJS后面加上who.o </br>
在 Dependencies:下加上以下这一行</br>
who.s who.o: who.c ../include/linux/kernel.h ../include/unistd.h
### 6:在用户端编写一个iam.c,调用函数iam()，测试一下
