. D:\projects\psh_scripts\Get-TargetFolderItem.ps1

'd:\111' `
    | Get-TargetFolderItem -NoTempFiles -NoVideoFiles -NoArchivedFiles `
        | Write-Host