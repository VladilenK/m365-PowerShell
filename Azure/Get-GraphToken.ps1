$clientID
$clientSc
$TenantId 

# Construct URI and body needed for authentication
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $clientID
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSc
    grant_type    = "client_credentials" 
}

# Get OAuth 2.0 Token
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
$tokenRequest

# Unpack Access Token
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token
$headers = @{Authorization = "Bearer $token" }
$headers


