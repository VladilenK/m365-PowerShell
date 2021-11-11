Get-MgProfile
#Select-MgProfile -Name "beta"

Connect-MgGraph -Scopes "User.Read.All", "Sites.Read.All"  # device
Connect-MgGraph -ClientId "" -TenantId "" -CertificateThumbprint ""

Get-MgProfile
Get-MgSite | select -First 1 | fl
Get-MgSite -All -Sort CreatedDateTime | select WebUrl, CreatedDateTime
# Get-MgSite -Filter "displayName eq 'Jan'"
# Get-MgSite -Filter "WebUrl eq 'https://contoso.sharepoint.com/teams/janat'"
# Get-MgSite -Filter "Name eq Jan"


Get-MgSite -siteId root | Select-Object id, DisplayName
Get-MgSite -search "Birds" | Select-Object DisplayName, Description, WebUrl

Get-MgSitePage -SiteId $Sites[0].Id
Get-MgSiteList -SiteId $Sites[0].Id | Select-Object id, DisplayName
Get-MgSiteDrive -SiteId $Sites[0].Id
