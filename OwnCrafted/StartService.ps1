$ServiceMonitored = "XboxGipSvc"
$ServiceStatus = Get-Service -Name $ServiceMonitored
$shortfecha = Get-Date -Format "ddMMyyyy-HHmmss"
$fullfecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

##Detects the service is Stopped or Running
if ($ServiceStatus.Status -eq "Running")
{
    Write-Host "The service $ServiceMonitored is"$ServiceStatus.Status""
}
else
{
    ##Output Warning
    Write-Host "The service  $ServiceMonitored is"$ServiceStatus.Status""
    $StatusService= $ServiceStatus.Status

    ##Creates the logfile
    $logstopped = New-Item -Path "C:\Users\user\AppData\" -ItemType File -Name "$shortfecha-$ServiceMonitored-Parado.txt" -Value "$fullfecha - The service $ServiceMonitored is on the state $StatusService"
    Write-Host "The file $logstopped was created to register this actions"
    sleep 1

    ##Output Warning
    Write-Host "The service $ServiceMonitored is going to be started..."
    sleep 1

    ##Changes the state of the process to Running
    $fullfecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    Add-Content $logstopped "`n$fullfecha - The service $ServiceMonitored is going to be started.."
    Set-Service $ServiceMonitored -Status Running
    sleep 3

    ##Check the process is Running
    $ServiceStatus = Get-Service -Name $ServiceMonitored
    $StatusService= $ServiceStatus.Status
    Write-Host "The service $ServiceMonitored has been updated to $StatusService!"

    ##The action is registered in the logfile
    Write-Host "This action is going to be registered at $logstopped"
    $fullfecha = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    Add-Content $logstopped "`n$fullfecha - The service $ServiceMonitored is on the state $StatusService"
    sleep 1

    ##Shows the content of the file
    cat $logstopped
}