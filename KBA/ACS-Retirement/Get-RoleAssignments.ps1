#  retrieves site user's permissions 


$siteUrl
$connSite  = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ReturnConnection -Thumbprint $certThumbprint -Tenant $tenantId
$connSite.Url

$web = Get-PnPWeb -Connection $connSite
$web


$roleAssignments = Get-PnPProperty -ClientObject $web -Property RoleAssignments -Connection $connSite
$roleAssignments

$permissions = @()
foreach ($ra in $roleAssignments) {
    $member = Get-PnPProperty -ClientObject $ra -Property Member -Connection $connSite
    $role = Get-PnPProperty -ClientObject $ra -Property RoleDefinitionBindings -Connection $connSite
    $permissions += [PSCustomObject]@{
        "MemberId" = $member.Id
        "Member" = $member.LoginName
        "Role" = $role.Name
    }
}
$permissions | Format-Table -AutoSize

Get-PnPWebPermission -Identity $web -PrincipalId 3 -Connection $connSite



