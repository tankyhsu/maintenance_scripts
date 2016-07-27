$Name="test"
# Get the management service
$VMMS = gwmi -namespace root\virtualization\v2 Msvm_VirtualSystemManagementService -computername localhost

$VM = gwmi MSVM_ComputerSystem -filter "ElementName='$Name'" -namespace root\virtualization\v2 -computername localhost

$SystemSettingData = $VM.getRelated("Msvm_VirtualSystemSettingData")

$result = $VM.GetRelated("Msvm_VirtualSystemSettingData", "Msvm_SnapshotOfVirtualSystem",
                    $null, $null, $null, $null, $false, $null)
