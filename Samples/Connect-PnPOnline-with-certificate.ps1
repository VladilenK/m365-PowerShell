#################################################################
# connect to PnP with certificate stored in KeyVault
$orgName = "contoso"
$tenant = "$orgName.onmicrosoft.com"
$adminUrl = "https://$orgName-admin.sharepoint.com"
$clientID = ""
$VaultName = ""
$certName = ""

$secretSecureString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName 
$secretPlainText = ConvertFrom-SecureString -AsPlainText -SecureString $secretSecureString.SecretValue

Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant  -Verbose 
