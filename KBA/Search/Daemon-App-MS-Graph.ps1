# Prerequisites
# app with Sites.Read.All Graph API application permissions 

########################################################
# Authentication
$TenantId 
$clientID
$clientSc.Substring(0,3)

# Construct URI and body needed for authentication
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientID
    client_secret = $clientSc
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
$entityTypes = "['driveItem','listItem','list','drive','site']"
$entityTypes = "['driveItem','listItem']"

$query = "LastModifiedTimeForRetention<2021-01-01"
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$query = "test*"
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
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[0].resource
$res.value[0].hitsContainers[0].hits[0].resource.lastModifiedBy.user


######
$entityTypes = "['driveItem','listItem','list','drive','site']"
$entityTypes = "['chatMessage']"
$entityTypes = "['driveItem']"

$query = "LastModifiedTimeForRetention<2023-12-10"
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$query = "test* AND isDocument=true"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": {
        "queryString": "$query"
      },
      "from" : 0,
			"size" : 5,
      "fields": ["WebUrl","lastModifiedBy","name" ],
      "region": "NAM"
    }
  ]
}
"@
$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits.Count
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[0].resource
$res.value[0].hitsContainers[0].hits[0].resource.lastModifiedBy.user
$res.value[0].hitsContainers[0].hits.resource.weburl
