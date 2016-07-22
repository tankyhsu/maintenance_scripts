# Maintenance scripts 

日常运维脚本存档

## Hyper-v scripts

adksetup.exe
提供安装WSIM windows镜像管理器，可以制作unattend无人值守安装的应答文件。

sysprep_unattended_template.xml
应答文件模板

命令行sysprep方法：
`C:\Windows\System32\sysprep>`

`sysprep /generalize /oobe /unattend:sysprep_unattended_template.xml /shutdown`

**注**

1. 虚拟化主机sysprep可添加参数`/mode:vm`
2. 非制作模板的情况，`/shutdown`可以改为`/reboot`