# creating sites in bulk using New-PnPSite

# regular:
$timeStart = Get-Date
151..160 | ForEach-Object {
    $title = "Test-Parallel-{0:000}" -f $_
    $alias = "Test-Parallel-{0:000}" -f $_
    New-PnPSite -Type TeamSite -Title $title -Alias $alias -Connection $connectionAdminInteractive 
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)

# parallel:
$connectionAdminInteractive.Url
$timeStart = Get-Date
401..500 | ForEach-Object -Parallel {
    $conn = $using:connectionAdminInteractive
    $title = "Test-Parallel-{0:000}" -f $_
    $alias = "Test-Parallel-{0:000}" -f $_
    $Url = "https://$orgname.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    # New-PnPSite -Type TeamSite -Title $title -Alias $alias -Connection $conn
    New-PnPSite -Type TeamSiteWithoutMicrosoft365Group -Title $title -Url $url -Connection $conn
    if ($?) { Write-Host "*" -ForegroundColor Green } else { Write-Host "0" -ForegroundColor Yellow }
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.00}" -f ($timeElapsed.TotalSeconds / 100)


# New-PnPSite -Type TeamSite -Title "dsfg" -Alias "asdgsdfgsf" -Connection $connectionAdminInteractive

# 161..170 | ForEach-Object -Parallel {    Write-Host $_ } 

