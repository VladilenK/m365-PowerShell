# creating sites in bulk using New-PnPTenantSite

# regular:
$timeStart = Get-Date
001..10 | ForEach-Object {
    $timestamp = Get-Date -Format "yyyy-MM-dd--hh-mm"
    $title = "Site-{0:0000}-Created-$timestamp" -f $_
    $Url = "https://$orgname.sharepoint.com/sites/" + $title
    $owner = "vlad@$orgname.onmicrosoft.com"
    Write-Host "Creating a new site:" $title -NoNewline
    New-PnPTenantSite -Title $title -Url $url -Owner $adminUPN -Template "STS#3" -TimeZone "6" 
    Write-Host ""
    Start-Sleep -Seconds 1
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)
