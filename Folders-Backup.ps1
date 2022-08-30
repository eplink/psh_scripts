<#
    Folders-Backup
    Version: 1.0.1
    
    .SYNOPSIS
    Backup the specified folders

    .DESCRIPTION   
    Backup script for the folders specified in the transferred file using the rar.exe console archiver
    
    .EXAMPLE
    ./Folders-Backup.ps1 `
        -rarFilePath 'c:\rar\rar.exe' `
        -targetsList 'D:\projects\backup.lst' `
        -excludesList 'D:\projects\exclude.lst' `
        -archPath 'D:\backup' `
        -archName 'shared_folders' `
        -isIncrCopy 1
#>

# to form a string of parameters for the console archiver
Param ( 
    [string]$rarFilePath,       # full path to archiever rar.exe
    [string]$targetsList,       # filepath with archFilePath folders to backup
    [string]$excludesList,      # filepath with exclusions from backup
    [string]$archPath,          # archive file destination path
    [string]$archName,          # archive file name
    [bool]$isIncrCopy           # is an incremental copy
)

# to use default value
$DEFAULT_INTERNAL_RAR_PATH = '\WinRAR\rar.exe'
$DEFAULT_ARCHIEVE_NAME = 'shared_folders'
$DEFAULT_LOGFILE_NAME = 'errors'

# to use the default parametrs
if (!$rarFilePath) {
    $rarFilePath = $Env:ProgramFiles + $DEFAULT_INTERNAL_RAR_PATH
}
if (!$archName) {
    $archName = $DEFAULT_ARCHIEVE_NAME
}
if (!$isIncrCopy) {
    $isIncrCopy = $false
}

# to check parameters for errors
if (!(Test-Path -Path $rarFilePath)) {
    Write-Host 'Error: Archiver is not detected!'
    exit 1
}
if (!(Test-Path -Path $targetsList)) {
    Write-Host 'Error: File of backup targets is not exist!'
    exit 1
}
if (!(Test-Path -Path $excludesList)) {
    Write-Host 'Error: File of excludes is not exist!'
    exit 1
}
if (!(Test-Path -Path $archPath)) {
    Write-Host 'Error: Path for create archive is no exist!'
    exit 1
}

# to create parameters for archiver
$targetsList  = "@" + $targetsList
$excludesList = "-x@" + $excludesList
$logFilePath = '-ilog' + $archPath + '\' + $DEFAULT_LOGFILE_NAME + '_' + (Get-Date).ToString("yyMMddHH") + '.log'
$archFilePath = $archPath + '\' + $archName + '_' + (Get-Date).ToString('yyMMddHH') + '.rar'
$keyIncrCopy = ''; if ($isIncrCopy) {$keyIncrCopy = '-ao'}

& $rarFilePath 'A' '-inul' '-ac' $keyIncrCopy $logFilePath '-m3' '-os' '-r' '-rr' '-s' '-t' $excludesList $archFilePath `
    $targetsList
