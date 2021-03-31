$subj = "localhost"
$friendlyName = "self-signed cert for auth"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName

$filePath = "$Home\code\certificates\cert004.pfx"
$certPwd = ConvertTo-SecureString -String "12345" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath $filePath -Password $certPwd


