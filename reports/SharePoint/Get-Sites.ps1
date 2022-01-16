
$conn = Connect-PnPOnline -ClientId $clientid -Url $url -Interactive -ReturnConnection
Get-PnPSite -Connection $conn
Get-PnPTenantSite -Connection $conn -Identity $conn.url

$sites = Get-PnPTenantSite 
$sites.count
$sites[-1]

