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

# HUBs
Get-SPOHubSite | ft -a SiteUrl, Title



# Org News Sites
Get-SPOOrgNewsSite
Set-SPOOrgNewsSite -OrgNewsSiteUrl "https://$orgname.sharepoint.com/sites/contoso-marketing" 

# organization assets library
Get-SPOOrgAssetsLibrary
Add-SPOOrgAssetsLibrary -LibraryUrl <URL> [-ThumbnailUrl <URL>] [-OrgAssetType <ImageDocumentLibrary or OfficeTemplateLibrary>] [-CdnType <Public or Private>]

# DisableCustomAppAuthentication

Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $false
Get-SPOTenant | ft DisableCustomAppAuthentication
Set-SPOTenant -DisableCustomAppAuthentication $true
Get-SPOTenant | ft DisableCustomAppAuthentication

#
Get-SPOBuiltInSiteTemplateSettings
Set-SPOBuiltInSiteTemplateSettings -Identity 'b8ef3134-92a2-4c9d-bca6-c2f14e79fe98' -IsHidden $true # Learning central
Set-SPOBuiltInSiteTemplateSettings -Identity '73495f08-0140-499b-8927-dd26a546f26a' -IsHidden $true # Department	

Set-SPOBuiltInSiteTemplateSettings -Identity 'b8ef3134-92a2-4c9d-bca6-c2f14e79fe98' -IsHidden $true # Learning central
Set-SPOBuiltInSiteTemplateSettings -Identity '73495f08-0140-499b-8927-dd26a546f26a' -IsHidden $true # Department	
Set-SPOBuiltInSiteTemplateSettings -Identity '00000000-0000-0000-0000-000000000000' -IsHidden $false # All



Get-Command *OrgNews*
Get-Command *ttemp*

