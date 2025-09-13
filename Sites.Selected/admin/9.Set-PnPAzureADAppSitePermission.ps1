DisConnect-PnPOnline 
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Tenant $tenantId -Interactive
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Tenant $tenantId -Thumbprint $certThumbprint 
Write-Host $connectionAdmin.Url

$tenant = Get-PnPTenant -Connection $connectionAdmin
$tenant.SiteOwnerManageLegacyServicePrincipalEnabled
$tenant.LegacyAuthProtocolsEnabled
$tenant.DisableCustomAppAuthentication
$tenant | fl DisableCustomAppAuthentication

Set-PnPTenant -DisableCustomAppAuthentication $false  -Connection $connectionAdmin
Set-PnPTenant -SiteOwnerManageLegacyServicePrincipalEnabled $true  -Connection $connectionAdmin

$appId = "" # 
$app = Get-PnPAzureADApp -Identity $appId  -Connection $connectionAdmin
$appDisplayname = $app.DisplayName; $appDisplayname

$siteUrl = "https://$orgname.sharepoint.com/teams/TestTeam01"

Grant-PnPAzureADAppSitePermission -AppId $appId -DisplayName $appDisplayname -Site $siteUrl -Permissions Read
Get-PnPAzureADAppSitePermission -Site $siteUrl  -Connection $connectionAdmin

$permissions = Get-PnPAzureADAppSitePermission -Site $siteUrl 
$permissions.Id

Revoke-PnPAzureADAppSitePermission -Site $siteUrl -PermissionId $permissions.Id

Get-PnPAzureACSPrincipal -Scope Tenant  -Connection $connectionAdmin

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $ClientId -Tenant $tenantId -Thumbprint $certThumbprint 
$connectionSite.Url

Get-PnPAzureACSPrincipal -Scope Site -IncludeSubsites -Connection $connectionSite

