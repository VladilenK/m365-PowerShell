# pnp
$siteUrl
Connect-PnPOnline -ClientId $clientid -Url $siteUrl -Interactive 
$pnpToken = Get-PnPGraphAccessToken 
$pnpToken

$Headers = @{
    'Authorization' = "bearer $($pnpToken)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers
