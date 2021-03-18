# https://dev.to/svarukala/use-microsoft-graph-to-set-granular-permissions-to-sharepoint-online-sites-for-azure-ad-application-4l12
# https://gist.github.com/svarukala

#Provide site url
# $sitePath = ""
$siteName = $sitePath.Split("/")[3] + '/' + $sitePath.Split("/")[4]

$ReqTokenBody = @{
  Grant_Type    = "client_credentials"
  Scope         = "https://graph.microsoft.com/.default"
  client_Id     = $clientID
  Client_Secret = $clientSecret
} 
$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $siteName + '?$select=id,displayName'
try {
  $spoResult = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri  $apiUrl -Method Get 
  Write-Host "Site:" $spoResult.displayName
}
catch {
  Write-Output "Failed to enumerate the site"
  Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
  Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
  Exit
}    

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $spoResult.id + '/permissions'

   
try {
  $spoData = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Get -ResponseHeadersVariable spoRespHeaders
  if ($spoData.value.length -eq 0) {
    Write-Host "No site level permissions found"
  }
  else {
    $permissions = $spoData.value | ForEach-Object { $_ | ConvertTo-Json -Depth 10 }
    $permissions 
  }
}
catch {
  Write-Output "Failed to add permissions the site"
  Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
  Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
}

