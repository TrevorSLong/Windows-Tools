# Win10-Remove-Bloatware.ps1 automates the removal of bloatware installed on Windows 10
# Written by Trevor Long, last modified 7-29-21

$doall = Read-Host "Would you like to uninstall bloatware by level or go one-by-one? Type the number 1-3 to choose a level (see documentation) or ENTER for One-By-One"

Function Remove-AppAuto {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$UApp
        ,
        [Switch]$PassThru
    ) 

    process {
            Get-AppxPackage $UApp | Remove-AppxPackage
            Write-Host "Uninstalled $UApp!" -ForegroundColor Green
    }
}

if ($doall -eq '3') {
    Write-Host "Beginning Level 3 Debloat" -ForegroundColor Yellow
    Remove-AppAuto -UApp '*3dbuilder*'
    Remove-AppAuto -UApp '*windowsalarms*'
    Remove-AppAuto -UApp '*windowscalculator*'
    Remove-AppAuto -UApp '*windowscommunicationsapps*'
    Remove-AppAuto -UApp '*windowscamera*'
    Remove-AppAuto -UApp '*officehub*'
    Remove-AppAuto -UApp '*skypeapp*'
    Remove-AppAuto -UApp '*getstarted*'
    Remove-AppAuto -UApp '*zunemusic*'
    Remove-AppAuto -UApp '*windowsmaps*'
    Remove-AppAuto -UApp '*solitairecollection*'
    Remove-AppAuto -UApp '*bingfinance*'
    Remove-AppAuto -UApp '*zunevideo*'
    Remove-AppAuto -UApp '*bingnews*'
    Remove-AppAuto -UApp '*onenote*'
    Remove-AppAuto -UApp '*people*'
    Remove-AppAuto -UApp '*windowsphone*'
    Remove-AppAuto -UApp '*photos*'
    Remove-AppAuto -UApp '*windowsstore*'
    Remove-AppAuto -UApp '*bingsports*'
    Remove-AppAuto -UApp '*soundrecorder*'
    Remove-AppAuto -UApp '*bingweather*'
    Remove-AppAuto -UApp '*xboxapp*'
    Remove-AppAuto -UApp '*Microsoft.MSPaint*'
    Remove-AppAuto -UApp '*Microsoft.MixedReality.Portal*'
    Remove-AppAuto -UApp '*Microsoft.YourPhone*'
    Remove-AppAuto -UApp '*Microsoft.Microsoft3DViewer*'
    Remove-AppAuto -UApp '*Microsoft.WindowsFeedbackHub*'
    Remove-AppAuto -UApp '*Microsoft.MicrosoftStickyNotes*'
    Remove-AppAuto -UApp '*Microsoft.ScreenSketch*'
    taskkill /f /im OneDrive.exe
    %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
    Remove-AppAuto -UApp '*Microsoft.Xbox.TCUI*'
    Remove-AppAuto -UApp '*Microsoft.XboxGameOverlay*'
    Remove-AppAuto -UApp '*Microsoft.XboxGamingOverlay*'
    Remove-AppAuto -UApp '*Microsoft.XboxIdentityProvider*'
    Remove-AppAuto -UApp '*Microsoft.XboxSpeechToTextOverlay*'
    break
}
if ($doall -eq '2') {
    Write-Host "Beginning Level 2 Debloat" -ForegroundColor Yellow
    Remove-AppAuto -UApp '*3dbuilder*'
    Remove-AppAuto -UApp '*officehub*'
    Remove-AppAuto -UApp '*skypeapp*'
    Remove-AppAuto -UApp '*getstarted*'
    Remove-AppAuto -UApp '*zunemusic*'
    Remove-AppAuto -UApp '*windowsmaps*'
    Remove-AppAuto -UApp '*solitairecollection*'
    Remove-AppAuto -UApp '*bingfinance*'
    Remove-AppAuto -UApp '*zunevideo*'
    Remove-AppAuto -UApp '*bingnews*'
    Remove-AppAuto -UApp '*onenote*'
    Remove-AppAuto -UApp '*people*'
    Remove-AppAuto -UApp '*windowsphone*'
    Remove-AppAuto -UApp '*bingsports*'
    Remove-AppAuto -UApp '*soundrecorder*'
    Remove-AppAuto -UApp '*bingweather*'
    Remove-AppAuto -UApp '*xboxapp*'
    Remove-AppAuto -UApp '*Microsoft.MSPaint*'
    Remove-AppAuto -UApp '*Microsoft.MixedReality.Portal*'
    Remove-AppAuto -UApp '*Microsoft.YourPhone*'
    Remove-AppAuto -UApp '*Microsoft.Microsoft3DViewer*'
    Remove-AppAuto -UApp '*Microsoft.WindowsFeedbackHub*'
    Remove-AppAuto -UApp '*Microsoft.MicrosoftStickyNotes*'
    Remove-AppAuto -UApp '*Microsoft.ScreenSketch*'
    Remove-AppAuto -UApp '*Microsoft.Xbox.TCUI*'
    Remove-AppAuto -UApp '*Microsoft.XboxGameOverlay*'
    Remove-AppAuto -UApp '*Microsoft.XboxGamingOverlay*'
    Remove-AppAuto -UApp '*Microsoft.XboxIdentityProvider*'
    Remove-AppAuto -UApp '*Microsoft.XboxSpeechToTextOverlay*'
    break
}
if ($doall -eq '1') {
    Write-Host "Beginning Level 1 Debloat" -ForegroundColor Yellow
    Remove-AppAuto -UApp '*3dbuilder*'
    Remove-AppAuto -UApp '*officehub*'
    Remove-AppAuto -UApp '*skypeapp*'
    Remove-AppAuto -UApp '*getstarted*'
    Remove-AppAuto -UApp '*zunemusic*'
    Remove-AppAuto -UApp '*bingfinance*'
    Remove-AppAuto -UApp '*zunevideo*'
    Remove-AppAuto -UApp '*bingnews*'
    Remove-AppAuto -UApp '*onenote*'
    Remove-AppAuto -UApp '*windowsphone*'
    Remove-AppAuto -UApp '*bingsports*'
    Remove-AppAuto -UApp '*soundrecorder*'
    Remove-AppAuto -UApp '*bingweather*'
    Remove-AppAuto -UApp '*Microsoft.MSPaint*'
    Remove-AppAuto -UApp '*Microsoft.MixedReality.Portal*'
    Remove-AppAuto -UApp '*Microsoft.YourPhone*'
    Remove-AppAuto -UApp '*Microsoft.Microsoft3DViewer*'
    Remove-AppAuto -UApp '*Microsoft.WindowsFeedbackHub*'
    break
}

Function Remove-App {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$UApp
        ,
        [Switch]$PassThru
    ) 

    process {
        $wantu = Read-Host "Would you like to remove $UApp ? Hit 'Y' for yes, hit ENTER to skip:"
        if ($wantu -eq 'Y') {
            Get-AppxPackage $UApp | Remove-AppxPackage
            Write-Host "Uninstalled $UApp!" -ForegroundColor Green
        }
        else {
            Write-Host "Skipped $UApp!" -ForegroundColor Yellow
        }
    }
}

    Remove-App -UApp '*3dbuilder*'
    Remove-App -UApp '*windowsalarms*'
    Remove-App -UApp '*windowscalculator*'
    Remove-App -UApp '*windowscommunicationsapps*'
    Remove-App -UApp '*windowscamera*'
    Remove-App -UApp '*officehub*'
    Remove-App -UApp '*skypeapp*'
    Remove-App -UApp '*getstarted*'
    Remove-App -UApp '*zunemusic*'
    Remove-App -UApp '*windowsmaps*'
    Remove-App -UApp '*solitairecollection*'
    Remove-App -UApp '*bingfinance*'
    Remove-App -UApp '*zunevideo*'
    Remove-App -UApp '*bingnews*'
    Remove-App -UApp '*onenote*'
    Remove-App -UApp '*people*'
    Remove-App -UApp '*windowsphone*'
    Remove-App -UApp '*photos*'
    Remove-App -UApp '*windowsstore*'
    Remove-App -UApp '*bingsports*'
    Remove-App -UApp '*soundrecorder*'
    Remove-App -UApp '*bingweather*'
    Remove-App -UApp '*xboxapp*'
    Remove-App -UApp '*Microsoft.MSPaint*'
    Remove-App -UApp '*Microsoft.MixedReality.Portal*'
    Remove-App -UApp '*Microsoft.YourPhone*'
    Remove-App -UApp '*Microsoft.Microsoft3DViewer*'
    Remove-App -UApp '*Microsoft.WindowsFeedbackHub*'
    Remove-App -UApp '*Microsoft.MicrosoftStickyNotes*'
    Remove-App -UApp '*Microsoft.ScreenSketch*'
    $onedriveu = Read-Host "Would you like to uninstall OneDrive? 'Y' for yes, ENTER to skip:"
    if ($onedriveu -eq 'Y') {
        taskkill /f /im OneDrive.exe
        %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
        Write-Host "Sucessfully uninstalled OneDrive!" -ForegroundColor Green
    }
    $xboxu = Read-Host "Would you like to uninstall Xbox Extras? 'Y' for yes, ENTER to skip:"
    if ($xboxu -eq 'Y') {
        Remove-AppAuto -UApp '*Microsoft.Xbox.TCUI*'
        Remove-AppAuto -UApp '*Microsoft.XboxGameOverlay*'
        Remove-AppAuto -UApp '*Microsoft.XboxGamingOverlay*'
        Remove-AppAuto -UApp '*Microsoft.XboxIdentityProvider*'
        Remove-AppAuto -UApp '*Microsoft.XboxSpeechToTextOverlay*'  
    }

Read-Host "Debloat complete! Please restart to finish the process. Press ENTER to quit:" -ForegroundColor Pink