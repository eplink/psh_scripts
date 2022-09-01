<#
    Folder-Backup
    Version: 1.0.0
    
    .SYNOPSIS
    Backup the specified folder

    .DESCRIPTION   
    Backup script for the specified folder using the rar.exe console archiver and volume shadow copy
    
    .EXAMPLE
    ./Folder-Backup.ps1 `
        -target 'D:\111' `
        -exclList 'D:\exclude.lst' `
        -dest 'D:\backup' `
        -addTL 1 `
        -isVSS 1
        -isIncr 1
#>

# to form a string of parameters for the console archiver
Param ( 
    [string]$target,            # target path for backup
    [string]$excList,           # filepath with exclusions from backup
    [string]$dest,              # archive file destination path
    [bool]$addTL,               # added time label to archive name
    [0..5]$CompressRatio,       #     
    [bool]$isIncrCopy           # is an incremental copy
)

# to use the default parametrs
$RAR_FILE_PATH = $Env:ProgramFiles + '\WinRAR\rar.exe'
if (!$addTL) { $addTL = $true }
if (!$isIncrCopy) { $isIncrCopy = $false }

# to check parameters for errors
if (!(Test-Path -Path $RAR_FILE_PATH)) {
    Write-Host 'Error: Archiver is not detected!'
    exit 1
}
if (!(Test-Path -Path $target)) {
    Write-Host 'Error: Backup target is not exist!'
    exit 1
}
if (!(Test-Path -Path $excList)) {
    Write-Host 'Error: File of excludes is not exist!'
    exit 1
}
if (!(Test-Path -Path $dest)) {
    Write-Host 'Error: Path for create archive is no exist!'
    exit 1
}

# to create parameters for archiver
$excList = "-x@" + $excList

$archName = Split-Path $target -Leaf        # extract the last segment of the path
if ($addTL) {
    $archName = $archName + '_' + (Get-Date).ToString('yyMMddHH')
}
$logName = $archName + '.err'
$archName = $archName + '.rar'

$logFilePath = '-ilog' + $dest + '\' + $logName
$archFilePath = $dest + '\' + $archName

[string]$keyIncrCopy 
if ($isIncrCopy) {
    $keyIncrCopy = '-ao'
}

& $RAR_FILE_PATH 'A' '-inul' '-ac' $keyIncrCopy $logFilePath '-m3' '-os' '-r' '-rr' '-s' '-t' $excludesList `
    $archFilePath $target