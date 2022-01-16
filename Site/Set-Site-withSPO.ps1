Get-Command *scop* -Module Microsoft.Online.SharePoint.PowerShell

Connect-SPOService -Url $adminUrl 

$site = Get-SPOSite -Identity $siteUrl
$site.Template

Get-SPOSiteDesign 
Get-SPOSiteScript


$sites = Get-SPOSite 
$sites[-1] | fl
