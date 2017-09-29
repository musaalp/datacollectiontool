**[Information]**

I extend WinSCP repo to collect files from remote hosts with powershell.

Before using this tool the Config\configurations.txt file must be modified according to servers informations.

You will find this "host;user;pass;remotePath;latestFileCount;protocol" template in configurations.txt.

host: it can be ip or domian.
user: host user, pay attention tp permission
pass: user's pass
remotePath: the path in the host for example /home/logs/ ..
latestFileCount: how many files you want to take, for example 5, this mean latest 5 file will download
protocol: sftp or ftp

There can be many host information in the configurations.txt. It depends how many different data you want to collect.
