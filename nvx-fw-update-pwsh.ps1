#Requires -Version 4
Set-StrictMode -Version Latest

Write-Host @"





███╗   ██╗██╗   ██╗██╗  ██╗    ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
████╗  ██║██║   ██║╚██╗██╔╝    ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
██╔██╗ ██║██║   ██║ ╚███╔╝     ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗      ███████╗██║     ██████╔╝██║██████╔╝   ██║   
██║╚██╗██║╚██╗ ██╔╝ ██╔██╗     ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝      ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
██║ ╚████║ ╚████╔╝ ██╔╝ ██╗    ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗    ███████║╚██████╗██║  ██║██║██║        ██║   
╚═╝  ╚═══╝  ╚═══╝  ╚═╝  ╚═╝     ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   




################################################################
################################################################
##Beep Boop, I am a computer, I am a lightbulb that does math.##
################################################################
################################################################
##########Script Hacked Together by: Daniel Jama################
############Last Updated: 2021_08_12 by DJ######################
################################################################
################################################################



"@


$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
Import-Module PSCrestron
$ResultsTable =@()
###############################################################
##Enter admin creditionals here#####
###############################################################
$uName = 'admin'
$pWord = 'admin'
$deviceList = Get-AutoDiscovery -Pattern nvx -ShowProgress
###############################################################
##Enter full path to firmware file and version number here#####
###############################################################
$fw = "G:\My Drive\Abt Commercial Audio Video\Danny Jama\Updating\Crestron\Tippy PSCrestron Superscripts\Crestron-EDK-Superscripts-main 2021_02_17\dm-nvx-35x-enc_6.0.4835.00027_r416525.zip"
$fwVersion = '6.0.4835.00027'
###############################################################
# start the jobs
foreach ($dev in $deviceList) {
        write-host $dev
        'Checking If Update Is Needed'
            if($dev.Description -match($fwVersion))
            {    Write-Host 'Unit Up To Date'
                 $updateNeed = 'False'
            }          
            elseif($dev.Description -inotmatch($fwVersion)) 
            {Write-Host 'Unit Needs Update'
             $updateNeed = 'True'
             write-host 'Sending update'

             Send-CrestronFirmware -Device $dev.ip -LocalFile $fw -Secure -Username $uName -Password $pWord
            } 
        }

foreach ($dev in $deviceList) {
        if($updateNeed -match('True'))
            {Read-Host -Prompt “Press Enter When Ready To Update”
             #Invoke-CrestronCommand -Device $dev -Command imgupd -Password $pWord -Secure -Username $uName
             Write-Host 'IMGUPD Command Sent'
             }
             elseif ($updateNeed -match('False'))
            {write-host $dev
            'Update not Sent, Check Version/Connection'
         }
         }

# Return the results
#-------------------
$Error | Out-File (Join-Path $PSScriptRoot 'Firmware ERROR LOG.txt')
$ResultsTable | Out-GridView
$ResultsTable | Select-Object -Property "Device", "Hostname", "Prompt", "Serial", "MACAddress", "VersionOS", "Category", "Set Static IP", "Firmware Upgrade", "Auth Method", "ErrorMessage" | Export-Csv -Path $PSScriptRoot\"Firmware Upgrade Results.csv" -NoTypeInformation

#Total time of script
$stopwatch
Read-Host -Prompt “Press Enter to exit”
