# 

$connAdmin

$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Broken-Team-Site"

$pnpTenantSite = Get-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Detailed
$pnpTenantSite | Select-Object Url, Template, IsTeamsConnected, GroupId, RelatedGroupId,  Owner | fl


Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -Owners $adminUPN
Set-PnPTenantSite -Identity $siteUrl -Connection $connectionAdmin -PrimarySiteCollectionAdmin $adminUPN

# Add-PnPMicrosoft365GroupToSite

Add-PnPMicrosoft365GroupToSite -Connection $connectionAdmin -Url $SiteURL -Alias "newM365GroupForBrokenSite" -DisplayName "New Team/Group for a broken site"  -KeepOldHomePage

# Add-PnPMicrosoft365GroupToSite -Url $SiteURL -Alias "newM365GroupForBrokenSite" -DisplayName "New Team/Group for a broken site"  -KeepOldHomePage


