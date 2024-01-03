# Prerequisites
Get-Module PnP.PowerShell -ListAvailable

# Authentication
$clientid = 'd82858e0-ed99-424f-a00f-cef64125e49c'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
$siteUrl = "https://s5dz3.sharepoint.com"
Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Interactive
(Get-PnPConnection).Url

# search
$query = "test*"
$res = Submit-PnPSearchQuery -Query $query 
$res.ResultRows.Count

$query = "* site:https://s5dz3.sharepoint.com/teams/sxcdvbxcvbxvcxcv"
$res = Submit-PnPSearchQuery -Query $query 
$res.ResultRows.Count

$query = "*"
$res = Submit-PnPSearchQuery -Query $query -SortList @{"LastModifiedTime" = "ascending"} 

$res.RowCount
$res.TotalRows
$res.ResultRows[0].SiteName
$res.ResultRows.Title
$res.ResultRows.OriginalPath
$res.ResultRows.LastModifiedTime

