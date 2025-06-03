$subj = "localhost"
$friendlyName = "cert008 - self-signed cert for auth"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName
$cert.NotAfter

$filePath = "$Home\code\certificates\"
$filePath = "$Home\Documents\keys\Certificates\"
$filePath = "$Home\OneDrive\archive\Documents\keys\Certificates\"
$filePathCer = $filePath + "cert008.cer"
$filePathPfx = $filePath + "cert008.pfx"
Export-Certificate -Cert $cert -FilePath $filePathCer -Type CERT
$certPwd = ConvertTo-SecureString -String "*******************" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath $filePathPfx -Password $certPwd

# Manually (with GUI): 
# upload certificate to Azure Key Vault 
# create an app, add certificate
# add API permissions

