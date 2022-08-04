# pnp secret
$adminUrl
$siteUrl
$clientid
$clientSc
Connect-PnPOnline -ClientId $clientid -Url $siteUrl -ClientSecret $clientSc
Get-PnPSite

Connect-PnPOnline -ClientId $clientid -Url $adminUrl -ClientSecret $clientSc
Get-PnPSite
Get-PnPTenantSite -Identity $siteUrl | ft -a

# PnP Cert
Connect-AzAccount
$VaultName = "AutomationKeyVault222"
$certName = "Cert003" # D57
$secretSecureString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName 
$secretPlainText = ConvertFrom-SecureString -AsPlainText -SecureString $secretSecureString.SecretValue
$secretPlainText.Substring(0, 4)

# connect to PnP with certificate stored in KeyVault
$TenantId 
$adminUrl
$clientID 

Connect-PnPOnline -Url $siteUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenantId  -Verbose 
Get-PnPSite

Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenantId  -Verbose 
Get-PnPSite
Get-PnPTenantSite -Identity $siteUrl | ft -a

$pnpToken = Get-PnPAppAuthAccessToken 
$pnpToken = Get-PnPAccessToken 
$pnpToken = Get-PnPGraphAccessToken 
$pnpToken = Request-PnPAccessToken
$pnpToken
$token = $pnpToken

$Headers = @{
    'Authorization' = "bearer $($token)"
}
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/sites' -Headers $Headers
