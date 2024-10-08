$connAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection 

$allsites = Get-PnPTenantSite -Connection $connAdmin
$allsites.Count
$urls = $allsites | Select-Object -Property Url -ExpandProperty Url

$standaloneSites = Get-PnPTenantSite -GroupIdDefined:$false -Connection $connAdmin
$standaloneSites.count

$groupSites = Get-PnPTenantSite -GroupIdDefined:$true -Connection $connAdmin
$groupSites.count
$groupSites[0] | fl | clip

$groups = Get-PnPMicrosoft365Group -Connection $connAdmin -IncludeSiteUrl
$groups.count
$groups[0].Visibility
$groups[0].siteUrl
$privateGroups = $groups | ?{$_.Visibility -eq "Private"} 
$privateGroups.count

$urls = $standaloneSites | Select-Object -Property Url -ExpandProperty Url
$urls += $privateGroups  | Select-Object -Property Url -ExpandProperty SiteUrl
$urls.count
$urls[0]

