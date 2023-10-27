# this script gets Microsoft Graph token 
# we need an App with Sites.FullControl.All MS Graph API permissions 

# these variables must be specified:
$tenantName     # e.g. contoso.onmicrosoft.com
$clientId       # App (client) Id of the admin (FullControl) App
$clientSc       # App (client) secret of the admin (FullControl) App

$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $clientId
    Client_Secret = $clientSc
} 
$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
$AccessToken = $TokenResponse.access_token
if ($TokenResponse.expires_in -gt 0) {
    # Write-Host "Got token. Token expires at  " $(Get-date).AddMinutes($TokenResponse.expires_in)
    Write-Host "Got token. Token expires in " $TokenResponse.expires_in
}



