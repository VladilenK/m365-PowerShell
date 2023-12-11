# Prerequisites
Get-Module MSAL.PS -ListAvailable | ft name, Version, Path 
# Install-Module MSAL.PS -Force -Scope CurrentUser -AcceptLicense -SkipPublisherCheck
Import-Module MSAL.PS

# Authentication
$clientid = 'd82858e0-ed99-424f-a00f-cef64125e49c'
$clientid = '31359c7f-bd7e-475c-86db-fdb8c937548e'
$TenantId = '7ddc7314-9f01-45d5-b012-71665bb1c544'

$token = Get-MsalToken -TenantId $TenantId -ClientId $clientid -Interactive 
$headers = @{Authorization = "Bearer $($token.AccessToken)" }
# validate token
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# Search
$entityTypes = "['driveItem','listItem','list','drive','site']"
$entityTypes = "['listItem']"
$entityTypes = "['chatMessage']"

$query = "LastModifiedTimeForRetention<2021-01-01"
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$query = "*"
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
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl

