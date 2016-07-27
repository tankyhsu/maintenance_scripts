# 调整虚拟机启动顺序
$Name="test"
$first=Get-VMHardDiskDrive -VMName $Name
set-VMFirmware $Name -FirstBootDevice $first
Get-VMFirmware $Name