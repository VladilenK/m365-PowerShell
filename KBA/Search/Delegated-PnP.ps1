# Prerequisites
Get-Module PnP.PowerShell -ListAvailable

# Authentication
$clientid = '31359c7f-bd7e-475c-86db-fdb8c937548e'
$clientid = 'd82858e0-ed99-424f-a00f-cef64125e49c'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
$siteUrl = "https://s5dz3.sharepoint.com"
Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Interactive

# search
$query = "test*"
$res = Submit-PnPSearchQuery -Query $query 

$query = "* contentclass:STS_ListItem_DocumentLibrary author:Patti"
$res = Submit-PnPSearchQuery -Query $query -All 

$query = "* site:https://s5dz3.sharepoint.com/teams/sxcdvbxcvbxvcxcv"
$res = Submit-PnPSearchQuery -Query $query 

$query = "test*"
$res = Submit-PnPSearchQuery -Query $query -SortList @{"LastModifiedTime" = "ascending"}

$res.ResultRows.Count
$res.ResultRows[0]
$res.ResultRows.Title
$res.ResultRows.OriginalPath
$res.ResultRows.LastModifiedTime

