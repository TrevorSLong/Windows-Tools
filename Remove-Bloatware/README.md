# Win10-Remove-Bloatware
This script automates the process of uninstalling Windows 10 bloatware. You can either choose what to uninstall one-by-one, or choose an uninstall level which has preset uninstallations listed below.


### Level 3 Uninstall:
    3dbuilder
    windowsalarms
    windowscalculator
    windowscommunicationsapps
    windowscamera
    officehub
    skypeapp
    getstarted
    zunemusic
    windowsmaps
    solitairecollection
    bingfinance
    zunevideo
    bingnews
    onenote
    people
    windowsphone
    photos
    windowsstore
    bingsports
    soundrecorder
    bingweather
    xboxapp
    Microsoft.MSPaint
    Microsoft.MixedReality.Portal
    Microsoft.YourPhone
    Microsoft.Microsoft3DViewer
    Microsoft.WindowsFeedbackHub
    Microsoft.MicrosoftStickyNotes
    Microsoft.ScreenSketch
    taskkill /f /im OneDrive.exe
    %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
    Microsoft.Xbox.TCUI
    Microsoft.XboxGameOverlay
    Microsoft.XboxGamingOverlay
    Microsoft.XboxIdentityProvider
    Microsoft.XboxSpeechToTextOverlay

### Level 2 Uninstall:
    3dbuilder
    officehub
    skypeapp
    getstarted
    zunemusic
    windowsmaps
    solitairecollection
    bingfinance
    zunevideo
    bingnews
    onenote
    people
    windowsphone
    bingsports
    soundrecorder
    bingweather
    xboxapp
    Microsoft.MSPaint
    Microsoft.MixedReality.Portal
    Microsoft.YourPhone
    Microsoft.Microsoft3DViewer
    Microsoft.WindowsFeedbackHub
    Microsoft.MicrosoftStickyNotes
    Microsoft.ScreenSketch
    Microsoft.Xbox.TCUI
    Microsoft.XboxGameOverlay
    Microsoft.XboxGamingOverlay
    Microsoft.XboxIdentityProvider
    Microsoft.XboxSpeechToTextOverlay

### Level 1 Uninstall:
    3dbuilder
    officehub
    skypeapp
    getstarted
    zunemusic
    bingfinance
    zunevideo
    bingnews
    onenote
    windowsphone
    bingsports
    soundrecorder
    bingweather
    Microsoft.MSPaint
    Microsoft.MixedReality.Portal
    Microsoft.YourPhone
    Microsoft.Microsoft3DViewer
    Microsoft.WindowsFeedbackHub

## Running the .exe file:
   * Right click the .exe and "Run as administrator"
   * Follow the on-screen directions

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
`git clone https://github.com/trevorslong/Windows-Tools`
*  Clones entire repository
*  add `~/FOLDER/SUBFOLDER` after PROGRAM.m to clone to specific folder
   * Ex: `git clone https://github.com/trevorslong/Windows-Tools ~/Windows-Tools`
   * to clone repository to a folder in home named Windows-Tools
