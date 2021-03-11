$url

$siteConnection = Connect-PnPOnline -Url $url -ClientId $ClientId -ClientSecret $ClientSecret -ReturnConnection 
$siteConnection.scopes
$siteConnection.Url
Get-PnPSite -Connection $siteConnection
Get-PnPList -Identity "Shared Documents"
Get-PnPList -Identity "Documents"
Get-PnPListItem -List "Shared Documents" 
Get-PnPListItem -List "Documents" 

$secretSecureString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $certName 
$secretPlainText = ConvertFrom-SecureString -AsPlainText -SecureString $secretSecureString.SecretValue
$siteConnection = Connect-PnPOnline -Url $Url -ClientId $clientID -CertificateBase64Encoded $secretPlainText -Tenant $tenant  -Verbose -ReturnConnection
$siteConnection
$siteConnection.scopes

Get-PnPSite -Connection $siteConnection
