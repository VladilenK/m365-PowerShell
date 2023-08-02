
# Get-PnPContext
# Get-PnPConnection

$timeStart = Get-Date
101..2500 | ForEach-Object -Parallel {
    $title = "Test-Ownerless-Policy-{0:00000}" -f $_
    $Url = "https://$orgname.sharepoint.com/teams/" + $title
    $owner = "user2del5@$orgname.onmicrosoft.com"
    $members = @()
    $members += 'Roger.K.Barrett@$orgname.onmicrosoft.com'
    $members += 'Richard.W.Wright@$orgname.onmicrosoft.com'
    $members += 'Robert.Dylan@$orgname.onmicrosoft.com'
    $members += 'user33@$orgname.onmicrosoft.com'
    $members += 'S.Lem@$orgname.onmicrosoft.com'
    $members += 'David.Aaronson@$orgname.onmicrosoft.com'
    $mbrs = $members | Get-Random -Count 3
    # $mbrs += "Vlad@$orgname.onmicrosoft.com"
    New-PnPMicrosoft365Group -DisplayName $title -MailNickname $title -Description $title -Owners $owner -Members $mbrs -IsPrivate -CreateTeam:$true -ResourceBehaviorOptions WelcomeEmailDisabled, HideGroupInOutlook 
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 60)



###################
# site