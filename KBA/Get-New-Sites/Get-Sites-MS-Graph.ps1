# This script retrieves new SharePoint Sites
# Option 1 is based on Microsoft Graph Search API and filtering by "created" property
# Option 2 is based on Microsoft Graph Sites API and sites search and sorting 
# requirements 
# - PowerShell 7 ( tested with 7.2.1 - 7.4.0)
# - an App registered with application permissions (min) Sites.Read.All

########################################################
# Authentication
$tenantId = ''
$clientId = ''
$clientSecret = '' 

# Construct URI and body needed for authentication
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientID
    client_secret = $clientSecret
    scope         = "https://graph.microsoft.com/.default"
    grant_type    = "client_credentials" 
}

# Get OAuth 2.0 Token
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
$tokenRequest.Headers.Date

# Unpack Access Token
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token
$headers = @{Authorization = "Bearer $token" }

# Option 1
# Microsoft Graph Search API and filtering by "created" property
# form a query
$apiUrl = "https://graph.microsoft.com/v1.0/search/query"
$query = "created>=2023-12-09"
$entityTypes = '["site"]'

$from = 0
$size = 20
$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": { "queryString": "$query" },
      "region": "NAM",
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
$newSites | Sort-Object createdDateTime
# end of Option 1 (Microsoft Graph Search API)

# Option 2 
# Microsoft Graph Sites API and sites search and sorting 
$apiUrl = "https://graph.microsoft.com/v1.0/sites?search=*&orderby=createdDateTime desc"
$apiUrl = "https://graph.microsoft.com/v1.0/sites/getAllSites"
$apiUrl = "https://graph.microsoft.com/v1.0/sites"
$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get -ContentType 'application/json'
$res.value.Count
$newSites = $res.value | Select-Object createdDateTime, weburl | Sort-Object createdDateTime
$newSites
# End of Option 2 (Microsoft Graph Sites API)

