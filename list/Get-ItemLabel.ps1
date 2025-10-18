

$siteUrl = "https://$orgname.sharepoint.com/sites/KBA-ACS-Site-01"
$siteUrl

$siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $clientID -Tenant $tenantId -Thumbprint $certThumbprint -ReturnConnection
$siteConnection.Url

Get-PnPList -Connection $siteConnection 
Get-PnPList -Connection $siteConnection -Identity Documents
$list = Get-PnPList -Connection $siteConnection -Identity Documents
$list

Get-PnPListItem -List Documents -Connection $siteConnection

$item = Get-PnPListItem -List Documents -Id 1 -Connection $siteConnection -Includes ParentList
$item = Get-PnPListItem -List Documents -Id 2 -Connection $siteConnection -Includes ParentList
$item | fl
$item.FieldValues | fl

$file = Get-PnPFile -Url $item.FieldValues.FileRef -Connection $siteConnection 
$file | fl


$fileUrl = $item.FieldValues.FileRef 
$fileUrl
$fileFullUrl = "https://$orgname.sharepoint.com" + $item.FieldValues.FileRef 
$fileFullUrl

$label = Get-PnPFileRetentionLabel -Url $fileUrl -Connection $siteConnection
$label | fl

$label = Get-PnPFileSensitivityLabel -Url $fileUrl -Connection $siteConnection
$label | fl

$labelInfo = Get-PnPFileSensitivityLabelInfo -Url $fileFullUrl -Connection $siteConnection
$labelInfo | fl