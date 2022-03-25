
$adminUrl = "https://uhgdev-admin.sharepoint.com"
$connectionAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionAdmin.Url


$siteUrl = "https://uhgdev.sharepoint.com/teams/AboutBirdwatching"
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ClientSecret $clientSc -ReturnConnection
$connectionSite.Url

$tenantSite = Get-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -Detailed
$tenantSite.DenyAddAndCustomizePages

Get-pnpsite -Connection $connectionSite
Set-PnPPropertyBagValue -Key "SiteCustomSubject" -Value "Birding" -Indexed:$true -Connection $connectionSite
Get-PnPPropertyBag -Key "SiteCustomSubject"  -Connection $connectionSite
Request-PnPReIndexWeb -Connection $connectionSite 


