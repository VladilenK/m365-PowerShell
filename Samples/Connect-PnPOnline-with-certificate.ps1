#################################################################
# connect to PnP with certificate stored in KeyVault

# retrieve certificate from an Azure Key Vault
$VaultName = "AutomationKeyVault222"
$certName = "Cert003" # D57
$secretSecureString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName 
$secretPlainText = ConvertFrom-SecureString -AsPlainText -SecureString $secretSecureString.SecretValue
$secretPlainText.Substring(0, 4)

# connect to PnP with certificate stored in KeyVault
$orgName = "contoso"
$orgName = "uhgdev"
$tenant = "$orgName.onmicrosoft.com"
$adminUrl = "https://$orgName-admin.sharepoint.com"

$clientID = "350b5b29-0d3d-4c0d-9a97-ef2b37e3b5f1" # test01
Connect-PnPOnline -Url $adminUrl -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant  -Verbose 
Get-PnPSite

