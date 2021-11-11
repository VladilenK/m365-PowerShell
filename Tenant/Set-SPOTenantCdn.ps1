# https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online

# Set up and configure the Office 365 CDN

# Enable your organization to use the Office 365 CDN
Get-SPOTenantCdnEnabled -CdnType Public
Get-SPOTenantCdnEnabled -CdnType Private

Set-SPOTenantCdnEnabled -CdnType Both -Enable $false -Confirm:$false
Set-SPOTenantCdnEnabled -CdnType Private -Enable $true -NoDefaultOrigins 

# Change the list of file types to include in the Office 365 CDN (Optional)
Get-SPOTenantCdnPolicies -CdnType Private # default GIF,ICO,JPEG,JPG,JS,PNG,GLB
Set-SPOTenantCdnPolicy -CdnType Private -PolicyType IncludeFileExtensions -PolicyValue "CSS,PNG,GIF,ICO,JPEG,JPG,JS"
Set-SPOTenantCdnPolicy -CdnType Private -PolicyType ExcludeRestrictedSiteClassifications  -PolicyValue "Confidential"

# Add an origin for your assets
Get-SPOTenantCdnOrigins -CdnType Private 
Remove-SPOTenantCdnOrigin -CdnType Private -OriginUrl "*/SITEASSETS"
Remove-SPOTenantCdnOrigin -CdnType Private -OriginUrl "*/USERPHOTO.ASPX"

Add-SPOTenantCdnOrigin -CdnType Private -OriginUrl "sites/test/siteassets/folder 1"
Add-SPOTenantCdnOrigin -CdnType Private -OriginUrl siteassets



# In private origins, assets being shared from an origin must have a major version published before they can be accessed from the CDN.
# Once you've run the command, the system synchronizes the configuration across the datacenter. This can take up to 15 minutes.


<#
PS C:\scripts\PowerShell> Get-SPOTenantCdnOrigins -CdnType Private
SITEASSETS (configuration pending)
PS C:\scripts\PowerShell> Get-SPOTenantCdnOrigins -CdnType Private
SITEASSETS (configuration pending)
PS C:\scripts\PowerShell> Get-SPOTenantCdnOrigins -CdnType Private
SITEASSETS
PS C:\scripts\PowerShell> 
#>

