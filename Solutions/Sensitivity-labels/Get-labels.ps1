$groupId = '5661d395-395d-4ec2-83f1-48415fb07341'
$group = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners -Identity $groupId 
$group | fl
$group.AssignedLabels

$aadGroup = Get-PnPAzureADGroup -Identity $groupId 
$aadGroup | fl

$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01-Ch03-Shared"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01-Ch05-Private"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01-Ch01-Private"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01-Ch02-Shared"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-01-Ch03-Shared2"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-02"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-02-Ch02-Shared"
$siteUrl = "https://$orgname.sharepoint.com/teams/Test-sens-labels-02-Ch01-Private"

$site = Get-PnPTenantSite -Identity $siteUrl -Detailed
$site | fl Url, SensitivityLabel

$connSite = Connect-PnPOnline -Url $siteUrl -ClientId $clientid -Thumbprint $certThumbprint -Tenant $tenantId -ReturnConnection
$connSite.Url
$pnpSite = Get-PnPSite -Connection $connSite
$pnpSite | fl SensitivityLabel, SensitivityLabelId, SensitivityLabelInfo
Get-PnPSiteSensitivityLabel -Connection $connSite


######################
#
$allSites = Get-PnPTenantSite 
$allSites | ?{$_.SensitivityLabel -ne $null}



