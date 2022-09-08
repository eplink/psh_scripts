# Справочник по командлетам Powershell

### Удаление папки со всем ее содержимым
` Remove-Item -Recurse -Force PATH\TO\FOLDER-NAME ` 
### Обновление Powershell 7.* через Интернет
` Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI" `
### Создание папки
` New-Item -Path 'C:\Dir\' -ItemType Directory `
### Сменить текущую папку
` Set-Location -Path C:\Windows `