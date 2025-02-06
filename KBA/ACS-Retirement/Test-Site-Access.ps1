

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $appId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection
$connectionSite.Url

# Actions

$site = Get-PnPSite -Connection $connectionSite
$timestamp = Get-Date -Format "yyyy-MM-dd-hh-mm"; $timestamp

$lists = Get-PnPList -Connection $connectionSite
$lists.count
$timestamp = Get-Date -Format "yyyy-MM-dd-hh-mm"; $timestamp

$list = Get-PnPList -Connection $connectionSite -Identity $($lists | ? { $_.Title -eq "Documents" } )
$list
$timestamp = Get-Date -Format "yyyy-MM-dd-hh-mm"; $timestamp

$items = Get-PnPListItem -Connection $connectionSite -List $list
$items.count
$timestamp = Get-Date -Format "yyyy-MM-dd-hh-mm"; $timestamp

$item = Get-PnPListItem -Connection $connectionSite -List $list -Id 1
$item
$timestamp = Get-Date -Format "yyyy-MM-dd-hh-mm"; $timestamp



