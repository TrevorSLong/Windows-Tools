# TheTrevorSpecial.ps1 combines other parts of the repo to make a simple script that makes Windows modifications I do to my own computer
$ErrorActionPreference= 'silentlycontinue'
Write-Host "|------------------------------------------------------------------|"
Write-Host "|                  Windows-Tools by Trevor Long                    |"
Write-Host "|                      Last Modified 12-6-21                       |"
Write-Host "|------------------------------------------------------------------|"
Write-Host "|         By using these tools you assume all risk involved        |"
Write-Host "|             I am not responsible if your Windows breaks!         |"
Write-Host "|             Its always a good idea to back up your data!         |"       
Write-Host "|------------------------------------------------------------------|"

Write-Host "The Trevor special uses tools from the rest of the toolkit to customize your computer the same way I would. The Readme in its folder explains what modifications it makes. If you don't like all them, you can run the tools manually to set it up perfect for yourself."

$accept = Read-Host "Type A and press ENTER to agree to the risks and start the customization:"

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


if ($accept -eq 'a'){


    Write-Host "Disabling Widgets...."
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "TaskbarDa"
    $regvalue = 0
    $regnick = "TaskbarDa"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Write-Host "Disabling Bing Start Menu Suggestions....."
    $regpath =  "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    $regname = "DisableSearchBoxSuggestions"
    $regvalue = 1
    $regnick = "DisableSearchBoxSuggestions"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Write-Host "Enabling Verbose Mode...."
    $regpath =  "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\System"
    $regname = "VerboseStatus"
    $regvalue = 1
    $regnick = "VerboseStatus"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Write-Host "Disabling Shake to Minimize...."
    $regpath =  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $regname = "DisallowShaking"
    $regvalue = 1
    $regnick = "DisallowShaking"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype

    Write-Host "Removing Cortana...."
    $regpath =  "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    $regname = "AllowCortana"
    $regvalue = 0
    $regnick = "AllowCortana"
    $regtype = 'DWORD'
    ChangeRegValues -regpath $regpath -regname $regname -regvalue $regvalue -regnick $regnick -regtype $regtype
    Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage

    Write-Host "Removing Bloatware...."
    Remove-AppAuto -UApp '*3dbuilder*'
    Remove-AppAuto -UApp '*skypeapp*'
    Remove-AppAuto -UApp '*getstarted*'
    Remove-AppAuto -UApp '*zunemusic*'
    Remove-AppAuto -UApp '*bingfinance*'
    Remove-AppAuto -UApp '*zunevideo*'
    Remove-AppAuto -UApp '*bingnews*'
    Remove-AppAuto -UApp '*windowsphone*'
    Remove-AppAuto -UApp '*bingsports*'
    Remove-AppAuto -UApp '*soundrecorder*'
    Remove-AppAuto -UApp '*bingweather*'
    Remove-AppAuto -UApp '*Microsoft.YourPhone*'
    Remove-AppAuto -UApp '*Microsoft.Microsoft3DViewer*'
    Remove-AppAuto -UApp '*Microsoft.WindowsFeedbackHub*'

    Read-Host "Trevor's customizations complete! Click ENTER to finish."
}