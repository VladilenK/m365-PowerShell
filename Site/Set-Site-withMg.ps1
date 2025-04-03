Get-Command "*admin*" -Module Microsoft.Graph.Sites

Connect-MgGraph -ClientId $clientid -TenantId $tenantId -CertificateThumbprint $certThumbprint
Get-MgContext

$siteUrl = "https://$orgname.sharepoint.com/sites/KBA-ACS-Site-01"

Get-MgSite 
Get-MgSite -search "Test" | Select-Object Id, DisplayName, WebUrl
Get-MgSite                | Select-Object Id, DisplayName, WebUrl

$siteId = "3a149d8e-c212-48f4-b9ca-c13710ed07e9"
$siteId = "b5734673-400c-4a0d-ac2f-3df3b80f3e1d"
Get-MgSite -SiteId $siteId
Get-MgSitePermission -SiteId $siteId -All


Import-Module Microsoft.Graph.Beta.Sites
Get-MgBetaSitePermission -SiteId $siteId -All

# Get-MgAdminSharepoint 
# Get-MgAdminSharepointSetting   