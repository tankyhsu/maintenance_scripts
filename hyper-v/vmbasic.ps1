# 查看虚拟机的基本信息

$Name="test"
# Get the management service
$VMMS = gwmi -namespace root\virtualization\v2 Msvm_VirtualSystemManagementService -computername localhost

$VM = gwmi MSVM_ComputerSystem -filter "ElementName='$Name'" -namespace root\virtualization\v2 -computername localhost

$SystemSettingData = $VM.getRelated("Msvm_VirtualSystemSettingData")#| where{$_.VirtualSystemType -eq "Microsoft:Hyper-V:Snapshot:Realized"}
# Get the first DVD drive in the system
$DVDDrive = $SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") | where{$_.ResourceType -eq 16} | select -first 1
# 虚拟硬盘
$VHD=$SystemSettingData.getRelated("MSVM_StorageAllocationSettingData") | where{$_.ResourceType -eq 31}、
# CPU
$Processor=$SystemSettingData.getRelated("Msvm_ProcessorSettingData")| where{$_.ResourceType -eq 3}
# 内存
$Memory=$SystemSettingData.getRelated("Msvm_MemorySettingData") | where{$_.ResourceType -eq 4}| select -first 1
# 1代hyper-v的硬盘驱动（2代不支持）
$IDE= $SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") #| Where { $_.ResourceSubType -eq "Microsoft:Hyper-V:Emulated IDE Controller"   } 
# 1/2代通用驱动
$diskdrive=$SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") | where { $_.ResourceSubType -eq "Microsoft:Hyper-V:Synthetic Disk Drive"}
# 与交换机的连接信息
$connection=$SystemSettingData.getRelated("Msvm_EthernetPortAllocationSettingData", "Msvm_VirtualSystemSettingDataComponent",$null, $null, $null, $null, $false, $null)
# 虚拟网卡
$nic=$SystemSettingData.getRelated("Msvm_SyntheticEthernetPortSettingData")
# 网络配置信息
$config=$nic.GetRelated("Msvm_GuestNetworkAdapterConfiguration")
# 虚拟机快照/检查点
$snapshot = $VM.GetRelated("Msvm_VirtualSystemSettingData", "Msvm_SnapshotOfVirtualSystem",
                    $null, $null, $null, $null, $false, $null)
