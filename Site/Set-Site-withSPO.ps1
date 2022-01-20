Get-Command *scop* -Module Microsoft.Online.SharePoint.PowerShell

Connect-SPOService -Url $adminUrl 

$site = Get-SPOSite -Identity $siteUrl
$site.Template

Get-SPOSiteDesign 
Get-SPOSiteScript

$sites = Get-SPOSite 
$sites[-1] | fl

Get-SPOUser -Site $siteUrl | ft -a
Remove-SPOUser -Site $siteUrl -LoginName $adminUPN 

Get-SPOSite -Identity $siteUrl | select Owner

Set-SPOSite -Owner "vlad@akteams.com" -Identity $siteUrl
Set-SPOSite -Owner $adminUPN -Identity $siteUrl

$everyoneLogin = "spo-grid-all-users/046d11d6-08e0-4d20-a743-562836cdcab5"
$everyoneLogin = "c:0-.f|rolemanager|spo-grid-all-users/046d11d6-08e0-4d20-a743-562836cdcab5"
Remove-SPOUser -Site $siteUrl -LoginName $everyoneLogin 

