# not working with delegated app

$conn = Connect-PnPOnline -ClientId $clientid -Url $url -Interactive -ReturnConnection
$conn.Url
Get-PnPSite -Connection $conn

$sites = Get-PnPTenantSite -IncludeOneDriveSites -Filter "Url -like '-my.sharepoint.com/personal/'" -Connection $conn
$sites.count
$sites[0].Url
$sites[0] | fl
$sites.Url

$sites | Select-Object Owner, Template, Url | export-csv -Path "c:\temp\od-sites.csv"

return

foreach ($site in $sites) {
    Set-PnPTenantSite -Owners $owners
    $connOD = Connect-PnPOnline -AccessToken $pnpToken -Url $site.Url -ReturnConnection
    $connOD.url
    Get-PnPSite -Connection $connOD
}


return
Get-PnPTenantSite -Connection $conn -Identity $siteUrl
Set-PnPTenantSite  -Connection $conn -Identity $siteUrl -Owners $owners
$pnpToken = Get-PnPAppAuthAccessToken -Connection $conn 
$pnpToken

$connOD = Connect-PnPOnline -AccessToken $pnpToken -Url $siteUrl -ReturnConnection
$connOD.url
Get-PnPUser -Connection $connOD

$connOD = Connect-PnPOnline -ClientId $clientid -Url $siteUrl -Interactive -ReturnConnection
$connOD.url
Get-PnPUser -Connection $connOD


$msalToken = Get-MsalToken -ClientId $clientid -Interactive -TenantId $tenantId 
$msalToken.AccessToken

$connOD = Connect-PnPOnline -AccessToken $msalToken.AccessToken -Url $siteUrl -ReturnConnection
$connOD.url
Get-PnPUser -Connection $connOD | fl

###############################
$conn = Connect-PnPOnline -Url $url -ReturnConnection -UseWebLogin
$conn.Url
Get-PnPSite -Connection $conn



$pnpToken = Request-PnPAccessToken -ClientId $clientid 
$pnpToken = Get-PnPAppAuthAccessToken -Connection $conn
$conn = Connect-PnPOnline -AccessToken $pnpToken -Url $url -ReturnConnection
$conn.url
Get-PnPSite -Connection $conn

$sites = $sites | Where-Object { $_.Url -like "*vlad_*" }
$sites.count
