# creating sites in bulk using New-PnPTenantSite

# regular:
$timeStart = Get-Date
1..12 | ForEach-Object {
    $title = "Test-LastModDate-{0:000}" -f $_
    $Url = "https://$orgname.sharepoint.com/sites/Test-Parallel-{0:000}" -f $_
    $owner = "vladilen@$orgname.onmicrosoft.com"
    New-PnPTenantSite -Title $title -Url $url -Owner $adminUPN -Template "STS#3" -TimeZone "6" 
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 12)
