<#
https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7
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

<# Module
Saving file as .psm1 makes it a PowerShell Script Module
Saving it in Documents\WindowsPowerShell\Modules\<Foldername same as psm1 file>\module.psm1
$env:PSModulePath
#>

<# Functions
Function can be called from elswere in the code
can accept input and output data
paramiters can use $args or named paramiters
there is default $input for all data sent to it
anything sent to output is returned from function (NOT write-host)

EXAMPLE:
function first3 {$input | select-object -First 3}
get-process | first3

#>

#Code signing
$cert = @(gci cert:\currentuser\my -codesigning)[0]
Set-AuthenticodeSignature signme.ps1 $cert


