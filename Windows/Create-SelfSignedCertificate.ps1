$subj = "localhost"
$friendlyName = "cert006"
$certStoreLocation = "Cert:\CurrentUser\My"
$cert = New-SelfSignedCertificate -Subject $subj -CertStoreLocation $certStoreLocation -KeyExportPolicy Exportable -KeySpec Signature -FriendlyName $friendlyName -KeyUsage DigitalSignature
$cert | fl
$cert.FriendlyName

$filePath = "C:\cert006.pfx"
$filePath = "C:\Users\Vlad\OneDrive\archive\Documents\keys\Certificates\cert006.pfx"
$certPwd = ConvertTo-SecureString -String "12345" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath $filePath -Password $certPwd


$filePath = "C:\Users\Vlad\OneDrive\archive\Documents\keys\Certificates\cert006.crt"
Export-Certificate -Cert $cert -FilePath $filePath -Type CERT


