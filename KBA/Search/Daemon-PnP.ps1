# Prerequisites
Get-Module PnP.PowerShell -ListAvailable

# Authentication
$tenantId = ''
$clientId = ''
$certThumbprint = ''

$siteUrl = "https://s5dz3.sharepoint.com"
Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Thumbprint $certThumbprint
(Get-PnPConnection).Url

# search
$query = "test*"
$res = Submit-PnPSearchQuery -Query $query 
$res.ResultRows.Count

$res = Submit-PnPSearchQuery -Query $query -MaxResults 5
$res.ResultRows.Count

$query = "* contentclass:STS_ListItem_DocumentLibrary author:Patti"
$res = Submit-PnPSearchQuery -Query $query -All 
$res.ResultRows.Count

$res
$res.ResultRows[0]
$res.ResultRows.Title

