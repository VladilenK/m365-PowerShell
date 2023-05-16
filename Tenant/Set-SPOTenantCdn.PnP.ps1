Get-PnPTenantCdnEnabled -CdnType Private
Get-PnPTenantCdnOrigin -CdnType Private
Get-PnPTenantCdnPolicies -CdnType Private

Get-PnPTenantCdnEnabled -CdnType Public
Get-PnPTenantCdnOrigin -CdnType Public
Get-PnPTenantCdnPolicies -CdnType Public

Set-PnPTenantCdnEnabled -CdnType Public -Enable $true
Add-PnPTenantCdnOrigin -CdnType Public -OriginUrl */cdn