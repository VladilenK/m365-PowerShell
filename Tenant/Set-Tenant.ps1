"GlAdmin@uhgdev.onmicrosoft.com" | clip
Connect-SPOService -Url "https://uhgdev-admin.sharepoint.com" 

# CDN
Get-SPOTenantCdnEnabled -CdnType Public
Get-SPOTenantCdnEnabled -CdnType Private
Set-SPOTenantCdnEnabled -CdnType Both -Enable $true
Set-SPOTenantCdnEnabled -CdnType Public -Enable $true
Get-SPOTenantCdnPolicies -CdnType Public
Get-SPOTenantCdnOrigins -CdnType Public
Add-SPOTenantCdnOrigin -CdnType Public -OriginUrl sites/cdn/cdndocs
# 15 minutes to run
Set-SPOTenantCdnEnabled -CdnType Public -Enable $false

# Home Site
Set-SPOHomeSite -HomeSiteUrl "https://uhgdev.sharepoint.com"
Get-SPOHomeSite 
Get-SPOHubSite | ft -a SiteUrl, Title

# DisableCustomAppAuthentication

Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $false
Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $true
Get-SPOTenant | ft DisableCustomAppAuthentication


