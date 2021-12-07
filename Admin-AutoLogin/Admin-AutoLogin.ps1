#Admin-AutoLogin.ps1 allows the user to easily enable admin auto login
$ErrorActionPreference= 'silentlycontinue'
Function Test-RegPathExist {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$regpath
        ,
        [Switch]$PassThru
    ) 
    process {
        
        $wholetrue = Test-Path $regpath
        if ( $wholetrue -eq $True ) {
            Write-Host "$regpath exists entirely." -ForegroundColor Green
            $true
        }
        else {
            $brokenregpath = $regpath.Split("\")
            $bregpath = $brokenregpath | Select-Object -First 1
            $bregpathj = $bregpath -join "\"
            $counter = 2
            $doesexist = Test-Path $bregpathj
            while ( $doesexist -eq $True ) {
                $lastbregpath = $bregpathj
                $bregpath = $brokenregpath | Select-Object -First $counter
                $bregpathj = $bregpath -join "\"
                $counter = $counter + 1
                $doesexist = Test-Path $bregpathj
            }
            Write-Host $lastbregpath -ForegroundColor Green -NoNewline
            $notexist = $regpath.Replace($lastbregpath,"")
            Write-Host $notexist -ForegroundColor Red
            Write-Host "--------------------------------------------------------"
            Write-Host "The path exists up to $lastbregpath" -ForegroundColor Green
            Write-Host "The path does not exist past $notexist" -ForegroundColor Red
            Write-Host "--------------------------------------------------------"
            $false
        }
    }
}
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
                break
            }
        }
        else {
            Test-RegPathExist -regpath $regpath
            New-Item -Path $regpath -Force
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

Write-Host "------------------------------------------------------"
Write-Host "              Enable Admin Auto Login                 "
Write-Host "------------------------------------------------------"
Write-Host "This script allows the user to easily add the ability to automatically login to an admin account at startup."
Write-Host "Please note: you will need to rerun the script if you change your password."
Write-Host "Please also note that this will not log the user in if the computer has locked after already being on."
$accept = Read-Host "By using this script you accept the all risks involved with changing registry values. Type 'A' and hit enter to accept and continue."

if ($accept -eq 'A'){

    $deadmin = Read-Host "Would you like to Enable or Disable Admin Auto Login. Please type E or D, then hit enter:"

    if ($deadmin -eq 'E'){

    Write-Host "The username and password will need to be provided, and will need to be an exact match."
    $whoami = whoami.exe
    $currentuser = $whoami.Split("\") | Select-Object -Last 1
    Write-Host "The currently logged in user has a username of: $currentuser"
    $username = Read-Host "Please type the username exactly (if logging in to this account type the username above):"
    $password = Read-Host "Please type the password for this user:"

    $regpath =  "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $regname = "DefaultUserName"
    $regvalue = $username
    $regnick = "DefaultUserName"
    $regtype = 'STRING'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    $regpath =  "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $regname = "DefaultPassword"
    $regvalue = $password
    $regnick = "DefaultPassword"
    $regtype = 'STRING'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    $regpath =  "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $regname = "AutoAdminLogon"
    $regvalue = 1
    $regnick = "AutoAdminLogon"
    $regtype = 'STRING'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Read-Host "Auto Admin Login enabled! Please restart to verify and apply changes! Press enter to exit."
    }

    if ($deadmin -eq 'D'){

    $regpath =  "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $regname = "AutoAdminLogon"
    $regvalue = 0
    $regnick = "AutoAdminLogon"
    $regtype = 'STRING'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Read-Host "Auto Admin Login disabled! Please restart to verify and apply changes! Press enter to exit."
    }

}