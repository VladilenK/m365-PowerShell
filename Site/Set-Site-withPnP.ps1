Get-Command *scop* -Module PnP.PowerShell

$connAdmin

$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Ext-02-Internal-Only-Policy"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Ext-01-None"
$siteUrl = "https://$orgname.sharepoint.com/sites/ContosoHub"
$siteUrl = "https://$orgname.sharepoint.com/sites/test-Ext-05-Standalone-Site"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Parallel-000"
$siteUrl = "https://$orgname.sharepoint.com/sites/Birding_in_KZ"
$siteUrl = "https://$orgname.sharepoint.com/sites/TestCommSite_01"
$siteUrl = "https://$orgname.sharepoint.com/sites/TestCommSite_01/SubSite_01"
$siteUrl = "https://$orgname.sharepoint.com/sites/Test-Sites-Selected"
$siteUrl = "https://$orgname.sharepoint.com/teams/TestTeam_03"
$siteUrl = "https://$orgname.sharepoint.com/sites/KBA-ACS-Site-01"
$siteUrl = "https://$orgname.sharepoint.com/sites/tst"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Broken-Team-Site"

$pnpTenantSite = Get-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Detailed
$pnpTenantSite | Select-Object Url, Template, IsTeamsConnected, GroupId, RelatedGroupId,  Owner | fl

$pnpTenantSite | Select-Object Url, Template, DenyAddAndCustomizePages, SensitivityLabel, Owner | fl




Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin -DenyAddAndCustomizePages:$false
Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin -DenyAddAndCustomizePages:$true
Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin -Owners $adminUPN

# sensitivity label
$pnpTenantSite | Select-Object Url, Template, DenyAddAndCustomizePages, SensitivityLabel | fl
$Id1 = [GUID]("0f4b1e4f-9646-4748-b397-283325ce9f49") # Test Label 01
$Id2 = [GUID]("737dde27-1b61-4232-b976-7ff1148da60c") # Internal-Only Site Group
$Id3 = [GUID]("27b5d387-be3c-4c5d-b59c-f204385c2ff3") # External Access Enabled Site or Group

Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin  -RemoveLabel 
Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin -SensitivityLabel $id2

$siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint
$siteConnection 
$pnpSite = Get-PnPSite -Connection $siteConnection -Includes Url, IsHubSite, HubSiteId, SearchBoxInNavBar, SearchBoxPlaceholderText
$pnpSite | Select-Object Url, IsHubSite, HubSiteId, SearchBoxInNavBar, SearchBoxPlaceholderText

$pnpWeb = Get-PnPWeb  -Connection $siteConnection -Includes Url, Title, WebTemplate, SearchBoxInNavBar, SearchBoxPlaceholderText, SearchScope 
$pnpWeb | fl  Url, Title, WebTemplate, SearchBoxInNavBar, SearchBoxPlaceholderText, SearchScope 




# 1=tenant, 2=Hub, 3=site, 0=default
$pnpWeb.SearchScope = 2
$pnpWeb.SearchBoxPlaceholderText = "Search Hub"
$pnpWeb.Update()
Invoke-PnPQuery -Connection $siteConnection


# features
Get-PnPFeature -Identity 41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092 -Connection $siteConnection
Enable-PnPFeature -Identity 41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092   -Connection $siteConnection


# rename site
Get-PnPTenantSite -Identity $siteUrl -Connection $connAdmin | ft -a Title 
Set-PnPTenantSite -Identity $siteUrl -Connection $connAdmin -Title "TestTeam_03 [renamed]"

##########################
# sharing options
$pnpTenantSite.SharingCapability
Set-PnPTenantSite -Identity $pnpTenantSite -SharingCapability

# App catalog
Add-PnPSiteCollectionAppCatalog -Site $siteUrl -Connection $connAdmin




