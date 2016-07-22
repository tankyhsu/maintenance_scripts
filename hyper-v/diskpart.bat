::--MBR格式分区--

list disk
select disk 0

list partition
create partition primary size=512000
active
format quick

create partition extended
create partition logical
format quick

list partition

list volume
select volume 1
assign letter=c
select volume 2
assign letter=d


::--GPT格式分区--
select disk 1

clean
convert GPT

list partition
create partition primary
active
format quick

list volume
select volume 3
assign letter=e

::--文件共享设置--
netsh firewall set service fileandprint
net share
net share c$ /delete
net share e$ /delete
net share ADMIN /delete

