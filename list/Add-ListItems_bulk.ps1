$siteUrl = "https://$orgname.sharepoint.com/sites/TestTeamSite_01"
Connect-PnPOnline -Url $siteUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant 
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList2"
$list | ft -a
$list.ItemCount

# add list items
# withOut BATCHES
$timeStart = Get-Date
for ($i = 0; $i -lt 500; $i++) {
    if ($i % 10) {} else { Write-Host $i " " -NoNewline }
    $title = "Test Title " + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | % { [char]$_ }))
    $number = $(Get-Random -Minimum 12000 -Maximum 13000 )
    $values = @{"Title" = $title; "Number" = $number }
    $addedItem = Add-PnPListItem -List $list -Values $values
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# with BATCHES
$timeStart = Get-Date
$batch = New-PnPBatch
1..1000 | ForEach-Object { 
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title }
    Add-PnPListItem -List $list -Values $values -Batch $batch 
}
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

#Get-PnPListItem -List Tasks -PageSize 1000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } | % { $_.BreakRoleInheritance($true, $true) }
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } 
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items | ForEach-Object { $_.DeleteObject() } } 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Descending | ForEach-Object { $_.DeleteObject() } } 

#Remove-PnPList -Identity $list



# | ForEach-Object { Write-Host $_.Title }
