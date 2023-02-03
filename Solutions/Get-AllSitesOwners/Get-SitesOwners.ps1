# App authenticaton required with Sites.FullControl.All and Directory.Read.All permissions
$connAdmin = Connect-PnPOnline -ReturnConnection -Tenant $tenantId  -Url $adminUrl -ClientId $clientid -Thumbprint $certThumbprint
$allTenantSites = Get-PnPTenantSite -Connection $connAdmin | Sort-Object Url
$allTenantSites.count

$sitesReport = @()
$ownersReport = @()
foreach ($tenantSite in $allTenantSites) {
    Write-Host $tenantSite.Url
    $connSite = Connect-PnPOnline -ReturnConnection -Tenant $tenantId  -Url $tenantSite.Url -ClientId $clientid -Thumbprint $certThumbprint
    $site = Get-PnPSite -Connection $connSite -Includes RootWeb, GroupId, Owner
    $siteOwnerEmail = ''
    $siteOwnersReport = @()
    if ($site.GroupId.Guid -eq '00000000-0000-0000-0000-000000000000') {
        $siteAdmins = Get-PnPSiteCollectionAdmin -Connection $connSite | ? { $_.PrincipalType -eq 'User' }
        $ownerType = 'Site Collection Administrator'
        $isGroupSite = $false
    }
    else {
        $siteAdmins = Get-PnPAzureADGroupOwner -Connection $connAdmin -Identity $site.GroupId.Guid
        $ownerType = 'Group Owner'
        $isGroupSite = $true
    }
    foreach ($siteAdmin in $siteAdmins) {
        if (!$siteAdmin.UserPrincipalName) {
            Get-PnPProperty -Connection $connAdmin -ClientObject $siteAdmin -Property UserPrincipalName | Out-Null
        }
        $aadUser = Get-PnPAzureADUser -Connection $connAdmin -Identity $siteAdmin.UserPrincipalName
        if ($aadUser.AccountEnabled) {
            $siteOwnerEmail += $aadUser.Mail + '; '
        }
        $siteOwnersReport += [PSCustomObject]@{
            SiteUrl     = $site.Url
            SiteTitle   = $site.RootWeb.Title
            IsGroupSite = $isGroupSite
            OwnerEmail  = $aadUser.Mail
            OwnerName   = $aadUser.DisplayName
            OwnerType   = $ownerType
            Enabled     = $aadUser.AccountEnabled
        }
    }
    $ownersReport += $siteOwnersReport
    $sitesReport += [PSCustomObject]@{
        SiteUrl     = $site.Url
        SiteTitle   = $site.RootWeb.Title
        IsGroupSite = $isGroupSite
        OwnerEmail  = $siteOwnerEmail
    }
}

$ownersReport.count
$sitesReport.count
