
# Get-PnPContext
# Get-PnPConnection

$timeStart = Get-Date
101..2500 | ForEach-Object -Parallel {
    $title = "Test-Ownerless-Policy-{0:00000}" -f $_
    $Url = "https://uhgdev.sharepoint.com/teams/" + $title
    $owner = "user2del5@uhgdev.onmicrosoft.com"
    $members = @()
    $members += 'Roger.K.Barrett@uhgdev.onmicrosoft.com'
    $members += 'Richard.W.Wright@uhgdev.onmicrosoft.com'
    $members += 'Robert.Dylan@uhgdev.onmicrosoft.com'
    $members += 'user33@uhgdev.onmicrosoft.com'
    $members += 'S.Lem@uhgdev.onmicrosoft.com'
    $members += 'David.Aaronson@uhgdev.onmicrosoft.com'
    $mbrs = $members | Get-Random -Count 3
    # $mbrs += "Vlad@uhgdev.onmicrosoft.com"
    New-PnPMicrosoft365Group -DisplayName $title -MailNickname $title -Description $title -Owners $owner -Members $mbrs -IsPrivate -CreateTeam:$true -ResourceBehaviorOptions WelcomeEmailDisabled, HideGroupInOutlook 
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 60)



###################
# site