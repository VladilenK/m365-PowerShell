$siteUrl

$siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint
$siteConnection 


Get-PnPList -Connection $siteConnection 
Get-PnPList -Connection $siteConnection -Identity Documents
$list = Get-PnPList -Connection $siteConnection -Identity Documents
$list



