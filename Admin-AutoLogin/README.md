# Admin-AutoLogin
This script allows the user to have an Administrator account automatically login to Windows on boot. I suggest you disable password on resuming in addition which can be found [here.](https://www.windowscentral.com/how-prevent-windows-10-requiring-password-when-resuming-sleep) These two things will make it so the user does not need to type in a password to login. In order to set this up, the user will need to know the username and password of the user they intend to auto login. If the users password is changed or auto login is no longer desired, run the script again.



## Running PowerShell Scripts
   * This is just one of many ways PowerShell scripts can be run as Admin. One of the least efficient but its easy for those unfamiliar with CLI.

   1. Search for "PowerShell" and click "Run ISE as Administrator"
      * ![PSInstructions1](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-1.PNG)
   2. Allow Admin access for PowerShell ISE
       * ![PSInstructions2](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-2.PNG)
   3. Run the command `Set-ExecutionPolicy Unrestricted` in the terminal below
       * ![PSInstructions3](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-3.PNG)
   4. Click "Yes to All"
       * ![PSInstructions4](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-4.PNG)
   5. Click the folder icon in the top left
       * ![PSInstructions5](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-5.PNG)
   6. Navigate to the PowerShell script you are running and click "Open"
       * ![PSInstructions6](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-6.PNG)
   7. Click the play button at the top to run the script
       * ![PSInstructions7](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-7.PNG)
   8. Follow the directions that pop up in the terminal window on the bottom.
       * ![PSInstructions8](https://raw.githubusercontent.com/trevorslong/Windows-Tools/main/Screenshots/ise-8.PNG)
   9. Once you're done run the command `Set-ExecutionPolicy RemoteSigned` to disable running PowerShell scripts from the internet

 
# Git Command
`git clone https://github.com/trevorslong/Windows-Tools`
*  Clones entire repository
*  add `~/FOLDER/SUBFOLDER` after PROGRAM.m to clone to specific folder
   * Ex: `git clone https://github.com/trevorslong/Windows-Tools ~/Windows-Tools`
   * to clone repository to a folder in home named Windows-Tools
