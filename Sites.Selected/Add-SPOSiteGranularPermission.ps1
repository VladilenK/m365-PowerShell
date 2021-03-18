# https://gist.github.com/svarukala/0fe3ebcf483d645bb501e7e987087b0b

clear
# Provide tenant prefix, Application (client) ID, and Client secret of the admin app
# $tenantPrefix = "contoso";
# $clientId = "client-id";
# $clientSecret = "client-secret";
# $tenantName = $tenantPrefix + ".onmicrosoft.com";
# $tenantDomain = $tenantPrefix + ".sharepoint.com";

#Provide the site url
# $sitePath = ""
# $clientAppId = ""
# $clientAppName = ""

$roles = @("read") #read, write
#$roles = @("write") #read, write

$rolesJson = ConvertTo-Json $roles
$siteName = $sitePath.Split("/")[3] + '/' + $sitePath.Split("/")[4]

$resource = "https://graph.microsoft.com/"
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
  Write-Host "Site: " $spoResult.displayName
}
catch {
  Write-Output "Failed to enumerate the site"
  Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
  #Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
  Exit
}    

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $spoResult.id + '/permissions'
$postBody = @"
{
  'roles': $rolesJson,
  'grantedToIdentities': [{
    'application': {
      'id': '$clientAppId',
      'displayName': '$clientAppName'
    }
  }]
}
"@

#Here is an example
<#
$postBody = @'
{
  'roles': ['write'],
  'grantedToIdentities': [{
    'application': {
      'id': '3842218f-b211-4444-90f9-ef790e46cf75',
      'displayName': 'Client App'
    }
  }]
}
'@
#>

try {
  $spoData = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Post -Body $postBody -ContentType "application/json" #-ResponseHeadersVariable spoRespHeaders
  "Successfully added the granular permissions"
  $spoData | ConvertTo-Json -Depth 10
}
catch {
  Write-Output "Failed to add permissions the site"
  Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
  #Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
}

