# Prerequisites
# app with Sites.Read.All Graph API application permissions 

########################################################
# Authentication
$tenantId = ''
$clientId = ''
$clientSecret = '' #

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
$headers

# Search
$apiUrl = "https://graph.microsoft.com/beta/search/query"

$query = "test*"

$entityTypes = "['driveItem','listItem','list','drive','site']"
$entityTypes = "['listItem']"

$body = @"
  { 
    "requests": [
      {
        "entityTypes": $entityTypes,
        "query": {
          "queryString": "$query"
        },
        "region": "NAM"
      }
    ]
  }
"@


$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits.Count
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits.resource.webUrl
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[0].resource
$res.value[0].hitsContainers[0].hits[0].resource.lastModifiedBy.user


######
$apiUrl = "https://graph.microsoft.com/beta/search/query"

$query = "LastModifiedTimeForRetention<2023-08-01"
$query = "lorem* AND isDocument=true site:https://s5dz3.sharepoint.com/sites/SalesandMarketing"
$query = "test*"

$entityTypes = "['chatMessage']"
$entityTypes = "['driveItem']"
$entityTypes = "['driveItem','listItem','list','drive','site']"

$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": {
        "queryString": "$query"
      },
      "region": "NAM",
      "from" : 100,
      "size" : 50,
      "fields": ["WebUrl","lastModifiedBy","name" ],
    }
  ]
}
"@
$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms


$res.value[0].hitsContainers[0].hits.Count
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl
$res.value[0].hitsContainers[0].hits[0].resource
$res.value[0].hitsContainers[0].hits[0].resource.lastModifiedBy.user
$res.value[0].hitsContainers[0].hits[0].resource.lastModifiedDateTime
$res.value[0].hitsContainers[0].hits.resource.lastModifiedDateTime
$res.value[0].hitsContainers[0].hits.resource.weburl

# to check if there are more results to return for paging
$res.value[0].hitsContainers[0].moreResultsAvailable

# ,"region": "NAM"
# 

