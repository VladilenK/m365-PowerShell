$subj = "localhost"
$friendlyName = "cert2026"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName

$filePath = "$home\Documents\cert2026.pfx"
# $certPwd = ConvertTo-SecureString -String "12345" -Force -AsPlainText
$certPwd = ConvertTo-SecureString -String "*****" -Force -AsPlainText

Export-PfxCertificate -Cert $cert -FilePath $filePath -Password $certPwd

$filePath = "$home\Documents\cert2026.crt"
Export-Certificate -Cert $cert -FilePath $filePath -Type CERT


