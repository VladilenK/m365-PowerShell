# MSAL
$connectionDetails = @{
    'TenantId'    = '046d11d6-08e0-4d20-a743-562836cdcab5'
    'ClientId'    = 'cb3d2f17-f734-4512-b39d-25e0b7472205'
    'Interactive' = $true
}

$token = Get-MsalToken @connectionDetails
$Headers = @{
    'Authorization' = "bearer $($token.AccessToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers
