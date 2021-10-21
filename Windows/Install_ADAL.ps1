Get-InstalledModule -Name ADAL.PS
Find-Module ADAL.PS
Install-Module ADAL.PS

Get-Module ADAL.PS
Get-Module ADAL.PS -ListAvailable 
Get-Module ADAL.PS -ListAvailable | ft name, Version, Path 

Import-Module ADAL.PS

Uninstall-Module ADAL.PS -AllVersions
