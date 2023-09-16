Connect-PnPOnline -Url $siteUrl -ClientId $clientid -Interactive
Connect-PnPOnline -Url $siteUrl -Interactive
DisConnect-PnPOnline 

$list = Get-PnPList -Identity "Shared Documents" -Includes Fields
$list | ft -a
$list.ItemCount
$list.Fields

###############################################################################
###############################################################################
# Set List Items
$items = Get-PnPListItem -List $list -PageSize 50 -Fields Title, Id, DisplayName, Client_Title
$items.count
$items | ft Id, DisplayName, Client_Title
$items[0] | fl
$items[0].FieldValues

$item = Get-PnPListItem -List $list -Id 10
$item.FieldValues['Modified']
$item.FieldValues['Last_x0020_Modified']
$item.FieldValues['SMLastModifiedDate']
$item.FieldValues['FileLeafRef']

$dateModified = Get-Date
$dateModified = $dateModified.AddYears(-5)

Set-PnPListItem -List $list -Identity 10 -Values @{"FileLeafRef" = "Older-Document.xlsx"}
Set-PnPListItem -List $list -Identity 10 -Values @{"Title" = "Older Document"}
Set-PnPListItem -List $list -Identity 10 -Values @{"Modified" = $(Get-Date -Date "2018-07-15") } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{"Modified" = "2018-07-15" } -UpdateType UpdateOverwriteVersion
Set-PnPListItem -List $list -Identity 10 -Values @{"Last_x0020_Modified" = "1/1/2018 10:05 PM" } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{"SMLastModifiedDate" = "1/1/2018 10:05 PM" } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{"SMLastModifiedDate" = $(Get-Date -Date "2018-07-15") } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{Modified = [datetime]"1/1/2018 10:05 PM" } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{Last_x0020_Modified = [datetime]"1/1/2018 10:05 PM" } -UpdateType SystemUpdate
Set-PnPListItem -List $list -Identity 10 -Values @{Last_x0020_Modified = "2023-09-13T02:13:42Z" } -UpdateType UpdateOverwriteVersion
Set-PnPListItem -List $list -Identity 10 -Values @{"Modified" = $dateModified } -UpdateType UpdateOverwriteVersion
Set-PnPListItem -List $list -Identity 10 -Values @{"SMLastModifiedDate" = $dateModified } -UpdateType UpdateOverwriteVersion

Submit-PnPSearchQuery -Query "LastModifiedTimeForRetention<2021-01-01"
$results = Submit-PnPSearchQuery -Query "test"
$results


