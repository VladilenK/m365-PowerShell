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


$sites2del | Select-Object -first 200
$sites2del | Select-Object -last 200
$sites2del.count

$sites2del = $sites2del | Select-Object -First 5010
$sites2del = $sites2del | Select-Object -skip 2
$sites2del = $standaloneSites | Select-Object -Skip 4

$connAdmin
$sites2del | ForEach-Object -Parallel {
    $conn = $using:connAdmin
    Write-Host $_.Url
    Remove-PnPTenantSite -Url $_.Url -Connection $conn -Force:$true 
} -ThrottleLimit 20

