Get-InstalledModule -Name Az 
Get-InstalledModule -Name Az -AllVersions | Select-Object -Property Name, Version
Get-Module Az 
Get-Module Az -ListAvailable 
Get-Module Az -ListAvailable | ft name, Version, Path 
Find-Module Az

Install-Module -Name Az -Scope CurrentUser -Force  -AllowClobber
Install-Module -Name Az -Scope AllUsers   -AllowClobber

Import-Module Az -RequiredVersion 5.7.0

Remove-Module Az
Update-Module Az -Scope CurrentUser -Force
Update-Module Az -Scope AllUsers 

UnInstall-Module -Name Az -AllVersions 
UnInstall-Module -Name Az -AllVersions 

Get-InstalledModule -Name Az | Uninstall-Module
Get-Module Az -ListAvailable | Uninstall-Module

# Az.Account
Get-InstalledModule -Name Az.Account 
Get-InstalledModule -Name Az -AllVersions | Select-Object -Property Name, Version
Get-Module Az.Account  
Get-Module Az.Account  -ListAvailable 
Find-Module Az.Account

Install-Module -Name Az.Account -Scope CurrentUser -AllowClobber 

Import-Module Az -RequiredVersion 5.7.0

Remove-Module Az
Update-Module Az.Account

# Resources
Get-Module Az.Resources -ListAvailable 
Find-Module Az.Resources

Update-Module Az.Resources
Remove-Module Az.Resources
Import-Module Az.Resources






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
Uninstall-Module AzureRM


###########################################################################
# MSAL
Find-Module MSAL.PS
Install-Module MSAL.PS



