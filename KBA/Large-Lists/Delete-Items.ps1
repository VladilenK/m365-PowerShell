# below are sample scripts to add, update and remove list items

$siteUrl = "https://$orgname.sharepoint.com/sites/Test001"
# Connect-PnPOnline -Url $siteUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant 
$connSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -ClientSecret $clientSc
Get-PnPSite | ft -a

$list = Get-PnPList -Identity "LargeList1"
$list | ft -a
$list.ItemCount


###############################################################################
#Remove List Items

$query = `
    "<View>
    <ViewFields>
        <FieldRef Name='Title'/>
        <FieldRef Name='Modified'/>
    </ViewFields>
    <Query>
        <Where><Eq>
            <FieldRef Name='Modified'/>
            <Value Type='DateTime'><Today/></Value>
        </Eq></Where>
    </Query>
</View>"
$someItems = Get-PnPListItem -List $list -Query $query -PageSize 50

$allItems = Get-PnPListItem -List $list -PageSize 50 
$allItems.count

$allItems | Sort-Object Modified | Select-Object -first 1 | % { $_.Id, $_['Title'], $_['Number'], $_['Modified'] } 
$allItems | Sort-Object Modified | Select-Object -last 1 | % { $_.Id, $_['Title'], $_['Number'], $_['Modified'] } 
$thresholdDate = Get-date -Date "2023-07-10 4:39:00 PM"
$itemsToDelete = $allItems | ? { $_["Modified"] -gt $thresholdDate }



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

