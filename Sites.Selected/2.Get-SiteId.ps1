# this script gets client site Id
# we need an MS Graph token

$siteUrl # e.g. "https://contoso.sharepoint.com/teams/Test-Sites-Selected"
$tenantDomain # e.g. "contoso.sharepoint.com";

$sitePath = $siteUrl.Split("/")[3] + '/' + $siteUrl.Split("/")[4]
$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $sitePath + '?$select=id,displayName'
$siteResult = Invoke-RestMethod -Headers @{Authorization = "Bearer $($AccessToken)" } -Uri  $apiUrl -Method Get 
Write-Host "Site display Name: " $siteResult.displayName
$clientSiteId = $siteResult.id
Write-Host "Site Id: " $clientSiteId

# or you can just specify Client Site Id:
# $clientSiteId = ""
$clientSiteId
