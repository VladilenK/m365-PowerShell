# this script is used to get all the group-based sites in the tenant owned by someone from the hierarchy
# assume we have the hierarchy of direct reports for a given user ("$allReports" list from Get-Hierarchy.ps1) 
#  

$headers = Get-AuthHeaders -config $config
$headers["Authorization"].Substring(0, 20) + "..." # show the first 20 characters of the token for verification

$sitesInHierarchy = @()
foreach ($user in $allReports) {
    $upn = $user.userPrincipalName
    # first, we'd get all groups owned by a person, then filter for those that are Microsoft 365 groups, and then get the sites associated with those groups
    $apiUrl = "https://graph.microsoft.com/v1.0/users/$upn/ownedObjects" 
    $data = Invoke-RestMethod -Headers $headers -Uri $apiUrl -Method Get
    $userGroups = $data.value | Where-Object { $_.groupTypes -contains "Unified" }
    foreach ($group in $userGroups) {
        $groupId = $group.id
        $apiUrl = "https://graph.microsoft.com/v1.0/groups/$groupId/sites/root"
        $site = Invoke-RestMethod -Headers $headers -Uri $apiUrl -Method Get
        if ($site) {
            $sitesInHierarchy += [PSCustomObject]@{
                User = $upn
                Group = $group.displayName
                GroupId = $group.id
                SiteUrl = $site.webUrl
                SiteType = "Group-Connected"
            }
        }
    }
}
$sitesInHierarchy | ft -AutoSize User, SiteUrl, SiteType


