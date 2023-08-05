Connect-ExchangeOnline 
$operations = 'OwnerlessGroupNotificationResponse'
$start = (Get-Date).AddDays(-30)
$end = Get-Date
$resultSize = 100
$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -Formatted -Operations $operations 
$results.Count

$auditData = @()
foreach ($event in $results) {
    $auditData += $event.AuditData | ConvertFrom-Json   
}
$auditData | Select-Object -last 1

$userResponse = @()
foreach ($event in $auditData) {
    $userResponse += [PSCustomObject]@{
        GroupName = $event.GroupName
        Action    = $event.ExtendedProperties[1].Value
        Member    = $event.Members.EmailAddress
    }
}
$userResponse.count
$userResponse




