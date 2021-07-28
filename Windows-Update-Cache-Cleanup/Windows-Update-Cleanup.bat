@echo off
ECHO ==========================
ECHO Trevor's Cleanup Script - Windows Update Cache Fix (TCS-WUC) V1.0
ECHO Last Modified 1-19-21
ECHO Note: User input is required after restarts
ECHO You are running this script at your own risk, I'm not responsible for damage to your OS or files
ECHO Automation in progress... Please watch for login and admin prompts!
ECHO ==========================
ECHO Press enter to continue
pause
ECHO ==========================
ECHO Please wait... Stopping Windows Update Services
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ECHO Complete!
ECHO ==========================
ECHO Please wait... Cleaning Software Distribution
del C:\Windows\SoftwareDistribution\Download\*.* /s/q/f
del C:\Windows\SoftwareDistribution\DataStore\*.* /s/q/f
del C:\Windows\SoftwareDistribution\PostRebootEventCache.V2\*.* /s/q/f
ECHO Complete!
ECHO ==========================
ECHO Please wait... Starting Windows Update Services
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
ECHO Complete!
ECHO ==========================
ECHO Restarting... Try updating after
ECHO Press enter to restart
pause
shutdown -r -t 0
