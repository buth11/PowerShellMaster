<#
Comment a Block of code
test 1234
.SYNOPSIS
Gets information about passed servers
.DESCRIPTION
Gets information about passed servers using WMI
.PARAMETER computer
Name o computers to scan
.example
CompInfo.ps1 host1, host2
#>

get-help .\CompInfo.ps1

#Count and list arguments '.\script.ps1 Helo World'
Write-Host 'Number of Arguments was :'
($args.Length)
Write-Output 'and they were:'
foreach($arg in $args)
{
    Write-Output $arg
}


#Write-Host in order '.\script.ps1 -name World -greeting hello' -> Hello World
Param([Parameter(Mandatory=$true,Position=2)][Alias("Friend")][string]$Name,
[Parameter(Mandatory=$true,Position=1)][string]$Greeting)
Write-Host $Greeting $Name


#Show phisical or logical processors, '.\script.ps1 it01 -showlogprocs'
Param(
[Parameter(Mandatory=$true)][string]$computername,[switch]$showlogprocs)
if($showlogprocs)
{
    Get-CimInstance -class win32_computersystem -ComputerName $computername `
    | fl NumberOfLogicalProcessors,totalphysicalmemory
}
else
{
    Get-CimInstance -class win32_computersystem -ComputerName $computername `
    | fl numberofprocessors,totalphysicalmemory
}

Write-Verbose #If we lunch script with paramiter -verbose it will prompt us with info, for example procentage of completition
Write-Debug #Give info like write-verbose but itstops program and ask you what to do

#Try and Catch
$lookingood = $true
try {
        $win32CSOut = Get-CimInstance -ClassName win32_computersystem `
        -ComputerName $compName -ErrorAction Stop
}
catch {
    "Sotething bad: $_"
    $lookingood = $false
}
if ($lookinggood) {
    Write-Output "faild fo $compName"
}