DisConnect-PnPOnline 
Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Tenant $tenantId -Interactive
Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Tenant $tenantId -Thumbprint $certThumbprint 

$tenant = Get-PnPTenant 
$tenant.SiteOwnerManageLegacyServicePrincipalEnabled
$tenant.LegacyAuthProtocolsEnabled
$tenant.DisableCustomAppAuthentication
$tenant | fl DisableCustomAppAuthentication

Set-PnPTenant -DisableCustomAppAuthentication $false
Set-PnPTenant -SiteOwnerManageLegacyServicePrincipalEnabled $true

$appId = "096fd951-7285-4e4f-9c1f-23a393556b19" # Client-app-with-Sites.Selected-dlg-02
$appId = "cb06d91c-33c7-408d-b5e2-4b60c33f2c7e" # KBA-ACS-App-01
$appId = "9cfd2747-c335-4103-88a7-ef5d6efaa3de" # KBA-ACS-App-02
$appId = "297219c4-bd24-4b9c-a15b-ec06de48f9f6" # KBA-ACS-App-03
$appId = "75bdc9ea-fcd6-49e0-bfda-5860f0fd2c5e" # KBA-ACS-App-04
$appId = "6fee0267-1b64-48e5-bfd3-d51472af13bd" # KBA-ACS-App-05
$appId = "777a9d91-725b-4bd5-bc5b-13967203ff3f" # KBA-ACS-App-06 
$appId = "faecd917-c657-4890-b6ea-1852acd697c1" # KBA-ACS-App-06 
$appId = "1ac8df5b-db63-4c4f-87b9-713495cfdda3" # KBA-ACS-App-07 
$appId = "7887d358-ef05-49df-964c-4fe5f122c0ba" # KBA-ACS-App-08 
$appId = "a2de88c7-d9b1-4958-94aa-8014f92d5ebf" # KBA-ACS-App-09 
$app = Get-PnPAzureADApp -Identity $appId
$appDisplayname = $app.DisplayName; $appDisplayname
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-01"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-02"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-03"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-04"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-05"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-06"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-08"
$siteUrl = "https://s5dz3.sharepoint.com/sites/KBA-ACS-Site-09"
$siteUrl = "https://s5dz3.sharepoint.com/teams/TestTeam01"

Grant-PnPAzureADAppSitePermission -AppId $appId -DisplayName $appDisplayname -Site $siteUrl -Permissions Read
Get-PnPAzureADAppSitePermission -Site $siteUrl 

$permissions = Get-PnPAzureADAppSitePermission -Site $siteUrl 
$permissions.Id

Revoke-PnPAzureADAppSitePermission -Site $siteUrl -PermissionId $permissions.Id

Get-PnPAzureACSPrincipal -Scope Site -IncludeSubsites 
Get-PnPAzureACSPrincipal -Scope Tenant 

