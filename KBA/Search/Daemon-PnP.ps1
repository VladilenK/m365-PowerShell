# Prerequisites
Get-Module PnP.PowerShell -ListAvailable

# Authentication
$clientID
$certThumbprint
$TenantId 
$siteUrl = "https://s5dz3.sharepoint.com"
Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Thumbprint $certThumbprint
(Get-PnPConnection).Url

# search
$query = "test*"
$res = Submit-PnPSearchQuery -Query $query 
$res = Submit-PnPSearchQuery -Query $query -MaxResults 5

$query = "* contentclass:STS_ListItem_DocumentLibrary author:Patti"
$res = Submit-PnPSearchQuery -Query $query -All 

$query = "* site:https://s5dz3.sharepoint.com/teams/sxcdvbxcvbxvcxcv"
$res = Submit-PnPSearchQuery -Query $query 

$query = "test*"
$query = "test* site:https://s5dz3.sharepoint.com/teams/sxcdvbxcvbxvcxcv"
$res = Submit-PnPSearchQuery -Query $query -SortList @{"LastModifiedTime" = "ascending"} 


$res.ResultRows.Count
$res.ResultRows[0]
$res.ResultRows.Title
$res.ResultRows.OriginalPath
$res.ResultRows.LastModifiedTime

