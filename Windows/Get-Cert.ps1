Get-ChildItem -Path "Cert:\LocalMachine\My" | ft Thumbprint, Subject, Issuer, NotBefore, NotAfter 
Get-ChildItem -Path "Cert:\CurrentUser\My" | ft NotAfter, Subject, FriendlyName, Issuer  -a 

$certname = "Kar1"
$certname = "Cert003"
$cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where-Object { $_.FriendlyName -eq $certname }
$cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where-Object { $_.Subject -eq "CN=$certname" }
#$cert = Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object {$_.FriendlyName -eq $certname}
if ($cert) { Write-Host "Certificate found: " -fore green; Write-Host $cert.Subject; $cert.DnsNameList } else { Write-Warning "No certificate found. Exit"; return }
$cert.DnsNameList
$cert | fl -Property *


return

$cert = New-SelfSignedCertificate -Subject "CN=DaemonConsoleCert" -CertStoreLocation "Cert:\CurrentUser\My"  -KeyExportPolicy Exportable -KeySpec Signature 
$cert | fl
$cert.FriendlyName

Export-Certificate -Cert $cert -Type CERT -FilePath "C:\Users\Vlad\code\Certificates\sss1"
ls C:\Users\Vlad\code\Certificates

$certCommonName = "*.$env:USERDNSDOMAIN"
$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $certCommonName

