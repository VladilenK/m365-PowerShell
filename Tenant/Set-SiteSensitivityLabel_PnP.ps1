Get-Module -Name PnP.PowerShell -ListAvailable
$PSVersionTable
# must be ? PowerShell 7

$upn = "vlad@$orgname.onmicrosoft.com"; $upn | clip
$upn = "Vladilen@$orgname.onmicrosoft.com"; $upn | clip
$Id1 = [GUID]("0f4b1e4f-9646-4748-b397-283325ce9f49") # Test Label 01
$Id2 = [GUID]("737dde27-1b61-4232-b976-7ff1148da60c") # Internal-Only Site Group
$Id3 = [GUID]("27b5d387-be3c-4c5d-b59c-f204385c2ff3") # External Access Enabled Site or Group

# Get-PnPAvailableSensitivityLabel [-Identity <Guid>] [-User <AzureADUserPipeBind>] [-Connection <PnPConnection>] [<CommonParameters>]
# Get-PnPAvailableSensitivityLabel -Connection $connection

#####################
$siteUrl = "https://$orgname.sharepoint.com/teams/test-21"
$siteUrl = "https://$orgname.sharepoint.com/sites/test-Ext-05-Standalone-Site"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Ext-02-Internal-Only-Policy"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-Ext-01-None"
# $connectionSite = Connect-PnPOnline -Url $siteUrl -Interactive -ClientId $clientid -ReturnConnection
# $connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -ClientSecret $clientSc -ReturnConnection
$connectionSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection
$connectionSite.url
$site = Get-PnPSite -Connection $connectionSite -includes Url, SensitivityLabel, SensitivityLabelId, SensitivityLabelInfo, CommentsOnSitePagesDisabled
$site | select Url, SensitivityLabelId, CommentsOnSitePagesDisabled | fl

Set-PnPSite -Connection $connectionSite -CommentsOnSitePagesDisabled:$true 
Set-PnPSite -Connection $connectionSite -CommentsOnSitePagesDisabled:$false

$site.SensitivityLabel.Guid
$site.SensitivityLabelId
$site.SensitivityLabelInfo

Get-PnPSiteSensitivityLabel -Connection $connectionSite
$lbl0 = Get-PnPSiteSensitivityLabel -Connection $connectionSite
Set-PnPSiteSensitivityLabel -Connection $connectionSite -Identity $Id2
Set-PnPSiteSensitivityLabel -Connection $connectionSite -Identity $Id3
Get-PnPSiteSensitivityLabel -Connection $connectionSite
Set-PnPSiteSensitivityLabel -Connection $connectionSite -Identity $lbl0.Id
Get-PnPSiteSensitivityLabel -Connection $connectionSite



