DisConnect-ExchangeOnline 
Connect-ExchangeOnline 
$operations = 'OwnerlessGroupNeedAttention'
$operations = 'OwnerlessGroupNotificationResponse'
$operations = 'OwnerlessGroupNotified'
$start = (Get-Date).AddDays(-30)
$end = (Get-Date).AddDays(1)
$resultSize = 1000
$freeText = 'Test-Ownerless-Policy-04832'
$objectId = '1b8eac95-0bdd-4936-a4f1-e05891bb82e9'
$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -Formatted -Operations $operations -FreeText $freeText 
$results.Count

$auditData = @()
foreach ($event in $results) {
    $auditData += $event.AuditData | ConvertFrom-Json   
}
$auditData | Select-Object -last 1


$auditData | Select-Object CreationTime, GroupName, @{Name="Members"; Expression={$_.Members.count}} 

# user Responce
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

# User notified
$usersNotified = @()
foreach ($event in $auditData) {
    foreach ($user in $event.Members) {
        $user | Add-Member -MemberType NoteProperty -Name "DateTime" -Value $event.CreationTime -Force 
        $user | Add-Member -MemberType NoteProperty -Name "GroupName" -Value $event.GroupName -Force 
        $usersNotified += $user
    }
}
$usersNotified.Count
$usersNotified | ? { $_.EmailAddress -eq 'AdeleV@s5dz3.onmicrosoft.com' } | Select-Object DateTime, EmailAddress, GroupName | Sort-Object DateTime
$usersNotified | ? { $_.GroupName -eq 'Test-Ownerless-Policy-05' } | Select-Object DateTime, EmailAddress, GroupName | Sort-Object DateTime



