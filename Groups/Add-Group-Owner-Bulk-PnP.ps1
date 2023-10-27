
# Get-PnPContext
# Get-PnPConnection

$allGroups = Get-PnPMicrosoft365Group
$allGroups.count
$groups = $allGroups | ? { $_.DisplayName -match 'Test-Ownerless-Policy-' } | Sort-Object DisplayName 
$groups = $groups | Select-Object -First 5000 -Skip 5000
# $groups = $groups | Sort-Object Id
$groups.count
$groups = $groups | Select-Object -First 3000 -Skip 2000
$groups[0]
$groups[-1]
$groups.count

$timeStart = Get-Date
$groups | ForEach-Object -Parallel {
    # Write-Host $_.DisplayName
    $owner = "user2del26@uhgdev.onmicrosoft.com"
    Add-PnPMicrosoft365GroupOwner  -Identity $_.Id -Users $owner
} -ThrottleLimit 50
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.000}" -f ($timeElapsed.TotalSeconds / ($groups.Count/1000))



###################
# site