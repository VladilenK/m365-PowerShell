# app with delegated permissions "Sites.Read.All"
# account with no permissions to SharePoint
# 
# $urls - list of sites Url to check (see get-sites.ps1)

$urls.count
$url = $urls[-1]; $url

$resultWebUrls = @()
$sw = [Diagnostics.Stopwatch]::StartNew()
foreach ($url in $urls) {
  # refresh token
  Write-Host "Web Url: " $url
  $queryString = "* site:" + $url
  $res = Submit-PnPSearchQuery -Connection $connsearch -Query $queryString -MaxResults 10 -SelectProperties WebUrl 
  Write-Host "  Got " $res.RowCount results, out of $res.TotalRows  ; 
  $resultWebUrls += $res.ResultRows.SPWebUrl
}
$sw.Stop()
$sw.Elapsed.TotalMinutes

$resultWebUrls.count
$resultWebUrlsUnique = $resultWebUrls | Sort-Object -Unique
$resultWebUrlsUnique.count


# $token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -Interactive
# $token = Get-MsalToken -ClientId $clientid -TenantId $tenantId -ForceRefresh -Silent

