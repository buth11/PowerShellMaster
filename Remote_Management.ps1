Enter-PSSession -ComputerName HA01 #enter session
Get-PSSession #check open sessions
Measure-Command {Get-Process} #tels what timie it took
Invoke-Command -ComputerName HA01 {$var=10} #will not work because sesion will close after executing command and varialbe will dissapire

Invoke-Command -ComputerName Bujalski-master -ScriptBlock {Get-EventLog -logname secrity | Select-Object -First 10}
Invoke-Command -ComputerName Bujalski-master -ScriptBlock {Get-Process | Select-Object -First 10}
Invoke-Command -ComputerName Bujalski-master -ScriptBlock {Get-EventLog -logname secrity -newest 10}

Measure-Command {Invoke-Command -ComputerName Bujalski-master -ScriptBlock {Get-Process | Where-Object {$_.name -eq "notepad"}}} #working remotly extract smallest amount data as possible to your machine

Invoke-Command -ComputerName Bujalski-master -ScriptBlock {Get-Process | Where-Object {$_.name -eq "notepad"} | Stop-Process}

#Max no of Invoke-Command's is 32 but we can change that by 'ThrottleLimit'
Get-PSSessionConfiguration #sessions config
$sess = New-PSSession -ComputerName Bujalski-master #-Credential (Get-Credential)

Invoke-Command -Session $sess {$var=10}
Invoke-Command -Session $sess {$var} #now it will work because sesion opened

$sess | Remove-PSSession #close session

$dcs = "bujalski-master", "solid"  #domain Controlers list
$dcs
Invoke-Command -ComputerName $dcs -ScriptBlock {$env:COMPUTERNAME} #lunch code for multi PC's

$sess = New-PSSession -ComputerName $dcs
Invoke-Command -Session $sess -ScriptBlock {$env:COMPUTERNAME} #open multi sessions

Enter-PSSession -Session $sess[0] #enter 1st session (0 base)

$sess | Remove-PSSession #close sessions

$dc = New-PSSession -ComputerName bujalski-master #session to DC

Import-Module -name activedirectory -PSSession $dc #import module from DC

$command = "Get-Process" #command as a string
&$command #to execute the string

Import-Module -Name activedirectory -PSSession $dc -Prefix OnDC #impotr new module with prefix to have dwo versions of same module

Get-Module -ListAvailable -SkipEditionCheck     #instal modules notcompatible with Core

Install-Module windowscompatibility -Scope currentuser
Import-WinModule microsoft.powershell.management

Get-EventLog -Newest 5 -LogName security

$sess = New-PSSession -Name DC1Sess -ComputerName bujalski-master  #we can connect and dissconnect to session
Get-PSSession
Invoke-Command -Session $sess {$var=50}
Disconnect-PSSession -Id 19
Connect-PSSession -Id 19
Invoke-Command -Session $sess {$var} #return 50
$sess | Remove-PSSession

# (get-psdrive) WSMan:\localhost\Client\Auth> CredSSP->false

Enter-PSSession bujalski-master.bujalski.local -Authentication Credssp -Credential (Get-Credential) #now we can use invoke-command in session
#Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value '' (10.0.0.121, *.bujalski.local, etc)

Import-Module PSDiagnostics
Get-Command -Module PSDiagnostics
Enable-PSWSManCombinedTrace
Invoke-Command -ComputerName za10 -ScriptBlock {Get-Process}
Disable-PSWSManCombinedTrace

#Book: secrets of powershell remoting