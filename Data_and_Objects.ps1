#region Module 6 - Parsing Data and Working With Objects

#Credentials
#This is not good
$user = "administrator"
$password = 'Pa55word'
$securePassword = ConvertTo-SecureString $password `
    -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $securePassword)

#An encrypted string
$encryptedPassword = ConvertFrom-SecureString (ConvertTo-SecureString -AsPlainText -Force "Password123")
$securepassword = ConvertTo-SecureString "<the huge value from previous command>"

#Another file
$cred = Get-Credential
$cred | Export-CliXml -Path "${env:\userprofile}\Jaap.Cred"

$cred = Import-CliXml -Path "${env:\userprofile}\Jaap.Cred"
Invoke-Command -Computername 'Server01' -Credential $cred {whoami}

    #OR

$credpath = "c:\temp\MyCredential.xml"
New-Object System.Management.Automation.PSCredential("john@savilltech.com", (ConvertTo-SecureString -AsPlainText -Force "Password123")) | Export-CliXml $credpath
$cred = import-clixml -path $credpath

#Var types [string], [char], [byte], [int], [long], [decimal], [bool], [DateTime]
$number=42
$boolset=$true
$stringval="hello"
$charval='a'
[char]$char='a'

$number.GetType() #--> number
$boolset.GetType()#--> boolean
$stringval.GetType()#--> string
$charval.GetType()#--> string
$char.GetType()#--> char

#test
42 –is [int]

$number = [int]42
#convert to string
$number.ToString() | gm

$string1 = "the quick brown fox jumped over the lazy dog"
#check if string1 contains "*fox" true/false
$string1 -like "*fox*"
#add two strings
$string2 = $string1 + " who was not amused"


#Time
$today=Get-Date # 2020 maja 19, wtorek 14:56:00
$today | Select-Object –ExpandProperty DayOfWeek #Tuesday
[DateTime]::ParseExact("02-25-2011","MM-dd-yyyy",[System.Globalization.CultureInfo]::InvariantCulture) # 2011 lutego 25, piątek 00:00:00
$christmas=[system.datetime]"25 December 2019" # 2019 grudnia 25, środa 00:00:00
($christmas - $today).Days # -146 
$today.AddDays(-60) # 2020 marca 20, piątek 14:56:00
$a = new-object system.globalization.datetimeformatinfo
$a.DayNames # Sunday, Monday, ... , Saturday

#Variable Scope
    #Local - current scope and child scopes
    #Global - accessible in all scopes
    #Script - avalable within the script scope only
    #Private - cannot be seen outside the current scope (not children)
function test-scope()
{
    write-output $defvar
    write-output $global:globvar
    write-output $script:scripvar
    write-output $private:privvar
    $funcvar = "function"
    $private:funcpriv = "funcpriv"
    $global:funcglobal = "globfunc"
}

$defvar = "default/local" #default
get-variable defvar -scope local
$global:globvar = "global"
$script:scripvar = "script"
$private:privvar = "private"
test-scope #no private
$funcvar
$funcglobal #this should be visible


#Variables with Invoke-Command
$message = "Message to John"
Invoke-Command -ComputerName za02 -ScriptBlock {Write-Host $message}

$ScriptBlockContent = {
    param ($MessageToWrite)
    Write-Host $MessageToWrite }
Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock $ScriptBlockContent -ArgumentList $message
#or
Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock {Write-Output $args} -ArgumentList $message

Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock {Write-Host $using:message}
