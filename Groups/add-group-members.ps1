$tenantId = '887d660e-c53f-4c38-af69-214fe2a73f0a'
$clientid = 'f001f1f9-cd40-421b-82d9-bcc71592aece' # delegated
# Disconnect-MgGraph
Connect-MgGraph -ClientId $clientid -TenantId $tenantId 

$groupId = "b796cf7b-5a98-4683-9c4f-3e07ebe81311" # Test-Ownerless-Policy-00035@uhgdev.onmicrosoft.com
Get-MgGroup -GroupId $groupId 
Get-MgGroupMember -GroupId $groupId 
Get-MgGroupOwner -GroupId $groupId 

New-MgGroupOwner -GroupId $groupId -DirectoryObjectId 'c70c5ff8-64d9-4469-9909-6081d322502c'
