# Prerequisites
# app with Sites.Read.All Graph API application permissions 
# Microsoft.Graph PowerShell module
Get-Module Microsoft.Graph.Authentication -ListAvailable | ft name, Version, Path 
Get-Module Microsoft.Graph.Search -ListAvailable | ft name, Version, Path 

# Authentication
$clientID
$certThumbprint
$TenantId 
Connect-MgGraph -ClientId $clientid -TenantId $TenantId -CertificateThumbprint $certThumbprint

Get-MgSite -Top 5

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
		    region = "NAM"
		}
	)
}

$res = Invoke-MgQuerySearch -Body $params
$res.HitsContainers[0].Hits.count
$res.HitsContainers[0].Hits | Select-Object -First 5

$res.HitsContainers[0].Hits[0] | fl
$res.HitsContainers[0].Hits[0].Resource.AdditionalProperties

$res.HitsContainers[0].MoreResultsAvailable
$res.HitsContainers[0].Total





