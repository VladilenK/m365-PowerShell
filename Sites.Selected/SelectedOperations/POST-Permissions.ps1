# with this script we provide granular access for application to SharePoint - e.g. to list/folder/item

$clientId = ""
$TenantId = "" 
$clientSc = ""

Write-Host "clientId:" $clientId
Write-Host "TenantId:" $TenantId
Write-Host "clientSc:" $clientSc.Substring(0,3)

# Authenticate 
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSc
    grant_type    = "client_credentials" 
}
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
$token = $tokenRequest.Content | ConvertFrom-Json
$token.expires_in
$accessToken = $token.access_token
$headers = @{Authorization = "Bearer $accessToken" }
$headers | ft -a


# Get root site
$apiUrl = "https://graph.microsoft.com/v1.0/sites/uhgdev.sharepoint.com:/teams/Test-Sites-Selected"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data | Format-List




