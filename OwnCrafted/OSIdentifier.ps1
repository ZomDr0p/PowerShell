$os = Get-WmiObject -class win32_operatingsystem

$objecto = New-Object -TypeName PSObject;
$objecto | Add-Member -MemberType NoteProperty -Name "OSBuild" -Value $os.BuildNumber;
$objecto | Add-Member -MemberType NoteProperty -Name "WinVersion" -Value $os.Version;

Write-Output $objecto
