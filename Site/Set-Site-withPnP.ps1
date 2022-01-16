Get-Command *scop* -Module PnP.PowerShell

$siteUrl = "https://uhgdev.sharepoint.com/sites/Birding_in_KZ"
$siteUrl = "https://uhgdev.sharepoint.com/sites/ContosoHub"
$connection
$pnpTenantSite = Get-PnPTenantSite -Identity $siteUrl -Detailed -Connection $connection
$pnpTenantSite | Select-Object Url, Template, DenyAddAndCustomizePages | fl
$pnpTenantSite

Set-PnPTenantSite -Identity $siteUrl -Connection $connection -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Identity $siteUrl -Connection $connection -Owners $adminUPN


$siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $appId -ForceAuthentication -ReturnConnection -Interactive
$siteConnection 
$pnpSite = Get-PnPSite -Connection $siteConnection -Includes Url, IsHubSite, HubSiteId, SearchBoxInNavBar, SearchBoxPlaceholderText
$pnpSite | Select-Object Url, IsHubSite, HubSiteId, SearchBoxInNavBar, SearchBoxPlaceholderText

$pnpWeb = Get-PnPWeb  -Connection $siteConnection -Includes Url, Title, WebTemplate, SearchBoxInNavBar, SearchBoxPlaceholderText, SearchScope 
$pnpWeb | fl  Url, Title, WebTemplate, SearchBoxInNavBar, SearchBoxPlaceholderText, SearchScope 

# 1=tenant, 2=Hub, 3=site, 0=default
$pnpWeb.SearchScope = 2
$pnpWeb.SearchBoxPlaceholderText = "Search Hub"
$pnpWeb.Update()
Invoke-PnPQuery -Connection $siteConnection


# features
Get-PnPFeature -Identity 41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092 -Connection $siteConnection
Enable-PnPFeature -Identity 41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092   -Connection $siteConnection



