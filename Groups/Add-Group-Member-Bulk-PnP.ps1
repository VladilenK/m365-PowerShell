
# Get-PnPContext
# Get-PnPConnection

$groups = Get-PnPMicrosoft365Group
$groups.count
$groups[1000]
$groups = $groups | ? { $_.DisplayName -match 'Test-Ownerless-Policy-' }
$groups.count

$timeStart = Get-Date
$groups | ForEach-Object -Parallel {
    Write-Host $_.DisplayName
    $orgname = 'uhgdev'
    # $owner = "user2del6@$orgname.onmicrosoft.com"
    # Add-PnPMicrosoft365GroupOwner  -Identity $_.Id -Users $owner
    $member = "Roger.K.Barrett@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
    $member = "Richard.W.Wright@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
    $member = "Robert.Dylan@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
    $member = "S.Lem@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
    $member = "David.Aaronson@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
    $member = "user33@$orgname.onmicrosoft.com"
    Add-PnPMicrosoft365GroupMember -Identity $_.Id -Users $member
} -ThrottleLimit 50
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10000)



###################
# site