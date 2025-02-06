# creating sites in bulk using New-PnPTenantSite

Connect-PnPOnline -Url $adminUrl -ClientId $clientid -Interactive 
Get-PnPSite

# regular:
$timeStart = Get-Date
01..10 | ForEach-Object {
    # $timestamp = Get-Date -Format "yyyy-MM-dd--hh-mm"
    $title = "KBA-ACS-Site-{0:00}" -f $_
    $Url = "https://$orgname.sharepoint.com/sites/" + $title
    $owner = $userUPN
    Write-Host "Creating a new site:" $title -NoNewline
    New-PnPTenantSite -Title $title -Url $url -Owner $adminUPN -Template "STS#3" -TimeZone "6" 
    Write-Host ""
    Start-Sleep -Seconds 1
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)
