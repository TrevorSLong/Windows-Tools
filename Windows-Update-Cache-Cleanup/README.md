## Windows-Update-Cache-Cleanup User Manual
   * Download the repository
   * Extract the files
   * Right click the .bat file and run as administrator
   * Press enter to run the script
   * Press enter once finished to end script and restart the computer


### What the script does:
   * Stops the services:
     * wuauserv
     * cryptSvc
     * bits
     * msiserver

   * Deletes the folders:
     * C:\Windows\SoftwareDistribution\Download\
     * C:\Windows\SoftwareDistribution\DataStore\
     * C:\Windows\SoftwareDistribution\PostRebootEventCache.V2\

   * Starts the services which were stopped
   * Restarts the computer