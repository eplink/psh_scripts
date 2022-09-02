<#
    Folder-Backup
    Version: 1.0.0
    
    .SYNOPSIS
    Backup the specified folder

    .DESCRIPTION   
    Backup script for the specified folder using the rar.exe console archiver and volume shadow copy
    
    .EXAMPLE
    ./Folder-Backup.ps1 `
        -Target 'D:\111' `
        -ExcList 'D:\projects\psh_scripts\Folder-Backup\exclude.lst' `
        -Dest 'D:\Backup' `
        -AddTL 1 `
        -IsIncr 1
#>

# to form a string of parameters for the console archiver
Param ( 
    [string]$Target,            # target path for backup
    [string]$ExcList,           # filepath with exclusions from backup
    [string]$Dest,              # archive file destination path
    [byte]$CompressRatio,       # archive ration of comression
    [bool]$AddTL,               # added time label to archive name
    [bool]$IsIncrCopy           # is an incremental copy
)

# to retun results of work
$Result = @{
    [bool]$ErrorFlag = $false
    [string]$Message = ''
    [string]$Result = ''
    [string]$Log = ''
}

# to use the default parametrs
$RAR_FILE_PATH = $Env:ProgramFiles + '\WinRAR\rar.exe'
if (!$AddTL) { $AddTL = $true }
if (!$IsIncrCopy) { $IsIncrCopy = $false }

# to check parameters for errors
if (!(Test-Path -Path $RAR_FILE_PATH)) {
    $Result.ErrorFlag = 1
    $Result.Message = "Error: Archiver Rar.exe not found!"
    Write-Host $Result.Message
    exit $Result
}
if (!(Test-Path -PaTh $Target)) {
    $Result.ErrorFlag = 1
    $Result.Message = "Error: Backup target is not exist!"
    Write-Host $Result.Message
    exit $Result
}
if (!(Test-Path -Path $ExcList)) {
    $Result.ErrorFlag = 1
    $Result.Message = "Error: File of excludes is not exist!"
    Write-Host $Result.Message
    exit $Result
}
if (!(Test-Path -Path $Dest)) {
    $Result.ErrorFlag = 1
    $Result.Message = "Error: Path of destinations is not exist!"
    Write-Host $Result.Message
    exit $Result
}
if (!($CompressRatio in 0..5)) {
    $Result.ErrorFlag = 1
    $Result.Message = "Error: Compression ratio is not in the range from 0 to 5!"
    Write-Host $Result.Message
    exit $Result
}

# to create parameters for archiver
$ExcList = "-x@" + $ExcList

$ArchName = Split-PaTh $Target -Leaf        # extract the last segment of the path
if ($AddTL) {
    $ArchName = $ArchName + '_' + (Get-Date).ToString('yyMMddHH')
}
$LogName = $ArchName + '.err'
$ArchName = $ArchName + '.rar'

$LogFilePath = '-ilog' + $Dest + '\' + $LogName
$ArchFilePath = $Dest + '\' + $ArchName

[string]$KeyIncrCopy 
if ($IsIncrCopy) {
    $KeyIncrCopy = '-ao'
}

Write-Host $RAR_FILE_PATH 'A' '-inul' '-ac' $KeyIncrCopy $LogFilePath '-m3' '-os' '-r' '-rr' '-s' '-t' $ExcludesList `
    $ArchFilePaTh $Target

exit $Result
