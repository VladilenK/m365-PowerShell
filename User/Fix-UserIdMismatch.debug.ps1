# 
# Script to fix UserId mismatch issue

$upn = "John.Smith@$orgname.onmicrosoft.com"

$adUser = Get-PnPAzureADUser -Connection $connectionAdmin -Identity $upn
$adUser | fl
$adUser.Id
# 1 Id                   : 16f8980d-4b6c-4c0b-b6a2-1791d7f365dc
# 2 Id                   : fd2c5286-6702-4a08-b92f-c3f815d7bb81

$UserProp = Get-PnPUserProfileProperty -Connection $connectionAdmin -Account $upn
$UserProp | fl
$UserProp["msOnline-ObjectId"]
$UserProp["SID"]
# Key   : UserProfile_GUID
# 1 Value : caa04825-956a-4351-b3f8-e7a1660547b8
# 2 Value : f60dc247-5d33-4b66-ad75-ce326457296e
# Key   : msOnline-ObjectId
# 1 Value : 16f8980d-4b6c-4c0b-b6a2-1791d7f365dc
# 2 Value : fd2c5286-6702-4a08-b92f-c3f815d7bb81
# Key   : AccountName
# 1 Value : i:0#.f|membership|john.smith@s5dz3.onmicrosoft.com
# 2 Value : i:0#.f|membership|john.smith@s5dz3.onmicrosoft.com
# Key   : SID
# 1 Value : i:0h.f|membership|100320050f642216@live.com
# 2 Value : i:0h.f|membership|100320050f7c5c71@live.com


$siteUrl = "https://$orgname.sharepoint.com/teams/UserIDMismatchTest03"
$siteUrl = "https://$orgname.sharepoint.com/teams/UserIDMismatchTest01"
$siteUrl = "https://$orgname.sharepoint.com/sites/UserIDMismatchTest02"

$connectionToSite = Connect-PnPOnline -ReturnConnection -Url $siteUrl -ClientId $ClientId -Thumbprint $Thumbprint -Tenant $tenantId
$connectionToSite.Url

Get-PnPGroup -Connection $connectionToSite 
Get-PnPUser -Connection $connectionToSite 
$siteUser = Get-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") -Includes AadObjectId
$siteUser | fl
# 1 Id                             : 9
# 2 Id                             : 9
# 3 Id                             : 13
# 1 LoginName                      : i:0#.f|membership|john.smith@s5dz3.onmicrosoft.com
# 2 LoginName                      : i:0#.f|membership|john.smith@s5dz3.onmicrosoft.com
# 3 LoginName                      : i:0#.f|membership|john.smith@s5dz3.onmicrosoft.com
$siteUser.AadObjectId | fl
# 1 NameId       : 16f8980d-4b6c-4c0b-b6a2-1791d7f365dc
# 2 NameId       : 16f8980d-4b6c-4c0b-b6a2-1791d7f365dc
# 3 NameId       : fd2c5286-6702-4a08-b92f-c3f815d7bb81
# 1 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}
# 2 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}
# 3 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}

$siteUser.UserId | fl
# 1 NameId       : 100320050f642216
# 2 NameId       : 100320050f642216
# 3 NameId       : 100320050f7c5c71
# 1 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}
# 2 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}
# 3 TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}
#   TypeId       : {c5c3ae1a-63b6-4f25-a887-54b0b20a28e2}


# Fix the issue by removing the user and re-adding
Remove-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") -Force
Get-PnPUser -Connection $connectionToSite 

$web = Get-PnPWeb -Connection $connectionToSite
$web.EnsureUser("i:0#.f|membership|$upn") 

$siteUser = Get-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") 
$siteUser 

$membersgroup = Get-PnPGroup -Connection $connectionToSite -AssociatedMemberGroup
$membersgroup
Get-PnPGroupMember -Connection $connectionToSite -Identity $membersgroup

Add-PnPGroupMember -Connection $connectionToSite -Identity $membersgroup -Users ("i:0#.f|membership|$upn")

$tenantSite = Get-PnPTenantSite -Connection $connectionAdmin -Url $siteUrl
$tenantSite.GroupId
$m365Group = Get-PnPMicrosoft365Group -Connection $connectionToSite -Identity $tenantSite.GroupId.Guid
$m365Group

Get-PnPMicrosoft365GroupMember -Connection $connectionToSite -Identity $m365Group 
Remove-PnPMicrosoft365GroupMember -Connection $connectionToSite -Identity $m365Group -Users $upn
Add-PnPMicrosoft365GroupMember -Connection $connectionToSite -Identity $m365Group -Users $upn

#############################################
# look at the Access requests list
Get-PnPList -Connection $connectionToSite 
$accessRequestList = Get-PnPList -Connection $connectionToSite -Identity "Access Requests"
$accessRequestList

$accessRequests = Get-PnPListItem -Connection $connectionToSite -List $accessRequestList 
$accessRequests.count

$accessRequests[-1] | fl
$accessRequests[-1].FieldValues | fl
$accessRequests[-1].FieldValues["Author"] | fl
$accessRequests[0].FieldValues["ReqByUser"] | fl
$accessRequests[-1].FieldValues["ReqByUser"] | fl
$accessRequests[-1].FieldValues["ReqByUser"] | fl
$accessRequests[0].FieldValues["PermissionLevelRequested"] | fl

$requests = $accessRequests | Sort-Object Id -Descending | Select-Object FieldValues 
$monthAgo = (Get-Date).AddMonths(-2)
foreach ($request in $requests) {
    if ($request.FieldValues["RequestDate"] -gt $monthAgo) {
        if ($request.FieldValues["ReqForUser"].Email -eq $userEmail) {
            break
        }
    }

}

$request.FieldValues

