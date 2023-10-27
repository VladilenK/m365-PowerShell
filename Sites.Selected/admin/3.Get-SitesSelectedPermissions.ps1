# 

# specify Client site Id and obtain Access Token
$clientSiteId
$AccessToken.Substring(0, 3)

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $clientSiteId + '/permissions'
$rawResults = Invoke-RestMethod -Headers @{Authorization = "Bearer $($AccessToken)" } -Uri $apiUrl -Method Get -ResponseHeadersVariable spoRespHeaders

$permissions = @()
foreach ($permission in $rawResults.value) {
  $apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $clientSiteId + '/permissions/' + $permission.id
  $rawPermissions = Invoke-RestMethod -Headers @{Authorization = "Bearer $($AccessToken)" } -Uri $apiUrl -Method Get -ResponseHeadersVariable spoRespHeaders
  $permissions += [PSCustomObject]@{
    Id      = $rawPermissions.id
    Role    = $rawPermissions.roles -join ";"
    AppName = $rawPermissions.grantedToIdentitiesV2.application.displayName -join ";"
    AppId   = $rawPermissions.grantedToIdentitiesV2.application.id -join ";"
  }
}
$permissions | Format-Table -AutoSize Role, AppName, AppId


