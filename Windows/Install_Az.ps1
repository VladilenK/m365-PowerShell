
Get-InstalledModule -Name Az 
Get-InstalledModule -Name Az -AllVersions | Select-Object -Property Name, Version
Get-Module Az -ListAvailable 
Find-Module Az

Install-Module -Name Az -AllowClobber -Scope CurrentUser

Import-Module Az

Remove-Module Az
Update-Module Az

# Connect to Azure with a browser sign in token
Connect-AzAccount -Subscription ""
Get-AzSubscription
Get-AzADUser -StartsWith "Vlad" | ft -a

Disconnect-AzAccount

####################
Get-AzADServicePrincipal | Where-Object { $_.DisplayName -match "DevOps" }

New-AzADServicePrincipal -Role Reader -Scope /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup

Uninstall-AzModule -Version 4.7.0
#################################################################

Get-Module -Name PackageManagement -ListAvailable
Update-Module -Name PackageManagement -Force 
Import-Module -Name PackageManagement -MinimumVersion 1.4
# Uninstall-Module Packagemanagement -MaximumVersion 1.1.7.2


Get-Module -Name AzureRM -ListAvailable
Remove-Module AzureRM 
Uninstall-AzureRM 

