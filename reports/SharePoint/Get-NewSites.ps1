# this script gets new SharePoint Sites
# the script is based on Microsoft Graph Search API

# get token
$token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -Interactive
# $token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -ForceRefresh -Silent
Write-Host "Token will expire on:" $token.ExpiresOn.LocalDateTime

# verify we have a good token
$headers = @{
  'Authorization' = "bearer $($token.AccessToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# form a query
$apiUrl = "https://graph.microsoft.com/v1.0/search/query"
$query = "created>=1/1/2021"
$entityTypes = '["site"]'

$from = 0
$size = 500
$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": { "queryString": "$query" },
      "from": $from,
      "size": $size
    }
  ]
}
"@

# invoke query
$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$newSites = $res.value[0].hitsContainers[0].hits.resource | Select-Object createdDateTime, weburl

return

$newSites.count
$newSites.webUrl

$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits.resource
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl
