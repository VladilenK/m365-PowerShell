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

Install-Module -Name PnP.PowerShell -Scope CurrentUser -Force -RequiredVersion 1.12.0

Find-Module PnP.PowerShell | Install-Module -AllowClobber -Scope CurrentUser

Find-Module PnP.PowerShell -AllVersions
Find-Module PnP.PowerShell -AllowPrerelease
Find-Module PnP.PowerShell -AllowPrerelease | Install-Module -AllowClobber
Get-Module PnP.PowerShell -ListAvailable
Get-Module -ListAvailable

Remove-Module -Name PnP.PowerShell -Force 
Import-Module PnP.PowerShell -Force -NoClobber
Import-Module PnP.PowerShell -Force -RequiredVersion 1.12.0
Get-Module PnP.PowerShell
Get-Module *PnP*

###################################################################################################
return

Uninstall-Module -Name SharePointPnPPowerShellOnline -AllVersions
Get-Module -Name SharePointPnPPowerShellOnline -ListAvailable

Get-Command -Module PnP.PowerShell *search*


##########################################
# fixing
# Could not load file or assembly 'Microsoft.Identity.Client, Version=4.50.0.0, Culture=neutral, PublicKeyToken=0a613f4dd989e8ae'. 
# Could not find or load a specific file. (0x80131621)

get-module -Name "Microsoft.Identity.Client"
get-module -ListAvailable -Name "Microsoft.Identity.Client"
get-module -ListAvailable *Identity*
get-module -ListAvailable | ? { $_.Name -like "*Identity*" }
find-module -Name "Microsoft.Identity.Client"
Install-module -Name "Microsoft.Identity.Client"
Import-module -Name "Microsoft.Identity.Client" 

find-module Microsoft.IdentityModel.Abstractions
dotnet add package Microsoft.IdentityModel.Abstractions --version 6.22.0
