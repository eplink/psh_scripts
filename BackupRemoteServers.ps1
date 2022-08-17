######################################################################################################################
###     Скрипт автоматизации резервного копирования удаленных серверов                                             ###
###                                                                                                                ###
###     Файлы:  BackupRemoteServers.ps1, BackupRemoteServers.json                                                  ###
###     Версия: 0.0.1                                                                                              ###
######################################################################################################################

$jSonFile = $MyInvocation.MyCommand.Path | Split-Path -Parent
$jSonFile = $jSonFile + "\BackupRemoteServers.json"

$Job = Get-Content $jSonFile -Raw -Encoding UTF8 | ConvertFrom-Json     # Загрузка параметров из .json

foreach ($Server in $Job.Servers) {                                     # Парсинг массива загруженного объекта
    
    $strLogFile = $Server.BackupPath -replace '/', '\' 
    $strLogFile += "\" + $Server.DnsName + ".log"

    $strBackupParam = " -backupTarget:" + $Server.BackupPath -replace '/', '\'
    $strBackupParam += $Server.IncludeArg
    $strBackupParam += " -allCritical"
    $strBackupParam += " -user:" + $Server.User
    $strBackupParam += " -password:" + $Server.Password
    $strBackupParam += " -quiet"
    
    $ScriptBlock = [scriptblock]::Create("WBADMIN START BACKUP $strBackupParam") 
    
    Invoke-Command -ComputerName $Server.DnsName -ScriptBlock $ScriptBlock | Out-File -LiteralPath $strLogFile

    # WBADMIN START BACKUP $strBackupParam >> $strLogFile

    # $strBackupParam = "-backupTarget:" + $strBackupParam 
    
    # WBADMIN START BACKUP -backupTarget:\\192.168.1.167\backup\hpv -include:d: -allCritical -user:OBLGAZ56\AUTOADMIN
    # -password:autoadmin -quiet
    
    # Write-Host $strBackupParam
    # Write-Host $strLogFile
}

# Write-Host $Job.MailServer
# Write-Host $Job.MailUser
