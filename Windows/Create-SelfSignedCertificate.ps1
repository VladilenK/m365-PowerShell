$subj = "localhost"
$friendlyName = "cert007"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName

$filePath = "C:\cert007.pfx"
$filePath = "C:\Users\Vlad\OneDrive\archive\Documents\keys\Certificates\cert007.pfx"
# $certPwd = ConvertTo-SecureString -String "12345" -Force -AsPlainText
$certPwd = ConvertTo-SecureString -String "Q1w2e3r4t5" -Force -AsPlainText

Export-PfxCertificate -Cert $cert -FilePath $filePath -Password $certPwd


$filePath = "C:\Users\Vlad\OneDrive\archive\Documents\keys\Certificates\cert007.crt"
Export-Certificate -Cert $cert -FilePath $filePath -Type CERT


