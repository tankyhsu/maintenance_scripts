# 查看虚拟机的基本信息

$Name="test"
# Get the management service
$VMMS = gwmi -namespace root\virtualization\v2 Msvm_VirtualSystemManagementService -computername localhost

$VM = gwmi MSVM_ComputerSystem -filter "ElementName='$Name'" -namespace root\virtualization\v2 -computername localhost

$SystemSettingData = $VM.getRelated("Msvm_VirtualSystemSettingData")#| where{$_.VirtualSystemType -eq "Microsoft:Hyper-V:Snapshot:Realized"}

# Get the first DVD drive in the system
$DVDDrive = $SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") | where{$_.ResourceType -eq 16} | select -first 1
$VHD=$SystemSettingData.getRelated("MSVM_StorageAllocationSettingData") | where{$_.ResourceType -eq 31}
$Processor=$SystemSettingData.getRelated("Msvm_ProcessorSettingData")| where{$_.ResourceType -eq 3}
$Memory=$SystemSettingData.getRelated("Msvm_MemorySettingData") | where{$_.ResourceType -eq 4}| select -first 1
$IDE= $SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") #| Where { $_.ResourceSubType -eq "Microsoft:Hyper-V:Emulated IDE Controller"   } 
$diskdrive=$SystemSettingData.getRelated("Msvm_ResourceAllocationSettingData") | where { $_.ResourceSubType -eq "Microsoft:Hyper-V:Synthetic Disk Drive"}

$connection=$SystemSettingData.getRelated("Msvm_EthernetPortAllocationSettingData", "Msvm_VirtualSystemSettingDataComponent",$null, $null, $null, $null, $false, $null)
$nic=$SystemSettingData.getRelated("Msvm_SyntheticEthernetPortSettingData")
$config=$nic.GetRelated("Msvm_GuestNetworkAdapterConfiguration")