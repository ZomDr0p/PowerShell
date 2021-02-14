function Check-Vm{

#VMWare detection
    $vmw = $false

#VMWare 1º & 2º process detection
    Get-Process | % { if (($_.Name.ToLower().Equals("vm3dservice")) -or ($_.Name.ToLower().Equals("vmtoolsd"))) {$vmw = $true}}

#VMWare 1º regkey detection
    $vmwkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services\'
    if ($vmwkey.Name.ToLower().Equals("vmtools"))
    {
        $vmw = $true  
    }

#VMWare 2º regkey detection
    $vmwkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services\'
    if ($vmwkey.Name.ToLower().Equals("vmusbmouse"))
    {
        $vmw = $true
    }

#VMWare 2º regkey detection
    $vmwkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services\'
    if ($vmwkey.Name.ToLower().Equals("vmusbmouse"))
    {
        $vmw = $true
    }

#VMWare 1º & 2º service detection
    $vmwservice = Get-Service | % { if (($_.Name.ToLower().Equals("vmicvss")) -or ($_.Name.ToLower().Equals("vmtoolsd"))) {$vmw = $true}}



#VirtualBox detection
    $vbox = $false

#VirtualBox 1º & 2º process detection
    Get-Process | % { if (($_.Name.ToLower().Equals('vboxservice') -or ($_.Name.ToLower().Equals('vboxtray')))) {$vbox = $true} }

#VirtualBox 1º regkey detection
    $vboxkey = Get-ChildItem -Path 'HKLM:\HARDWARE\ACPI\DSDT'
    if ($vboxkey.Name.ToLower().Equals('vbox__'))
    {
        $vbox = $true
    }

#VirtualBox 2º regkey detection
    $vboxkey = Get-ChildItem -Path 'HKLM:\HARDWARE\ACPI\FADT'
    if ($vboxkey.Name.ToLower().Equals('vbox__'))
    {
        $vbox = $true
    }


#Xen detection
    $xenvm = $false


#Xen 1º & 2º & 3º & 4º process detection
    Get-ChildItem | % { if ( $_.Name.ToLower().Equals('xenservice')) { $xenvm = $true }}


#Xen 1º regkey
    $xenvmkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services'
    if ($xenvmkey.Name.ToLower().Equals('xenevtchn'))
    {
        $xenvm = $true
    }

#Xen 2º & 3º regkey
    $xenvmkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services'
    if ($xenvmkey.Name.ToLower().Contains('xennet'))
    {   
        $xenvm = $true
    }

#Xen 4º regkey
    $xenvmkey = Get-ChildItem -Path 'HKLM:\SYSTEM\ControlSet001\Services'
    if ($xenvmkey.Name.ToLower().Contains('xensvc'))
    {   
        $xenvm = $true
    }


#Check the detection variables and returns if the host is a virtualmachine and what technology 
if($vmw = $true)
{
    Write-Host "Is a VMWare machine"
}

elseif( $vbox = $true)
{
    Write-Host "Is a VirtualBox machine"
}

elseif( $xenvm = $true)
{
    Write-Host "Is a Xen machine"
}

else
{
    Write-Host "Is not a virutal machine"
}

}