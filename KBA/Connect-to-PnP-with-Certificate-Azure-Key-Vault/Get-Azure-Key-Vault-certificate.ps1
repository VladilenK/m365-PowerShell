# ensure you use PowerShell 7
$PSVersionTable

# connect to your Azure subscription
Connect-AzAccount -Subscription "<subscription id>" -Tenant "<tenant id>"
Get-AzSubscription | fl
Get-AzContext

# Specify Key Vault Name and Certificate Name
$VaultName = "<azure key vault name>"
$certName = "certificate name as it stored in key vault"

# Get certificate stored in KeyVault (Yes, get it as SECRET)
$secret = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName
$secretValueText = ($secret.SecretValue | ConvertFrom-SecureString -AsPlainText )

# connect to PnP
$tenant = "contoso.onmicrosoft.com" # or tenant Id
$siteUrl = "https://contoso.sharepoint.com"
$clientID = "<App (client) Id>" # Azure Registered App with the same certificate and API permissions configured
Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenant -CertificateBase64Encoded $secretValueText

Get-PnPSite

