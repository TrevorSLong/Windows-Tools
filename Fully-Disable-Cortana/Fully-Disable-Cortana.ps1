#Fully-Disable-Cortana.ps1
#Disables Cortana on Windows 10 via the registry

Function Test-RegistryValue {
    param(
        [Alias("PSPath")]
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
function ChangeRegValues {
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
        [Switch]$PassThru
    ) 
    process{
        if (Test-RegistryValue -Path $regpath -Name $regname ){

            Set-ItemProperty -Path $regpath -Name $regname -Value $regvalue
            $regvaluecheck = Get-ItemPropertyValue -Path $regpath -Name $regname

            if( $regvalue -eq $regvaluecheck){
                Write-Host "$regnick value successfully changed to $regvaluecheck!" -ForegroundColor Green
            }
            else {
                Write-Host "$regnick value change fail! Value is still $regvaluecheck! Please change this key manually" -ForegroundColor Red
            }
        }
        else {
            New-ItemProperty -Path $regpath -Name $regname -Value $regvalue
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
if ($disablecortana -eq 'D'){
  
    $pathexist = Test-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana'
    if ($pathexist -eq $False) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'Windows Search'
    }
  
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    $regname = "AllowCortana"
    $regvalue = 0
    $regnick = "AllowCortana"
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
}
else { 

    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    $regname = "AllowCortana"
    $regvalue = 1
    $regnick = "AllowCortana"
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick
}

