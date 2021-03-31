# Get certificate stored in KeyVault
$VaultName = ""
$certName = "cert001"

$secretSecureString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName 
$secretPlainText = ConvertFrom-SecureString -AsPlainText -SecureString $secretSecureString.SecretValue

# connect to PnP
$orgName = "contoso"
$tenant = "$orgName.onmicrosoft.com"
$adminUrl = "https://$orgName-admin.sharepoint.com"
$clientID = "5a3a432d-c1c1-480a-b2b1-4fcb2b1ed989"

Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant 
Get-PnPTenant
