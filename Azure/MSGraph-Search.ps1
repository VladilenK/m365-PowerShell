# MSAL
$connectionDetails = @{
    'TenantId'    = '046d11d6-08e0-4d20-a743-562836cdcab5'
    'ClientId'    = 'cb3d2f17-f734-4512-b39d-25e0b7472205'
    'Interactive' = $true
}

$token = Get-MsalToken @connectionDetails
$Headers = @{
    'Authorization' = "bearer $($token.AccessToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers


# search
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": [
        "driveItem"
      ],
      "query": {
        "queryString": "Planet"
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




