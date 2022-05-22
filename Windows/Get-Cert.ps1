Get-ChildItem -Path "Cert:\LocalMachine\My" | ft Thumbprint, Subject, Issuer, NotBefore, NotAfter 
Get-ChildItem -Path "Cert:\CurrentUser\My" | ft NotAfter, Subject, FriendlyName, Issuer  -a 
Get-ChildItem -Path "Cert:\CurrentUser\My" | ft Thumbprint, Subject, FriendlyName   -a 


$certname = "Cert003"
$cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where-Object { $_.FriendlyName -eq $certname } ; $cert.FriendlyName
# $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where-Object { $_.Subject -eq "CN=$certname" }
#$cert = Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object {$_.FriendlyName -eq $certname}
if ($cert) { Write-Host "Certificate found: " -fore green; Write-Host $cert.Subject; $cert.DnsNameList } else { Write-Warning "No certificate found. Exit"; return }
$cert.DnsNameList
$cert.Thumbprint
$cert | fl -Property *
$cert.RawData
