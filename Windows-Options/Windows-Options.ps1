# Windows11-Options.ps1 - this script aims to make it easy to disable some parts of Windows 11 that are not necessary

$dewidgets = Read-Host "Would you like to disable/enable widgets? E to enable, D to disable, ENTER to skip:"
$decortana = Read-Host "Would you like to disable Cortana for the current user 'D', disable for all users 'A', or to skip hit ENTER:"
$taskbar = Read-Host "Would you like to move the taskbar? Type 'L' for LEFT, 'C' for CENTER, or ENTER to skip"
$deupdate = Read-Host "Would you like Enable or Disable Windows Auto-Updates through the registry? E to enable, D to disable, ENTER to skip:"
$debing = Read-Host "Would you like to disable Bing suggestions in the start menu? E to enable, D to disable, ENTER to skip:"
$delockscreen = Read-Host "Would you like to disable the lock screen? E to enable, D to disable, ENTER to skip:"
$deverbose = Read-Host "Would you like to enable verbose mode (See documentation)? E to enable, D to disable, ENTER to skip:"
$delasttab = Read-Host "Would you like to enable last tab opening on the taskbar (see documentation)? E to enable, D to disable, ENTER to skip:"
$deshaketm = Read-Host "Would you like to disable shake to minimize? E to enable, D to disable, ENTER to skip:"
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

if ($dewidgets -eq 'D'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "TaskbarDa"
    $regvalue = 0
    $regnick = "TaskbarDa"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($dewidgets -eq 'E'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "TaskbarDa"
    $regvalue = 1
    $regnick = "TaskbarDa"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($debing -eq 'E'){
    $regpath =  "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $regname = "DisableSearchBoxSuggestions"
    $regvalue = 0
    $regnick = "DisableSearchBoxSuggestions"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($debing -eq 'D'){
    $regpath =  "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $regname = "DisableSearchBoxSuggestions"
    $regvalue = 1
    $regnick = "DisableSearchBoxSuggestions"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($delockscreen -eq 'D'){
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
    $regname = "NoLockScreen"
    $regvalue = 1
    $regnick = "NoLockScreen"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($delockscreen -eq 'E'){
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
    $regname = "NoLockScreen"
    $regvalue = 0
    $regnick = "NoLockScreen"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($deverbose -eq 'E'){
    $regpath =  "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System"
    $regname = "VerboseStatus"
    $regvalue = 1
    $regnick = "VerboseStatus"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($deverbose -eq 'D'){
    $regpath =  "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System"
    $regname = "VerboseStatus"
    $regvalue = 1
    $regnick = "VerboseStatus"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($delasttab -eq 'E'){
    $regpath =  "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "LastActiveClick"
    $regvalue = 1
    $regnick = "LastActiveClick"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($delasttab -eq 'D'){
    $regpath =  "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "LastActiveClick"
    $regvalue = 0
    $regnick = "LastActiveClick"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($deshaketm -eq 'D'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "DisallowShaking"
    $regvalue = 1
    $regnick = "DisallowShaking"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($deshaketm -eq 'E'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "DisallowShaking"
    $regvalue = 0
    $regnick = "DisallowShaking"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($decortana -eq 'D') {
    Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
}
if ($decortana -eq 'A') {
    Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage
}

if ($taskbar -eq 'L'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "TaskbarAl"
    $regvalue = 0
    $regnick = "TaskbarAl"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($taskbar -eq 'C'){
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "TaskbarAl"
    $regvalue = 1
    $regnick = "TaskbarAl"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}

if ($deupdate -eq 'D'){
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    $regname = "NoAutoUpdate"
    $regvalue = 1
    $regnick = "NoAutoUpdate"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
if ($deupdate -eq 'E'){
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    $regname = "NoAutoUpdate"
    $regvalue = 0
    $regnick = "NoAutoUpdate"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}