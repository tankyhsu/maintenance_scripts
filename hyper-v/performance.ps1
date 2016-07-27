# 查看物理机性能计数器信息

Get-Counter '\Process(*)\IO Data Operations/sec' 
Get-Counter '\Process(*)\IO Data Bytes/sec'
Get-Counter '\Network Interface(*)\Bytes Received/sec'
Get-Counter '\Network Interface(*)\Bytes Sent/sec'