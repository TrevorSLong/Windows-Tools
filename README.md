# Trevors-Cleanup-Script
This repository contains batch files used to automate computer cleanup using built in Windows utilities. Made for Windows 10, will also probably work on Windows 8 and 8.1.

## Cleanup-Script
   * Cleanup script to help optimize Windows performance

## Windows-Update-Cleanup
   * Stops Windows services and deletes the Windows update cache to fix issues with Windows update

## Registry-Hardening
   * This script changes registry values to harden a Windows installation.

## User Manual
   * Download the repository
   * Extract the files
   * Move the "TCS" folder to the root of a flash drive
   * Double click the "Run TCS V2.0" Shortcut
   * When asked Y/N type "Y" and hit enter
   * Everytime the script restarts you will need to login
   * Later in the script an Admin prompt will pop up, please hit "Yes"
   * Wait until the script says its done
   * Make sure to hit ENTER to close the script!

## Video Instructions
   * `https://youtu.be/Q8NXnG8z5IE`

## Utilities Used
#### Temporary File Cleaner
   * cleanmgr
   * del %temp%
#### Defragment C Drive
   * defrag c:
#### CHKDSK
   * CHKDSK /f
#### SFC
   * SFC /scannow
#### DISM
   * dism /online /cleanup-image /restorehealth
   
# Git Command
`git clone https://github.com/DroTron/Trevors-Cleanup-Script`
*  Clones entire repository
*  add `~/FOLDER/SUBFOLDER` after PROGRAM.m to clone to specific folder
   * Ex: `git clone https://github.com/DroTron/Trevors-Cleanup-Scripts ~/Trevors-Cleanup-Script`
   * to clone repository to a folder in home named NumericalMethods
