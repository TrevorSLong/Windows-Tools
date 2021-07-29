#Fully-Disable-Cortana.ps1
#Disables Cortana on Windows 10 via the registry

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

$disablecortana = Read-Host "
Would you like to disable or enable Cortana via the registry?
Type 'E' for enable or 'D' for disable:
"
$deletecortana = Read-Host "
Would you like to delete Cortana (youll need to reinstall through the Microsoft Store?
Type 'Y' to delete Cortana, 'A' to delete Cortana for ALL USERS, or ENTER to skip:"

if ($disablecortana -eq 'D'){
  
    $pathexist = Test-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana'
    if ($pathexist -eq $False) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'Windows Search'
    }
  
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    $regname = "AllowCortana"
    $regvalue = 0
    $regnick = "AllowCortana"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}
else { 

    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    $regname = "AllowCortana"
    $regvalue = 1
    $regnick = "AllowCortana"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
}

if ($deletecortana -eq 'Y') {
    Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
}
if ($deletecortana -eq 'A') {
    Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage
}
