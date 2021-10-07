<#This script will ftp file to the device
Before executing:
1. Define devices in: devices.txt
#>

Write-Host "Job started:", (Get-Date) -ForegroundColor Yellow

# import libraries
Write-Host 'Importing libraries' -ForegroundColor DarkYellow
Import-Module PSCrestron

# import file
try
    {
        $devs = @(Get-Content -Path (Join-Path $PSScriptRoot\ScriptInput 'devices.txt'))
        Write-Host 'Obtaining list of devices' -ForegroundColor DarkYellow
}
catch
    {
        Write-Host 'Error Obtaining list of devices' -ForegroundColor Red
}

foreach ($d in $devs)
    {
        Write-host "$d" -ForegroundColor DarkYellow
}

# define variables

# Promt user for variables
$source = Read-Host "Enter the location of a source file" 
$destination = Read-Host "Enter the destination (Full path including file name)"
$username = 'admin'
$password = 'admin'
$port = 22
$command = Read-Host "Enter Text Console command to be executed"


# ask for confirmation of a command

$confirmation = Read-Host "Do you want to send the command: $command after upload? (y or n)"

# loop for each device

if ($confirmation -eq 'y') 
    {
        switch ($port)
        {
            22
            {
                # loop for each device
                foreach ($d in $devs)
            {
            Write-Host 'Uploading file to:' $d -ForegroundColor green
            Send-FTPFile -Device $d -LocalFile $source -RemoteFile $destination  -Password $password -Port $port -Secure -Username $username -ErrorAction SilentlyContinue
                Invoke-CrestronCommand -Device $d -Command $command -Password $password -Port $port -Secure -Username $username -ErrorAction SilentlyContinue
                }
            }



            41795 
            {
                # loop for each device
                foreach ($d in $devs)
            {
                Write-Host 'Uploading file to:' $d -ForegroundColor green
            Send-FTPFile -Device $d -LocalFile $source -RemoteFile $destination -ErrorAction SilentlyContinue
                Invoke-CrestronCommand -Device $d -Command $command -ErrorAction SilentlyContinue            
            }    
            }
        }
    }
else
    {
        switch ($port)
        {
            22
            {
                # loop for each device
                foreach ($d in $devs)
            {
            Write-Host 'Uploading file to:' $d -ForegroundColor green
            Send-FTPFile -Device $d -LocalFile $source -RemoteFile $destination  -Password $password -Port $port -Secure -Username $username -ErrorAction SilentlyContinue
                }
            }



            41795 
            {
                # loop for each device
                foreach ($d in $devs)
            {
                Write-Host 'Uploading file to:' $d -ForegroundColor green
            Send-FTPFile -Device $d -LocalFile $source -RemoteFile $destination -ErrorAction SilentlyContinue
                }    
            }
        }
    }



Write-Host "Job completed:", (Get-Date) -ForegroundColor Yellow
