# the scrip can remove some large list items based on criteria

$siteUrl = "https://$orgname.sharepoint.com/sites/TestTeamSite_01"
#New-SPOSite -Url $siteUrl -Owner $adminUPN -Template "sts#3" -StorageQuota 2048
# Connect-PnPOnline -Url $siteUrl -Credentials $cred
Connect-PnPOnline -Url $siteUrl -ClientId $clientID -ClientSecret $clientSc
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList1"
$list | ft -a
$list.ItemCount

# get items
$listItems = Get-PnPListItem -List $list -PageSize 1000
$listItems.count

# review items 
$listItems[0].FieldValues.Editor.LookupValue
($listItems[0..1] + $listItems[-2..-1] ) `
| select Id, `
@{Name = "Created"; Expression = { $_.FieldValues["Created"] } }, `
@{Name = "Modified"; Expression = { $_.FieldValues["Modified"] } }, `
@{Name = "Editor"; Expression = { $_.FieldValues["Editor"].LookupValue } }

# select items to delete based on criteria
$listItems.count
$itemsToDelete = $listItems | Where-Object { $_.FieldValues["Modified"] -gt "1/1/2023" } | Sort-Object Id 
$itemsToDelete = $listItems | Where-Object { $_.FieldValues["Modified"] -gt "2/12/2023" } | Sort-Object Id 
$itemsToDelete = $listItems | Where-Object { $_.FieldValues["Modified"] -gt "2023-02-12" } | Sort-Object Id 
$itemsToDelete.Count

($itemsToDelete[0..2] + $itemsToDelete[-3..-1] ) | select Id, `
@{Name = "Created"; Expression = { $_.FieldValues["Created"] } }, `
@{Name = "Modified"; Expression = { $_.FieldValues["Modified"] } }, `
@{Name = "Editor"; Expression = { $_.FieldValues["Editor"].LookupValue } }

# remove Items with batches
$timeStart = Get-Date
$batch = New-PnPBatch
$itemsToDelete | Foreach-Object { Remove-PnPListItem -List $list -Identity $_.Id -Batch $batch }
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

$list = Get-PnPList -Identity "LargeList1"
$list.ItemCount

$items = Get-PnPListItem -List $list -PageSize 500
$items.count
$items[0].Id
$items[-1].Id








#Remove-PnPList -Identity $list



# | ForEach-Object { Write-Host $_.Title }
