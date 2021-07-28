## Windows10RegistryHardening.ps1
Windows10RegistryHardening.ps1 takes care of many of the registry and services changes to help the security of Windows 10 systems. A full list of what is changed is below the instructions on how to run the script. Contact trevor.long@woodward.com with issues.

#### Running the script:
* Search for "Create a restore point"
  * Click "Configure"
  * Change the max usage to 1%, click "Apply", then click "OK"
  * Close the Window

* Search for "PowerShell ISE"
  * Run it as Admin
  * Go to File > Open and find ThinClientHardeningScript.ps1
  * In the PowerShell terminal at the bottom, type: `Set-ExecutionPolicy RemoteSigned`
  * Click "Yes to all" when prompted

* Run the script by clicking the green play button at the top of the screen
  * In the terminal you should see a disclaimer and instructions, click "ENTER" to continue
  * Once it asks you to click ENTER again, the script has finished running.
  * Take note of errors and correct them manually if needed.
  * Click ENTER to finish running the script

* In the PowerShell terminal type `Set-ExecutionPolicy Restricted` to undo the changes from before
  * Click "Yes to all" when prompted

* Close the PowerShell ISE, all services and registry values should now be changed.


#### What the script does:
•	Enables RemoteRegistry service and sets to “Automatic”
•	Starts RemoteRegistry service
•	Add DWORD `HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System' LocalAccountTokenFilterPolicy = 1`
•	Add DWORD `HKLM\Software\Policies\Microsoft\MIcrosoftEdge\Phishing Filter` `PreventOverrideAppRepUnknown = 1`
•	In `HKLM\System\CurrentControlSet\Services\RPCLocator\Start` - change from value of `3` to value of `4`
•	In `HKLM\System\CurrentControlSet\Services\SSDPSRV\Start` - change from value of `3` to value of `4`
•	In `HKLM\System\CurrentControlSet\Services\upnphost\Start` - change from value of `3` to value of `4`
•	In `HKLM\System\CurrentControlSet\Services\WMPNetworkSvc\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\icssvc\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\XboxGipSvc\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\XblAuthManager\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\XblGameSave\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\XboxNetApiSvc\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\irmon\Start` - change from value of `3` to value of `4` 
•	In `HKLM\System\CurrentControlSet\Services\SharedAccess\Start` - change from value of `3` to value of `4` 
•	In `Software\Policies\Microsoft\Windows NT\Terminal Services\Client`: Add the DWORD `fClientDisableUDP` and set the value to `1`
•	In `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0`
o	Change the value to `2`
