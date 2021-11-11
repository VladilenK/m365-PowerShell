Connect-SPOService -Url "" 

Get-SPOTenant

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
Set-SPOHomeSite -HomeSiteUrl ""
Get-SPOHomeSite 
Get-SPOHubSite | ft -a SiteUrl, Title

# Org News Sites
Get-SPOOrgNewsSite
Set-SPOOrgNewsSite -OrgNewsSiteUrl <site URL>

# organization assets library
Get-SPOOrgAssetsLibrary
Add-SPOOrgAssetsLibrary -LibraryUrl <URL> [-ThumbnailUrl <URL>] [-OrgAssetType <ImageDocumentLibrary or OfficeTemplateLibrary>] [-CdnType <Public or Private>]

# DisableCustomAppAuthentication

Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $false
Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $true
Get-SPOTenant | ft DisableCustomAppAuthentication


