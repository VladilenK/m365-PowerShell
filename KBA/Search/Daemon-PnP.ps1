# Prerequisites
Get-Module PnP.PowerShell -ListAvailable

# Authentication
$tenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
$clientId = 'aceed4f0-1fc0-487d-90d1-6ed9cafb2541'
$certThumbprint = '160AE9107C82821A326363D4BCA82C1707C226B3'

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

