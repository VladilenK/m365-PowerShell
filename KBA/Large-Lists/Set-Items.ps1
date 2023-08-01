# below are sample scripts to add, update and remove list items

$siteUrl = "https://$orgname.sharepoint.com/sites/Test001"
# Connect-PnPOnline -Url $siteUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant 
$connSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -ClientSecret $clientSc
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList1"
$list | ft -a
$list.ItemCount

###############################################################################
###############################################################################
# Set List Items
$items = Get-PnPListItem -List $list -PageSize 50 
$items.count

# withOut BATCHES
$timeStart = Get-Date
$items[1..10] | ForEach-Object { 
    $number = 7
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Set-PnPListItem -List "LargeList2" -Values $values -Identity $_.Id
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# with BATCHES
$timeStart = Get-Date
$batch = New-PnPBatch
$items[1..100] | ForEach-Object { 
    $number = 12
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Set-PnPListItem -List $list -Values $values -Identity $_.Id -Batch $batch
}
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# try Parallel: Set-PnPListItem
$timeStart = Get-Date
$items[1..100] | ForEach-Object -Parallel { 
    $number = 11
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Set-PnPListItem -List "LargeList2" -Values $values -Identity $_.Id
} -ThrottleLimit 3
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

