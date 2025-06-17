# authentication with MSAL
# app with delegated permissions
Import-Module MSAL.PS
$token = Get-MsalToken -TenantId $TenantId -ClientId $clientId -Interactive 
$token | Select-Object | fl ExpiresOn, TenantId
$token.Scopes

$headers = @{Authorization = "Bearer $($token.AccessToken)" }
#  Validate the token
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

#  Retrieve a collection of person objects ordered by their relevance to the user
$results = Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me/people' -Headers $Headers
$results.value | Select-Object -Property displayName, jobTitle, userPrincipalName, id

#  Search through a collection of person objects ordered by their relevance to the user
$query = "diego"
$url = 'https://graph.microsoft.com/v1.0/me/people/?$search=' + $query
$results = Invoke-RestMethod -Uri $url -Headers $Headers
$results.value | Select-Object -Property displayName, jobTitle, userPrincipalName, id


#  Retrieve a collection of person objects ordered by their relevance to the specified user
$userId = '45cd5e76-c02c-4e23-a341-8ac485ec6902' # user id
$url = "https://graph.microsoft.com/v1.0/users/$userId/people"
$results = Invoke-RestMethod -Uri $url -Headers $Headers 
$results.value | Select-Object -Property displayName, jobTitle, userPrincipalName, id


# search
$query = "Diego"
$query = ""
$apiUrl = "https://graph.microsoft.com/v1.0/search/query"
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": [
        "person"
      ],
      "query": {
        "queryString": "$query"
      }
    }
  ]
}
"@

$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].total
$res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits[0].resource | fl





#######################################################################################
Connect-PnPOnline -ClientId $clientid -Url $url -Interactive -ReturnConnection
Connect-PnPOnline -AccessToken $token -Url $url -ReturnConnection
$results = Submit-PnPSearchQuery -Query "Bird*"
$results.RowCount
$results.ResultRows[0]
$results.ResultRows[0].OriginalPath
$results.ResultRows.OriginalPath


