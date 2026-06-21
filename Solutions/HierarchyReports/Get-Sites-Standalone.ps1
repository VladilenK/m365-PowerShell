# WIP - work in progress 
# this script is used to get all standalone (non-group-connected) sites in the tenant owned by someone from the hierarchy
# we are not dealing here with private or shared channel sites, as we can use Teams Graph API to get channel sites owners.
# assume we have the hierarchy of direct reports for a given user ("$allReports" list from Get-Hierarchy.ps1) 
# NB! the script should work well for small tenants but for larger tenants, it might be not efficient to loop through all sites one by one, as it would require a lot of time.

# we have to use SharePoint API to get the standaone site owners, as Microsoft Graph API doesn't provide such functionality

$Path = "./Solutions/HierarchyReports/Config.psd1"
Test-Path -Path $Path 
$config = Import-PowerShellDataFile -Path $Path -Verbose
$adminUrl = "https://$($config.orgname)-admin.sharepoint.com"
$connection = Connect-PnPOnline -Url $adminUrl -ClientId $config.ClientId -Tenant $config.TenantId -Thumbprint $config.Thumbprint -ReturnConnection
$connection.Url

# private or shared channel sites are considerd as sites where GroupId is defined, 
# $sites = Get-PnPTenantSite -Connection $connection -GroupIdDefined:$true
$sites = Get-PnPTenantSite -Connection $connection -GroupIdDefined:$false
# so by setting GroupIdDefined to false, we are getting only standalone sites.
Write-Host "Total standalone sites in the tenant: $($sites.count)"

# out of curiosity, let's see how many of these of which templates
$sites | Group-Object Template | Select-Object Name, Count

# let us iterate through the sites and get their owners, and then check if any of the owners are in our hierarchy list ($allReports)
$sitesInHierarchy = @()
foreach ($site in $sites) {
    $siteUrl = $site.Url
    $connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $config.ClientId -Tenant $config.TenantId -Thumbprint $config.Thumbprint -ReturnConnection
    $owners = Get-PnPSiteCollectionAdmin -Connection $connectionSite 
    foreach ($owner in $owners) {
        if ($allReports.userPrincipalName -contains $owner.LoginName) {
            $sitesInHierarchy += [PSCustomObject]@{
                SiteUrl = $siteUrl
                Owner = $owner.LoginName
                Template = $site.Template
            }
        }
    }
}

