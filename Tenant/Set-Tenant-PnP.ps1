Get-Command -Module PnP.PowerShell *template* 
Get-PnPTenant | select DisableCustomAppAuthentication, CommentsOnSitePagesDisabled | fl

$tenant = Get-PnPTenant 
$tenant.DisableCustomAppAuthentication

#################
Set-PnPTenant -CommentsOnSitePagesDisabled $true
Set-PnPTenant -CommentsOnSitePagesDisabled $false

Get-Command -Module PnP.PowerShell -Name *tenanttempl*

Get-PnPTenantTemplate 
Get-PnPSiteTemplate

