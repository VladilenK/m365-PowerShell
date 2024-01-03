# Prerequisites
Get-Module Microsoft.Graph.Authentication -ListAvailable | ft name, Version, Path 
Get-Module Microsoft.Graph.Search -ListAvailable | ft name, Version, Path 

# Authentication
$clientid = '31359c7f-bd7e-475c-86db-fdb8c937548e'
$clientid = 'd82858e0-ed99-424f-a00f-cef64125e49c'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
Connect-MgGraph -ClientId $clientid -TenantId $TenantId 
# DisConnect-MgGraph 

# Search
$params = @{
	requests = @(
		@{
			entityTypes = @(
				"driveItem", "listItem"
			)
			query = @{
				queryString = "t*"
			}
			fields = @(
				"createdBy"
				"WebUrl"
			)
			from = 0
			size = 50
		}
	)
}

$res = Invoke-MgQuerySearch -Body $params
$res.HitsContainers[0].Hits.Count
$res.HitsContainers[0].MoreResultsAvailable
$res.HitsContainers[0].Total

$res.HitsContainers[0].Hits

$res.HitsContainers[0].Hits[10] | fl
$res.HitsContainers[0].Hits[10].Resource.AdditionalProperties
$res.HitsContainers[0].Hits[10].Resource.AdditionalProperties.createdBy.Values




