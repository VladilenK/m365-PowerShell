# PowerShell 7
$PSVersionTable

$upn = "Vlad@uhgdev.onmicrosoft.com"

# SharePoint REST
$SiteURL = "https://uhgdev.sharepoint.com/sites/spo-app-test-01"
$clientID # with Delegated permissions
$connectionSite = Connect-PnPOnline -Url $SiteURL -Interactive -ReturnConnection -ClientId $clientID
$RestMethodURL = $SiteURL + '/_api/web/lists?$select=Title'
$Lists = Invoke-PnPSPRestMethod -Url $RestMethodURL -Connection $connectionSite
$Lists.value

# Invoke-RestMethod
Get-Command -Module PnP.PowerShell "*token*"
$pnpToken = Get-PnPAppAuthAccessToken -Connection $connectionSite
$pnpToken
$Headers = @{'Authorization' = "bearer $($pnpToken)" }
Invoke-RestMethod -Uri $RestMethodURL -Headers $Headers

########################################################
