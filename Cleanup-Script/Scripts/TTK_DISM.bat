@ECHO OFF 
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
ECHO ==========================
ECHO Trevor's Cleanup Script (TCS) V2.0
ECHO Last modified 1-17-21
ECHO Automation in progress... Please do not close
ECHO ==========================
ECHO Executing DISM - DO NOT TOUCH
dism /online /cleanup-image /restorehealth
ECHO Complete! Restarting...
ECHO ==========================
shutdown.exe -r -t 00