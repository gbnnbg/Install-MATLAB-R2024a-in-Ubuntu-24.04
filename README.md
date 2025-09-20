# Install-MATLAB-R2024a-in-Ubuntu-24.04
在Ubuntu24.04上安装MATLAB 2024a
在ubuntu 24.04中安装matlab非常麻烦，因为在安装过程中，安装程序会尝试调用映像文件中的旧的libstdc++.so.6，即使在离线状态下使用如下命令：LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 ./install 也会在输入密钥和加载证书时出现问题，因此只能使用静默安装。
从以下链接下载R2024a for linux: https://pan.baidu.com/s/18uG5hnl8lSbuzVoyLKLvXQ 提取码:c3ac 下载github库中其他内容
在图形界面中，双击.iso文件即可装载镜像文件系统。修改github库中的“installer_input.txt”，特别需要按照如下方式修改这一行：
licensePath=/path/to/your/license.lic
请注意去掉前面的#，以解除注释状态。然后根据需要选择你所要安装的matlab产品，由于证书不含在线的内容，因此请不要安装名称中含有“web”的产品和Model-Based_Calibration_Toolbox。删除#表示你选择了该产品。
保存installer_input.txt后，在装载镜像文件系统的文件夹下打开终端，输入以下命令：sudo -E ./install -inputFile /path/to/your/installer_input.txt
此时开始安装matlab。可以通过在tmp文件夹下生成的日志文件查看安装状态：gedit /tmp/matlab-root
完成安装后，将github库中的“libmwlmgrimpl.so”复制到matlab的位置去。在终端中输入：
cd /usr/local/MATLAB/R2024a/bin/glnxa64/matlab_startup_plugins/lmgrimpl
sudo mv libmwlmgrimpl.so libmwlmgrimpl.bak
sudo cp <path_to_your_crack_file>/libmwlmgrimpl.so libmwlmgrimpl.so
然后在终端中输入以下命令，就能启动matlab了：/usr/local/MATLAB/R2024a/bin/matlab
在使用matlab时，程序也会尝试调用旧的libstdc++.so.6，因此需要删除旧的libstdc++.so.6，让matlab调用ubuntu24.04中自带的libstdc++.so.6。
cd /usr/local/MATLAB/R2024a/sys/os/glnxa64
sudo mv libstdc++.so.6 libstdc++.so.6.backup
这样就能让matlab调用ubuntu24.04中自带的libstdc++.so.6了。为了使启动matlab方便，因此需要添加路径
sudo gedit ~/.bashrc
在最后一行添加：export PATH=/usr/local/MATLAB/R2024a/bin:$PATH
在终端里：
source ~/.bashrc
matlab
此时应该能正常启动matlab了。

像windows中一样启动matlab和matlab的文件
将“matlab“文件复制到/usr/local/bin/matlab：sudo cp <path_to_your_file>/matlab /usr/local/bin/matlab
在终端中运行:sudo chmod +x /usr/local/bin/matlab
将"matlab.desktop"复制到~/.local/share/applications：cp <path_to_your_file>/matlab.desktop ~/.local/share/applications/matlab.desktop
在终端中输入：update-desktop-database ~/.local/share/applications

可能遇到的问题
提示mkdir: 无法创建目录 "/home/<user_name>/.MathWorks": 权限不够
解决办法：sudo chown -R <user_name>:<user_name> /home/<user_name>/.MathWorks
打开matlab时要求重新输入密钥和证书
查看/usr/local/MATLAB/R2024a文件夹下是否有文件夹，licenses文件夹是否有.lic文件。如果没有，在/usr/local/MATLAB/R2024a文件夹下打开终端中并输入：
sudo mkdir licenses
cd licenses
sudo cp <path_to_lic>/license.lic
