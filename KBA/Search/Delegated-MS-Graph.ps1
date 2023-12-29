# Prerequisites
Get-Module MSAL.PS -ListAvailable | ft name, Version, Path 
# Install-Module MSAL.PS -Force -Scope CurrentUser -AcceptLicense -SkipPublisherCheck
Import-Module MSAL.PS

# Interactive Authentication
$clientid = '89f88689-57ac-49b0-822a-e1d7ac4596a8'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'
$token = Get-MsalToken -TenantId $TenantId -ClientId $clientid -Interactive

$token.IdToken.Substring(0,5)
$headers = @{Authorization = "Bearer $($token.AccessToken)" }

# validate token
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# Search
$apiUrl = "https://graph.microsoft.com/beta/search/query"

$query = "test-2023*"
$query = "test123"

$entityTypes = "['driveItem']"
$entityTypes = "['driveItem','listItem','list','drive','site']"
$entityTypes = "['chatMessage']"

$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": {
        "queryString": "$query"
      }
    }
  ]
}
"@

$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].hitsContainers[0].hits.Count
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl

