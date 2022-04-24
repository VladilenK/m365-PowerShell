$siteUrl = "https://$orgname.sharepoint.com/sites/TestTeamSite_01"
# Connect-PnPOnline -Url $siteUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant 
Connect-PnPOnline -Url $siteUrl -ClientId $clientID -ClientSecret $clientSc
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList1"
$list | ft -a
$list.ItemCount

# add list items
# withOut BATCHES
$timeStart = Get-Date
1..20 | ForEach-Object { 
    $number = 1
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Add-PnPListItem -List $list -Values $values 
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# with BATCHES
$timeStart = Get-Date
$batch = New-PnPBatch
1..7000 | ForEach-Object { 
    $number = 31100
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Add-PnPListItem -List $list -Values $values -Batch $batch 
}
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# try Parallel: Add-PnPListItem
$timeStart = Get-Date
1..100 | ForEach-Object -Parallel { 
    $number = 9
    $title = "Test Title $_" + $( -join ((65..90) + (97..122) | Get-Random -Count 15 | ForEach-Object { [char]$_ }))
    $values = @{"Title" = $title; "Number" = $number }
    Add-PnPListItem -List "LargeList1" -Values $values 
} -ThrottleLimit 5
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

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

###############################################################################
#Remove List Items
$items = Get-PnPListItem -List $list -PageSize 50 
$items.count

# withOut BATCHES
$timeStart = Get-Date
$items[11..111] | ForEach-Object { 
    Remove-PnPListItem -List $list -Identity $_ -Force:$true
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# with BATCHES
$timeStart = Get-Date
$batch = New-PnPBatch
$items | Foreach-Object { Remove-PnPListItem -List $list -Identity $_.Id -Batch $batch }
Invoke-PnPBatch -Batch $batch
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds

# with ScriptBlock
$timeStart = Get-Date
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 -ScriptBlock `
{ Param($items) $items | Sort-Object -Property Id -Descending | ForEach-Object { $_.DeleteObject() } }
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds


###############################################################################

#Get-PnPListItem -List Tasks -PageSize 1000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } | % { $_.BreakRoleInheritance($true, $true) }
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() } 
Get-PnPListItem -List $list -PageSize 100 -ScriptBlock { Param($items) $items | ForEach-Object { $_.DeleteObject() } } 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 
Get-PnPListItem -List $list -Fields "ID" -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Descending | ForEach-Object { $_.DeleteObject() } } 

$list
$site = Get-PnPSite 
$site

Remove-PnPList -Identity $list



# | ForEach-Object { Write-Host $_.Title }

