#region Module 8 - Automation Technologies

#Short workflow
Workflow MyWorkflow {Write-Output "Hello from Workflow!"}
MyWorkflow

#Long workflow
Workflow LongWorkflow
{
Write-Output -InputObject "Loading some information..."
  Start-Sleep -Seconds 10
  CheckPoint-Workflow
  Write-Output -InputObject "Performing process list..."
  Get-process -PSPersist $true #this adds checkpoint
  Start-Sleep -Seconds 10
  CheckPoint-Workflow
  Write-Output -InputObject "Cleaning up..."
  Start-Sleep -Seconds 10

}

LongWorkflow –AsJob –JobName LongWF –PSPersist $true
Suspend-Job LongWF #Susspend
Get-Job LongWF #See the job
Receive-Job LongWF –Keep #see current work
Resume-Job LongWF #Resume
Get-Job LongWF
Receive-Job LongWF –Keep
Remove-Job LongWF #removes the saved state of the job


#Parallel execution, all four commands run at the same time, resoult is mixed up
workflow paralleltest
{
    parallel
    {
        get-process -Name w*
        get-process -Name s*
        get-service -name x*
        get-eventlog -LogName Application -newest 10
    }
}
paralleltest

#Run command for all computers at the same time
workflow compparam
{
   param([string[]]$computers)
   foreach –parallel ($computer in $computers)
   {
        Get-CimInstance –Class Win32_OperatingSystem –PSComputerName $computer
        Get-CimInstance –Class win32_ComputerSystem –PSComputerName $computer
   }
}

compparam -computers solid, biosys

#Parallel and Sequence
workflow parallelseqtest
{
    parallel
    {
        sequence
        {
            get-process -Name w*
            get-process -Name s*
        }
        get-service -name x*
        get-eventlog -LogName Application -newest 10
    }
}
parallelseqtest

#No $global scope, Cannot use a case insensitive switch statement and interactive ones (use InlineScript)
Workflow RestrictionCheck
{
    $msgtest = "Hello"
    #msgtest.ToUpper()   That doesn't work
    $msgtest = InlineScript {($using:msgtest).ToUpper()} #Cannot use direct $string.ToLower()
    Write-Output $msgtest
}
RestrictionCheck

#Calling a function
$FunctionURL = "<your URI>"
Invoke-RestMethod -Method Get -Uri $FunctionURL

Invoke-RestMethod -Method Get -Uri "$($FunctionURL)&name=John"

$JSONBody = @{name = "World"} | ConvertTo-Json
Invoke-RestMethod -Method Post -Body $JSONBody -Uri $FunctionURL
#endregion
