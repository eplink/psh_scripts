# todo Сделать ввод входных параметров с прооверкой существования файлов

$rar = $Env:ProgramFiles + "\WinRAR\rar.exe"

$runPath = $MyInvocation.MyCommand.Path | Split-Path -Parent
$backupList  = " @" + $runPath + "\backup.lst"
$excludeList = " -x@" + $runPath + "\exclude.lst"
$targetFolder = "d:\backup\day"

# todo Сделать метку времени созадния в имени файла ошибок
$logFile = " -ilog" + $targetFolder + "\backup.log"
$target = $targetFolder + "\shared_folders.rar"


#$command = rar + "A -ac -ag_YYYY-EEE_A  -ilog" E:Backupbackup.log -inul -m5 -os -r -rr -s -t -v4g 
#-x@E:BackupScriptexclude.lst E:BackupbackupsCompany.rar @E:backupScriptbackup.lst

#$command = $rar + " A -ac -ag_YYMMDDHH" + $logFile + " -inul -m5 -os -r -rr -s -t -v4g" 
#$command = $command + $excludeList + " " + $target + $backupList

# todo Сделать запуск команды из строки Command

# todo Сделать email репортинг

# Write-Host $command
#& $command