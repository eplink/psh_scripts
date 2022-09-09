function Get-TargetFolderItem {
    Param ( 
        [Parameter (Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript ({ Test-Path -Path $_ -PathType Container })]
        [string]$TargetFolder,
        [Parameter (Mandatory = $false)]
        [switch]$NoTempFiles = $false,
        [Parameter (Mandatory = $false)]
        [switch]$NoVideoFiles = $false,
        [Parameter (Mandatory = $false)]
        [switch]$NoArchivedFiles = $false
    )
    
    [string] $ExcludeFiles
    
    # to exclude temporary files from output of function
    if ($NoTempFiles) {
        $ExcludeFiles += @('~*.*','*.tmp', '*Thumbs.db')
    }

    # to exclude video files from output of function
    if ($NoVideoFiles) {
        $ExcludeFiles += @('*.mp4', '*.mpg', '*.avi', '*.wmf', '*.mov', '*.mkv', '3gp')
    }

    # to exclude archived files from output of function
    if ($NoArchivedFiles) {
        $Attribut = 'Archive'
    }
    
    $Result = & Get-ChildItem -LiteralPath $TargetFolder -Recurse -Force `
        -Exclude $ExcludeFiles -Attributes $Attribut
    
    return $Result 
}