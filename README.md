# Windows-Tools:
This repository contains batch files used to automate computer cleanup using built in Windows utilities. Made for Windows 10, will also probably work on Windows 8, 8.1, and 11. All scripts **Must be run as Administrator**. If you need help running these scripts scroll down to the directions.

# Scripts:
### Cleanup-Script
   * Designed for Windows 10
   * Cleanup script to help optimize Windows performance
   * This is a .bat file, right click and run as administrator

### Windows-Update-Cache-Cleanup
   * Stops Windows services and deletes the Windows update cache to fix issues with Windows update
   * This is a .bat file, right click and run as administrator

### Registry-Hardening
   * This script changes registry values to harden a Windows installation.
   * This is a .ps1 file, run PowerShell as Admin or follow the directions below.

### Fully-Disable-Cortana
   * This is designed for Windows 10
   * Disables Cortana through the registry
   * This is a .ps1 file, run PowerShell as Admin or follow the directions below.

### Remove-Bloatware
   * Automatically removes Windows bloatware using levels listed on the Remove-Bloatware README
   * Optional one-by-one removal of bloatware for better customization

# Other:

### Components:
   * A bunch of smaller functions and scripts used to make the other scripts, they may be helpful for scripts you write yourself

### Screenshots:
   * Screenshots for README.md tutorials.

## Running the .exe file
   * Right click the .exe file and click "Run as Administrator"
   * A CMD window should pop up, follow the on screen directions.

## Running PowerShell Scripts
   * This is just one of many ways PowerShell scripts can be run as Admin. One of the least efficient but its easy for those unfamiliar with CLI.

   1. Search for "PowerShell" and click "Run ISE as Administrator"
      * ![PSInstructions1](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-1.PNG)
   2. Allow Admin access for PowerShell ISE
       * ![PSInstructions2](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-2.PNG)
   3. Run the command `Set-ExecutionPolicy Unrestricted` in the terminal below
       * ![PSInstructions3](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-3.PNG)
   4. Click "Yes to All"
       * ![PSInstructions4](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-4.PNG)
   5. Click the folder icon in the top left
       * ![PSInstructions5](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-5.PNG)
   6. Navigate to the PowerShell script you are running and click "Open"
       * ![PSInstructions6](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-6.PNG)
   7. Click the play button at the top to run the script
       * ![PSInstructions7](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-7.PNG)
   8. Follow the directions that pop up in the terminal window on the bottom.
       * ![PSInstructions8](https://raw.githubusercontent.com/DroTron/Windows-Tools/main/Screenshots/ise-8.PNG)
   9. Once you're done run the command `Set-ExecutionPolicy RemoteSigned` to disable running PowerShell scripts from the internet

 
# Git Command
`git clone https://github.com/DroTron/Windows-Tools`
*  Clones entire repository
*  add `~/FOLDER/SUBFOLDER` after PROGRAM.m to clone to specific folder
   * Ex: `git clone https://github.com/DroTron/Windows-Tools ~/Windows-Tools`
   * to clone repository to a folder in home named Windows-Tools
