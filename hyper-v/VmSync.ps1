# 输出所有虚拟机的配置信息
# Get the management service
$VMMS = gwmi -namespace root\virtualization\v2 Msvm_VirtualSystemManagementService -computername localhost
$VMs = gwmi MSVM_ComputerSystem  -namespace root\virtualization\v2 -computername localhost

for($i=1;$i -le $VMs.Count;$i++)
{
    $config =New-Object PSObject 
    $VM = $VMs.Get($i-1)
    $SystemSettingData = $VM.getRelated("Msvm_VirtualSystemSettingData")
    $Processor=$SystemSettingData.getRelated("Msvm_ProcessorSettingData")| where{$_.ResourceType -eq 3}
    $Memory=$SystemSettingData.getRelated("Msvm_MemorySettingData") | where{$_.ResourceType -eq 4}| select -first 1
    #$VHD=$SystemSettingData.getRelated("MSVM_StorageAllocationSettingData") | where{$_.ResourceType -eq 31}

    $config |add-member NoteProperty displayName $VM.ElementName
    $config |add-member NoteProperty machineId $VM.Name
    $config |add-member NoteProperty fixedMemory $Memory.VirtualQuantity
    $config |add-member NoteProperty maxMemory $Memory.Limit
    $config |add-member NoteProperty minMemory $Memory.Reservation
    $config |add-member NoteProperty cpu $Processor.VirtualQuantity
    #$config |add-member NoteProperty vhd $VHD.

    write-output $config |Out-File -FilePath c:\vms.txt -Append
}