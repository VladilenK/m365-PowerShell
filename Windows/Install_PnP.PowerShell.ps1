[Net.ServicePointManager]::SecurityProtocol = "tls12"
powershell.exe -NoLogo -NoProfile -Command 'Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber'


###################################################################################################
# PnP.PowerShell 
Get-InstalledModule -Name PnP.PowerShell -AllVersions
Find-Module PnP.PowerShell

Get-Module -ListAvailable | ? { $_.Name -like "*pnp*" }
Get-Module -Name PnP.PowerShell 
Get-Module -Name PnP.PowerShell -ListAvailable 
Get-Module -Name PnP.PowerShell -ListAvailable | ft Name, Version, Path

Import-Module -Name PnP.PowerShell 

Remove-Module -Name PnP.PowerShell -Force
Uninstall-Module -Name PnP.PowerShell -Force -AllowPrerelease -AllVersions
Uninstall-Module -Name PnP.PowerShell -Force -RequiredVersion 1.4.0
Get-Module -ListAvailable -Name PnP.PowerShell | ? { $_.Version -ne '1.10.0' } | Uninstall-Module

Update-Module -Name PnP.PowerShell -Scope CurrentUser -Force

Find-Module PnP.PowerShell | Install-Module -AllowClobber -Scope CurrentUser

Find-Module PnP.PowerShell -AllowPrerelease
Find-Module PnP.PowerShell -AllowPrerelease | Install-Module -AllowClobber
Get-Module PnP.PowerShell -ListAvailable
Get-Module -ListAvailable

Import-Module PnP.PowerShell -Force -NoClobber
Get-Module PnP.PowerShell
Get-Module *PnP*

###################################################################################################
return

Uninstall-Module -Name SharePointPnPPowerShellOnline -AllVersions
Get-Module -Name SharePointPnPPowerShellOnline -ListAvailable

Get-Command -Module PnP.PowerShell *search*
