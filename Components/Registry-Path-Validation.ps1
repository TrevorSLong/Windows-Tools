# Registry-Path-Validation
# This little function tests whether a registry directory exists and shows where the path is broken if the path doesn't exists
# Created by Trevor Long, last modified 7-30-21
# -------------------------------------------------------------------------------------------------------------------------------------------------------
# Inputs:
# $regpath - the full registry path which you want to validate exists (required value)
# -------------------------------------------------------------------------------------------------------------------------------------------------------
# Example:
# Test-Regpath -regpath HKLM:\System\CurrentControlSet\Services\XblAuthManager -firstnumber 3
# Output: HKLM:\System\CurrentControlSet exists
# True
# -------------------------------------------------------------------------------------------------------------------------------------------------------


Function Validate-RegPath {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$regpath
        ,
        [Switch]$PassThru
    ) 
    process {
        
        $wholetrue = Test-Path $regpath
        if ( $wholetrue -eq $True ) {
            Write-Host "$regpath exists entirely." -ForegroundColor Green
        }
        else {
            $brokenregpath = $regpath.Split("\")
            $bregpath = $brokenregpath | Select-Object -First 1
            $bregpathj = $bregpath -join "\"
            $counter = 2
            $doesexist = Test-Path $bregpathj
            while ( $doesexist -eq $True ) {
                $lastbregpath = $bregpathj
                $bregpath = $brokenregpath | Select-Object -First $counter
                $bregpathj = $bregpath -join "\"
                $counter = $counter + 1
                $doesexist = Test-Path $bregpathj
            }
            $blastregpath = $lastbregpath.Split("\")
            Write-Host $lastbregpath -ForegroundColor Green -NoNewline
            $notexist = $regpath.Replace($lastbregpath,"")
            Write-Host $notexist -ForegroundColor Red
            Write-Host "--------------------------------------------------------"
            Write-Host "The path exists up to $lastbregpath" -ForegroundColor Green
            Write-Host "The path does not exist past $notexist" -ForegroundColor Red
            Write-Host "--------------------------------------------------------"
        }
    }
}