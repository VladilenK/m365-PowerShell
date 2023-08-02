# This script is just a sample to demonstrate basic technique on deletion m365 groups with PowerShell and MS Graph
# please do not run this script as is, but update it upon your needs

# Assume that you prepared a list of groups to remove
# based on your own criterias (e.g. inactive ownerless groups)
# import CSV
$groupsToDeleteFilePath = ""
$groupsToDelete = Import-Csv -Path $groupsToDeleteFilePath

# authentication with App
#  app must have as minimum "Group.ReadWrite.All" Microsoft Graph API application permission
Connect-MgGraph -ClientId $clientid -TenantId $tenantId -CertificateThumbprint $CertificateThumbprint

# authentication with personal Id
#  app must have as minimum "Group.ReadWrite.All" Microsoft Graph API delegated permission
#  user must have SharePoint admin (or Teams admin) roles activated
Connect-MgGraph -ClientId $clientid -TenantId $tenantId 
Get-MgUserFollowedSite -UserId $userUPN

# sample data
$groupsToDelete = @()
$groupsToDelete += [PSCustomObject]@{GroupId = '443d22ae-683a-4fe4-8875-7bd78227a026' }
$groupsToDelete += [PSCustomObject]@{GroupId = 'e5805388-c18c-48c0-b42d-6223cf8f3d82' }

# Get Groups
foreach ($group in $groupsToDelete) {
    Get-MgGroup -GroupId $group.GroupId
}


# Delete group
# add Owner to the group
$groupId = '443d22ae-683a-4fe4-8875-7bd78227a026'
Remove-MgGroup -GroupId $groupId


