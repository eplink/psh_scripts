function Get-TargetFolderItem {
      Param ( 
        [Parameter (Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript ({Test-Path -Path $_ -PathType Container})]
            [string]$TargetFolder,
        [Parameter (Mandatory = $false)]
            [switch]$NoTempFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoVideoFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoAudioFiles = $false,
        [Parameter (Mandatory = $false)]
            [switch]$NoArchivedFiles = $false
    )
    
    $ArchAttribut = '-Attributes ArchiveArchive'
   
    $Result = Get-ChildItem -Path $TargetFolder -Recurse $ArchAttribut
    
    return $Result
}

'd:\111' | Get-TargetFolderItem | Write-Host