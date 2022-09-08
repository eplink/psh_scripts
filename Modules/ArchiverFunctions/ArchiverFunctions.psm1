<#
    .SYNOPSIS
    ArchiverFunctions module contains functions of work with internal archiver

    .DESCRIPTION
    This module contains useful functions of work with internal archiver
#>

# requires -version 4

function Get-TargetFolderItem
{
    [CmdletBinding()]
    Param ( 
        [Parameter (Mandatory = $true,
                    ValueFromPipeline = $true)]
            [System.IO.DirectoryInfo]$TargetFolder,
        [Parameter (Mandatory = $false)]
            [switch]$NoTempFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoVideoFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoAudioFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoArchivedFiles = $false
    )
    
   $Result = Get-ChildItem -Path $TargetFolder -Recurse
   Write-Host $Result

}
