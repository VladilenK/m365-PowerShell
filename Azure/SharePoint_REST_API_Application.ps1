not working
########################################################################
# SharePoint REST
$SiteURL 
$clientID
$clientSc

$connectionSite = Connect-PnPOnline -ReturnConnection -Url $SiteURL -ClientId $clientID -ClientSecret $clientSc
$connectionSite

$RestMethodURL = $SiteURL + '/_api/web/lists?$select=Title'
$Lists = Invoke-PnPSPRestMethod -Url $RestMethodURL -Connection $connectionSite
$Lists.value

Get-Command -Module PnP.PowerShell "*token*"
$pnpToken = Get-PnPAppAuthAccessToken -Connection $connectionSite
$pnpToken = Get-PnPAccessToken -Connection $connectionSite
$pnpToken = Get-PnPGraphAccessToken -Connection $connectionSite
$pnptoken = Request-PnPAccessToken -ClientId $clientID
$pnpToken
$Headers = @{'Authorization' = "bearer $($pnpToken)" }
Invoke-RestMethod -Uri $RestMethodURL -Headers $Headers

Import-Module MSAL.PS
$msaltoken = Get-MsalToken -ClientId $clientID -ClientSecret $(ConvertTo-SecureString $clientSc -AsPlainText -Force) -TenantId $tenantId 
$msaltoken.AccessToken
$Headers = @{'Authorization' = "bearer $($msaltoken.AccessToken)" }
Invoke-RestMethod -Uri $RestMethodURL -Headers $Headers

