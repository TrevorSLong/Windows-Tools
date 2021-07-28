@echo off
ECHO ==========================
ECHO Trevor's Cleanup Script (TCS) V2.0
ECHO Last Modified 1-17-21
ECHO Note: User input is required after restarts
ECHO You are running this script at your own risk, I'm not responsible for damage to your OS or files
ECHO Automation in progress... Please watch for login and admin prompts!
ECHO ==========================

call :Resume
goto %current%
goto :eof

:one
::Add script to Run key
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "%~n0" /d "%~dpnx0" /f
echo two >%~dp0current.txt
::Section 1
ECHO ==========================
ECHO Executing CHKDSK, CHKDSK will run during restart
chkdsk /f
ECHO Complete! CHKDSK will run after restart
ECHO ==========================
ECHO Please wait... Cleaning Temporary Files
cleanmgr /sagerun:11
del %temp%\*.*/s/q
ECHO Complete!
ECHO ==========================
ECHO Please wait... Defragmenting C Drive
defrag c: 
ECHO Complete!
ECHO ==========================
ECHO Executing SFC
sfc /scannow
ECHO Complete! Restarting to apply changes and run DISM
ECHO ==========================
shutdown -r -t 0
goto :eof

:two
echo three >%~dp0current.txt
::Section 2
ECHO ============================
ECHO Calling DISM script
@start %~d0%\TCS\Scripts\TTK_DISM.bat
ECHO Complete! Please wait for DISM script to complete and restart computer.
ECHO ============================
ECHO -DO NOT TOUCH, AUTOMATION IN PROGRESS-
goto :eof
pause

:three
::Remove script from Run key
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "%~n0" /f
del %~dp0current.txt
ECHO ==========================
ECHO Trevor's Cleanup Script (TCS) V2.0
ECHO Automation Complete
ECHO DO NOT HIT X! Press enter to close!
ECHO ---------- Windows Information ----------
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
SystemInfo | Find /i "Install Date"
ECHO ---------- System Information ----------
systeminfo | findstr /c:"Total Physical Memory"
wmic cpu get name
wmic diskdrive get name,model,size
wmic path win32_videocontroller get name
ECHO ---------- Press enter to close script ----------
ECHO ==========================
pause
goto :eof

:resume
if exist %~dp0current.txt (
    set /p current=<%~dp0current.txt
) else (
    set current=one
)