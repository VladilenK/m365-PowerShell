$siteUrl = "https://kar1.sharepoint.com/sites/LargeLists"
#New-SPOSite -Url $siteUrl -Owner $adminUPN -Template "sts#3" -StorageQuota 2048

Connect-PnPOnline -Url $siteUrl -Credentials $cred
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList"
$list | ft -a
$list.ItemCount

# add list items
for ($i = 0; $i -lt 5500; $i++) {
    if ($i % 10) { Write-Host $i " " -NoNewline }
    $addedItem = Add-PnPListItem -List $list -Values @{"Title" = "Test Title " + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | % { [char]$_ })); "Number" = $(Get-Random -Minimum 1 -Maximum 10000 ) }
}

#Get-PnPListItem -List Tasks -PageSize 1000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } | % { $_.BreakRoleInheritance($true, $true) }
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } 
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items | ForEach-Object { $_.DeleteObject() } } 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Descending | ForEach-Object { $_.DeleteObject() } } 

Remove-PnPList -Identity $list



# | ForEach-Object { Write-Host $_.Title }
