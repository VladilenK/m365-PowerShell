Find-Module MSAL.PS
Get-InstalledModule -Name MSAL.PS

Get-Module MSAL.PS
Get-Module MSAL.PS -ListAvailable 
Get-Module MSAL.PS -ListAvailable | ft name, Version, Path 

Install-Module MSAL.PS -Force -Scope CurrentUser -AcceptLicense -SkipPublisherCheck

Update-Module MSAL.PS -Force
Uninstall-Module MSAL.PS -AllVersions
Get-InstalledModule -Name MSAL.PS | Uninstall-Module

Import-Module MSAL.PS


