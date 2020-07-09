### 1.解压hit-oslab-linux-20110823.tar.gz（包含linux-0.11源码、bochs虚拟机等）
cd /home/用户/  </br>
tar -zxvf hit-oslab-linux-20110823.tar.gz  </br>
解压后会放在 /home/用户/ 目录下的 oslab/   </br>

### 2.执行脚本，一步完成安装实验环境所需的东西
cd ~/oslab-env/   </br>
chmod +x setup.sh   </br>
./setup.sh    </br>

### 3.编译linux-0.11
cd ~/oslab/linux-0.11/  </br>
make all                 </br>

### 4.运行boch模拟器
cd ~/oslab/        </br>
./run               </br>
