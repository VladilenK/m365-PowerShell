# specify Client site Id and obtain Access Token
$clientSiteId
$AccessToken.Substring(0, 3)
$sitePath
$clientId
$clientAppName

# specify app role
$roles = @("read") #read, write
$roles = @("write") #read, write

$rolesJson = ConvertTo-Json $roles

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $clientSiteId + '/permissions'
$postBody = @"
{
  'roles': $rolesJson,
  'grantedToIdentities': [{
    'application': {
      'id': '$clientId',
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

$rawPermissions = Invoke-RestMethod -Headers @{Authorization = "Bearer $($AccessToken)" } -Uri $apiUrl -Method Post -Body $postBody -ContentType "application/json" #-ResponseHeadersVariable spoRespHeaders
$permission = [PSCustomObject]@{
  Role    = $rawPermissions.roles -join ";"
  AppName = $rawPermissions.grantedToIdentitiesV2.application.displayName -join ";"
  AppId   = $rawPermissions.grantedToIdentitiesV2.application.id -join ";"
}
$permission
