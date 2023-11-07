
# get OwnerlessGroup events from Audit log
$auditLog = Import-Csv -Path "$Home\Downloads\ownerlessgroupnotified.csv"
$auditLog.count
$auditLog_OwnerlessGroupNotified = $auditLog | ? { $_.Operation -eq "OwnerlessGroupNotified" }
$auditLog_OwnerlessGroupNotified.count

$auditLog = Import-Csv -Path "$Home\Downloads\ownerlessgroupnotificationresponse.csv"
$auditLog.count
$auditLog_OwnerlessGroupNotificationResponse = $auditLog | ? { $_.Operation -eq "OwnerlessGroupNotificationResponse" }
$auditLog_OwnerlessGroupNotificationResponse.count

$auditLog = Import-Csv -Path "$Home\Downloads\ownerlessgroupneedattention.csv"
$auditLog.count
$auditLog_OwnerlessGroupNeedAttention = $auditLog | ? { $_.Operation -eq "OwnerlessGroupNeedAttention" } | Sort-Object CreationDate
$auditLog_OwnerlessGroupNeedAttention.count

# Groups that are still ownerless
$OwnerlessGroupNeedAttention = @()
foreach ($event in $auditLog_OwnerlessGroupNeedAttention) {
    $OwnerlessGroupNeedAttentionEvent = $event.AuditData | ConvertFrom-Json   
    $OwnerlessGroupNeedAttention += $OwnerlessGroupNeedAttentionEvent | Select-Object -Property GroupId, GroupName
}
$OwnerlessGroupNeedAttention | Select-Object -last 1
$OwnerlessGroupNeedAttention.Count

# Notified members
$NotifiedMembers = @()
foreach ($event in $auditLog_OwnerlessGroupNotified) {
    $NotifiedMembersEvent = $event.AuditData | ConvertFrom-Json   
    foreach ($member in $NotifiedMembersEvent.Members) {
        $NotifiedMembers += [PSCustomObject]@{
            GroupId = $NotifiedMembersEvent.GroupId
            UserId  = $member.UserId
            EmailAddress = $member.EmailAddress
        }
    }
    # $NotifiedMembers += $OwnerlessGroupNeedAttentionEvent | Select-Object -Property GroupId, GroupName
}
$NotifiedMembers | Select-Object -last 1
$NotifiedMembers.Count

# members who declined invitation
$membersDeclined = @()
foreach ($event in $auditLog_OwnerlessGroupNotificationResponse) {
    $responseEventData = $event.AuditData | ConvertFrom-Json   
    $responceType = $responseEventData.ExtendedProperties | ?{$_.Name -eq "ResponseType"} | Select-Object -Property Value -ExpandProperty Value
    $memberId = $responseEventData.Members | Select-Object -First 1 -Property UserId -ExpandProperty UserId 
    if ($responceType -eq "DeclineOwnership" ) {
        $membersDeclined += [PSCustomObject]@{
            GroupId = $responseEventData.GroupId
            UserId = $memberId
        }
    }
}
$membersDeclined | Select-Object -last 1
$membersDeclined.Count


# members to elevate
$membersToElevate = @()
foreach ($group in $OwnerlessGroupNeedAttention) {
    $groupNotifiedMembers = $NotifiedMembers | ?{$_.GroupId -eq $group.GroupId} | Select-Object -Property UserId -Unique
    $groupMembersDeclined = $membersDeclined | ?{$_.GroupId -eq $group.GroupId} | Select-Object -Property UserId -Unique
    foreach ($member in $groupNotifiedMembers) {
        if ($member.UserId -notin $groupMembersDeclined.UserId ) {
            $membersToElevate += [PSCustomObject]@{
                GroupId = $group.GroupId
                UserId = $member.UserId
            }
        }
    }
}
$membersToElevate.count
$membersToElevate




$usersNotified = @()
foreach ($event in $auditData) {
    foreach ($user in $event.Members) {
        $user | Add-Member -MemberType NoteProperty -Name "DateTime" -Value $event.CreationTime -Force 
        $user | Add-Member -MemberType NoteProperty -Name "GroupName" -Value $event.GroupName -Force 
        $usersNotified += $user
    }
}
$usersNotified | ? { $_.EmailAddress -eq 'AdeleV@s5dz3.onmicrosoft.com' } | Select-Object DateTime, EmailAddress, GroupName | Sort-Object DateTime
$usersNotified | ? { $_.GroupName -eq 'Test-Ownerless-Policy-05' } | Select-Object DateTime, EmailAddress, GroupName | Sort-Object DateTime

############################################################################################



