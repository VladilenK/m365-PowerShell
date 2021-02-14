$siteUrl = "https://$orgname.sharepoint.com/sites/TestTeamSite_01"
#New-SPOSite -Url $siteUrl -Owner $adminUPN -Template "sts#3" -StorageQuota 2048

Connect-PnPOnline -Url $siteUrl -Credentials $cred
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList2"
$list | ft -a
$list.ItemCount

# remove Items 
# plain
$timeStart = Get-Date
9001..10000 | Foreach-Object { Remove-PnPListItem -List $list -Identity $_ -Force:$true }
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds




# with script block
#Get-PnPListItem -List Tasks -PageSize 1000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } | % { $_.BreakRoleInheritance($true, $true) }
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } 
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items | ForEach-Object { $_.DeleteObject() } } 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 

$timeStart = Get-Date
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Descending | ForEach-Object { $_.DeleteObject() } } 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# remove Items with batches
$timeStart = Get-Date
$batch = New-PnPBatch
2001..9000 | Foreach-Object { Remove-PnPListItem -List $list -Identity $_ -Batch $batch }
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

$list = Get-PnPList -Identity "LargeList2"
$list.ItemCount

$items = Get-PnPListItem -List $list -PageSize 500
$items.count
$items[0].Id
$items[-1].Id








#Remove-PnPList -Identity $list



# | ForEach-Object { Write-Host $_.Title }
