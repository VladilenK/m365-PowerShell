# WIP
# App authenticaton required with Sites.FullControl.All and Directory.Read.All permissions
# please refer to https://Vladilen.com for minimal permissions

$connAdmin = Connect-PnPOnline -ReturnConnection                    -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc
$connAdmin = Connect-PnPOnline -ReturnConnection -Tenant $tenantId  -Url $adminUrl -ClientId $clientid -Thumbprint $certThumbprint
$connAdmin.Url
Get-PnPTenant  -Connection $connAdmin | Select-Object DisableCustomAppAuthentication
$allTenantSites = Get-PnPTenantSite -Connection $connAdmin
$allTenantSites.count

$sitesReport = @()
$ownersReport = @()
$tenantSite = $allTenantSites[10]; $tenantSite
foreach ($tenantSite in $allTenantSites) {
    $connSite = Connect-PnPOnline -ReturnConnection -Tenant $tenantId  -Url $tenantSite.Url -ClientId $clientid -Thumbprint $certThumbprint
    $site = Get-PnPSite -Connection $connSite -Includes RootWeb, GroupId, Owner
    $site.Url
    $site.RootWeb.Title
    $site.Owner.LoginName
    $site.GroupId
    $site.RootWeb.WebTemplate
    $siteOwnerEmail = ''
    if ($site.GroupId.Guid -eq '00000000-0000-0000-0000-000000000000') {
        $siteAdmins = Get-PnPSiteCollectionAdmin -Connection $connSite 
        foreach ($siteAdmin in $siteAdmins) {
            if ($siteAdmin.PrincipalType -eq 'User') {
                $aadUser = Get-PnPAzureADUser -Connection $connAdmin -Identity $siteAdmin.LoginName.Split('|')[-1]
                if ($aadUser.AccountEnabled) {
                    $siteOwnerEmail += $aadUser.Mail + '; '
                }
                $ownersReport += [PSCustomObject]@{
                    SiteUrl     = $site.Url
                    SiteTitle   = $site.RootWeb.Title
                    IsGroupSite = $true
                    OwnerEmail  = $aadUser.Mail
                    OwnerName   = $aadUser.DisplayName
                    OwnerType   = 'Site Collection Administrator'
                    Enabled     = $aadUser.AccountEnabled
                }
            }
        }
    }
}

$ownersReport.count

# Get-PnPAzureADGroup -Connection $connAdmin -Identity $site.GroupId.Guid
# Get-PnPAzureADGroupMember -Connection $connAdmin -Identity $site.GroupId.Guid
