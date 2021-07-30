# Test-Regpath.ps1
# This little function tests whether a registry directory exists and allows the user to specify how far into the directory they want to validate
# Created by Trevor Long, last modified 7-30-21
# -------------------------------------------------------------------------------------------------------------------------------------------------------
# Inputs:
# $regpath - the full registry path which you want to validate exists (required value)
# $firstnumber - this is how many levels deep into the $regpath the user wants to validate (default value is 999)
# -------------------------------------------------------------------------------------------------------------------------------------------------------
# Example:
# Test-Regpath -regpath HKLM:\System\CurrentControlSet\Services\XblAuthManager -firstnumber 3
# Output: HKLM:\System\CurrentControlSet exists
# True
# -------------------------------------------------------------------------------------------------------------------------------------------------------


Function Test-Regpath {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$regpath
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [int32]$firstnumber
        ,
        [Switch]$PassThru
    ) 
    process {
        if ($firstnumber -eq '0') {
            $firstnumber = 9999
        }
        $brokenregpath = $regpath.Split("\")
        $bregpath = $brokenregpath | Select-Object -First $firstnumber
        $bregpathj = $bregpath -join "\"
        if ( Test-Path $bregpathj ) {
            Write-Host "$bregpathj exists"
            $true
        }
        else {
            Write-Host "$bregpathj does not exist"
            $false
        }

    }
}