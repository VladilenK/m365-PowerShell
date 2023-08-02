
$adminUrl = "https://$orgname-admin.sharepoint.com"
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionAdmin.Url


$siteUrl = "https://$orgname.sharepoint.com/teams/test-21"
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionSite.Url

$tenantSite = Get-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -Detailed
$tenantSite

$site = Get-pnpsite -Connection $connectionSite
$site

$SearchConfiguration = Get-PnPSearchConfiguration -Connection $connectionSite -OutputFormat ManagedPropertyMappings -Scope Site     
$SearchConfiguration


Get-PnPSearchSettings -Connection $connectionSite
Request-PnPReIndexWeb -Connection $connectionSite 



