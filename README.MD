# Maintenance scripts 

日常运维脚本存档

## Hyper-v scripts

### winrm 远程管理

服务端执行`powershell.exe  -file  winrmconfig.ps1`

1. 在服务器端运行`winrm set winrm/config/client @{TrustedHosts="RemoteComputerName"}` 命令前，需要先设置winrm接受请求，开始运行 cmd后，输入`winrm quickconfig`，然后输入y，同意，再配置上面的winrm set命令
2. 我们回到客户端，我们右键，选择powershell，输入：
　　`Set-Item wsman:\localhost\Client\TrustedHosts server01 -Concatenate -Force`


### Hyper-V Remote Management Configuration Utility (HVRemote)

[参考msdn](https://code.msdn.microsoft.com/Hyper-V-Remote-Management-26d127c6)

### sysprep

adksetup.exe
提供安装WSIM windows镜像管理器，可以制作unattend无人值守安装的应答文件。

sysprep_unattended_template.xml
应答文件模板

命令行sysprep方法：

```bat
cd C:\Windows\System32\sysprep>
sysprep /generalize /oobe /unattend:sysprep_unattended_template.xml /shutdown
```

**注**

1. 虚拟化主机sysprep可添加参数`/mode:vm`
2. 非制作模板的情况，`/shutdown`可以改为`/reboot`