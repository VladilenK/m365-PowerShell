# app with delegated permissions "Sites.Read.All"
# account with no permissions to SharePoint

$connsearch = Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Interactive
$token = Get-PnPAccessToken -Connection $connsearch
Get-PnPGraphAccessToken -Decoded
$Headers = @{
    'Authorization' = "bearer $($token)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# search
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$queryString = "*"
$entityTypes = "['driveItem','listItem','list','drive','site']"

$body = @"
{ 
  "requests": [
    {
      "entityTypes": $entityTypes,
      "query": {
        "queryString": "$queryString"
      }
    }
  ]
}
"@

$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'

$res.value[0].hitsContainers[0].hits.count
$res.value[0].hitsContainers[0].moreResultsAvailable
$res.value[0].hitsContainers[0].total

# looping through all results
$siteUrl = "https://s5dz3.sharepoint.com"
# DisConnect-PnPOnline 
$connsearch = Connect-PnPOnline -ClientId $clientid -Tenant $TenantId -Url $siteUrl -Interactive
(Get-PnPConnection).Url
$queryString = "*"
$resultWebUrls = @()
$noMoreResults = $false
$sw = [Diagnostics.Stopwatch]::StartNew()
$from = 0
do {
  # there must be a technique to refresh token 
  $res = Submit-PnPSearchQuery -Connection $connsearch -Query $queryString -StartRow $from -TrimDuplicates:$true -MaxResults 100 -SelectProperties WebUrl 
  Write-Host Got $res.RowCount results, starting from $from, out of $res.TotalRows  ; 
  Write-Host "  Web Url" $res.ResultRows[0].SPWebUrl
  $resultWebUrls += $res.ResultRows.SPWebUrl
  if ($res.TotalRows -gt ($from + 100) ) {
    $from = $from + 100
  } else {
    $noMoreResults = $true
  }
} until ($noMoreResults)  
$sw.Stop()
$sw.Elapsed.TotalMinutes
$resultWebUrls.count
$resultWebUrlsUnique = $resultWebUrls | Sort-Object -Unique
$resultWebUrlsUnique.count

$res.ResultRows[0].SPWebUrl

