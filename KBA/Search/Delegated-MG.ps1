# Prerequisites
Get-Module Microsoft.Graph.Authentication -ListAvailable | ft name, Version, Path 

# Authentication
$clientid = '31359c7f-bd7e-475c-86db-fdb8c937548e'
$clientid = 'd82858e0-ed99-424f-a00f-cef64125e49c'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
Connect-MgGraph -ClientId $clientid -TenantId $TenantId

# Search
$params = @{
	requests = @(
		@{
			entityTypes = @(
				"driveItem"
			)
			query = @{
				queryString = "lorem"
			}
			from = 0
			size = 25
			fields = @(
				"title"
				"description"
			)
		}
	)
}

$res = Invoke-MgQuerySearch -Body $params
$res.HitsContainers[0].Hits
   