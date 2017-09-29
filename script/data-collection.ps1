try
{
    # Collected data will be place here
    $localPath = "C:\DataCollectionTool\download\"
    
    # Load WinSCP .NET assembly
    Add-Type -Path "C:\DataCollectionTool\lib\WinSCPnet.dll"

    # Get the configurations    
    $configurationLines = Get-Content "C:\DataCollectionTool\config\configurations.txt"
    
    foreach($line in $configurationLines)
    {
        $configVars = $line.split(';')
        
        $hostName = $configVars[0]
        $user = $configVars[1]
        $pass = $configVars[2]
        $remotePath = $configVars[3]
        $fileCount = $configVars[4]
        $connectionType = $configVars[5]

        $sessionOptions = New-Object WinSCP.SessionOptions -Property @{            
            HostName = $hostName
            UserName = $user
            Password = $pass            
        }

        if($connectionType -eq "sftp")
        {
            $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
            $sessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = "true"    
        }
        else
        {
            $sessionOptions.Protocol = [WinSCP.Protocol]::Ftp
        }
 
        $session = New-Object WinSCP.Session
        $session.ExecutablePath = "C:\DataCollectionTool\lib\WinSCP.exe"
 
        try
        {
            # Connect
            $session.Open($sessionOptions)
 
            # Get list of files in the directory
            $directoryInfo = $session.ListDirectory($remotePath)
 
            # Select the most recent file
            $latest =
                $directoryInfo.Files |
                Where-Object { -Not $_.IsDirectory } |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First $fileCount    
 
            # Any file at all?
            if ($latest -eq $Null)
            {
                Write-Host "No file found"
                exit 1
            }

            write-Host "`n"
            Write-Host  ([string]::Format("Downloading process from: {0} started", $hostName))            

            foreach($file in $latest)
            {
                # Download the selected file
                $session.GetFiles($session.EscapeFileMask($remotePath + $file.Name), $localPath).Check()

                $downloadedFrom = $hostName + $remotePath
                #Write-Host  -foregroundcolor green "$file successfully downloaded from $downloadedFrom"
                Write-Host  -foregroundcolor green ([string]::Format("Success: {0} downloaded from {1}", $file, $downloadedFrom))
            }
            Write-Host  ([string]::Format("Downloading process from: {0} completed", $hostName)) 
            write-Host "`n"        
        }
        finally
        {
            # Disconnect, clean up
            $session.Dispose()
        }
    }
 
    exit 0
}
catch [Exception]
{
    # Catch exp
    Write-Host -foregroundcolor red ("Error: {0}" -f $_.Exception.Message)
    exit 1
}