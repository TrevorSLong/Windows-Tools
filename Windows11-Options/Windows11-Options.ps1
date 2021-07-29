# Windows11-Options.ps1 - this script aims to make it easy to disable some parts of Windows 11 that are not necessary

$dewidgets = Read-Host "Would you like to disable/enable widgets? Type 'D' to disable and 'E' to enable:"
$decortana = Read-Host "Would you like to disable Cortana for the current user 'D', disable for all users 'A', or to skip hit ENTER:"
$taskbar = Read-Host "Would you like to move the taskbar? Type 'L' for LEFT, 'C' for CENTER, or ENTER to skip"
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