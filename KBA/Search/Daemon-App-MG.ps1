# Prerequisites
# app with Sites.Read.All Graph API application permissions 
# Microsoft.Graph PowerShell module
Get-Module Microsoft.Graph.Authentication -ListAvailable | ft name, Version, Path 

# Authentication
$clientID
$certThumbprint
$TenantId 
Connect-MgGraph -ClientId $clientid -TenantId $TenantId -CertificateThumbprint $certThumbprint

# Get-MgSite -Top 5

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
      region = "NAM"
		}
	)
}

$res = Invoke-MgQuerySearch -Body $params
$res.HitsContainers[0].Hits



