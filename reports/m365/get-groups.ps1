Get-Command -verb get -Noun *group
$id = '8a81ee08-08d8-4204-991f-68e85e317b10'

# Az
Connect-AzAccount
$groups = Get-AzADGroup 
$groups.count
$groups[-1] | fl
$groups[1].Member.Count

Get-AzADGroup -ObjectId $id -Select groupTypes -AppendSelected
Get-AzADGroup -ObjectId $id -Select Member -AppendSelected 
$group = Get-AzADGroup -ObjectId $id -Select Member -AppendSelected 
$group.Member

# AzureAD
Connect-AzureAD
$groups = Get-AzureADGroup 
$groups.count
$groups[-1] | fl
$groups[-2]

# MSOL
Connect-MsolService
$groups = Get-MsolGroup
$groups.count
$groups[-1] | fl
$groups[-2]

#MG
Connect-MgGraph -ClientId $clientId 
Get-MgGroup