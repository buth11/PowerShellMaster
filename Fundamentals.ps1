#test
Get-ChildItem | Sort-Object -Descending  -Property LastWriteTime #list objects from actual directory
Clear-Host
Get-ChildItem | ForEach-Object {"$($_.GetType().fullname) - $_.name"}
Clear-Host
Get-Host #vesion PowerShell
$PSVersionTable #vesion PowerShell
Get-Alias dir #actual command for Dir
Get-Alias # All Aliases
Get-PSDrive #Explore whole PC, drives, registres, functions etc
Get-Command -Module Plaster | Select-Object -Unique Noun | Sort-Object Noun #show all nouns commands in module
(Get-Module Plaster).Version #module version
Install-Module az #instal module AZ
Get-Help Get-ChildItem -Examples
Get-Command -Module Plaster
Get-Command -Noun SecureString
Get-Help Get-Process -Online