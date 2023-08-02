# This script is just a sample to demonstrate basic technique on deletion m365 groups with PowerShell and MS Graph
# please do not run this script as is, but update it upon your needs

# Assume that you prepared a list of groups to remove
# based on your own criterias (e.g. inactive ownerless groups)
# import CSV
$groupsFilePath = ""
$groups = Import-Csv -Path $groupsFilePath

# authentication with App
#  app must have as minimum "Group.ReadWrite.All" Microsoft Graph API application permission
Connect-MgGraph -ClientId $clientid -TenantId $tenantId -CertificateThumbprint $CertificateThumbprint

# authentication with personal Id
#  app must have as minimum "Group.ReadWrite.All" Microsoft Graph API delegated permission
#  user must have SharePoint admin (or Teams admin) roles activated
Connect-MgGraph -ClientId $clientid -TenantId $tenantId 
Get-MgContext | Select-Object Scopes -ExpandProperty Scopes

# sample data
$groups = @()
$groups += [PSCustomObject]@{GroupId = '443d22ae-683a-4fe4-8875-7bd78227a026' }
$groups += [PSCustomObject]@{GroupId = 'e5805388-c18c-48c0-b42d-6223cf8f3d82' }

# Get Groups
foreach ($group in $groups) {
    Get-MgGroup -GroupId $group.GroupId
}

# add members to the group
$groupId = '443d22ae-683a-4fe4-8875-7bd78227a026'
$userId = 'df74e0d3-d78c-495b-b47a-549437d93cf7' # Adele
New-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId

# add Owner to the group
$groupId = '443d22ae-683a-4fe4-8875-7bd78227a026'
$groupId = 'e5805388-c18c-48c0-b42d-6223cf8f3d82'
$groupId = '732da004-ff2b-4c39-88e6-8919cb159398'
$userId = 'eacd52fb-5ae0-45ec-9d17-5ded9a0b9756' # Megan
$userId = 'df74e0d3-d78c-495b-b47a-549437d93cf7' # Adele
New-MgGroupOwner -GroupId $groupId -DirectoryObjectId $userId






