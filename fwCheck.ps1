#Requires -Version 4
Set-StrictMode -Version Latest
Import-Module PSCrestron

###############################################################
##Enter admin creditionals here#####
###############################################################
$uName = 'admin'
$pWord = 'AbtCre$tron'
$deviceList = Get-AutoDiscovery -Pattern nvx -ShowProgress
###############################################################
##Enter full path to firmware file and version number here#####
###############################################################
$fw = "G:\My Drive\Abt Commercial Audio Video\Danny Jama\Updating\Crestron\NVX Firmware Load Script Toolbox\dm-nvx-35x-enc_6.0.4835.00027_r416525.zip"
$fwVersion = '6.0.4835.00027'
###############################################################
foreach ($dev in $deviceList) {
    write-host $dev.hostname 'Checking If Update Is Needed'
    if ($dev.Description -match ($fwVersion)) {
        Write-Host 'Unit Up To Date'
        $updateNeed = 'False'
    }          
    elseif ($dev.Description -inotmatch ($fwVersion)) {
        Write-Host $dev.hostname 'Unit Needs Update'
        $updateNeed = 'True'
        write-host 'Sending update'
        Send-CrestronFirmware -Device $dev.ip -LocalFile $fw -Secure -Username $uName -Password $pWord
    }
}
