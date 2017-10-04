Introduction
-------------
This tool extended by using WinSCP. It is basicly collect files from given hosts. The files to be collected are sorted as descenting according to the creation date.


Configuration
-------------
Before execute the script, the configurations.txt in the \config directory must be configurate according hosts informations. Each line contains, related informations according to its host.

The template in the configurations.txt file is:
```
{hostAddress};{user};{pass};{remotePath};{latestFileCount};{protocol}
```

>  - **hostAddress** : it can be domain name or ip address, for example musaalp.com or 127.0.0.1 etc.
>  - **user** : a user which is has read permission to get files from given host.
>  - **pass** : user's pass.
>  - **remotePath** : the path in the given host to get files.
>  - **latestFileCount** : indentify how many files should be take.
>  - **protocol** : sftp or ftp.

There is a one more variable named <kbd>$localPath</kbd> in the script should be set.
The local address where collected files to be store.


Usage
-------------
```sh
Power Shell:
Navigate to the directory where the script lives:
cd "C:\DataCollectionTool\script"

Execute the script
.\data-collection.ps1
```

```sh
Command Line:
Execute the script
Powershell.exe -File C:\DataCollectionTool\script\data-collection.ps1
```

