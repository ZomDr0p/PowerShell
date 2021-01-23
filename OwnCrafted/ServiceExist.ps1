$count= 0
do{
##Input service
$Service = Read-Host "Input a service"

##Check if the service exits in the host
foreach($Service in Get-Service | Where-Object{$_.Name -like $Service} | %{$_.Name})
    {
    $count ++
    }

##If does not exits
if($count -eq 0)
{
Write-Host "The service '$Service' does not exits"
}

##If does exits
else
{
Write-Host "The service '$Service' does exits"
Get-WmiObject -Class win32_service | Where-Object {$_.Name -like $Service} | Format-Table -Property Name,ProcessId,StartMode,State,Status
}

##If does not exist it repeats again 
}while($count -eq 0)