## This script handles the hardening of a Windows 10 computer
#Written by Trevor Long, last modified 7-19-21

$null = Read-Host '
README:
---------------------------------------------------------------------------------------------------------------------------------
This script is designed to automate much of the Windows 10 Registry Hardening Process, some parts may fail and need to be run manually.
This script adds/changes many registry values, this has the possiblility to break the operating system,
a restore point should be made, but to ensure you have a backup, go make a restore point manually.
Once the script has finished, check for error and correct any manually if needed.
---------------------------------------------------------------------------------------------------------------------------------
By clicking ENTER you agree to have read the above comment, and understand the script and its author take no responsibility if 
it breaks Windows.
---------------------------------------------------------------------------------------------------------------------------------
Click ENTER to continue'

#Creates a restore point
Write-Host "
Attempting to create restore point........
"
Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

Function Test-RegistryValue {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Path
        ,
        [Parameter(Position = 1, Mandatory = $true)]
        [String]$Name
        ,
        [Switch]$PassThru
    ) 

    process {
        if (Test-Path $Path) {
            $Key = Get-Item -LiteralPath $Path
            if ($null -ne $Key.GetValue($Name, $null)) {
                if ($PassThru) {
                    Get-ItemProperty $Path $Name
                } else {
                    $true
                }
            } else {
                $false
            }
        } else {
            $false
        }
    }
}
Function ChangeRegValues {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$regpath
        ,
        [Parameter(Position = 1, Mandatory = $true)]
        [String]$regname
        ,
        [Parameter(Position = 2, Mandatory = $true)]
        [String]$regvalue
        ,
        [Parameter(Position = 3, Mandatory = $true)]
        [String]$regnick
        ,
        [Parameter(Position = 4, Mandatory = $false)]
        [String]$regtype
        ,
        [Switch]$PassThru
    ) 
    process{
        if (Test-RegistryValue -Path $regpath -Name $regname ){

            Set-ItemProperty -Path $regpath -Name $regname -Value $regvalue -Type $regtype
            $regvaluecheck = Get-ItemPropertyValue -Path $regpath -Name $regname

            if( $regvalue -eq $regvaluecheck){
                Write-Host "$regnick value successfully changed to $regvaluecheck!" -ForegroundColor Green
            }
            else {
                Write-Host "$regnick value change fail! Value is still $regvaluecheck! Please change this key manually" -ForegroundColor Red
            }
        }
        else {
            New-ItemProperty -Path $regpath -Name $regname -Value $regvalue -Type $regtype
            $regvaluecheck = Get-ItemPropertyValue -Path $regpath -Name $regname

            if( $regvalue -eq $regvaluecheck){
                Write-Host "$regnick value successfully added with a value $regvaluecheck!" -ForegroundColor Green
            }
            else {
                Write-Host "$regnick value add fail! Please add this key manually." -ForegroundColor Red
            }
        
        }
    }
}

#Changes RemoteRegistry Service
$enablerr = Read-Host "
Would you like to enable the RemoteRegistry service and set it for automatic startup?
Type 'Y' for yes or 'N' for No:
"
if ($enablerr -eq 'Y'){
    Set-Service -Name RemoteRegistry -StartupType Automatic #Turns RemoteRegistry to start automatically
    Set-Service -Name RemoteRegistry -Status Running -PassThru #Turns RemoteRegistry on now

    $rrstatus = Get-Service -Name "RemoteRegistry" | Select-Object -property status
    if ($rrstatus.Status -eq 'Stopped') {
        Write-Host "Starting RemoteRegistry service failed! Please start manually!" -ForegroundColor Red
    }
    else {
        Write-Host "RemoteRegistry set to automatic startup and started!" -ForegroundColor Green
    }
}
else { 
    Write-Host "RemoteRegistry not enabled, continuing script"
    break 
}

#Sets registry values 
Write-Host "
Attempting to change registry values.......
"
#RPCLocator
$regpath =  "HKLM:\System\CurrentControlSet\Services\RPCLocator"
$regname = "Start"
$regvalue = 4
$regnick = "RPCLocator"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#SSDPSRV
$regpath =  "HKLM:\System\CurrentControlSet\Services\SSDPSRV"
$regname = "Start"
$regvalue = 4
$regnick = "SSDPSRV"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#upnphost
$regpath =  "HKLM:\System\CurrentControlSet\Services\upnphost"
$regname = "Start"
$regvalue = 4
$regnick = "upnphost"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#WMPNetworkSvc
$regpath =  "HKLM:\System\CurrentControlSet\Services\WMPNetworkSvc"
$regname = "Start"
$regvalue = 4
$regnick = "WMPNetworkSvc"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#icssvc
$regpath =  "HKLM:\System\CurrentControlSet\Services\icssvc"
$regname = "Start"
$regvalue = 4
$regnick = "icssvc"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#XboxGipSvc
$regpath =  "HKLM:\System\CurrentControlSet\Services\XboxGipSvc"
$regname = "Start"
$regvalue = 4
$regnick = "XboxGipSvc"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#XboxNetCpiSvc
$regpath =  "HKLM:\System\CurrentControlSet\Services\XboxNetApiSvc"
$regname = "Start"
$regvalue = 4
$regnick = "XboxNetCpiSvc"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#XboxAuthManager
$regpath =  "HKLM:\System\CurrentControlSet\Services\XblAuthManager"
$regname = "Start"
$regvalue = 4
$regnick = "XboxAuthManager"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#XblGameSave
$regpath =  "HKLM:\System\CurrentControlSet\Services\XblGameSave"
$regname = "Start"
$regvalue = 4
$regnick = "XblGameSave"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#irmon
$regpath =  "HKLM:\System\CurrentControlSet\Services\irmon"
$regname = "Start"
$regvalue = 4
$regnick = "irmon"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#SharedAccess
$regpath = "HKLM:\System\CurrentControlSet\Services\SharedAccess"
$regname = "Start"
$regvalue = 4
$regnick = "SharedAccess"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#7bc4a2f9-d8fc-4469-b07b-33eb785aaca0
$regpath = "HKLM:\System\ControlSet001\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0"
$regname = "7bc4a2f9-d8fc-4469-b07b-33eb785aaca0"
$regvalue = 2
$regnick = "7bc4a2f9-d8fc-4469-b07b-33eb785aaca0"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
#LocalAccountTokenFilterPolicy
$regpath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$regname = "LocalAccountTokenFilterPolicy"
$regvalue = 1
$regnick = "LocalAccountTokenFilterPolicy"
$regtype = "DWORD"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
#PreventOverrideAppRepUnknown
$regpath = "HKLM:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$regname = "PreventOverrideAppRepUnknown"
$regvalue = 1
$regnick = "PreventOverrideAppRepUnknown"
$regtype = "DWORD"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
#fClientDisableUDP
$regpath = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services\Client"
$regname = "fClientDisableUDP"
$regvalue = 1
$regnick = "fClientDisableUDP"
$regtype = "DWORD"
ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

$null = Read-Host '
---------------------------------------------------------------------------------------------------------------------------------
The script has finished running, please the red text above and take note. Fix any errors manually if needed. Running the script again 
will work but it will show many more errors.
---------------------------------------------------------------------------------------------------------------------------------
Click ENTER to close the script and finish
'
