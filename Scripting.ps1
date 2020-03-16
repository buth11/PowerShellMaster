#region Region1 - Example
Get-Process
Get-Service
#endregion

Get-ExecutionPolicy #(Set-ExecutionPolicy Unrestricted RemoteSigned, Restricted,AllSigned)

#To run script we need to give full path 'c:\test.ps1' or when we are in forlder with script just '.\test.ps1'
#From CMD PowerShell [-noexit] "& <path>\<script>.ps1"  OR  pwsh -command "&.\addmumbers.ps1"

Write-Host #outputs data directly to the host (no pipeline)
Write-Output #outputs continue down the pipeline (BETER TO USE)

function Receive-Output
{
    process {Write-Host $_ -ForegroundColor Green}    
}

Write-Output "this is test" | Receive-Output

Write-Host #have pretty formating

Write-Host "you are looking " -NoNewline
Write-Host "Awesome" -ForegroundColor Red `
-BackgroundColor Yellow -NoNewline
Write-Host " today"

Write-Warning "danger" #preformated
Write-Error "error" #preformated

#If $var = 10 then '$var' wil be $var but "$var" will be 10
# `t - TAB

#User Input Read-Host
$name = Read-Host "Who are you?"
$pass = Read-Host "What is your password?" -AsSecureString
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass)) #Recover Secured password from $pass

#works with Windows PowerShell
param (
    [string]$compName = 'it01')
    get-wmiobject -class win32_computersystem `
    -computername $compName |
    fl numberofprocessors,totalphysicalmemory

#Works with pwsh (Lunch script '.\param.ps1 it02')
param (
    [string]$compName = 'it01')
    Get-CimInstance -ClassName win32_computersystem `
    -computername $compName |
    fl numberofprocessors,totalphysicalmemory

#Prompt for pc name
param (
    [Parameter(Mandatory=$true)][string]$compName)
    Get-CimInstance -ClassName win32_computersystem `
    -computername $compName |
    fl numberofprocessors,totalphysicalmemory


param (
    [Parameter(Mandatory=$true)][string[]]$comps)
    foreach ($compName in $comps)
    {
    Get-CimInstance -ClassName win32_computersystem `
    -computername $compName |
    fl numberofprocessors,totalphysicalmemory
    }