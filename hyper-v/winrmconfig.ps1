#基本参数
$Server="xxx"
$account="xxx/administrator"
$ip="xx.xx.xx.xx"

#开启远程管理
Enable-PSRemoting
winrm quickconfig

#添加TrustedHosts，同时授权IP和机器名，后一天会覆盖前一条
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $Server
#Set-Item WSMan:\localhost\Client\TrustedHosts -Value $ip

#修改防火墙规则
Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Internet

Enter-PSSession -ComputerName $Server -Credential $account