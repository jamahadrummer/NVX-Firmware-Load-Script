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
    if ($dev.Description -match ($fwVersion)) {
        $updateNeed = 'False'
    }          
    elseif ($dev.Description -inotmatch ($fwVersion)) {
        $updateNeed = 'True'
    }
    if ($updateNeed -match ('True')) {
        #Read-Host -Prompt 'Press Enter When Ready To Update'ù
        #Invoke-CrestronCommand -Device $dev -Command imgupd -Password $pWord -Secure -Username $uName
        Write-Host $dev.hostname 'IMGUPD Command Sent'
    }
    elseif ($updateNeed -match ('False')) {
        write-host $dev.hostname 'Update not Sent, Check Version/Connection'
    }
}