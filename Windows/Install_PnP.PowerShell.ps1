[Net.ServicePointManager]::SecurityProtocol = "tls12"
powershell.exe -NoLogo -NoProfile -Command 'Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber'


###################################################################################################
# PnP.PowerShell 
Get-Module -ListAvailable | ? { $_.Name -like "*pnp*" }
Get-Module -Name PnP.PowerShell 
Get-Module -Name PnP.PowerShell -ListAvailable 
Import-Module -Name PnP.PowerShell 

Get-Module -ListAvailable -Name PnP.PowerShell | Uninstall-Module
Remove-Module -Name PnP.PowerShell -Force
Uninstall-Module -Name PnP.PowerShell -Force -AllowPrerelease -AllVersions

Update-Module -Name PnP.PowerShell

Find-Module PnP.PowerShell
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
