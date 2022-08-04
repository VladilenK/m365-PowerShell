# MSAL
# Secret:
$msalToken = Get-MsalToken -ClientId $clientid -ClientSecret $(ConvertTo-SecureString $clientSc -AsPlainText -Force) -TenantId $TenantId
$msalToken.ExpiresOn.LocalDateTime

# Certificate
$certThumbprint
$ClientCertificate = Get-Item "Cert:\CurrentUser\My\$($certThumbprint)"
$msalToken = Get-MsalToken -ClientId $clientID -TenantId $tenantID -ClientCertificate $ClientCertificate
$msalToken.ExpiresOn.LocalDateTime

$token = $msalToken.AccessToken
$Headers = @{
    'Authorization' = "Bearer $($token)"
}

# test it
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/sites' -Headers $Headers
