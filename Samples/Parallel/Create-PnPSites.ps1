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
$connection.Url
$connAdmin.Url
$timeStart = Get-Date
0100..1000 | ForEach-Object -Parallel {
    $conn = $using:connection
    $title = "Test-Parallel-{0:0000}" -f $_
    $alias = "Test-Parallel-{0:0000}" -f $_
    $conn.Url 
    $title 
    $alias
    # $Url = "https://s5dz3.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    # New-PnPSite -Type TeamSite -Connection $conn -Title $title -Alias $alias
    # New-PnPSite -Type TeamSiteWithoutMicrosoft365Group -Title $title -Url $url -Connection $conn 
    New-PnPTeamsTeam -DisplayName $title -Visibility Private -Connection $conn -Owners "AlexW@s5dz3.onmicrosoft.com"
    if ($?) { Write-Host "*" -ForegroundColor Green } else { Write-Host "0" -ForegroundColor Yellow }
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.00}" -f ($timeElapsed.TotalSeconds / 100)


$newSite = New-PnPSite -Type TeamSite -Title "dsfg" -Alias "asdgsdfgsf" -Connection $connection

New-PnPTeamsTeam -DisplayName "myPnPDemo01team" -Visibility Public -Connection $connection 

# 161..170 | ForEach-Object -Parallel {    Write-Host $_ } 

