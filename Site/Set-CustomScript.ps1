$siteUrl = "https://$orgname.sharepoint.com/sites/tst"

$pnpTenantSite = Get-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Detailed
$pnpTenantSite | Select-Object Url, Template, IsTeamsConnected, GroupId, RelatedGroupId,  Owner | fl

$pnpTenantSite | Select-Object Url, Template, DenyAddAndCustomizePages, SensitivityLabel, Owner | fl
$pnpTenantSite


Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -DenyAddAndCustomizePages:$true

$tenant = Get-PnPTenant -Connection $connectionAdmin
$tenant.AllowWebPropertyBagUpdateWhenDenyAddAndCustomizePagesIsEnabled

#  the command “Set-SPOTenant -DelayDenyAddAndCustomizePagesEnforcement $True” will only be accessible till mid-November 2024

$connectionSite = Connect-PnPOnline -ReturnConnection -Url $siteUrl -ClientId $ClientId -Thumbprint $Thumbprint -Tenant $tenantId
$connectionSite.Url

$site = Get-PnPSite -Connection $connectionSite 
$site

$web = Get-PnPWeb  -Connection $connectionSite
$web


