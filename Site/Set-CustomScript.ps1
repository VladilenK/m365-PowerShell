
##################
# Site
$siteUrl = "https://$orgname.sharepoint.com/sites/tst"

$pnpTenantSite = Get-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Detailed
$pnpTenantSite | Select-Object Url, Template, IsTeamsConnected, GroupId, RelatedGroupId,  Owner | fl

$pnpTenantSite | Select-Object Url, Template, DenyAddAndCustomizePages, SensitivityLabel, Owner | fl

Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -DenyAddAndCustomizePages:$true

$connectionSite = Connect-PnPOnline -ReturnConnection -Url $siteUrl -ClientId $ClientId -Thumbprint $Thumbprint -Tenant $tenantId
$connectionSite.Url

$site = Get-PnPSite -Connection $connectionSite 
$site

$web = Get-PnPWeb  -Connection $connectionSite
$web

########################
# regular user (site FullControl, no tenant admin)
$connectionSite.Url
$site = Get-PnPSite 
$site

$web = Get-PnPWeb 
$web

Get-PnPPropertyBag 
Set-PnPAdaptiveScopeProperty -Key "SiteCustomSubject" -Value "Test8"
Set-PnPPropertyBagValue      -Key "SiteCustomSubject" -Value "Test9" -Indexed:$true 


return
##########################################
# Set Tenant
#  the command “Set-SPOTenant -DelayDenyAddAndCustomizePagesEnforcement $True” will only be accessible till mid-November 2024

$tenant = Get-PnPTenant -Connection $connectionAdmin
$tenant.AllowWebPropertyBagUpdateWhenDenyAddAndCustomizePagesIsEnabled

Get-PnPTenant -Connection $connectionAdmin | Select-Object AllowWebPropertyBagUpdateWhenDenyAddAndCustomizePagesIsEnabled
Set-PnPTenant -Connection $connectionAdmin -AllowWebPropertyBagUpdateWhenDenyAddAndCustomizePagesIsEnabled $true
Set-PnPTenant -Connection $connectionAdmin -AllowWebPropertyBagUpdateWhenDenyAddAndCustomizePagesIsEnabled:$false




