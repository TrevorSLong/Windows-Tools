## Cleanup-Script User Manual
   * Download the repository
   * Extract the files
   * Move the `Windows-Update-Cleanup` folder to the root of a flash drive
   * Double click the "Run TCS V2.0" Shortcut
   * When asked Y/N type "Y" and hit enter
   * Everytime the script restarts you will need to login
   * Later in the script an Admin prompt will pop up, please hit "Yes"
   * Wait until the script says its done
   * Make sure to hit ENTER to close the script!

## Video Instructions
   * [https://youtu.be/Q8NXnG8z5IE](https://youtu.be/Q8NXnG8z5IE)

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