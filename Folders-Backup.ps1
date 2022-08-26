# ./Folders-Backup.ps1 
#       -backupList 'D:\projects\psh_scripts\Folders-Backup\backup.lst' 
#       -excludeList 'D:\projects\psh_scripts\Folders-Backup\exclude.lst' -targetFolder 'D:\Backup' 
#       -archName 'shared_folders' -incrCopy 1


Param ( 
    [string]$rarPath,
    [string]$backupList, 
    [string]$excludeList,
    [string]$targetFolder,
    [string]$archName,
    [bool]$incrCopy
)

# todo Сделать прооверку существования файлов переданных параметрами

if (!$rarPath) {
    $rarPath = $Env:ProgramFiles + "\WinRAR\rar.exe"
}

if (!$archName) {
    $archName = 'shared_folders'
}

if (!$incrCopy) {
    $incrCopy = $false
}


$backupList  = "@" + $backupList
$excludeList = "-x@" + $excludeList

# todo Сделать метку времени созадния в имени файла ошибок

$logFile = "-ilog" + $targetFolder + "\backup.log"
$target = $targetFolder + '\' + $archName + ".rar"


$command = $rarPath

& $command  'A' '-ac' '-ag_YYMMDDHH' $logFile '-m5' '-os' '-r' '-rr' '-s' '-t' $excludeList $target $backupList

# Write-Host $command

# todo Сделать email репортинг