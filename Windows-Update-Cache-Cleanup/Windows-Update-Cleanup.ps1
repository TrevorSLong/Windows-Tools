# Windows-Update-Cleanup.ps1
# Stops services, Remove-Itemetes update cache, then starts services again
# Great for troubleshooting Windows update errors

Write-Host "Welcome to Windows Update Cleanup! By using this tool you assume all risk (very minimal) to using this tool."
$accept = Read-Host "To accept, please type 'a' and hit ENTER:"
Read-Host "Thank you. Please hit ENTER to begin the cleanup process."

if ($accept -contains 'a'){

    Write-Host "Stopping Windows Update services....."

    Stop-service -Name "wuauserv"
    Stop-service -Name "cryptSvc"
    Stop-service -Name "bits"
    Stop-service -Name "msiserver"

    Write-Host "Complete!"

    #Remove-Item C:\Windows\SoftwareDistribution\Download\*.* -Recurse
    #Remove-Item C:\Windows\SoftwareDistribution\DataStore\*.* -Recurse
    #Remove-Item C:\Windows\SoftwareDistribution\PostRebootEventCache.V2\*.* -Recurse

    Write-Host "Deleting the update cache....."

    Get-ChildItem -Path C:\Windows\SoftwareDistribution\Download\ -Include * -File -Recurse | ForEach-Object { $_.Delete()}
    Get-ChildItem -Path C:\Windows\SoftwareDistribution\DataStore\ -Include * -File -Recurse | ForEach-Object { $_.Delete()}
    Get-ChildItem -Path C:\Windows\SoftwareDistribution\PostRebootEventCache.V2\ -Include * -File -Recurse | ForEach-Object { $_.Delete()}

    Write-Host "Complete!"

    Write-Host "Starting Windows Update services....."

    Start-service -Name "wuauserv"
    Start-service -Name "cryptSvc"
    Start-service -Name "bits"
    Start-service -Name "msiserver"

    Write-Host "Complete!"
    
    Read-Host "Process complete! Please reboot to finish cleanup. Press ENTER to exit."
}

