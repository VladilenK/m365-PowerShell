# pnp
$url = "https://orgname.sharepoint.com"
Connect-PnPOnline -ClientId "cb3d2f17-f734-4512-b39d-25e0b7472205" -Url $url -Interactive 
$pnpToken = Get-PnPGraphAccessToken 
$pnpToken

$Headers = @{
    'Authorization' = "bearer $($pnpToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers
