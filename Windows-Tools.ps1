# Windows-Tools.ps1
# All tools written by Trevor Long
# Last Modified 12-6-21
# The goal of this tool is to wrap all of the other tools into one

Write-Host "|------------------------------------------------------------------|"
Write-Host "|                  Windows-Tools by Trevor Long                    |"
Write-Host "|                      Last Modified 12-6-21                       |"
Write-Host "|------------------------------------------------------------------|"
Write-Host "|         By using these tools you assume all risk involved        |"
Write-Host "|             I am not responsible if your Windows breaks!         |"
Write-Host "|             Its always a good idea to back up your data!         |"       
Write-Host "|------------------------------------------------------------------|"

Read-Host "To accept the risk of using these scripts type 'A' and hit ENTER."

Write-Host "Welcome to Windows-Tools! Choose the tool to run, then hit ENTER."
Write-Host "Please note: all folders must be present and in their original locations!"
Write-Host "Ex: 'a' then hit ENTER."
Write-Host "Please note, Cleanup Script can not be run from this all-in-one tool."
Write-Host ""
Write-Host "A) Disable Windows Auto Update"
Write-Host "B) Fully Disable Cortana"
Write-Host "C) Registry Hardening"
Write-Host "D) Remove Bloatware"
Write-Host "E) Windows options"
Write-Host "F) Windows Update Cleanup"
$tools = Read-Host "Enter the letter here:"

if ($tools -contains 'a'){
    & "$PSScriptRoot\Disable-Windows-Auto-Update\Disable-AutoUpdate.ps1"
}
if ($tools -contains 'b'){
    & "$PSScriptRoot\Fully-Disable-Cortana\Fully-Disable-Cortana.ps1"
}
if ($tools -contains 'c'){
    & "$PSScriptRoot\Registry-Hardening\Windows10RegistryHardening.ps1"
}
if ($tools -contains 'd'){
    & "$PSScriptRoot\Remove-Bloatware\Remove-Bloatware.ps1"
}
if ($tools -contains 'e'){
    & "$PSScriptRoot\Windows-Options\Windows-Options.ps1"
}
if ($tools -contains 'f'){
    & "$PSScriptRoot\Windows-Update-Cache-Cleanup\Windows-Update-Cleanup.ps1"
}