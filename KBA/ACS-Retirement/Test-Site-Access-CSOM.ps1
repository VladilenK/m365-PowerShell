$siteUrl
$appId
$appSecret

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $appId -ClientSecret $appSecret -ReturnConnection
$connectionSite.Url

$siteUrl
$appId
$tenantId
$certThumbprint

$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $appId -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection
$connectionSite.Url


# CSOM
$ctx = Get-PnPContext -Connection $connectionSite
$web = $ctx.Web
$ctx.Load($web)
$ctx.ExecuteQuery()
$web | fl Url, Title, Id, Exists, IsPropertyAvailable


# REST
$restLists = Invoke-PnPSPRestMethod -Connection $connectionSite -Url "/_api/web/lists?$select=Id,Title"
$restLists.value | ft -a Id, Title


