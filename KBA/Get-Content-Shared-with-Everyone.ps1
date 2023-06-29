# app with delegated permissions "Sites.Read.All"
$tenantId = '046d11d6-08e0-4d20-a743-562836cdcab5'
$clientid = 'cb3d2f17-f734-4512-b39d-25e0b7472205'
$connectionDetails = @{
    'TenantId'    = $tenantId
    'ClientId'    = $clientid
    'Interactive' = $true
}

$token = Get-MsalToken @connectionDetails
$Headers = @{
    'Authorization' = "bearer $($token.AccessToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# search

$apiUrl = "https://graph.microsoft.com/beta/search/query"
$queryString = "*"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": [
        "drive",
        "driveItem",
        "list",
        "listItem",
        "site"
      ],
      "query": {
        "queryString": $queryString
      }
    }
  ]
}
"@

$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits | ft -a summary, resource
$res.value[0].hitsContainers[0].hits[0] | fl
$res.value[0].hitsContainers[0].hits[1] | fl

#######################################################################################
# PnP.PowerShell
Connect-PnPOnline -ClientId $clientid -Url $url -Interactive -ReturnConnection
Connect-PnPOnline -AccessToken $token -Url $url -ReturnConnection
$results = Submit-PnPSearchQuery -Query "Bird*"
$results.RowCount
$results.ResultRows[0]
$results.ResultRows[0].OriginalPath
$results.ResultRows.OriginalPath


Get-PnPListItem -List $ListName -Fields “ID” -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Property Id -Descending | ForEach-Object{ $_.DeleteObject() } }
Get-PnPListItem -List $list -Fields "ID"     -PageSize 100 -ScriptBlock { Param($items) $items | Sort-Object -Property Id -Descending | ForEach-Object{ $_.DeleteObject() } } 



