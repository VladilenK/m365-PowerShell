$siteUrl
$appId
$appSecret

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $appId -ClientSecret $appSecret -ReturnConnection
$connectionSite.Url

$siteUrl
$appId
$tenantId
$certThumbprint

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $appId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection
$connectionSite.Url

# Actions

$site = Get-PnPSite -Connection $connectionSite
$site
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"; $timestamp

$lists = Get-PnPList -Connection $connectionSite
$lists.count
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"; $timestamp

$list = Get-PnPList -Connection $connectionSite -Identity $($lists | ? { $_.Title -eq "Documents" } )
$list.Title
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"; $timestamp

$items = Get-PnPListItem -Connection $connectionSite -List $list
$items.count
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"; $timestamp

$item = Get-PnPListItem -Connection $connectionSite -List $list -Id 1
$item.FieldValues.FileRef
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm"; $timestamp


