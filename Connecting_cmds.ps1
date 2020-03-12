# ';' add at the and if you want to run multi commands on one line
Write-Output "hello"; Write-Output "World"

Get-Process a* | Get-Member #all things (events, methods, properties etc)

Get-Process |Where-Object {$_.Name -eq "notepad"} | Get-Member

Get-Process |Where-Object {$_.Name -eq "notepad"} | Stop-Process #stop notepad
(Get-Process |Where-Object {$_.Name -eq "notepad"}).kill() #kill notepad

Get-Process | Sort-Object -Property Name | Where-Object {$_.Name -eq "notepad"} #narrow it to the right bad idea

Get-Process -Name notepad | Sort-Object -Property id #narrow it to the left good idea
Get-Process -Name notepad | Sort-Object -Property id | Stop-Process

ipconfig | Select-String -Pattern 192

#variables
$proc = Get-Process #all processes in variable
$proc[0] #call 1st process

$proc.GetType()         #check type
$proc.GetType().FullName

$proc | Format-List  # or table etc.

Get-Process | Select-Object -Property Name, @{name='procid';expression={$_.id}} #select only Name and ID as 'procid'
Get-Process | Where-Object {$_.Handles -gt 1000} | Sort-Object -Property Handles | Format-Table Name,Handles -AutoSize
$proc = Get-Process | Where-Object {$_.Handles -gt 1000} # or $proc = Get-Process | Where-Object Handles -gt 1000

#out-verb
Get-Process | Out-GridView #gridView
Get-Process | Out-GridView -PassThru | Stop-Process # opent gridview and close process of selected row and pressing OK

Get-Process w* | clip #copy to clipboard output of command

Get-Process > proc.txt #save output in txt file
notepad proc.txt #open  saved txt file
Remove-Item .\proc.txt #remove txt file

Get-Process | Out-File proc.txt #save output in txt file
Get-Content .\proc.txt #display content

Get-Process | Export-Csv proc.csv # export all info to csv file
Get-Process | Export-Clixml proc.xml # export all info to xml file, more detiled

$proc = Import-Csv .\proc.csv # import all info fro csv file as objects
$proc = Import-Clixml .\proc.xml # import all info fro xml file as objects

Get-Process | Measure-Object # no of processes
Get-Process | Measure-Object WS -Sum -Maximum -Minimum -Average
Get-Process | Sort-Object ws -Descending | Select-Object -First 5

Get-WinEvent -LogName security -MaxEvents 5 #need admin rights
Invoke-Command -ComputerName br001, br002 -ScriptBlock {Get-WinEvent -LogName security -MaxEvents 5} # execute command remotly

Get-NetAdapter | Where-Object {$_.Name -like "Ethernet*"} | Enable-NetAdapter # remotly turn on nic

#Compare-Object
$proc = Get-Process
$proc2 = Get-Process
Compare-Object -ReferenceObject $proc -DifferenceObject $proc2 -Property name #compare one variable with other by Name

#Advanced outputs: html, json, csv, xml, secure string

# -WhatIf : shows you what would happen, -Confirm  : ask you for conformation
Get-Process | Stop-Process -WhatIf #show what will happen if you would run stupid command

#remote AD
Enter-PSSession -ComputerName bujalski-master
#filter users than didn't logon fo over 360 days
Get-ADUser -Filter * -Properties "LastLogonDate" | Where-Object {$_.LastLogonDate -le (Get-Date).AddDays(-360)} | Sort-Object -Property lasrlogondate -Descending | Format-Table -Property name, lastlogondate -AutoSize
#disable this account (whatif)
Get-ADUser -Filter * -Properties "LastLogonDate" | Where-Object {$_.LastLogonDate -le (Get-Date).AddDays(-360)} | Sort-Object -Property lasrlogondate -Descending | disable-adaccount -WhatIf

#confirmpreference

$ConfirmPreference #high, medium, low if they are same or different < then it prompt for conformation
$ConfirmPreference = "medium" #change conformation level
Get-Process notepad | Stop-Process -Confirm:$false #turn off conformation
Get-Service | Where-Object {$_.Status -eq "stopped"} | Start-Process -WhatIf

#alias % foreach-object, ? where-object









