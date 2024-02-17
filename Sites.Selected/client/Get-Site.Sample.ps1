# this script demonstrates working with Microsoft Graph API as a daemon app
# You'd need to specify below Application (client) ID, secret, tenant name and site: 
$tenantPrefix = "CONTOSO"
$clientId = "CLIENT ID"
$clientSecret = "CLIENT SECRET"
$siteUrl = "SITE URL" # e.g. "https://contoso.sharepoint.com/teams/Test-Sites-Selected"


# Authenticate to Microsoft:
$tenantName = $tenantPrefix +".onmicrosoft.com";
$tenantDomain = $tenantPrefix +".sharepoint.com";
$sitePath = $siteUrl.Split("/")[3] + '/' + $siteUrl.Split("/")[4]
$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $clientId
    Client_Secret = $clientSecret
} 
$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
$AccessToken = $TokenResponse.access_token

# Get SharePoint site with MS Graph API: 
$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $sitePath + '?$select=id,displayName'
$spoResult = Invoke-RestMethod -Headers @{Authorization = "Bearer $AccessToken" } -Uri  $apiUrl -Method Get 
Write-Host "Site: " $spoResult.displayName


