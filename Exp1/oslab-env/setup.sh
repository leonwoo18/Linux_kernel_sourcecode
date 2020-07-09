#!/bin/sh

# 实验环境所需要的脚本
# $Author$: leonwoo
# $Date$: 2020-7-10
export OSLAB_INSTALL_PATH=$HOME/oslab
cat hit.icon
echo "|              Environment config（for64bit&32bit）                  |"
echo "|                    $ \033[34m@Leonwoo\033[0m $                                    |"
echo "+-------------------------------------------------------------------+"

install_gcc34_amd64() {
    echo -n "* Install gcc-3.4 for x86_64(amd64) arch now......"
    if [ -z `which gcc-3.4` ]; then
        sudo dpkg -i gcc-3.4/amd64/gcc-3.4-base_3.4.6-8ubuntu2_amd64.deb > /dev/null   #编译linux-0.11需要用到的低版本gcc
        sudo dpkg -i gcc-3.4/amd64/cpp-3.4_3.4.6-8ubuntu2_amd64.deb > /dev/null
        sudo dpkg -i gcc-3.4/amd64/gcc-3.4_3.4.6-8ubuntu2_amd64.deb > /dev/null
        echo "\033[34mDone\033[0m"
    else
        echo "\033[32mSipped\033[0m"
    fi
}

install_gcc34_i386() {
    echo -n "* Install gcc-3.4 for x86(i386) arch now......"
    if [ -z `which gcc-3.4` ]; then
        sudo dpkg -i gcc-3.4/i386/gcc-3.4-base_3.4.6-8ubuntu2_i386.deb > /dev/null   
        sudo dpkg -i gcc-3.4/i386/cpp-3.4_3.4.6-8ubuntu2_i386.deb > /dev/null
        sudo dpkg -i gcc-3.4/i386/gcc-3.4_3.4.6-8ubuntu2_i386.deb > /dev/null
        echo "\033[34mDone\033[0m"
    else
        echo "\033[33mSkipped\033[0m"
    fi
}

install_dep_i386() {
    echo "* Install dependencies for x86(i386) arch now......"
    sudo apt-get install bin86            #安装as86、ld86（用于编译和链接linux-0.11/boot下的bootsect.s和setup.s）
    sudo apt-get install build-essential  #C语言编译环境
    echo "* Install dependencies for x86(i386) arch now......\033[34mDone\033[0m"
}

install_dep_amd64() {
    echo "* Install dependencies for x86_64(amd64) arch now......"
    sudo apt-get install bin86
	sudo apt-get install build-essential
	
    sudo apt-get install libc6-dev-i386   #64位系统需要安装32位兼容库
	sudo apt-get install libsm6:i386      #libsm6对应的32位库
	sudo apt-get install libx11-6:i386    #libxlibx11-6安装对应的32位库
	sudo apt-get install libxpm4:i386     #libx11-6对应的32位库
	
    echo "* Install dependencies for x86_64(amd64) arch now......\033[34mDone\033[0m"
}



# 提供跳过更新的参数
if [ "$1" ] && ([ "$1" = "-skip" ] || [ "$1" = "-s" ]); then   #跳过更新源
    echo -n "* Begin to setup......\033[33m3\033[0m sec to start"; sleep 1
    echo -n "\r* Begin to setup......\033[33m2\033[0m sec to start"; sleep 1
    echo -n "\r* Begin to setup......\033[33m1\033[0m sec to start"; sleep 1
    echo "\r* Begin to setup......                                 \033[0m"
else
    echo -n "* Update apt sources......\033[33m3\033[31m sec to start"; sleep 1
    echo -n "\r* Update apt sources......\033[33m2\033[31m sec to start"; sleep 1
    echo -n "\r* Update apt sources......\033[33m1\033[31m sec to start"; sleep 1
    echo "\r* Update apt sources......                                 "
    sudo apt-get update                #更新源
fi



# 32位系统或者64位系统
if [ `getconf LONG_BIT` = "64" ]
then
    install_dep_amd64
    install_gcc34_amd64
else
    install_dep_i386
    install_gcc34_i386
fi

echo "\033[34m* Installation finished. Ciao~\033[0m"
