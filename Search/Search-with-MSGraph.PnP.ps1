$conn = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -Tenant $TenantId -Interactive
$token = Get-PnPGraphAccessToken -Connection $conn


$Headers = @{
    'Authorization' = "bearer $($token)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# search
$query = "*"
$query = "*.pptx LastModifiedTimeForRetention<2023-09-01 site:https://s5dz3.sharepoint.com/sites/Mark8ProjectTeam"
$query = "LastModifiedTimeForRetention<2023-09-01"

$apiUrl = "https://graph.microsoft.com/beta/search/query"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": [
        "driveItem"
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
# $res.value[0].hitsContainers[0].hits
$res.value[0].hitsContainers[0].hits.resource.WebUrl
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl


#######################################################################################
Connect-PnPOnline -ClientId $clientid -Url $url -Interactive -ReturnConnection
Connect-PnPOnline -AccessToken $token -Url $url -ReturnConnection
$results = Submit-PnPSearchQuery -Query "Bird*"
$results.RowCount
$results.ResultRows[0]
$results.ResultRows[0].OriginalPath
$results.ResultRows.OriginalPath


