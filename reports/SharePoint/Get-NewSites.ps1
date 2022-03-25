# This script retrieves new SharePoint Sites
# Option 1 is based on Microsoft Graph Search API and filtering by "created" property
# Option 2 is based on Microsoft Graph Sites API and sites search and sorting by "created" property
# requirements 
# - PowerShell 7 ( tested with 7.2.1)
# - MSAL.PS module ( tested with 4.37.0.0)
# - an App registered with delegated permissions (min) Sites.Read.All
# - SharePoint service admin role elevated

$PSVersionTable
Get-InstalledModule -Name MSAL.PS

# get token
$token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -Interactive
# $token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -ForceRefresh -Silent
Write-Host "Token will expire on:" $token.ExpiresOn.LocalDateTime

# verify we have a good token/header
$headers = @{
  'Authorization' = "bearer $($token.AccessToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# Option 1 (Microsoft Graph Search API)
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
$newSites.Count
$newSites
# end of Option 1 (Microsoft Graph Search API)

# Option 2 (Microsoft Graph Sites API)

$apiUrl = "https://graph.microsoft.com/v1.0/sites"
$apiUrl = "https://graph.microsoft.com/v1.0/sites?search=*&orderby=createdDateTime desc"
$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get -ContentType 'application/json'
$res.value.Count
$newSites = $res.value | Select-Object createdDateTime, weburl
$newSites
# End of Option 2 (Microsoft Graph Sites API)

