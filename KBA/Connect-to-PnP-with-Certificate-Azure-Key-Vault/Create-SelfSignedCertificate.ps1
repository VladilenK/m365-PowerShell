$subj = "localhost"
$friendlyName = "self-signed cert for auth"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName

$filePathCer = "$Home\code\certificates\cert004.cer"
Export-Certificate -Cert $cert -FilePath $filePathCer -Type CERT
$filePathPfx = "$Home\code\certificates\cert004.pfx"
$certPwd = ConvertTo-SecureString -String "12345" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath $filePathPfx -Password $certPwd

# ensure you have access to your subscription with Az module:
Connect-AzAccount -Subscription "" -Tenant "..."
Get-AzSubscription | fl
Get-AzContext

# Manually (with GUI): 
# upload certificate to Azure Key Vault 
# create an app, add certificate
# add API permissions

