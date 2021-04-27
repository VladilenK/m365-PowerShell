Find-Module -Filter "Exchange"
Find-Module ExchangeOnlineManagement
$moduleName = "ExchangeOnlineManagement"

Get-InstalledModule -Name $moduleName
Get-InstalledModule -Name $moduleName -AllVersions | Select-Object -Property Name, Version
Get-Module $moduleName 
Get-Module $moduleName -ListAvailable 
Get-Module $moduleName -ListAvailable | ft name, Version, Path 

Install-Module -Name $moduleName -AllowClobber -Scope CurrentUser
#Install-Module -Name $moduleName -AllowClobber -Scope AllUsers 

Import-Module $moduleName 

Remove-Module $moduleName
Update-Module $moduleName -Scope CurrentUser
Update-Module $moduleName -Scope AllUsers 

UnInstall-Module -Name $moduleName -AllVersions 
UnInstall-Module -Name $moduleName -AllVersions 

Get-InstalledModule -Name $moduleName | Uninstall-Module
Get-Module $moduleName -ListAvailable | Uninstall-Module

