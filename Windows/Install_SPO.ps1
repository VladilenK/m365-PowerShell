# https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps

Get-InstalledModule -Name Microsoft.Online.SharePoint.PowerShell
Get-Module Microsoft.Online.SharePoint.PowerShell -ListAvailable | ft -a
Find-Module Microsoft.Online.SharePoint.PowerShell | ft -a
Install-Module Microsoft.Online.SharePoint.PowerShell   #-Force 

Import-Module Microsoft.Online.SharePoint.PowerShell
Import-Module Microsoft.Online.SharePoint.PowerShell –force
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

# Update
Get-Module Microsoft.Online.SharePoint.PowerShell -ListAvailable | ft -a
Find-Module Microsoft.Online.SharePoint.PowerShell | ft -a

# If you already have a previous version of the shell installed, uninstall it first and then install the latest version.
Uninstall-Module -Name Microsoft.Online.SharePoint.PowerShell -AllVersions
Uninstall-Module -Name Microsoft.Online.SharePoint.PowerShell -RequiredVersion 16.0.8525.1200

#Update-Module -Name Microsoft.Online.SharePoint.PowerShell

Get-Command -Module Microsoft.Online.SharePoint.PowerShell
Get-Command -Module Microsoft.Online.SharePoint.PowerShell *templ*

# install MSonline

Get-Module MSOnline -ListAvailable | ft -a
Get-Command -Module MSOnline -All
Get-Command Get-MsolUser
Uninstall-Module MSOnline

Import-Module MSOnline 

Install-Module MSOnline 


####################
# tEAMS
find-module MicrosoftTeams
Install-Module -Name MicrosoftTeams
Get-InstalledModule MicrosoftTeams
Import-Module MicrosoftTeams
Get-Module MicrosoftTeams

Connect-MicrosoftTeams -Credential $cred
Get-Team -User $cUPN


return
###############################################################################################
Get-PSRepository
Register-PSRepository -Name "PSGallery" –SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted
Register-PSRepository -Default 

#Find-Module -Repository PSGallery -Verbose 

ls 'C:\Program Files\PackageManagement\ProviderAssemblies\'
explorer 'C:\Program Files\PackageManagement\ProviderAssemblies\'

$dcred = [System.Net.CredentialCache]::DefaultCredentials
[System.Net.WebRequest]::DefaultWebProxy.Credentials = $dcred


Get-PSRepository

####################################################
# if Import-Module : Could not load type 'Microsoft.SharePoint.Administration.DesignPackageType' from assembly 'Microsoft.SharePoint.Client, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.

# (1) Navigate to C:\Windows\Microsoft.NET\assembly\GAC_MSIL
# (2) Remove the Microsoft.SharePoint.Client* assemblies
# (3) Uninstall the module with Uninstall-Module -Name Microsoft.Online.SharePoint.PowerShell


