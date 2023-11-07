$auditLog = Import-Csv -Path "C:\Users\Vlad\Downloads\Ownerless-Groups.csv"
$auditLog = Import-Csv -Path "$Home\Downloads\ownerlessgroupnotified.csv"
$auditLog.count

$auditLog_OwnerlessGroupNotified = $auditLog | ? { $_.Operation -eq "OwnerlessGroupNotified" }
$auditLog_OwnerlessGroupNotified.count

$auditData = @()
foreach ($event in $auditLog_OwnerlessGroupNotified) {
    $auditData += $event.AuditData | ConvertFrom-Json   
}
$auditData | Select-Object -last 1

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

############################################################

$auditLog_OwnerlessGroupNeedAttention = $auditLog | Where-Object { $_.Operation -eq "OwnerlessGroupNeedAttention" }
$auditLog_OwnerlessGroupNeedAttention.count

$auditData = @()
foreach ($event in $auditLog_OwnerlessGroupNeedAttention) {
    $auditData += $event.AuditData | ConvertFrom-Json   
}
$auditData | Select-Object -last 1

$groups = @()
foreach ($event in $auditData) {
    $groups += [PSCustomObject]@{
        GroupName             = $event.GroupName
        FirstNotificationDate = $event.ExtendedProperties[0].Value
        LastNotificationDate  = $event.ExtendedProperties[1].Value
        Members               = $event.Members.EmailAddress.replace("@s5dz3.onmicrosoft.com", "") -join ';'
        MembersCount          = $event.Members.Count
    }
}
$groups.Count
$groups | Select-Object GroupName, FirstNotificationDate, LastNotificationDate, MembersCount, Members

