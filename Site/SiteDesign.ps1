
$siteUrl = "https://$orgname.sharepoint.com/sites/Birding_in_KZ"
$site = Get-SPOSite -Identity $siteUrl

$site.Template

Get-SPOSiteDesign 
Get-SPOSiteScript

Set-SPOBuiltInSiteTemplateSettings -Identity 'b8ef3134-92a2-4c9d-bca6-c2f14e79fe98' -IsHidden $true # Learning central
Set-SPOBuiltInSiteTemplateSettings -Identity '73495f08-0140-499b-8927-dd26a546f26a' -IsHidden $true # Department	

$designId = '73495f08-0140-499b-8927-dd26a546f26a' # Department
Invoke-SPOSiteDesign -Identity $designId -WebUrl $siteUrl
