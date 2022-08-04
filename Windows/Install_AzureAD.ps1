Get-InstalledModule -Name AzureAD
Get-InstalledModule -Name AzureAD -AllVersions | Select-Object -Property Name, Version
Get-Module AzureAD -ListAvailable 
Get-Module AzureAD -ListAvailable | ft name, Version, Path 

Find-Module AzureAD
Install-Module -Name AzureAD -Scope CurrentUser
Install-Module -Name AzureAD -AllowClobber -Scope CurrentUser
Install-Module -Name AzureAD -AllowClobber -Scope AllUsers 

Import-Module AzureAD 
Import-Module AzureAD -RequiredVersion 5.7.0
Get-Module AzureAD 

Remove-Module AzureAD
Update-Module AzureAD -Scope CurrentUser
Update-Module AzureAD -Scope AllUsers 

UnInstall-Module -Name AzureAD -AllVersions 
UnInstall-Module -Name AzureAD -AllVersions 

Get-InstalledModule -Name AzureAD | Uninstall-Module
Get-Module AzureAD -ListAvailable | Uninstall-Module

Connect-AzureAD -ApplicationId $clientID -TenantId $tenantId -CertificateThumbprint $thumbprint

$PSVersionTable
