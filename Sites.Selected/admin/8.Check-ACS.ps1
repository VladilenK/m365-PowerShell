# $connAdmin = Connect-PnPOnline -Url $adminUrl -ClientId $clientid -ClientSecret $clientsc -ReturnConnection 
# $connAdmin.Url

$siteUrl
$connSite  = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -ReturnConnection -Thumbprint $thumbPrint -Tenant $tenantId
$connSite.Url

# $clientIdDlg = "7bac27b8-d042-4ed9-b030-d286734366a2"
# $connSite  = Connect-PnPOnline -Url $siteUrl -ClientId $clientIdDlg  -ReturnConnection -TenantAdminUrl $adminUrl -Interactive

Get-PnPAzureACSPrincipal -Connection $connSite -Scope All 

