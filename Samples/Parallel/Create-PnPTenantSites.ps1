# creating sites in bulk using New-PnPTenantSite

# regular:
$timeStart = Get-Date
1..10 | ForEach-Object {
    $title = "Test-Parallel-{0:000}" -f $_
    $Url = "https://uhgdev.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    $owner = "vladilen@uhgdev.onmicrosoft.com"
    New-PnPTenantSite -Title $title -Url $url -Owner $owner -Template "STS#3" -TimeZone "6" -Connection $connectionAdmin
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)

# parallel:
$timeStart = Get-Date
1000..1500 | ForEach-Object -Parallel {
    $title = "Test-Parallel-{0:0000}" -f $_
    $Url = "https://uhgdev.sharepoint.com/teams/Test-Parallel-{0:0000}" -f $_
    $owner = "vladilen@uhgdev.onmicrosoft.com"
    $template = "STS#3"
    $template = "SITEPAGEPUBLISHING#0"
    New-PnPTenantSite -Title $title -Url $url -Owner $owner -Template $template -TimeZone "6" -Connection $using:connection
    if ($?) { Write-Host "*" -ForegroundColor Green } else { Write-Host "0" -ForegroundColor Yellow }
} -ThrottleLimit 5
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.00}" -f ($timeElapsed.TotalSeconds / 501)


