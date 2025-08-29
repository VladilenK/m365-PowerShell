# Disconnect-MgGraph
Connect-MgGraph -ClientId $clientid -TenantId $tenantId 

$groupId = '82c3d9cd-08c3-4931-8b09-16305f38d664'  # 1
$groupId = 'b9bc6bd8-f0ea-4842-860f-331a71c415bd'  # 2
$upn = "john.smith@$orgname.onmicrosoft.com"
Get-MgGroup -GroupId $groupId 
Get-MgGroupMember -GroupId $groupId 
Get-MgGroupOwner -GroupId $groupId 

New-MgGroupMember -GroupId $groupId -DirectoryObjectId '644bc310-0834-4b7f-aa4b-70c7c2231566'
New-MgGroupMember -GroupId $groupId -DirectoryObjectId 'fd2c5286-6702-4a08-b92f-c3f815d7bb81'
# notifications are sent

