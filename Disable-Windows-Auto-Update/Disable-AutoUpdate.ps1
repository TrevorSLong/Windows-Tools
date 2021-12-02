# Disable-AutoUpdate.ps1 - this script aims to make it easy to disable Windows auto update

$deupdate = Read-Host "Would you like Enable or Disable Windows Auto-Updates through the registry? Type E or D then hit enter. "
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
